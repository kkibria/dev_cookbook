---
title: Flutter matters
---

# {{ page.title }}

## Flutter Text and rendering features

* [flutter-text-rendering](https://www.raywenderlich.com/4562681-flutter-text-rendering)
* [framework.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/framework.dart)
* [text.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/text.dart)
* [basic.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/basic.dart)
* [Examples of Flutter's layered architecture](https://github.com/flutter/flutter/tree/master/examples/layers)

## Medium articles

* [full-flutter-website](https://medium.com/flutter-community/more-than-a-flutter-web-app-is-a-full-flutter-website-c6bb210b1f16)
* [flutter-web-plugin](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1)

## YouTube videos

* [Widgets 101](https://www.youtube.com/watch?v=CXedqMlLo7M)
* [Flutter's Rendering Pipeline](https://www.youtube.com/watch?v=UUfXWzp0-DU)
* [The Mahogany Staircase - Flutter's Layered Design](https://www.youtube.com/watch?v=dkyY9WCGMi0)
  
## Firebase Auth sample

* [firebase auth example](https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_auth/firebase_auth/example)
* Youtube [Flutter Web - Firebase Authentication for your web apps](https://youtu.be/qtJU5T0tF-M).
  Github [link](https://github.com/rajayogan/flutterweb-firebaseauth) used in this video.

## Articles on rendering

* [The Engine architecture](https://github.com/flutter/flutter/wiki/The-Engine-architecture)
* [Flutter’s Rendering Engine: A Tutorial ](https://medium.com/saugo360/flutters-rendering-engine-a-tutorial-part-1-e9eff68b825d)
* [Everything you need to know about tree data structures](https://www.freecodecamp.org/news/all-you-need-to-know-about-tree-data-structures-bceacb85490c/)
* [Android’s Font Renderer](https://medium.com/@romainguy/androids-font-renderer-c368bbde87d9)

## Flutter

### Setup

* Install git
* Install npm
* Install flutter sdk
* Read carefully the [firebase CLI docs](https://firebase.google.com/docs/cli). Install firebase CLI using npm.

  ```text
  npm install -g firebase-tools
  ```

* log into firebase using the firbase CLI.

  ```text
  firebase login
  # this will test the succesfull login
  # by listing all your projects
  firebase projects:list
  ```

* Read carefully [flutter web doc](https://flutter.dev/docs/get-started/web). Change channel to dev or beta. Currently I am using dev channel to the latest features.

  ```text
  flutter channel dev
  flutter upgrade
  flutter config --enable-web
  ```

* Set powershell script policy by running in an **admin powershell** for Windows machine. Otherwise firebase commands will not run.

  ```khankibria
  Set-ExecutionPolicy RemoteSigned
  ```

### Create a flutter project

Type following flutter cli command in shell to create a starter flutter project.

```text
flutter create <app_name>
cd <app_name>
```
This creates a folder named '`<app_name>`' in the current working directory. Next we change working directory to newly created '`<app_name>`' folder.

Android app, IOS app, and web app target support will be added to the project by the cli command.

### Add git and setup for gitlab

```bash
git init
git add .
git commit -m "intial commit"
git push --set-upstream https://gitlab.com/kkibria/<app_name>.git master
git remote add origin https://gitlab.com/kkibria/<app_name>.git
```

## Add firebase to tha flutter project

### Create a firebase project
* Go to firebase [console](https://console.firebase.google.com).

* Create a new firebase project in firebase console with the `<app_name>` as the project name.

### Add the firebase SDK support libraries

Add firebase dart libraries to the `dependecies` section of `pubspec.yaml` file.

```
...

dependencies:
  ...

  # flutter firebase SDK libraries
  # comment out the ones you dont need
  firebase_auth: ^0.15.4
  firebase_messaging: ^6.0.9
  firebase_database: ^3.1.1
  cloud_firestore: ^0.13.2+2
  firebase_storage: ^3.1.1

...
```

### Webapp with PWA
PWA support was already added for web platform by `flutter create` command. We need to connect flutter web target with a firebase web app.
* Add an web app to the firebase project.
* Add a nickname for the `<app_name>_web`.
* Click on firebase hosting option.
* Now click on Register button.
* It will show a javascript snippet that will show how to add firebase javascript SDK to `web/index.html`. For now we wont add the snippet. We will do it later.
* In the project `Setting > General` tab select Google Cloud Platform \(GCP\) resource location.
* Configure firestore into Native mode.

### Coneect the flutter web target with firebase webapp.

Run following firebase CLI command from inside <app_name> directory.

```text
firebase init
```

Select either `Realtime Database` or `Firestore`, or both as necessary. Both can be used if there is a need but probably not common. Check the rest of the options as necessary as well. Hit enter.

Select `Exiting project` and hit enter. Then select the firebase project you just created.

Note: selecting firestore is giving index trouble, so I selected Realtime.

Select all defaults except for the public directory, type `build/web`.

## Android app from flutter
Todo......

## IOS app from flutter
Todo.....

## Web app from flutter

### Update the flutter web template
`firebase init` will build an `index.html` file in `build/web` directory. You will see the firebase javascript SDK snippet we saw earlier, is allready included in this `index.html`. Copy the firebase relevant portion in this file to the web template `web/index.html` file to update the template for future `flutter build web` command to build the app.

The template will end up looking something like the following,

```text
<!DOCTYPE html>
<html>
<head>

  ...

  <title>my awesome pwa app</title>
  <link rel="manifest" href="/manifest.json">

  ...

  <!-- update the version number as needed -->
  <script defer src="/__/firebase/7.8.2/firebase-app.js"></script>
  <!-- include only the Firebase features as you need -->
  <!-- comment out the ones you dont need -->
  <script defer src="/__/firebase/7.8.2/firebase-auth.js"></script>
  <script defer src="/__/firebase/7.8.2/firebase-database.js"></script>
  <script defer src="/__/firebase/7.8.2/firebase-firestore.js"></script>
  <script defer src="/__/firebase/7.8.2/firebase-messaging.js"></script>
  <script defer src="/__/firebase/7.8.2/firebase-storage.js"></script>
  <!-- initialize the SDK after all desired features are loaded -->
  <script defer src="/__/firebase/init.js"></script>

</head>

<body>
  <!-- This script installs service_worker.js to provide PWA functionality to
       application. For more information, see:
       https://developers.google.com/web/fundamentals/primers/service-workers -->
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        navigator.serviceWorker.register('/flutter_service_worker.js');
      });
    }
  </script>

  ...

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      try {
        let app = firebase.app();
        let features = 
          [
            'auth', 
            'database',
            'firestore', 
            'messaging', 
            'storage'
          ].filter(feature => typeof app[feature] === 'function');
      } catch (e) {
        console.error(e);
      }
    });
  </script>

  ...

  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
```


now you can use,

* firebase serve
* firebase deploy

... to be continued

google api problem [https://stackoverflow.com/questions/58495985/firebase-403-permission-denied-firebaseerror-installations-requests-are-blo/58496014\#58496014](https://stackoverflow.com/questions/58495985/firebase-403-permission-denied-firebaseerror-installations-requests-are-blo/58496014#58496014)

