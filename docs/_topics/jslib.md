---
title: Javascript library
---

# {{ page.title }}

## Using require like a node package in browser

Lets take an example where we will use node package in a ``commonjs`` javascript file. This kind of setup would work in a node environment without
problem. But in a browser using ``require`` would normally be a problem. We can use the following method to make it work in browser.

In this example we will instantiate jquery with ``require`` as a node module. First get jquery module using npm. Then make ``test.js`` module as following.
At the end of the file we will export the API.

```javascript
var $ = require("jquery");

function getName () {
  return 'Jim';
};

function getLocation () {
  return 'Munich';
};

function injectEl() {
  // wait till document is ready 
  $(function() {
    $("<h1>This text was injected using jquery</h1>").appendTo(".inject-dev");
  });
}

const dob = '12.01.1982';

module.exports.getName = getName;
module.exports.getLocation = getLocation;
module.exports.dob = dob;
module.exports.injectEl = injectEl;
```

Now wrap everything up in a single module.
You have two options,
* Use ``browserify``.
* Use ``rollup``.

## Use browserify 

Assuming you have already installed ``browserify`` and ``js-beautify``, run them. If node builtins are used your ``commonjs`` file, ``browserify --s`` option will include them.

```bash
browserify test.js --s test -o gen-test.js
#optional only if you like to examine the generated file.
js-beautify gen-test.js -o pretty-gen-test.js
```
Check the outputs, you can see jquery has already been included in the output. 

Now we can load ``gen-test.js`` in the browser in an html file. It also works with svelte. Following shows using it in a svelte source. 

```html
<script>
  import { onMount } from 'svelte';
  import test from "./gen-test.js"

  let name = test.getName();
  let location = test.getLocation();
  let dob = test.dob;

  test.injectEl();
</script>

<main>
  <h1>Hello {name}!</h1>
  <p>Location: {location}, dob: {dob}</p>
  <div class="inject-dev"></div>
</main>
```

I have built this as an npm project in [github](https://github.com/kkibria/svelte-js-library) with svelte template.

## Use rollup
If you have installed ``rollup`` this can also be done with added benefit of tree shaking. ``rollup.config.js`` can be configured as, 

```javascript
import resolve from '@rollup/plugin-node-resolve';
import commonjs from '@rollup/plugin-commonjs';
import json from '@rollup/plugin-json';
export default {
  ...
  plugins: [
    resolve({
      browser: true,

      // only if you need rollup to look inside
      // node_modules for builtins
      preferBuiltins: false, 

      dedupe: ['svelte']
    }),
    json(),
    commonjs()
  ]
}
```

### node builtins
If node builtins are used your ``commonjs`` file, they will be missing. You have two options,
* Import the builtins packages individually with npm, if you have only a few missing. Set ``preferBuiltins`` to ``false`` 
so that rollup can get them from ``node_modules``.
* All node builtins  can be included using npm packages ``rollup-plugin-node-builtins`` and ``rollup-plugin-node-globals`` with rollup.
The default ``preferBuiltins`` value is ``true``, so rollup will use these instead.