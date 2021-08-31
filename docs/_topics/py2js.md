---
title: Translating Python to Javascript language
---

# {{ page.title }}

I have written large Python projects in the past, looking into converting some to javascript.

## Links
* <https://www.transcrypt.org/>


## virtual environment for python

The venv module provides support for creating lightweight “virtual environments” with their own site directories, optionally isolated from system site directories. Each virtual environment has its own Python binary (which matches the version of the binary that was used to create this environment) and can have its own independent set of installed Python packages in its site directories.

## setup transcrypt

We have to use virtual environment for ``transcrypt`` to function correctly.
1. First find out the python
path of the version of python you need to use, for example, ``C:/Python39/python.exe``.
2. Go to the root folder of the project and create virtual environment called ``env`` for the project.
```bash
cd my_proj
C:/Python39/python.exe -m venv ./env
```
3. Now activate the environment
```bash
./env/scripts/Activate
```
4. Now install ``transcrypt``
```bash
pip install transcrypt
```
## converting to javascript
have a python file
``test-trans.py``
```python
import os
from pathlib import Path

inifile = os.path.join(Path.home(), ".imagesel", "config.ini")
print(inifile)
```

now test it with python
```
py test-trans.py
```

in order to use os and pathlib we need to replace them with equivalent javascript calls
using stubs. we will create stubs in dir called ``stubs``
these are special python files that can use javascript libraries.

``os.py``
```python
p = require('path')

class path:
    def join(*args):
        return p.join(*args)
```

``pathlib.py``
```python
os = require ('os')

class Path:
    def home():
        return os.homedir()
```

Now we can convert them to javascript 
```bash
python -m transcrypt -b -n ..\test-trans.py
```
This will produce a directory called ``__target__`` with all the javascript files in it.

## converting to a node bundle

Now initialize node environment and install rollup

```bash
npm init // accept defaults
npm i rollup
```

Next we need to use rollup to bundle them for node,
```bash
node_modules\.bin\rollup .\__target__\test-trans.js --o bundle.js --f cjs
```

Now test it with node
```
node bundle.js
```
We get the same result.

deactivate python local environment
```bash
deactivate
```

## venv to generate requirements.txt

```bash
pip freeze > requirements.txt
```





