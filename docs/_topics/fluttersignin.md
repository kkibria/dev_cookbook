---
title: Flutter Sign-in for your users
---

# {{ page.title }}

## google sign in
Enable the google sign-in in the authentication tab in firebase console for the project. In the enable dialog, expand the web SDK config.
Copy the Web client ID and save setting.  Lets say this value is ``somerandomstuff.apps.googleusercontent.com``. Now copy the client ID value into the ``web/index.html`` file in a meta tag.

```text
<head>
  ...
  <meta name="google-signin-client_id" content="somerandomstuff.apps.googleusercontent.com" />
  ...
  <title>my awesome pwa app</title>
  <link rel="manifest" href="/manifest.json">
  ...
 /head>
```

## email link sign in
* read [article](https://medium.com/@huzaifa.ameen229/firebase-email-link-authentication-ac2504068562)
* read [article](https://medium.com/@ayushsahu_52982/passwordless-login-with-firebase-flutter-f0819209677)
* read [article](https://medium.com/mindorks/working-with-firebase-dynamic-links-a581df8fee6f)
* you'll have to whitelist that dynamic link domain, [article](https://stackoverflow.com/questions/51374411/firebase-says-domain-not-whitelisted-for-a-link-that-is-whitelisted)
