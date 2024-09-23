In this exercise, you'll use `pytest` with _parametrize_ to test a function. Then, you update a test class to use a fixture instead of a `setup()` and `teardown()` method. Using _parametrize_ and working with fixtures allows you to become more flexible when creating or updating tests.

## Step 1 - Add a file with tests for this exercise

1. Create a new test file called _test_advanced.py_ and add the following code:

    ```python
    def str_to_bool(string):
        if string.lower() in ['yes', 'y', '1']:
            return True
        elif string.lower() in ['no', 'n', '0']:
            return False

    ```

    The function `str_to_bool()` accepts a string as input and depending on its contents it returns a `True` or `False` value. 

2. In the same file, append the tests for the `str_to_bool()` function. Use `pytest.mark.parametrize()` to test all the true values first:

    ```python
    import pytest 

    @pytest.mark.parametrize("string", ['Y', 'y', '1', 'YES'])
    def test_str_to_bool_true(string):
        assert str_to_bool(string) is True
    ```
    
3. Next, append another test with the false values:

    ```python
    @pytest.mark.parametrize("string", ['N', 'n', '0', 'NO'])
    def test_str_to_bool_false(string):
        assert str_to_bool(string) is False
    ```
    
    There are now two tests covering all the possible inputs for both the `True` and `False` return values. 

> [!NOTE]
> It isn't common to have tests within the same file as actual code. For simplicity, the examples in this exercise will have actual code in the same file. In real-world Python projects you'll find that tests are separated by files and directories from the code it's testing. 

## Step 2 - Run the tests and explore the report

After you add the tests, the next step is to run `pytest` and inspect the output. Use the increased verbosity flag (`-v`) so that you can see all input values being treated as a separate test. 

```bash
$ pytest -v test_avanced.py
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0 
rootdir: /private
collected 8 items

test_advanced.py::test_str_to_bool_true[Y] PASSED                        [ 12%]
test_advanced.py::test_str_to_bool_true[y] PASSED                        [ 25%]
test_advanced.py::test_str_to_bool_true[1] PASSED                        [ 37%]
test_advanced.py::test_str_to_bool_true[YES] PASSED                      [ 50%]
test_advanced.py::test_str_to_bool_false[N] PASSED                       [ 62%]
test_advanced.py::test_str_to_bool_false[n] PASSED                       [ 75%]
test_advanced.py::test_str_to_bool_false[0] PASSED                       [ 87%]
test_advanced.py::test_str_to_bool_false[NO] PASSED                      [100%]

============================== 8 passed in 0.01s ===============================
```

Although you wrote only two test functions, `pytest` was able to create eight tests in total thanks to the `parametrize()` function.

## Step 3 - Port an existing test to a fixture

1. Add a new class-based test to the _test_advanced.py_ file. This test should use a `setup()` and `teardown()` function that creates a temporary file with some text on it. After each test, the file gets removed. It should look like this:

   ```python
   import os
   
   
   class TestFile:
   
       def setup(self):
           with open("/tmp/done", 'w') as _f:
               _f.write("1")
   
       def teardown(self):
           try:
               os.remove("/tmp/done")
           except OSError:
               pass
   
       def test_done_file(self):
           with open("/tmp/done") as _f:
               contents = _f.read()
           assert contents == "1"
   ```
   
   This test class creates a file, but is problematic because the _/tmp/_ path isn’t guaranteed to be present on every system. 

2. Create a fixture that uses the `pytest` `tmpdir()` fixture to write to the file and return the path:
   
   ```python
   import pytest

   @pytest.fixture
   def tmpfile(tmpdir):
       def write():
           file = tmpdir.join("done")
           file.write("1")
           return file.strpath
       return write
   ```

   The `tmpfile()` fixture uses pytest's `tmpdir()` fixture, which guarantees a valid temporary file that gets cleaned after tests are done.

3. Update the `TestFile` class so that it uses the fixture _instead of_ the helper methods:

    ```python
    class TestFile:

        def test_f(self, tmpfile):
            path = tmpfile()
            with open(path) as _f:
                contents = _f.read()
            assert contents == "1"
    ```

    This test class can now ensure that a temporary file gets created and has the proper contents for the assertion to work.

## Check your work 

By now you should have a Python file named _test_advanced.py_ with the following code: 

- A `str_to_bool()` function that accepts a string and returns a boolean value depending on the contents of the string.
- Two parametrized tests for the `str_to_bool()` function, one that tests the `True` values and the other one that tests the `False` values.
- A custom `pytest` fixture that uses the `tmpdir()` fixture to create a temporary _done_ file with some contents.
- A test class that uses the custom `tmpfile()` fixture to create the file.

All tests should pass when running them in the terminal, with no errors.