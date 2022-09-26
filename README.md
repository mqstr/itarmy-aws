###  Running [mhddos_proxy_releases](https://github.com/porthole-ascend-cinnamon/mhddos_proxy_releases) on EC2 instance in the AWS cloud from scratch
Identical project for the GCP cloud is [here](https://github.com/mqstr/itarmy-gcp).
#### Quick start
    $ git clone https://github.com/mqstr/itarmy-aws.git
    $ cd itarmy-aws
    $ terraform init
    $ terraform apply
#### Description
This project uses minimal resource configuration - enlarge them if needed:
- machine type `t2.micro` in AWS
- `1000` threads in mhddos_proxy_linux
- terminate the EC2 instance at `19:00`
#### Connect to EC2 instance
1. Generate SSH keys on your local mashine
```
$ ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/master/.ssh/id_ed25519):
Created directory '/home/master/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/master/.ssh/id_ed25519
Your public key has been saved in /home/master/.ssh/id_ed25519.pub
```
2. Run `terraform apply` to upload public SSH key to AWS cloud
3. Connect to EC2 instance
```
$ ssh ubuntu@<Public IPv4 address>
```
4. Attach to a `tmux` session with the name `itarmy`
```
ubuntu@<Private IP DNS name>:~$ tmux attach-session -t itarmy
```
