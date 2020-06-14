## Unit Testings

### Unit Tests vs. Integration Tests
Testing multiple components is known as **integration testing**. While a **unit test** is a smaller test, one that checks that a single component operates in the right way. A unit test helps you to isolate what is broken in your application and fix it faster. 

`test fixture`: A *test fixture* represents the preparation needed to perform one or more tests, and any associate cleanup actions. This may involve, for example, creating temporary or proxy databases, directories, or starting a server process.

`test case`: A *test case* is the individual unit of testing. It checks for a specific response to a particular set of inputs. unittest provides a base class, TestCase, which may be used to create new test cases.

`test suite`: A *test suite* is a collection of test cases, test suites, or both. It is used to aggregate tests that should be executed together.

### Basic Example
```python
import unittest

class TestStringMethods(unittest.TestCase):

    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)

if __name__ == '__main__':
    unittest.main()
```
- A testcase is created by subclassing `unittest.TestCase`.
- The three individual tests are defined with methods whose names start with the letters `test_`. This naming convention informs the test runner about which methods represent tests.
- `assertEqual()` to check for an expected result.
- `assertTrue()` or `assertFalse()` to verify a condition.
- `assertRaises()` to verify that a specific exception gets raised.
- The `setUp()` and `tearDown()` methods allow you to define instructions that will be executed before and after each test method.
- `assertIs(a, b)` to check whether `a is b`.
- `assertIsNone(a)` to check whether `a is None`.
- `assertIn(a, b)` to check whether `a in b`.
- `assertIsInstance(a, b)` to check whether `isinstance(a, b)`.

### Running a Test
Running test modules, classes or even individual test methods:
```bash
python -m unittest test_module1 test_module2
python -m unittest test_module.TestClass
python -m unittest test_module.TestClass.test_method
```

Test modules can be specified by file path as well:
```python
python -m unittest tests/test_something.py
```

Run tests with more details (higher verbosity):
```python
python -m unittest -v test_module
```

### How to Use `unittest` in Flask
Refer to [Flask Document: testing](http://flask.pocoo.org/docs/1.0/testing/).

> References:
> 
> 1. [Python document: unit testing framework](https://docs.python.org/3/library/unittest.html)
> 2. [Real Python: python testing](https://realpython.com/python-testing/)
> 3. [Flask Document: testing](http://flask.pocoo.org/docs/1.0/testing/)