---
title: How to create a new project in gitlab or github
---

# {{ page.title }}

## gitlab
Create a local project directory. In this example we will use ``prj_dir` as the directory name. Now populate the ``prj_dir`` with all the files and folders that will be used for initial commit.

```bash
cd prj_dir
git init
git add .
git commit -m "initial commit"
git push --set-upstream https://gitlab.com/USERNAME/REPOSITORY.git master
git remote add origin https://gitlab.com/USERNAME/REPOSITORY.git
git pull
```

I created a convenience npm module that will execute the above commands without typing them individually. You can clone from [https://gitlab.com/kkibria/gitlab.git](https://gitlab.com/kkibria/gitlab.git), build the npm module and install.

## github
Create a new repository.

Create a new folder ``prj_dir`` and ``README.md`` file,
```bash
cd prj_dir
git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin master
```

Push an existing folder maintained with git,
```bash
git remote add origin https://github.com/USERNAME/REPOSITORY.git
git push -u origin master
```

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

## Setting up your own git server
* <https://medium.com/@kevalpatel2106/create-your-own-git-server-using-raspberry-pi-and-gitlab-f64475901a66>
* [Install self-managed GitLab](https://about.gitlab.com/install/#raspberry-pi-os). They have a version for raspberry pi.


## Git Workflow
* <https://musescore.org/en/handbook/developers-handbook/finding-your-way-around/git-workflow>.
Describes git workflow for their project,
but a great page to consider for any project using git.