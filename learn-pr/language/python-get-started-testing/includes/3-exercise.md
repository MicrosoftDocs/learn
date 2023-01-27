In this exercise, you'll take advantage of the `unittest` module, which is included in Python's standard library to write tests and fix bugs. Passing tests ensures that code is behaving as expected, increasing the confidence that new changes aren't breaking previous functionality.

## Step 1 - Add a file for this exercise

1. Using Python's filename conventions for test files, create a new test file. Name the test file *test_exercise.py* and add the following code:

    ```python
    def str_to_bool(value):
        true_values = ['y','yes']
        false_values = ['no', 'n']
    
        if value in true_values:
            return True
        if value in false_values:
            return False
    ```

    The function `str_to_bool()` takes a string as input, and its job is to return a `True` or `False` depending on the contents of the string. For example if the string is `y` it would return `True`. Similarly, if the string is `no`, it would return `False`.

2. In the same file, append the tests for the function:

    ```python
    import unittest
    
    class TestStrToBool(unittest.TestCase):
    
        def test_y_is_true(self):
            result = str_to_bool('y')
            self.assertTrue(result)
    
        def test_yes_is_true(self):
            result = str_to_bool('Yes')
            self.assertTrue(result)
    
    if __name__ == '__main__':
        unittest.main()
    ```

## Step 2 - Run the tests and identify the failure

Now the test file has a function to test and a couple of tests to verify its behavior. It's time to run the tests and work with failures.

- Execute the file with Python:

    ```bash
    $ python test_exercise.py
    ```

    The run should complete with one test passing and one failure, and the failure output should be similar to the following output:

    ```bash
    .F
    ======================================================================
    FAIL: test_yes_is_true (__main__.TestStrToBool)
    ----------------------------------------------------------------------
    Traceback (most recent call last):
      File "/private/tmp/test_exercise.py", line 20, in test_yes_is_true
        self.assertTrue(result)
    AssertionError: None is not true
    
    ----------------------------------------------------------------------
    Ran 2 tests in 0.000s
    
    FAILED (failures=1)
    ```

    The output points out that the `test_yes_is_true()` test is failing. It uses `'Yes'` as input to the `str_to_bool()` function, which isn't part of the `true_vals` list. Because the function doesn't see `'Yes'` as part of any of the values it ends up returning an implicit `None`, which is why the error states: `None is not true`.

## Step 3 - Fix the bug and make the tests pass

Now that the error has pointed out the capitalized `'Yes'` string input, the bug needs to be fixed. Although the test can be updated to use the lowercase word (`'yes'`) to make it pass, the fix is going to make the function work with any casing. That means that any of these options should work: `YES`, `YeS`, `yES`, `yes`, `yeS`, `Y`, `y`.

1. Update the `str_to_bool()` function to reassign the `value` variable to be lowercase using `value.lower()`. The updated function should look like this:

    ```python
    def str_to_bool(value):
        value = value.lower()
        true_values = ['y','yes']
        false_values = ['no', 'n']
    
        if value in true_values:
            return True
        if value in false_values:
            return False
    ```

2. Rerun the test script:

    ```bash
    $ python test_exercise.py
    ```

3. Now verify the output. It should show two passing tests now:

    ```bash
    ..
    ----------------------------------------------------------------------
    Ran 2 tests in 0.000s
    
    OK
    ```

> [!NOTE]
> Since the function is able to work with more values of different casing, more tests should be added to cover those variations. This would prevent future changes to the function from causing a different (unexpected) behavior.

## Step 4 - Add new code with tests

Part of the idea of working with tests is getting validation for changes. Even if the changes are updating existing code or adding new functionality, tests increase the confidence that everything still works as expected.

In this case, the function being tested only works with strings, so using any other type as input would cause an unhandled exception to be raised.

1. Update the function so that it raises an `AttributeError` if a non-string value is used. This case can be detected by catching an `AttributeError` when calling `value.lower()` because only strings have a `lower()` method:

    ```python
    def str_to_bool(value):
        try:
            value = value.lower()
        except AttributeError:
            raise AttributeError(f"{value} must be of type string")
        true_values = ['y','yes']
        false_values = ['no', 'n']
    
        if value in true_values:
            return True
        if value in false_values:
            return False
    ```

2. Use a new assert method from `unittest.TestCase` in the test class. This new test should verify that the `AttributeError` is raised by non-string input:

    ```python
        def test_invalid_input(self):
            with self.assertRaises(AttributeError):
                str_to_bool(1)
    ```

3. Run the tests again by executing the Python script. the output should show three passing tests:

    ```bash
    $ python test_exercise.py
    ...
    ----------------------------------------------------------------------
    Ran 3 tests in 0.000s
    
    OK
    ```

## Check your work

At this point you should have a Python test file, named *test_exercise.py* or something similar, with the following components:

- A `str_to_bool()` function
- A `try/except` block in the `str_to_bool()` function that catches `AttributeError`.
- A `TestStrToBool()` test class that inherits from `unittest.TestCase`.
- At least three test methods that test inputs to the `str_to_bool()` function.

All of these tests should pass when you run them in the terminal.
