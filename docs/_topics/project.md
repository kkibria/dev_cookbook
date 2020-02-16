# How to create a new project in gitlab

Create a local project directory. In this example we will use **prj\_dir** as the directory name. Now populate the **prj\_dir** with all the files and folders that will be used for initial commit.

```text
cd prj_dir
git init
git add .
git commit -m "intial commit"
git push --set-upstream https://gitlab.com/kkibria/prj_dir.git master
git remote add origin https://gitlab.com/kkibria/prj_dir.git
```

