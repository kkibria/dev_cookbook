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

## Flutter PWA

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

  ```text
  Set-ExecutionPolicy RemoteSigned
  ```

### Create a flutter project with PWA

PWA will be added for web platform.

```text
flutter create <app_name>
```

* Add git and setup for gitlab

  ```text
  cd <app_name>
  git init
  git add .
  git commit -m "intial commit"
  git push --set-upstream https://gitlab.com/kkibria/<app_name>.git master
  git remote add origin https://gitlab.com/kkibria/<app_name>.git
  ```

### Add firebase to flutter project

* Create a firebase project in firebase console with the  as the porject name.
* Add an web app to the project.
* Add a nickname for the app \_web.
* Click on firebase hosting option.
* Now click on Register button.
* Add the firebase SDK to `web/index.html` file as instruceted in firebase console.
* In the project `Setting > General` tab select Google Cloud Platform \(GCP\) resource location.
* Coneect the flutter project with firebase.

```text
# run from inside <app_name> directory
firebase init
```

Select either `Realtime Database` or `Firestore`, Because you can use only one of them. Both can be use if there is a need but probably not common. Check the rest of the options as necessary.



hit enter.

Select `Exiting project` and hit enter. Then select the firebase project you just created.

Note: selecting firestore is giving index trouble, so I selected Realtime

Select all defaults except for the public directory, type `build/web`.

It will build an `index.html` file in `build/web` directory. Copy the firebase relevant portion in this file to the web template `web/index.html` file to update the template for future `flutter build web` command to build the app.

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

