---
title: How to create a new project in gitlab
---

# {{ page.title }}

Create a local project directory. In this example we will use **prj\_dir** as the directory name. Now populate the **prj\_dir** with all the files and folders that will be used for initial commit.

```bash
cd prj_dir
git init
git add .
git commit -m "initial commit"
git push --set-upstream https://gitlab.com/kkibria/prj_dir.git master
git remote add origin https://gitlab.com/kkibria/prj_dir.git
git pull
```

I created a convenience npm module that will execute the above commands without typing them individually. You can clone from [https://gitlab.com/kkibria/gitlab.git](https://gitlab.com/kkibria/gitlab.git), build the npm module and install.

## Changing a remote's URL
The ``git remote set-url`` command changes an existing remote repository URL.
```bash
$ git remote -v
> origin  https://github.com/USERNAME/REPOSITORY1.git (fetch)
> origin  https://github.com/USERNAME/REPOSITORY1.git (push)
# Change remote's URL,
$ git remote set-url origin https://github.com/USERNAME/REPOSITORY2.git
# Verify
$ git remote -v
> origin  https://github.com/USERNAME/REPOSITORY2.git (fetch)
> origin  https://github.com/USERNAME/REPOSITORY2.git (push)
```