---
title: Svelte, firebase
---
# {{ page.title }}

## General capabilities
* [The Svelte Handbook](https://www.freecodecamp.org/news/the-svelte-handbook/)

### create a starter svelte project
```bash
npx degit sveltejs/template my-svelte-project
cd my-svelte-project
npm install
npm run dev
```

## Svelte components
* <https://github.com/hperrin/svelte-material-ui>
* <https://github.com/collardeau/svelte-fluid-header>
* <https://flaviocopes.com/svelte-state-management/>

## Styling
* <https://css-tricks.com/what-i-like-about-writing-styles-with-svelte/>
* with tailwind we can import external css file into a component, <https://mattferderer.com/add-postcss-imports-to-tailwind-css>
* css in js for svelte, <https://svelte.dev/blog/svelte-css-in-js>

## Generated content and global styling in production build
Svelte allows css support of generated content with global styling. However it (with postcss and purgecss) removes any css that is not being used by the static content during production build, if it is loaded from a css file using postcss-include facility even it is a global style. During development build this doesn't happen though since we don't run purgecss in development build. To ensure those styles are retained we need to tell purgecss about those. For instance if we used a highlighter such as highlight.js which prepends highlight classes with ``hljs-`` prefix. Then we can retain styling for them by adding a whitelist pattern ``/hljs-/``
in ``postcss.config.js``.
```javascript
const purgecss = require('@fullhuman/postcss-purgecss')({
  content: ['./src/**/*.svelte', './src/**/*.html'],
  whitelistPatterns: [/svelte-/, /hljs-/],
  defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
})
```

## Svelte Browser compatibility
* [Making a svelte app compatible with Internet Explorer 11](https://blog.az.sg/posts/svelte-and-ie11/)
* [Svelte3, Rollup and Babel7](http://simey.me/svelte3-rollup-and-babel7/)

## Svelte with firebase
* [svelte](https://svelte.dev/)
* [Rich Harris - Rethinking reactivity](https://youtu.be/AdNJ3fydeao)
* [Svelte 3 Reaction & QuickStart Tutorial](https://youtu.be/043h4ugAj4c)
* [Svelte + Firebase = Sveltefire (and it is FIRE 🔥🔥🔥)](https://youtu.be/urDLn8RNlCA)
* [Svelte Realtime Todo List with Firebase](https://fireship.io/lessons/svelte-v3-overview-firebase/). I built a template using this in <https://github.com/kkibria/svelte-todo>.

## Routing
* [Client-side (SPA) routing in Svelte](https://youtu.be/edFp-vuDlLs)
* [Micro client-side router inspired by the Express router](https://visionmedia.github.io/page.js/)
* [Svelte routing with page.js, Part 1](https://dev.to/ism/svelte-routing-with-page-js-part-1-2h9h)
* [Svelte routing with page.js, Part 2](https://dev.to/ism/svelte-routing-with-page-js-part-2-4l76), code in <https://github.com/iljoo/svelte-pagejs>.
* [Setting up Routing In Svelte with Page.js](https://jackwhiting.co.uk/posts/setting-up-routing-in-svelte-with-pagejs/)


## Sapper
* [sapper](https://sapper.svelte.dev/)
* [Building a project with Sapper, a JavaScript app framework](https://www.merixstudio.com/blog/project-sapper-javascript-framework/)
* [Simple Svelte 3 app with router](https://medium.com/swlh/simple-svelte-3-app-with-router-44fe83c833b6)
* [Exploring Sapper + Svelte: A quick tutorial](https://blog.logrocket.com/exploring-sapper-svelte-a-quick-tutorial/)
* [Build a fast reactive blog with Svelte and Sapper](https://www.creativebloq.com/how-to/svelte-and-sapper)

## Sapper with firebase

* [How to host a Sapper.js SSR app on Firebase](https://dev.to/eckhardtd/how-to-host-a-sapper-js-ssr-app-on-firebase-hmb)
* [Sapper - Deploy to Firebase Cloud Functions](https://youtu.be/fxfFMn4VMpQ)
* [migrating to Sapper part 1 - SEO, Twitter Cards, OpenGraph](https://lacourt.dev/2019/06/16)
* [migrating to Sapper part 2 - TDD with Cypress.io](https://lacourt.dev/2019/06/21)
* [migrating to Sapper part 3 - RSS feed](https://lacourt.dev/2019/06/29)
* [migrating to Sapper part 2 bis - Netlify, GitHub Actions with Cypress.io](https://lacourt.dev/2019/06/30)
* <https://github.com/fusionstrings/firebase-functions-sapper>

## SPA & Search Engine Optimization (SEO)
* [SPA SEO: A Single-Page App Guide to Google’s 1st Page](https://snipcart.com/spa-seo)
* [Why Single Page Application Views Should be Hydrated on the Client, Not the Server](https://love2dev.com/blog/why-single-page-application-views-should-be-hydrated-on-the-client-not-the-server/)

## Svelte with firebase and page.js router
* I am building a template, work in progress: <https://github.com/kkibria/svelte-page-blog>.

## Svelte build to standalone app with electron
* [Getting started with Electron and Svelte](https://dev.to/o_a_e/getting-started-with-electron-and-svelte-2gn8), 
  github template <https://github.com/jzillmann/template-electron-svelte>.

## Svelte markdown editor
* [Build Markdown editor using Svelte in 10 minutes](https://dev.to/karkranikhil/build-markdown-editor-using-svelte-in-10-minutes-1c69),
  this uses [marked.js](https://marked.js.org) parser, [github](https://github.com/markedjs/marked).
* Stackedit is a vue markdown editor, but provides scroll sync. We can take
  a look at the source code and do similar thing in Svelte. Uses <https://github.com/markdown-it/markdown-it>. markdown-it has most versatile collection of plugins.
* Nice scrollbar sync example, <https://github.com/vincentcn/markdown-scroll-sync>.
* Another scrollbar sync example, <https://github.com/jonschlinkert/remarkable>. Look in the demo directory.
* The most promising markdown editing seems to be ``markdown-it``, ``vscode`` uses this for their markdown support as well. 
  This seems to be a project which evolved from 
  ``remarkable``. Check Github <https://github.com/markdown-it/markdown-it> in the ``support/demo_template`` directory for the scroll syncing javascript source.
  With some modification this can be integrated with svelte.
  I like the way vscode does it, whenever the cursor is on a line, it finds the whole element in the preview window and draws a side bar to indicate
  the element being edited.     


## Firebase storage with svelte
* [RxFire in Svelte 3 using Firebase Firestore and Authentication](https://dev.to/ajonpllc/rxfire-in-svelte-3-using-firebase-firestore-and-authentication-pca)

## Svelte Component exported functions
``Comp1.svelte`` file.
```html
<script>
    import Comp2, {mod_param as C2param} from 'Comp2.svelte';

    console.log(C2param.someText);
    C2param.someFunc("Comp2 function called from Comp1");
</script>
```

``Comp2.svelte`` file.
```html
<script>
  // This is component instance context
...
</script>

<script context="module">
  // This is component module context
  export const mod_param = {
    someFunc: (text) => {
      console.log(text);
    },

    someText: "hello from Comp2" 
  }
</script>
```
> Exchanging data between components module and instance context is tricky
> So appropriate handling required in such case. It is best to use 
> [REPL](https://svelte.dev/repl) sandbox ``JS output`` window to 
> check the exact use case.   

## Login data passing with context API

Firebase can have has it own login subscription via rxfire. However following articles are good read to understand svelte support data sharing across the app.    
* [REPL context API demo](https://svelte.dev/tutorial/context-api)
* [Lighter and Faster - A Guide to the Svelte Framework](https://www.toptal.com/front-end/svelte-framework-guide),
  Github [source](https://github.com/teimurjan/svelte-login-form)

