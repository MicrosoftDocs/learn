The _parametrize_ feature in pytest might initially seem complex, but its purpose is straightforward once you understand the problem it addresses. Essentially, _parametrize_ allows you to run the same test function with different inputs efficiently, making it easier to run detailed and varied assertions with less code.

When calling _parametrize_, the first argument is a string containing one or more argument names, for example, `"test\_input_"`. The second argument contains a list of argument values, for example, `["27", "6+9", "0", "O"]`. The last four arguments have default values and are optional.

You can find the English language pytest API reference for _parametrize_ here: [pytest.Metafunc.parametrize](https://docs.pytest.org/en/7.1.x/reference/reference.html?hightlight=parametrize#pytest-Metafunc.parametrize). 

## When to use parametrize

Two common scenarios where you might want to use _parametrize_ include:

* When testing _for_ loops
* When multiple tests assert the same behavior

Let's review each example first without using _parametrize_, and then with it to show how it can improve our tests.


### For loops

Here's an example of a test function with a `for` loop:

```python
def test_string_is_digit():
    items = ["1", "10", "33"]
    for item in items:
        assert item.isdigit()
```

This test is problematic because if it fails, it can lead to several issues, including:

- **Ambiguous test reports:** The test report doesn't clarify whether only one item failed or if there are multiple failures.
- **Single test view:** All items are seen as a single test, which obscures individual item performance.
- **Uncertain fixes:** If a failure is corrected, there's no way to know if all issues are resolved without rerunning the entire test.

Let's modify the test to specifically include two items that are expected to fail:

```python
def test_string_is_digit():
    items = ["No", "1", "10", "33", "Yes"]
    for item in items:
        assert item.isdigit()
```

Running the test shows only one failure even though there are two invalid items in that list:

```bash
$ pytest test_items.py
=================================== FAILURES ===================================
_____________________________ test_string_is_digit _____________________________
test_items.py:4: in test_string_is_digit
    assert item.isdigit()
E   AssertionError: assert False
E    +  where False = <built-in method isdigit of str object at 0x103fa1df0>()
E    +    where <built-in method isdigit of str object at 0x103fa1df0> = 'No'.isdigit
=========================== short test summary info ============================
FAILED test_items.py::test_string_is_digit - AssertionError: assert False
============================== 1 failed in 0.01s ===============================
```

This is a great use case for _parametrize_. Before we can see how to update the test, let's explore another common situation that doesn't involve `for` loops.

### Tests that assert the same behavior

A group of tests that make the same assertion are also a good candidate for _parametrize_. If the previous test was rewritten with one test for each item, it would allow for better failure reporting, but it would be repetitive:

```python
def test_is_digit_1():
    assert "1".isdigit()

def test_is_digit_10():
    assert "10".isdigit()

def test_is_digit_33():
    assert "33".isdigit()
```

These tests are better in the sense that a failure can be easily associated with a single input. And although it might seem unusual to have several similar tests, it’s common to see in production test suites that try to be granular.

Although the tests would be better because they can report exactly what fails (or passes) they also come with the following issues:

- Code is repetitive, which creates a maintenance burden
- There’s potential for typos and mistakes when updating the tests
- Because they’re repetitive, engineers might not include all use cases and inputs
 
## How to use parametrize

Now that you’re aware of some of the use cases for _parametrize_, let's update the test that used a `for` loop that includes failing items.

To use _parametrize_, you must import `pytest` as a library, and then use it as a decorator in the function. Here's the updated test:

```python
import pytest

@pytest.mark.parametrize("item", ["No", "1", "10", "33", "Yes"])
def test_string_is_digit(item):
    assert item.isdigit()
```

Before running the tests, let's go over the changes.

The `pytest.mark.parametrize()` decorator defines two arguments. The first argument is a string called `"item"`. That string is used as the _named argument_ for the test function that you see in the next line in the test function definition. The second argument is the list of test values.


### Rich error reporting

Behind the scenes, pytest considers each item in that list _as a separate test_. That means that passing and failing tests gets reported separately. Let's see what happens when running the test with `pytest`:

```bash
$ pytest test_items.py
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0
rootdir: /private
collected 5 items

test_items.py F...F                                                      [100%]

=================================== FAILURES ===================================
___________________________ test_string_is_digit[No] ___________________________
test_items.py:5: in test_string_is_digit
    assert item.isdigit()
E   AssertionError: assert False
E    +  where False = <built-in method isdigit of str object at 0x102d45e30>()
E    +    where <built-in method isdigit of str object at 0x102d45e30> = 'No'.isdigit
__________________________ test_string_is_digit[Yes] ___________________________
test_items.py:5: in test_string_is_digit
    assert item.isdigit()
E   AssertionError: assert False
E    +  where False = <built-in method isdigit of str object at 0x102d45df0>()
E    +    where <built-in method isdigit of str object at 0x102d45df0> = 'Yes'.isdigit
=========================== short test summary info ============================
FAILED test_items.py::test_string_is_digit[No] - AssertionError: assert False
FAILED test_items.py::test_string_is_digit[Yes] - AssertionError: assert False
========================= 2 failed, 3 passed in 0.07s ==========================
```

There are a few notable items in the test reporting. First, we see that from a single test pytest is reporting five tests in total: three passing and two failing. The failures are reported separately, including what the failing input is.

```bash
$ pytest test_items.py
___________________________ test_string_is_digit[No] ___________________________
[...]
E    +    where <built-in method isdigit of str object at 0x102d45e30> = 'No'.isdigit
[...]
FAILED test_items.py::test_string_is_digit[No] - AssertionError: assert False
```

It's hard to miss the value that caused the failure with so many places where it gets reported. 


### Use the verbose output flag 

When the tests are run in the command-line, the test reporting when test pass is minimal. Here's how the test would look after an update to fix the failures:

```python
@pytest.mark.parametrize("item", ["0", "1", "10", "33", "9"])
def test_string_is_digit(item):
    assert item.isdigit()
```

And running the tests produces minimal output:

```bash
$ pytest test_items.py 
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0
rootdir: /private
collected 5 items

test_items.py .....                                                      [100%]

============================== 5 passed in 0.01s ===============================
```

Increasing the verbosity shows the values that pytest runs for each test when using _parametrize_:

```bash
$ pytest -v test_items.py
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0 
rootdir: /private
collected 5 items

test_items.py::test_string_is_digit[0] PASSED                            [ 20%]
test_items.py::test_string_is_digit[1] PASSED                            [ 40%]
test_items.py::test_string_is_digit[10] PASSED                           [ 60%]
test_items.py::test_string_is_digit[33] PASSED                           [ 80%]
test_items.py::test_string_is_digit[9] PASSED                            [100%]

============================== 5 passed in 0.01s ===============================
```

## How to use multiple argument names

The examples we've seen so far just have one argument name in the first argument. We've been using `"item"` but you can include multiple argument names in the string that specifies the first argument separated by commas. 

One use case for using multiple argument names is if you want to pass in a set of expected values to test against your input value. In your second argument, each item in your set needs to have a quantity of values equal to the number of input names. For example, if your input names are `"test\_input, expected\_value"`, then your second argument might look something like this: [("3+5", 8), ("3*4", 12)]

This test verifies if an object has an attribute using the Python `hasattr()` function. It returns a boolean depending on whether the object possesses the associated attribute.

```python
>>> hasattr(dict(), "keys")
True
>>> hasattr("string", "append")
False
```

Since `hasattr()` requires two arguments, we can use _parametrize_ in the following way:

```python
@pytest.mark.parametrize("item, attribute", [("", "format"), (list(), "append")])
def test_attributes(item, attribute):
    assert hasattr(item, attribute)
```

The _parametrize_ decorator still uses a single string for the first argument but with two argument names separated by a comma, which become arguments to the test function. In this case, it’s `item` and `attribute`.

Next is a list of two pairs of items. Each of these pairs represents an `item` and an `attribute` to test for.

When pytest can't build a string representation of the objects being passed in, it creates one. You can see this when running the test:

```bash
$ pytest -v test_items.py
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0 
rootdir: /private
collected 2 items

test_items.py::test_attributes[-format] PASSED                           [ 50%]
test_items.py::test_attributes[item1-append] PASSED                      [100%]

============================== 2 passed in 0.01s ===============================
```
