Python has a testing module called `unittest` in its standard library. Being in the standard library means the module is included in Python itself, so there's no need to install anything to use it. 

It's common to see test files that import `unittest` and test classes that use the library to implement tests.

Classes and inheritance are the basis for using `unittest` to write tests. So, it isn't possible to write test functions or other tests that don't use the base class from `unittest`.

## Write tests using unittest

Writing tests with `unittest` requires importing the module and creating at least one class that inherits from the `unittest.TestCase` class. Here's how an example test looks in a file called *test_assertions.py*:

```python
import unittest

class TestAssertions(unittest.TestCase):

    def test_equals(self):
        self.assertEqual("one string", "one string")
        
if __name__ == '__main__':
    unittest.main()
```

There are several essential items in the file that are required for the test to work. From naming conventions to particular methods that, when combined, allow a test file to be executed.

### Run tests

There are two ways to run a test file. Let's look again at the end of the *test_assertions.py* file, where the `unittest.main()` call allows running the tests by executing the file with Python:

```python
if __name__ == '__main__':
    unittest.main()
```

The test run is possible because of the `if` block at the end, where the condition is only met when running the script directly with Python. Let's check the output when running it in that way:

```bash
$ python test_assertions.py
.
----------------------------------------------------------------------
Ran 1 test in 0.000s

OK
```

Another way to run tests with the `unittest` module is by using it with the Python executable. This time, it isn't necessary to specify the filename because tests can be discovered automatically:

```bash
$ python -m unittest
.
----------------------------------------------------------------------
Ran 1 test in 0.000s

OK

```

> [!NOTE]
> Test discovery is only possible when you follow naming conventions for methods, classes, and files. If the file does not start with the word *test*, it won't get executed. 

### Naming conventions

The class and method names follow a test convention. The convention is that they need to be prefixed with `test`. Although it isn't required, test classes use camel-casing, and test methods are lower-case, and words are separated with an underscore. For example, here's how a test for customer accounts that verify creation and deletion could look:

```python
class TestAccounts(unittest.TestCase):

    def test_creation(self):
        self.assertTrue(account.create())

    def test_deletion(self):
        self.assertTrue(account.delete())
```

Test classes or methods that don't follow these conventions won't get run. Although it might seem like a problem not to run every single method in a class, it can be helpful when creating non-test code.

### Assertions and assert methods

It's essential to use assert methods instead of Python's built-in `assert()` function to have rich reporting when failures happen. The *test_assertion.py* example uses `self.assertEqual()`, one of the many special methods from the `unittest.TestCase` class to ensure that two values are equal:

```python
self.assertEqual("one string", "one string")
```

In this case, both strings are equal, so the test passes. Testing for equality is one of the many different assertions that the `unittest.TestCase` class offers. Although there are more than 30 assert methods, the following are most commonly used aside from `self.assertEqual()`:

* `self.assertTrue(value)`: Ensure that `value` is true. 
* `self.assertFalse(value)`: Ensure that `value` is false.
* `self.assertNotEqual(a, b)`: Check that `a` and `b` aren't equal.

> [!NOTE]
> Python data structures like dictionaries and lists evaluate as true when they have at least one item in them and false when they are empty. Avoid evaluating data structures in this way with `assertTrue()` and `assertFalse()` to prevent unexpected items from going undetected. It is preferable to be as accurate as possible when testing.

### Failures and reporting

Passing tests are a great way to ensure robustness. Still, understanding failure reporting is crucial to update and fix production code.

In the next example, we change one of the strings from `"one string"` to `"other string"`. Then, we execute the test with Python. Here's how the output looks now:

```bash
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

The test shows an assertion failure because the strings are different. The report enhances the assertion error to show the strings are mismatched on a few characters. It's helpful to check where exactly the error happened because it narrows the area where the problem is. In this case, it's in the *test_assertions.py* file on line six.
