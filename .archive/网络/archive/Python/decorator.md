### First-Class Object
In `Python`, functions are first-class object, meaning that **functions can be passed around and used as arguments**.

Example:
```python
def say_hello(name):
    return f"Hello {name}"

def greet_bob(greeter_func):
    return greeter_func("Bob")
```

```python
>>> greet_bob(say_hello)
'Hello Bob'
```
The `say_hello` function is named without parentheses. This means that only a **reference** to the function is passed. The function is not executed.

### Inner Functions
The inner functions are not defined until the parent function is called. They are locally scoped to parent function meaning that they only exist inside the parent function as local variables. 

### Simple Decorators
**Decorators wrap a function, modifying its behavior**.

Example:

```python
from datetime import datetime

def not_during_the_night(func):
    @functools.wraps(func)  # to preserve info about the original function
    def wrapper():
        if 7 <= datetime.now().hour < 22:
            func()
        else:
            pass  # Hush, the neighbors are asleep
    return wrapper
```

Without decorator:
```python
def say_whee():
    print("Whee!")

say_whee = not_during_the_night(say_whee)
```

With the decorator:
```python
@my_decorator
def say_whee():
    print("Whee!")
```

If wish to decorate function with arguments, use `*args` and `**kwargs` in the inner wrapper function.

### Decorating Classes
`@classmethod` and `@staticmethod` decorators are used to define methods inside a class namespace that are not connected to a particular instance of that class. Class methods are often used as **factory methods** that can create specific instances of the class.

The `@property` decorator is used to customize getters and setters for class attributes.

### Nesting Decorators
Several decorators can be applied to a function by stacking them on top of each other. Decorators are being executed in the order they are listed. 

### Decorators with arguments
Example:

*Decorator definition*:
```python
def repeat(num_times):
    def decorator_repeat(func):
        @functools.wraps(func)
        def wrapper_repeat(*args, **kwargs):
            for _ in range(num_times):
                value = func(*args, **kwargs)
            return value
        return wrapper_repeat
    return decorator_repeat
```
*Function declaration*:
```python
@repeat(num_times=4)
def greet(name):
    print(f"Hello {name}")
```
*Output*:
```python
>>> greet("World")
Hello World
Hello World
Hello World
Hello World
```

### Decorators both with or without arguments
*Decorator definition*:
```python
def repeat(_func=None, *, num_times=2):
    def decorator_repeat(func):
        @functools.wraps(func)
        def wrapper_repeat(*args, **kwargs):
            for _ in range(num_times):
                value = func(*args, **kwargs)
            return value
        return wrapper_repeat

    if _func is None:
        return decorator_repeat
    else:
        return decorator_repeat(_func)
```
Here, `*` means that the remaining arguments can’t be called as positional arguments (since we are passing `num_times=int` as argument instead of `_func` if we decided to call with arguments) i.e. only **kwargs** can be accepted.

*Functions declarations*:
```python
@repeat
def say_whee():
    print("Whee!")

@repeat(num_times=3)
def greet(name):
    print(f"Hello {name}")
```

*Output*:
```python
>>> say_whee()
Whee!
Whee!

>>> greet("Penny")
Hello Penny
Hello Penny
Hello Penny
```

> Reference:
> 
> [Real Python: Primer on Python Decorators](https://realpython.com/primer-on-python-decorators/)