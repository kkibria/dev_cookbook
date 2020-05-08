---
title: Java development
---

# {{ page.title }}

## Maven

Maven build will store jar in a local maven repository and all the dependencies (jars, plugin jars, other artifacts) for later use. 
Also keep in mind that, beyond just this type of local repository, Maven does support 3 types of repos:

* **Local** – Folder location on the local Dev machine.
* **Central** – Repository provided by Maven community.
* **Remote** – Organization owned custom repository.

### The Local Repository

This is where all the project artifacts are stored locally.
When maven build is executed, Maven automatically downloads all the dependency jars into the local repository.
Usually this folder is named ``.m2``.

Here's where the default path to this folder is – based on OS:

* Windows: ``C:\Users\<User_Name>\.m2`` i.e. ``%UserProfile%\.m2``.
* Linux: ``/home/<User_Name>/.m2`` i.e. ``~/.m2``.
* Mac: ``/Users/<user_name>/.m2``  i.e. ``~/.m2``.

If the local repo is not present in this default location, it's likely that maven config file has changed the default. The config file is located at the following path ``<Maven-installation-Path>/conf/settings.xml``.

## Antlr 4


