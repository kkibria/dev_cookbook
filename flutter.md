# Flutter Text and rendering features

* [flutter-text-rendering](https://www.raywenderlich.com/4562681-flutter-text-rendering)
* [framework.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/framework.dart)
* [text.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/text.dart)
* [basic.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/basic.dart)
* [Examples of Flutter's layered architecture](https://github.com/flutter/flutter/tree/master/examples/layers)

# Medium articles
* [full-flutter-website](https://medium.com/flutter-community/more-than-a-flutter-web-app-is-a-full-flutter-website-c6bb210b1f16)
* [flutter-web-plugin](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1)

# YouTube videos
* [Widgets 101](https://www.youtube.com/watch?v=CXedqMlLo7M)
* [Flutter's Rendering Pipeline](https://www.youtube.com/watch?v=UUfXWzp0-DU)
* [The Mahogany Staircase - Flutter's Layered Design](https://www.youtube.com/watch?v=dkyY9WCGMi0)

# Articles on rendering
* [The Engine architecture](https://github.com/flutter/flutter/wiki/The-Engine-architecture)
* [Flutter’s Rendering Engine: A Tutorial ](https://medium.com/saugo360/flutters-rendering-engine-a-tutorial-part-1-e9eff68b825d)
* [Everything you need to know about tree data structures](https://www.freecodecamp.org/news/all-you-need-to-know-about-tree-data-structures-bceacb85490c/)
* [Android’s Font Renderer](https://medium.com/@romainguy/androids-font-renderer-c368bbde87d9)

# Flutter PWA
## Setup
* Install git
* Install npm
* Install flutter sdk
* Read carefully the [firebase CLI docs](https://firebase.google.com/docs/cli). Install firebase CLI using npm.
```
npm install -g firebase-tools
```
* log into firebase using the firbase CLI.
```
firebase login
# this will test the succesfull login
# by listing all your projects
firebase projects:list
```
* Read carefully [flutter web doc](https://flutter.dev/docs/get-started/web). Change channel to dev or beta. Currently I am using dev channel to the latest features.
```
flutter channel dev
flutter upgrade
flutter config --enable-web
```

* Set powershell script policy by running in an __admin powershell__ for Windows machine. Otherwise firebase commands will not run.
```
Set-ExecutionPolicy RemoteSigned
```

## Create a flutter project with PWA
PWA will be added for web platform.

```
flutter create <app_name>
```
* Add git and setup for gitlab
```
cd <app_name>
git init
git add .
git commit -m "intial commit"
git push --set-upstream https://gitlab.com/kkibria/<app_name>.git master
git remote add origin https://gitlab.com/kkibria/<app_name>.git
```

## Add firebase to flutter project

* Create a firebase project in firebase console.
* coneect the flutter project with firebase.
Todo: need to update, need to go thru the web setup again and document.....

```
# run from inside <app_name> directory
firebase init
```
now you can use, 
* firebase serve
* firebase deploy

