Python has a testing module called `unittest` in its standard library. Being in the standard library means the module is included in Python itself, so there's no need to install anything to use it. 

It's common to see test files that import `unittest` and test classes that use the library to implement tests.

Classes and inheritance are the basis for using `unittest` to write tests. So, it isn't possible to write test functions or other tests that don't use the base class from `unittest`.

## Write tests using unittest

Create a new file called *test_assertions.py* and add the following code:

```python
import unittest

class TestAssertions(unittest.TestCase):

    def test_equals(self):
        self.assertEqual"one string", "one string")
        
if __name__ == '__main__':
    unittest.main()
```

There are several essential items in the file that are required for the test to work. From naming conventions to particular methods that combined allow a test file to get executed.

### Running tests

There are two ways to run a test file. At the end of the *test_assertions.py* file, the `unittest.main()` call allows running the tests by executing the file with Python:

```
$ python test_assertions.py
.
----------------------------------------------------------------------
Ran 1 test in 0.000s

OK
```

The test run is possible because of the `if` block at the end, where the condition is only met when running the script directly with Python.

Another way to run tests with `unittest` is by using the module with the Python executable. This time, it isn't necessary to specify the filename because tests can be discovered automatically:

```
$ python -m unittest
.
----------------------------------------------------------------------
Ran 1 test in 0.000s

OK

```

> [!Note]
> Test discovery is only possible when following naming conventions for methods, classes, and files. If the file does not start with the word *test*, it will not get executed. 

### Naming conventions

The class and method names are following a test convention. The convention is that they need to be prefixed with `test`. Although it isn't required, test classes use camel-casing, and test methods are lower-case, and words are separate with an underscore.  

Test classes or methods that don't follow these conventions won't get run. Although it might seem like a problem not to run every single method in a class, it can be helpful when creating non-test code.

If using test discovery with `unittest`, then test files require the *test* prefix. 

### Assertions and assert methods

It's essential to use assert methods instead of Python's built-in `assert()` function to have rich reporting when failures happen. The *test_assertion.py* uses `self.assertEqual()`, one of the many special methods from the `unittest.TestCase` class to ensure that two values are equal:

```python
self.assertEqual("one string", "one string")
```

In this case, both strings are equal, so the test passes. Testing equality is one of the many different assertions that the `unittest.TestCase` class offers. Although there are over 30 assert methods, these are most commonly used aside from `self.assertEqual()`:

* `self.assertTrue(value)`: Ensure that `value` is true. 
* `self.assertFalse(value)`
* `self.assertNotEqual(a, b)`

> [!Note]
> Python data structures like dictionaries and lists evaluate as true when they have at least one item in them and false when they are empty. Avoid evaluating data structures in this way with `assertTrue()` and `assertFalse()` to prevent unexpected items go undetected. It is preferable to be as accurate as possible when testing.

### Failures and reporting

Passing tests are a great way to ensure robustness. Still, understanding failure reporting is crucial to update and fix production code. 

Update the *test_assertion.py* file so that the strings are different. In the next example, I change one of the strings from `"one string"` to `"other string"`, run the tests, and inspect the output:

```
$ python test_assertions.py
F
======================================================================
FAIL: test_equals (__main__.TestAssertions)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/private/tmp/test_assertions.py", line 6, in test_equals
    self.assertEqual("one string", "other string")
AssertionError: 'one string' != 'other string'
- one string
?  ^
+ other string
?  ^^ +


----------------------------------------------------------------------
Ran 1 test in 0.001s

FAILED (failures=1)
```

The test shows an assertion failure because the strings are different. The report enhances the assertion error to show the strings are mismatched on a few characters. It's helpful to check where exactly the error happened. In this case, it's in the *test_assertions.py* file on line six.