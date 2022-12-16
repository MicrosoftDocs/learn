The _parametrize_ feature of Pytest might seem intimidating at first. It becomes immediately clear once you grasp the problem it solves. In most cases, the parametrize feature allows you to easily provide different inputs to a test that performs the same assertion.

## When to use it

There are two common scenarios that present a perfect reason to use _parametrize_. In both cases, you should be aware of the drawbacks. You should try to prevent these drawbacks, and luckily, Pytest offers a better way to solve them. Let's go through each of these cases in detail.


### For-loops

If you've ever seen a test that uses a for-loop to make assertions based on different inputs, that is a perfect scenario to use parametrize. This is how a test function with a for loop could look:

```python
def test_string_is_digit():
    items = ["1", "10", "33"]
    for item in items:
        assert item.isdigit()
```

Such a test is problematic because if one of the items fails, you find yourself with these issues:

- The test report can't tell if just one item fails or there are other items that should fail
- All combinations are seen as a single test
- If you fix a failure, you can't tell if you've fixed all failures, forcing to rerun the test again

Let's modify the test so that it has two items that should fail:

```python
def test_string_is_digit():
    items = ["No", "1", "10", "33", "Yes"]
    for item in items:
        assert item.isdigit()
```

Running the test shows only one failure even though there are two invalid items in that list:

```bash
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

This is a perfect use case for _parametrize_. Before we can see how to update the test, let's explore another common situation that doesn't involve for-loops.

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

These tests are better in the sense that a failure can be easily associated with a single input, and although it might seem out of the ordinary to have several similar tests, it’s actually common to see in production test suites that try to be granular.

Although the tests would be better because they can report exactly what fails (or passes) they also come with the following issues:

- Code is very repetitive, which creates unnecessary maintenance burden
- There’s potential for typos and mistakes when updates need to happen to all these tests
- Because they’re repetitive, engineers might avoid all use cases and inputs
 
## Use parametrize

Now that you’re aware of some of the use cases for _parametrize_, let's update the test that is using for-loop that includes failing items, which currently looks like the following:

```python
def test_string_is_digit():
    items = ["No", "1", "10", "33", "Yes"]
    for item in items:
        assert item.isdigit()
```

To use _parametrize_, you must import `pytest` as a library, and then use it as a decorator in the function, this is how the updated test should look now:

```python
import pytest

@pytest.mark.parametrize("item", ["No", "1", "10", "33", "Yes"])
def test_string_is_digit(item):
    assert item.isdigit()
```

Before running the tests, let's go over the changes. The `pytest.mark.parametrize()` decorator defines two arguments. The first argument is a string called `"item"`. That string is used as the _named argument_ for the test function that you see in the next line in the test function definition. The other argument is the list of items.

### Rich error reporting

Behind the scenes, Pytest will consider each item in that list _as a separate test_. That means that all passing and failing tests will get reported separately. Let's see what happens when running the test with `pytest`:

```bash
$ pytest
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

There are a few notable items in the test reporting. First, we see that from a single test Pytest is reporting five tests in total: three passing and two failing. The failures are reported separately, including what the failing input is. For example, the string `"No"` is reported in three places: one in the title of the failure section, then the assertion error, and finally in the failure line towards the end:

```bash
___________________________ test_string_is_digit[No] ___________________________
[...]
E    +    where <built-in method isdigit of str object at 0x102d45e30> = 'No'.isdigit
[...]
FAILED test_items.py::test_string_is_digit[No] - AssertionError: assert False
```

It's hard to miss the value that caused the failure with so many places where it gets reported. 


### Useful passing reporting 

When running the tests in the command-line, the test reporting when tests are passing is minimal. This is how the test would look after an update to fix the failures:

```python
@pytest.mark.parametrize("item", ["0", "1", "10", "33", "9"])
def test_string_is_digit(item):
    assert item.isdigit()
```

And running the tests produces minimal output:

```bash
$ pytest 
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0
rootdir: /private
collected 5 items

test_items.py .....                                                      [100%]

============================== 5 passed in 0.01s ===============================
```

But increasing the verbosity can include the values that Pytest sees for each test when parametrizing:

```bash
pytest -v test_items.py
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

## Use multiple arguments

So far you've seen using a single argument and multiple items for _parametrize_. However, it’s possible to use multiple arguments. 

> [!TIP]
> Although using multiple arguments is possible, try not to overdo this feature as it can make tests harder to read.

We have a test that wants to check if an object has an attribute. For this test, we'll use the `hasattr()` built-in function from Python. It returns a boolean depending on the attribute of the object. Here’s a quick example of how that works:

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

The _parametrize_ decorator still uses a single string for the first argument but with two words. These two words within the string, are now separated by a comma. Each comma-separated word becomes an argument to the function. In this case, it’s `item` and `attribute`.

Next, the list of items to pass is a list of two items. Each of these pairs represents an `item` and an `attribute` to test for.

When Pytest can't build a string representation of the objects being passed in, it will create one. You can see this in action when running the test:

```bash
$ pytest -v
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0 
rootdir: /private
collected 2 items

test_items.py::test_attributes[-format] PASSED                           [ 50%]
test_items.py::test_attributes[item1-append] PASSED                      [100%]

============================== 2 passed in 0.01s ===============================
```
