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

