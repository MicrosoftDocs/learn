In this exercise, you use Pytest to test a function. Then, you find and fix some potential problems with the function that cause failing tests. Looking at failures and using Pytest's rich error reporting is essential to identify and fix problematic tests or bugs in production code.

For this exercise, we use a function called `admin_command()` that accepts a system command as input, and optionally prefixes it with the `sudo` tool. The function has a bug, that you discover by writing tests.

## Step 1 - Add a file with tests for this exercise

1. Using Python's filename conventions for test files, create a new test file. Name the test file *test_exercise.py* and add the following code:

    ```python
    def admin_command(command, sudo=True):
        """
        Prefix a command with `sudo` unless it is explicitly not needed. Expects
        `command` to be a list.
        """
        if sudo:
            ["sudo"] + command
        return command
    ```

    The function `admin_command()` takes a list as input using the `command` argument, and optionally can prefix the list with `sudo`. If the `sudo` keyword argument is set to `False`, then it returns the same command given as input.

2. In the same file, append the tests for the `admin_command()` function. The tests use a helper method that returns a sample command:

    ```python
    class TestAdminCommand:

    def command(self):
        return ["ps", "aux"]

    def test_no_sudo(self):
        result = admin_command(self.command(), sudo=False)
        assert result == self.command()

    def test_sudo(self):
        result = admin_command(self.command(), sudo=True)
        expected = ["sudo"] + self.command()
        assert result == expected
    ```

> [!NOTE]
> It isn't common to have tests within the same file as actual code. For simplicity, the examples in this exercise will have actual code in the same file. In real-world Python projects, tests are typically separated by files and directories from the code that they're testing.

## Step 2 - Run the tests and identify the failure

Now that the test file has a function to test and a couple of tests to verify its behavior, it's time to run the tests and work with failures.

- Execute the file with Python:

    ```bash
    $ pytest test_exercise.py
    ```

     The run should complete with one test passing and one failure, and the failure output should be similar to the following output:

    ```bash
    =================================== FAILURES ===================================
    __________________________ TestAdminCommand.test_sudo __________________________
    
    self = <test_exercise.TestAdminCommand object at 0x10634c2e0>
    
        def test_sudo(self):
            result = admin_command(self.command(), sudo=True)
            expected = ["sudo"] + self.command()
    >       assert result == expected
    E       AssertionError: assert ['ps', 'aux'] == ['sudo', 'ps', 'aux']
    E         At index 0 diff: 'ps' != 'sudo'
    E         Right contains one more item: 'aux'
    E         Use -v to get the full diff
    
    test_exercise.py:24: AssertionError
    =========================== short test summary info ============================
    FAILED test_exercise.py::TestAdminCommand::test_sudo - AssertionError: assert...
    ========================= 1 failed, 1 passed in 0.04s ==========================
    ```

    The output fails on the `test_sudo()` test. Pytest is giving detail about the two lists being compared. In this case, the `result` variable doesn't have the `sudo` command in it, which is what the test expects.

## Step 3 - Fix the bug and make the tests pass

Before making any changes, you must understand why there's a failure in the first place. Although you can see that the expectation isn’t being met (`sudo` isn’t in the result), you have to find out why.

Look at the following lines of code from the `admin_command()` function when the `sudo=True` condition is met:

```python
    if sudo:
        ["sudo"] + command
```

The operation of the lists isn’t being used to return the value. Since it isn't being returned, the function ends up returning the command without `sudo` always.

1. Update the `admin_command()` function to return the list operation so that the modified result is used when requesting a `sudo` command. The updated function should look like this:


    ```python
    def admin_command(command, sudo=True):
        """
        Prefix a command with `sudo` unless it is explicitly not needed. Expects
        `command` to be a list.
        """
        if sudo:
            return ["sudo"] + command
        return command
    ```

2. Rerun the test with Pytest. Try increasing the verbosity of the output by using the `-v` flag with Pytest:

    ```bash
    $ pytest -v test_exercise.py
    ```

3. Now verify the output. It should show two passing tests now:

    ```bash
    ============================= test session starts ==============================
    Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0 
    cachedir: .pytest_cache
    rootdir: /private
    collected 2 items
    
    test_exercise.py::TestAdminCommand::test_no_sudo PASSED                  [ 50%]
    test_exercise.py::TestAdminCommand::test_sudo PASSED                     [100%]
    
    ============================== 2 passed in 0.00s ===============================
    ```

> [!NOTE]
> Since the function is able to work with more values of different casing, more tests should be added to cover those variations. This would prevent future changes to the function from causing a different (unexpected) behavior.

## Step 4 - Add new code with tests

After adding tests in the previous steps, you should feel comfortable making more changes to the function and verifying them with tests. Even if the changes aren't covered by existing tests, you can feel confident that you aren't breaking any previous assumptions.

In this case, the `admin_command()` function is trusting blindly that the `command` argument is always a list. Let's improve that by ensuring that an exception with a useful error message gets raised.

1. First, create a test that captures the behavior. Although the function isn't updated yet, try a test-first approach (also known as Test Driven Development or TDD).

    - Update the *test_exercise.py* file so that it imports `pytest` at the top. This test uses an internal helper from the `pytest` framework:

    ```python
    import pytest
    ```

    - Now append a new test to the class to check on the exception. This test should expect a `TypeError` from the function when the value passed to it is not a list:

    ```python
        def test_non_list_commands(self):
            with pytest.raises(TypeError):
                admin_command("some command", sudo=True)
    ```


2. Run the tests again with Pytest, they should all pass:

    ```bash
    ============================= test session starts ==============================
    Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0
    rootdir: /private/
    collected 3 items

    test_exercise.py ...                                                     [100%]

    ============================== 3 passed in 0.00s ===============================
    ```

    The test is good enough to check for `TypeError` but it would be good to add the code with a useful error message.

3. Update the function to raise a `TypeError` explicitly with a helpful error message:

    ```python
    def admin_command(command, sudo=True):
        """
        Prefix a command with `sudo` unless it is explicitly not needed. Expects
        `command` to be a list.
        """
        if not isinstance(command, list):
            raise TypeError(f"was expecting command to be a list, but got a {type(command)}")
        if sudo:
            return ["sudo"] + command
        return command
    ```

4. Finally, update the `test_non_list_commands()` method to check for the error message:

    ```python
    def test_non_list_commands(self):
        with pytest.raises(TypeError) as error:
            admin_command("some command", sudo=True)
        assert error.value.args[0] == "was expecting command to be a list, but got a <class 'str'>"
    ```

    The updated test uses `error` as a variable that holds all the exception information. Using `error.value.args`, you’re able to look into the arguments of the exception. In this case, the first argument has the error string that the test can check.

## Check your work

At this point you should have a Python test file named *test_exercise.py* that includes:

- An `admin_command()` function that accepts an argument, and a keyword argument.
- A `TypeError` exception with a helpful error message in the `admin_command()` function.
- A `TestAdminCommand()` test class that has a `command()` helper method and three test methods that check the `admin_command()` function.

All tests should be passing with no errors when you run them in the terminal.