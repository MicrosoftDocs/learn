The `@pytest.mark.parametrize()` decorator lets one test function run several times with different input values. Use it when the assertion logic is the same but the examples vary. Parametrization can reduce repetition and lets pytest report each input as its own test item.

The decorator usually takes two required arguments:

- `argnames`: A comma-separated string, or a list or tuple of strings, with the names of the arguments to pass to the test function. Examples include `"item"`, `"test_input, expected"`, `["test_input", "expected"]`, and `("test_input", "expected")`.
- `argvalues`: An iterable of values or parameter sets to use for those arguments. With one argument name, each item is passed as one test value, even if that value is a tuple. With multiple argument names, each item must provide one value for each argument name, usually as a tuple, list, or `pytest.param(...)` call.

The optional `ids` argument lets you customize the test ID that pytest uses to label each generated test item. More advanced options, such as `indirect` and `scope`, are useful for cases such as parametrized fixtures or expensive resources; you can read about them in pytest's [parametrization how-to](https://docs.pytest.org/en/stable/how-to/parametrize.html) and [`@pytest.mark.parametrize` reference](https://docs.pytest.org/en/stable/reference/reference.html#pytest-mark-parametrize-ref).

> [!NOTE]
> Pytest passes parameter values to tests as-is; it doesn't copy them. If a test mutates a mutable parameter value, such as a list or dictionary, that mutation can be visible in later generated cases that receive the same object.

## When to use parametrize

Two common scenarios where you might want to use `@pytest.mark.parametrize()` include:

- When a test loops over inputs and repeats the same assertion
- When multiple test functions assert the same behavior with different inputs

Let's review each example first without using `@pytest.mark.parametrize()`, and then with it to show how it can make tests easier to maintain and diagnose.

### For loops

Here's an example of a test function with a `for` loop:

```python
def test_string_is_digit():
    items = ["1", "10", "33"]
    for item in items:
        assert item.isdigit()
```

This pattern can be hard to diagnose when one input fails:

- **Incomplete feedback:** The first failing assertion stops the loop, so later values aren't evaluated in that run.
- **Single test result:** Pytest reports one collected test rather than one test case per input.
- **Repeated reruns:** Fixing the first failure might reveal another failure only after you run the test again.

Let's modify the test to include two items that will fail the assertion:

```python
def test_string_is_digit():
    items = ["No", "1", "10", "33", "Yes"]
    for item in items:
        assert item.isdigit()
```

Running the test shows only the first failure, even though there are two invalid items in the list. The command examples use `python -m pytest`, which works when Python is available as `python`. If your shell uses `python3` on macOS or Linux, or `py` on Windows, substitute that command.

```console
python -m pytest test_items.py
=================================== FAILURES ===================================
_____________________________ test_string_is_digit _____________________________

    def test_string_is_digit():
        items = ["No", "1", "10", "33", "Yes"]
        for item in items:
>           assert item.isdigit()
E           AssertionError: assert False
E            +  where False = <built-in method isdigit of str object at 0x...>()
E            +    where <built-in method isdigit of str object at 0x...> = 'No'.isdigit

test_items.py:4: AssertionError
=========================== short test summary info ============================
FAILED test_items.py::test_string_is_digit - AssertionError: assert False
============================== 1 failed in 0.01s ===============================
```

Pytest's assertion-introspection output shows the bound `str.isdigit` method and the string value that triggered the failure. Session headers, platform details, memory addresses, and run times can vary, so the examples omit or shorten them with `...` and `0x...`. The relevant detail is that the loop stops at the first failure (`'No'`) and never evaluates `'Yes'`.

This is a useful case for `@pytest.mark.parametrize()`. Before we update the test, let's explore another common situation that doesn't involve `for` loops.

### Tests that assert the same behavior

A group of tests that make the same assertion are also good candidates for `@pytest.mark.parametrize()`. If the previous test was rewritten with one test for each item, it would allow for better failure reporting, but it would be repetitive:

```python
def test_is_digit_1():
    assert "1".isdigit()

def test_is_digit_10():
    assert "10".isdigit()

def test_is_digit_33():
    assert "33".isdigit()
```

These tests are more granular because a failure can be associated with a single input. Although it might seem unusual to have several similar tests, this pattern is common in production test suites that try to report failures precisely.

However, repetitive tests come with the following issues:

- Code is repetitive, which creates a maintenance burden.
- Similar functions are easy to update inconsistently.
- Adding a new input requires copying another test body, so important cases can be overlooked.

Parametrization keeps the reporting benefit of separate test items without copying the same test body.

## How to use parametrize

Now that you’re aware of some use cases for `@pytest.mark.parametrize()`, let's update the test that used a `for` loop with failing items.

Import `pytest`, and then apply `@pytest.mark.parametrize()` directly above the test function:

```python
import pytest

@pytest.mark.parametrize("item", ["No", "1", "10", "33", "Yes"])
def test_string_is_digit(item):
    assert item.isdigit()
```

Before running the tests, let's go over the changes.

In this example, the decorator receives two arguments. The first argument, `"item"`, names the argument that pytest passes into the test function. The name must match the `item` parameter in `test_string_is_digit(item)`. The second argument is the list of values that pytest uses for the generated test cases.

### Rich error reporting

Behind the scenes, pytest collects one test item for each value in the parameter list. That means passing and failing cases are reported separately. Let's see what happens when running the test:

```console
python -m pytest test_items.py
============================= test session starts ==============================
...
collected 5 items

test_items.py F...F                                                      [100%]

=================================== FAILURES ===================================
___________________________ test_string_is_digit[No] ___________________________

item = 'No'

    @pytest.mark.parametrize("item", ["No", "1", "10", "33", "Yes"])
    def test_string_is_digit(item):
>       assert item.isdigit()
E       AssertionError: assert False
E        +  where False = <built-in method isdigit of str object at 0x...>()
E        +    where <built-in method isdigit of str object at 0x...> = 'No'.isdigit

test_items.py:5: AssertionError
__________________________ test_string_is_digit[Yes] ___________________________

item = 'Yes'

    @pytest.mark.parametrize("item", ["No", "1", "10", "33", "Yes"])
    def test_string_is_digit(item):
>       assert item.isdigit()
E       AssertionError: assert False
E        +  where False = <built-in method isdigit of str object at 0x...>()
E        +    where <built-in method isdigit of str object at 0x...> = 'Yes'.isdigit

test_items.py:5: AssertionError
=========================== short test summary info ============================
FAILED test_items.py::test_string_is_digit[No] - AssertionError: assert False
FAILED test_items.py::test_string_is_digit[Yes] - AssertionError: assert False
========================= 2 failed, 3 passed in 0.07s ==========================
```

There are a few notable items in the test report. First, pytest reports five collected items from a single test function: three passing and two failing. Failures are reported separately, including the input value that caused each failure. The header `test_string_is_digit[No]` shows the parameter set, and the parameter local `item = 'No'` appears above the source view. The bound-method introspection lines (memory addresses shown as `0x...`) confirm which value triggered the assertion failure:

```text
___________________________ test_string_is_digit[No] ___________________________

item = 'No'
[...]
FAILED test_items.py::test_string_is_digit[No] - AssertionError: assert False
```

It's hard to miss the value that caused the failure with so many places where it gets reported.

### Use the verbose output flag

When tests pass, command-line reporting is minimal by default. Here's how the test would look after an update to fix the failures (continue editing the same `test_items.py` so `import pytest` is already present):

```python
@pytest.mark.parametrize("item", ["0", "1", "10", "33", "9"])
def test_string_is_digit(item):
    assert item.isdigit()
```

Running the tests produces minimal output:

```console
python -m pytest test_items.py
============================= test session starts ==============================
...
collected 5 items

test_items.py .....                                                      [100%]

============================== 5 passed in 0.01s ===============================
```

Increasing the verbosity shows each generated test case and its generated parameter ID:

```console
python -m pytest -v test_items.py
============================= test session starts ==============================
...
collected 5 items

test_items.py::test_string_is_digit[0] PASSED                            [ 20%]
test_items.py::test_string_is_digit[1] PASSED                            [ 40%]
test_items.py::test_string_is_digit[10] PASSED                           [ 60%]
test_items.py::test_string_is_digit[33] PASSED                           [ 80%]
test_items.py::test_string_is_digit[9] PASSED                            [100%]

============================== 5 passed in 0.01s ===============================
```

## How to use multiple argument names

The examples we've seen so far use one argument name: `"item"`. You can also include multiple argument names in the first argument. When you use a string, separate the names with commas. You can also pass the names as a list or tuple, such as `["item", "attribute"]` or `("item", "attribute")`.

One use case for multiple argument names is passing an input value and the expected value to test against it. In the second argument, each parameter set needs one value for each argument name. For example, if the argument names are `"test_input, expected_value"`, the argument values might be `[("3+5", 8), ("3*4", 12)]`.

The next example uses Python's [`hasattr()`](https://docs.python.org/3/library/functions.html#hasattr) function, which returns a boolean value depending on whether an object has a named attribute:

```python
>>> hasattr(dict(), "keys")
True
>>> hasattr("string", "append")
False
```

Each test case needs an object and an attribute name, so we can use `@pytest.mark.parametrize()` in the following way. Continue in the same `test_items.py` file so `import pytest` is already in place:

```python
@pytest.mark.parametrize("item, attribute", [("", "format"), (list(), "append")])
def test_attributes(item, attribute):
    assert hasattr(item, attribute)
```

The `@pytest.mark.parametrize()` decorator still uses a single string for the first argument, but that string now contains two argument names separated by a comma. The names become arguments to the test function. In this case, they are `item` and `attribute`. A list or tuple of names works the same way.

The second argument is a list with two parameter sets. Each parameter set contains one `item` value and one `attribute` value. If a parameter set has too few or too many values for the argument names, pytest raises a collection error before it runs the test cases.

Pytest builds a test ID for each parameter set. For simple values such as numbers, strings, booleans, and `None`, pytest uses the value's usual string representation. For other objects, pytest falls back to a name based on the argument name and the parameter set's zero-based index. In this output, the empty string contributes an empty ID part, so the dash separator between the two IDs is still visible in `[-format]`. Because `list()` doesn't have a simple generated ID, pytest substitutes `item1`:

```console
python -m pytest -v test_items.py::test_attributes
============================= test session starts ==============================
...
collected 2 items

test_items.py::test_attributes[-format] PASSED                           [ 50%]
test_items.py::test_attributes[item1-append] PASSED                      [100%]

============================== 2 passed in 0.01s ===============================
```

If generated IDs are hard to read, you can pass the optional `ids` argument or wrap a parameter set in `pytest.param(..., id="name")` to supply a clearer name. For example:

```python
import pytest


@pytest.mark.parametrize(
    "item, attribute",
    [
        pytest.param("", "format", id="empty-string-format"),
        (list(), "append"),
    ],
)
def test_attributes(item, attribute):
    assert hasattr(item, attribute)
```

The `pytest.param("", "format", id="empty-string-format")` call supplies the whole ID for that parameter set, replacing the auto-generated `-format` ID. In verbose output, the generated tests are named `test_attributes[empty-string-format]` and `test_attributes[item1-append]`. Clear IDs make verbose output and failure messages easier to scan.
