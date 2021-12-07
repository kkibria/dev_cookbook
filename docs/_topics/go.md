---
title: Go language
---

# {{ page.title }}



## vscode powershell setup
The powershell does not have the environment variables setup for `go` when it starts.
First setup the powershell startup as shown in
[Powershell setup](vscode#powershell-setup).

In your go project directory create `.psrc.ps1` and put the following get the
environments.
```bash
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
$env:GOPATH = [Environment]::GetEnvironmentVariable("GOPATH","User")
```
Alternatively you can setup your custom go binary path and `GOPATH` in this file as well.

## Server
* <https://github.com/eranyanay/1m-go-websockets>


## desktop
* <https://github.com/zserge/lorca>
* <https://youtu.be/p_7MfQZTy34>
* <https://github.com/webview/webview>
* <https://github.com/wailsapp/wails>
* <https://youtu.be/Dg9rUXxNV-c>


## using dbus


## python to go
* <https://github.com/google/grumpy>
* <https://youtu.be/m335zpefXFE>