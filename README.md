English version [below](#english-version).
###  Запуск [mhddos_proxy_releases](https://github.com/porthole-ascend-cinnamon/mhddos_proxy_releases) на віртуальній машині в хмарному сервісі AWS з нуля
Ідентичний проєкт для хмарного сервісу GCP знаходиться [тут](https://github.com/mqstr/itarmy-gcp).
#### Передумови
- активний [обліковий запис AWS](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- встановлений [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- добре мати встановлений [Git](https://git-scm.com/book/uk/v2/Вступ-Інсталяція-Git) щоб ви могли оновлювати свою локальну копію цього репозиторію, інакше [завантажте](https://github.com/mqstr/itarmy-aws/archive/refs/heads/main.zip) його останню версію
#### Швидкий старт
    $ git clone https://github.com/mqstr/itarmy-aws.git
    $ cd itarmy-aws
    $ terraform init
    $ terraform apply
#### Опис
Цей проєкт використовує мінімальну конфігурацію ресурсів - збільшить їх за потреби:
- тип віртуальної машини `t2.micro` в хмарі AWS
- `1000` потоків у mhddos_proxy_linux
- видалення віртуальної машини о `19:00`
#### Підключення до віртуальної машини
1. Згенеруйте ключі SSH на локальному комп’ютері
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
2. Запустіть `terraform apply` щоб завантажити публічний ключ SSH в хмару AWS
3. Підключіться до віртуальної машини
```
$ ssh ubuntu@<Public IPv4 address>
```
4. Приєднайтеся до сеансу `tmux` з назвою `itarmy`
```
ubuntu@<Private IP DNS name>:~$ tmux attach-session -t itarmy
```
## English version
###  Running [mhddos_proxy_releases](https://github.com/porthole-ascend-cinnamon/mhddos_proxy_releases) on EC2 instance in the AWS cloud from scratch
An identical project for the GCP cloud is [here](https://github.com/mqstr/itarmy-gcp).
#### Prerequisites
- active [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- installed [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- good to have installed [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) so you can update your local copy of this repository, otherwise [dowload](https://github.com/mqstr/itarmy-aws/archive/refs/heads/main.zip) its latest version
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
#### Connect to the EC2 instance
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
2. Run `terraform apply` to upload public SSH key to the AWS cloud
3. Connect to the EC2 instance
```
$ ssh ubuntu@<Public IPv4 address>
```
4. Attach to a `tmux` session with the name `itarmy`
```
ubuntu@<Private IP DNS name>:~$ tmux attach-session -t itarmy
```
