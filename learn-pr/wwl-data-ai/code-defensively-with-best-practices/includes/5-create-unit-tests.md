## Create unit tests

Suppose you write a function that calculates a discount and test it by hand. Later you refactor the function. You have to test it by hand again, and it's easy to forget.

**Unit tests** are automated checks that verify your code works correctly. You write them once and run them whenever the code changes.

### Write a simple test

The following code defines a function and a test for it:

```python
def calculate_discount(price: float, discount_percent: float) -> float:
    """Calculate price after applying a discount."""
    return price * (1 - discount_percent / 100)

# Test it
def test_calculate_discount():
    # No discount should return original price
    result = calculate_discount(100, 0)
    assert result == 100, "No discount should return original price"
    
    # 50% discount should return half price
    result = calculate_discount(100, 50)
    assert result == 50, "50% discount should return half price"
    
    print("All tests passed!")

# Run the test
test_calculate_discount()
```

```output
All tests passed!
```

The `assert` statement checks that a condition is true. If the condition is false, Python raises an `AssertionError` with your message. For example, if `calculate_discount(100, 50)` returned `60`, the program would stop with:

```output
Traceback (most recent call last):
  ...
AssertionError: 50% discount should return half price
```

The test checks the result for you, so you don't have to check it by hand each time.

These checks compare numbers exactly, which works here because the results are whole numbers. For decimal results, compare with a tolerance, such as `math.isclose(result, expected)`, because small rounding differences can make an exact comparison fail.

> [!NOTE]
> Python ignores `assert` statements when you run it with the `-O` option. Use `assert` in tests. Use `if` and `raise` to validate input in your program, as you learned in the previous unit.

### Why tests matter

Tests give you three benefits:

1. **Confidence**: When tests pass, the code works for the cases you tested.
2. **Safety**: When you refactor code, tests show whether you broke something.
3. **Documentation**: Tests show how to use your functions.

### Run multiple tests

When you have several functions, use Python's `unittest` framework to organize and run your tests. Put the functions in `calculator.py`:

```python
# calculator.py
def add(a: float, b: float) -> float:
    """Return the sum of a and b."""
    return a + b

def subtract(a: float, b: float) -> float:
    """Return a minus b."""
    return a - b

def divide(a: float, b: float) -> float:
    """Return a divided by b. Raise ValueError if b is zero."""
    if b == 0:
        raise ValueError("b must not be zero")
    return a / b
```

Put the tests in `test_calculator.py`:

```python
# test_calculator.py
import unittest
from calculator import add, subtract, divide

class TestCalculator(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(2, 3), 5)

    def test_divide(self):
        self.assertEqual(divide(10, 4), 2.5)

    def test_divide_by_zero(self):
        with self.assertRaises(ValueError):
            divide(10, 0)

    def test_subtract(self):
        self.assertEqual(subtract(5, 2), 3)
```

The `TestCase` class provides assertion methods such as `assertEqual`, which checks that two values are equal, and `assertRaises`, which checks that code raises a specific exception.

The `divide(10, 0)` test covers an **edge case**, an input that's easy to get wrong. It also confirms that the validation in `divide` works.

From the folder that contains both files, run:

```console
python -m unittest test_calculator -v
```

```output
test_add (test_calculator.TestCalculator.test_add) ... ok
test_divide (test_calculator.TestCalculator.test_divide) ... ok
test_divide_by_zero (test_calculator.TestCalculator.test_divide_by_zero) ... ok
test_subtract (test_calculator.TestCalculator.test_subtract) ... ok

----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
```

> [!NOTE]
> This output uses the Python 3.11 and later format. Earlier versions show `test_add (test_calculator.TestCalculator)` instead.

When a test fails, `unittest` shows the expected and actual values. In this example, `subtract(5, 2)` returns `4` but the test expects `3`:

```output
======================================================================
FAIL: test_subtract (test_calculator.TestCalculator.test_subtract)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "test_calculator.py", line 17, in test_subtract
    self.assertEqual(subtract(5, 2), 3)
AssertionError: 4 != 3
```

Either the code or the test is wrong. Check both.

### Write tests first (optional)

In **test-driven development**, you write the test **before** the function. Start with the test:

```python
def test_is_even():
    assert is_even(2)
    assert not is_even(3)
    assert is_even(0)

test_is_even()
```

Run the test. It fails because `is_even` doesn't exist yet:

```output
NameError: name 'is_even' is not defined
```

Then write `is_even` above the test:

```python
def is_even(number):
    return number % 2 == 0
```

Run the test again. It passes. Writing the test first forces you to decide what the function should do before you write it.

### Start testing

Follow these steps:
1. Write a function.
2. Test the happy path, the normal case.
3. Test edge cases, such as empty input, zero, negative numbers, and invalid values.
4. Run the tests after every change.

Tests give you a safety net. When you refactor, they will likely catch mistakes.
