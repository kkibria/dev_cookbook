---
title: Markdown renderer and editor in browser
---

# {{ page.title }}

## markdown-it
```bash
#install markdown-it
npm install markdown-it
#install markdown-it addons
npm install markdown-it-abbr markdown-it-container markdown-it-deflist markdown-it-emoji markdown-it-footnote markdown-it-ins markdown-it-mark markdown-it-sub markdown-it-sub
#install highlighter for markdown
npm install highlight.js
```
### setting up for markdown editing

## Showdown.js
* Github Showdown.js [source](https://github.com/showdownjs/showdown).
* Code highlighting (showdown highlight js extension)[https://stackoverflow.com/questions/21785658/showdown-highlightjs-extension]
* Github Showdown highlighter [source](https://github.com/Bloggify/showdown-highlight),
* Highlight.js, a general purpose highlighter, <https://highlightjs.org/>, Github [source](https://github.com/highlightjs/highlight.js).
* Check showdown extensions, [Github](https://github.com/showdownjs/extension-boilerplate). To develop a new extension take a look at their  [template](https://github.com/showdownjs/extension-boilerplate) at github. There are other extensions, google it.
* Showdown extension writeup, <https://github.com/showdownjs/ng-showdown/wiki/Creating-an-Extension>.

Showdown use:

```html
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>dev_cookbook</title>
    <script src="https://unpkg.com/showdown/dist/showdown.min.js"></script>
</head>

<body>
    <script>
        var div = document.createElement("DIV");
        document.body.appendChild(div);   // Append <button> to <body>
        var converter = new showdown.Converter();
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                div.innerHTML = converter.makeHtml(this.responseText);
            }
        };
        xhttp.open("GET", "README.md", true);
        xhttp.send();
    </script>
</body>

</html>
```