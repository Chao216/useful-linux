# Some useful skills for better Linux user experience.

## 1. sources.list
if you are living in China, it is a good idea to change the sources of repository for you linux system.<br/>

the sources are in `/etc/apt/sources.list` file, you can back up the default sources.list with `sudo cp /etc/apt/sources.list ~/Document/sources_backup.list`

```shell
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
```

after adding the new sources, run `sudo apt update`. and `sudo apt full-upgrade` as optional action.

---

## 2. samba

samba is useful to transfer files between linux and windows machines.

### 2.1 set samba server

first install samba on your machine
```shell
sudo apt update
sudo apt install samba
```

then you need to set up samba<br/>

make a directory for samba to share with`mkdir /home/<username>/sambashare/`

back up your `/etc/samba/smb.conf` and edit it
```shell
sudo vim /etc/samba/smb.conf
```

adding the following lines
```shell
[sambashare]
    comment = Samba on Ubuntu
    path = /home/username/sambashare
    read only = no
    browsable = yes
```

the path is the absolute path (directory) you made for samba to share with<br/>

now enable and run the service with systemctl
```
sudo systemctl enable smbd
sudo systemctl restart smbd

# check smbd service status
sudo systemctl status smbd
```

allow samba traffic on firewall
```shell
sudo ufw allow samba
```

setting up user account for samba
```shell
sudo smbpasswd -a username
```

***Note! the user should exist on the machine you set up the samba server.***

### 2.2 samba client

connect on linux gui

on file explorer, use connect to server

``` 
smb://ip_address/sambashare
```

on windows, open file explorer, and on address bar
```
\\ip_address\sambashare
```

***Note! the path for client is ip_address/sambashare, which was in square bracket in smb.conf file, keep it same as [sambashare] you configured on the server***

### 2.2.1 smbclient

you can use samba on terminal with `smbclient`

simply `sudo apt install smbclient`

to connect samba server on terminal 
```shell
smbclient //ip_address/sambashare -U username
```

enter password for user, and you are good to go.<br/>
you can use ls, cd, pwd, and so on in smbclient.<br/>
to fetch a remote file to local machine
```shell
get file_name
```
to upload a file from local machine to server
```shell
put file_name
```

***Note! you local working directory is the directory where you run smbclient program, and remote current directory can be shown as pwd.*** 


to exit smbclient on terminal, type `exit`

## execute or source a file

execute a file will run the file in a new shell process, to execute a file
```shell

./file_name

# or

file_name

```
source a file will run the file in current shell process, to source a file

```shell
source file_name

# or 

. file_name
```

***Note ! dot is an alias to source in UNIX***
