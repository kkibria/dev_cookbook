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
* Medium [auth-in-flutter](https://medium.com/@greg.perry/auth-in-flutter-97275b29b550)

## Firebase Auth articles
* [do-you-really-know-cors](https://dzone.com/articles/do-you-really-know-cors)
* [flutter-passwordless-authentication-a-guide-for-phone-email-login](https://proandroiddev.com/flutter-passwordless-authentication-a-guide-for-phone-email-login-6759252f4e)
* [passwordless-login-with-firebase-flutter](https://medium.com/@ayushsahu_52982/passwordless-login-with-firebase-flutter-f0819209677)
* [flutter-email-verification-and-password-reset](https://medium.com/@levimatheri/flutter-email-verification-and-password-reset-db2eed893d1d) 

## Articles on rendering
* [The Engine architecture](https://github.com/flutter/flutter/wiki/The-Engine-architecture)
* [Flutter’s Rendering Engine: A Tutorial ](https://medium.com/saugo360/flutters-rendering-engine-a-tutorial-part-1-e9eff68b825d)
* [Everything you need to know about tree data structures](https://www.freecodecamp.org/news/all-you-need-to-know-about-tree-data-structures-bceacb85490c/)
* [Android’s Font Renderer](https://medium.com/@romainguy/androids-font-renderer-c368bbde87d9)

## Flutter renderobject / painting
* [How to Create a Flutter Widget Using a RenderObject](https://nicksnettravels.builttoroam.com/create-a-flutter-widget/)
* [Creating a custom clock widget in Flutter](https://stackoverflow.com/questions/45130497/creating-a-custom-clock-widget-in-flutter/45133660)

## Stack Overflow
* google api problem [Firebase: 403 PERMISSION_DENIED](https://stackoverflow.com/questions/58495985/firebase-403-permission-denied-firebaseerror-installations-requests-are-blo/58496014#58496014)

## Flutter UI design tools
* [flutter IDE](https://github.com/Norbert515/flutter_ide)
* [flutter studio](https://medium.com/@pmutisya/flutter-studio-version-2-41cce10fcf3d), no source code! he has two apps, [https://flutterstudio.app](https://flutterstudio.app) and [https://devicedb.app/](https://devicedb.app/).
* [anotther flutter studio project](https://github.com/thebuggycoder/flutterstudio), 
has source code but broken code at the moment.

## Dart serialization
* [serializing-your-object-in-flutter](https://medium.com/flutter-community/serializing-your-object-in-flutter-ab510f0b8b47)

## Page Routing
* Flutter [web routing with parameters](https://medium.com/flutter-community/advance-url-navigation-for-flutter-web-d8b5f2d424e6)


## Firebase security videos
* [Security Rules](https://youtu.be/DBKB6r5BFqo)
* [Firebase Database Rules Tutorial](https://youtu.be/qLrDWBKTUZo)
* [Firestore Rules Testing with the Emulator - New Feature](https://youtu.be/Rx4pVS1vPGY)

## Firebase database rule generator
* [bolt](https://github.com/FirebaseExtended/bolt)

## Cloud Firestore rule generator
* [fireward](https://github.com/bijoutrouvaille/fireward)

## Firestore
* [Firestore Security Rules Cookbook](https://fireship.io/snippets/firestore-rules-recipes/)


### firestore rules common functions
```
service cloud.firestore {
  match /databases/{database}/documents {

    function isSignedIn() {
      return request.auth != null;
    }
    function emailVerified() {
      return request.auth.token.email_verified;
    }
    function userExists() {
      return exists(/databases/$(database)/documents/users/$(request.auth.uid));
    }

    // [READ] Data that exists on the Firestore document
    function existingData() {
      return resource.data;
    }
    // [WRITE] Data that is sent to a Firestore document
    function incomingData() {
      return request.resource.data;
    }

    // Does the logged-in user match the requested userId?
    function isUser(userId) {
      return request.auth.uid == userId;
    }

    // Fetch a user from Firestore
    function getUserData() {
      return get(/databases/$(database)/documents/accounts/$(request.auth.uid)).data
    }

    // Fetch a user-specific field from Firestore
    function userEmail(userId) {
      return get(/databases/$(database)/documents/users/$(userId)).data.email;
    }


    // example application for functions
    match /orders/{orderId} {
      allow create: if isSignedIn() && emailVerified() && isUser(incomingData().userId);
      allow read, list, update, delete: if isSignedIn() && isUser(existingData().userId);
    }

  }
}
```

### firestore rules data validation

```
function isValidProduct() {
  return incomingData().price > 10 && 
         incomingData().name.size() < 50 &&
         incomingData().category in ['widgets', 'things'] &&
         existingData().locked == false && 
         getUserData().admin == true
}
```



## dart code generation
* [[Part 1] Code generation in Dart: the basics](https://medium.com/flutter-community/part-1-code-generation-in-dart-the-basics-3127f4c842cc)
* [[Part 2] Code generation in Dart: Annotations, source_gen and build_runner](https://medium.com/flutter-community/part-2-code-generation-in-dart-annotations-source-gen-and-build-runner-bbceee28697b)
* [todo_reporter.dart in github](https://github.com/jorgecoca/todo_reporter.dart)


