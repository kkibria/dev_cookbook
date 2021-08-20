---
title: Translating Python to Javascript language
---

# {{ page.title }}

I have written large Python projects in the past, looking into converting some to javascript.

## Links
* <https://www.transcrypt.org/>

`test.py`
```python
def test_def(a):		# Shalabh Chaturvedi, AS Cookbook
    for i in range(len(a)):
        print(i)

xx = [2, 3, 4]
test_def(xx)
```

Running transcrypt gives error
```
> python -m transcrypt -b -m -n .\test.py
Error while compiling (offending file last):
        File 'test', line 2, namely:

        Error while compiling (offending file last):
        File 'test', line 2, namely:


Aborted
```


this was happening due to version mismatch, see <https://stackoverflow.com/questions/68582595/error-message-seems-ambiguous-without-any-descriptive-clue>


