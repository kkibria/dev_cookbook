---
title: Using showdown to perform client side processing of markup files
---

# {{ page.title }}
```
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
        document.body.appendChild(div);               // Append <button> to <body>
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