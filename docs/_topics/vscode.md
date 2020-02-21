---
title: Install vscode in ubuntu
---

# {{ page.title }}

First, update the packages index and install the dependencies by typing:
```
sudo apt update
sudo apt install software-properties-common apt-transport-https wget git
```
Next, import the Microsoft GPG key using the following wget command:
```
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
```

And enable the Visual Studio Code repository by typing:

```
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
```
Once the apt repository is enabled, install the latest version of Visual Studio Code with:
```
sudo apt update
sudo apt install code
```
Visual Studio Code has been installed on your Ubuntu desktop and you can start using it. Next, ubuntu specific Setup credential cache so that you dont have to keep typing origin usercode and password.

```
git config --global credential.helper store
```