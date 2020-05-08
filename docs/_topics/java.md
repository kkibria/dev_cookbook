---
title: Java development
---

# {{ page.title }}

## Maven

Maven is a great build tool, running maven build will compile, do all sorts of tasks and create the project target.

Maven build will store target jar and all the dependencies (jars, plugin jars, other artifacts) for later use in the local repository. Maven supports 3 types of repository for dependencies:

* **Local** – Repository on local Dev machine.
* **Central** – Repository provided by Maven community.
* **Remote** – Organization owned custom repository.

### The Local Repository

This is where all the project artifacts are stored locally.
When maven build is executed, Maven automatically downloads all the dependency jars into the local repository. If maven builds a jar, it is also stored here.  
Usually this folder is named ``.m2``.

The default path to this folder,

* Windows: ``C:\Users\<User_Name>\.m2`` i.e. ``%UserProfile%\.m2``.
* Linux: ``/home/<User_Name>/.m2`` i.e. ``~/.m2``.
* Mac: ``/Users/<user_name>/.m2``  i.e. ``~/.m2``.

> Note that, maven config file can change the default. The config file is located at the following path 
``<Maven-install-Path>/conf/settings.xml``.

## Antlr 4

Todo.




