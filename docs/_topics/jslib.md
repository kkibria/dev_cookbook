---
title: Javascript library
---

# {{ page.title }}

## Using require like a node package

First add jquery using npm.

Original ``test.js``.

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

### Wrap everything up in a single module 
Assuming you have already installed ``browserify`` and ``js-beautify``, run them.
```bash
browserify test.js --s test -o gen-test.js
js-beautify gen-test.js -o pretty-gen-test.js
```
Check the outputs, you can see jquery has already been factored in the output. 

Now we can load ``gen-test.js`` in the browser in an html file. It also works with svelte.

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

I have put this in github <https://github.com/kkibria/svelte-js-library>