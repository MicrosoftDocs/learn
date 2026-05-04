In this exercise, you'll use `pytest` with `@pytest.mark.parametrize` to test a function, including cases that expect an exception. Then, you'll refactor a class-based test from the xUnit-style `setup_method()` and `teardown_method()` approach to a fixture. Using parametrization and fixtures helps you write tests that cover more cases with less repetition and clearer setup.

For setup help, see the Python documentation for [virtual environments](https://docs.python.org/3/library/venv.html), the pip documentation for [`pip install`](https://pip.pypa.io/en/stable/cli/pip_install/), and the pytest documentation for [installing pytest](https://docs.pytest.org/en/stable/getting-started.html#install-pytest). For more details about the pytest features in this exercise, see the pytest documentation for [parametrizing test functions](https://docs.pytest.org/en/stable/how-to/parametrize.html#pytest-mark-parametrize-parametrizing-test-functions), [assertions about expected exceptions](https://docs.pytest.org/en/stable/how-to/assert.html#assertions-about-expected-exceptions), [fixtures](https://docs.pytest.org/en/stable/how-to/fixtures.html), [xUnit-style setup](https://docs.pytest.org/en/stable/how-to/xunit_setup.html), and [temporary directories and files](https://docs.pytest.org/en/stable/how-to/tmp_path.html).

## Before you start

Use Python 3.10 or later, as described in the module prerequisites. If you already have a virtual environment with pytest installed and activated, continue to Step 1. Otherwise, create and activate a virtual environment in the folder where you'll create _test_advanced.py_.

On Windows PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install pytest
python -m pytest --version
```

On macOS, Linux, or Windows Subsystem for Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install pytest
python -m pytest --version
```

The version command should print a pytest version, similar to this output:

```output
pytest x.y.z
```

The install commands don't pin pytest to a specific version. Pip uses package metadata to choose a stable pytest release compatible with the Python version in the virtual environment.

Use `python -m pytest` throughout this exercise so pytest runs from the active environment. If Windows PowerShell blocks `Activate.ps1`, see the Python `venv` documentation for the PowerShell execution policy option, or run the virtual environment's Python directly for the pip and pytest commands. For example:

```powershell
.\.venv\Scripts\python -m pip install --upgrade pip
.\.venv\Scripts\python -m pip install pytest
.\.venv\Scripts\python -m pytest -v test_advanced.py
```

## Step 1 - Add a file with tests for this exercise

1. In the same folder where you'll run pytest, create a new test file named _test_advanced.py_. Don't put the file inside the _.venv_ folder. Add the following code:

    ```python
    import pytest


    def str_to_bool(string):
        normalized = string.lower()
        if normalized in ["yes", "y", "1"]:
            return True
        if normalized in ["no", "n", "0"]:
            return False
        raise ValueError(f"Cannot convert {string!r} to a boolean")
    ```

    The function `str_to_bool()` accepts a string as input. It returns `True` for recognized true values, returns `False` for recognized false values, and raises a `ValueError` for any other value.

2. In the same file, append the tests for the `str_to_bool()` function. Use `@pytest.mark.parametrize` to test the true values first:

    ```python
    @pytest.mark.parametrize("string", ["Y", "y", "1", "YES"])
    def test_str_to_bool_true(string):
        assert str_to_bool(string) is True
    ```

3. Next, append another test with the false values:

    ```python
    @pytest.mark.parametrize("string", ["N", "n", "0", "NO"])
    def test_str_to_bool_false(string):
        assert str_to_bool(string) is False
    ```

    There are now two test functions covering representative inputs for both the `True` and `False` return values.

4. Finally, append a parametrized test for values that the function shouldn't accept. Use `pytest.raises()` as a context manager so the test passes only when `str_to_bool()` raises the expected exception:

    ```python
    @pytest.mark.parametrize("string", ["maybe", "2"])
    def test_str_to_bool_invalid(string):
        with pytest.raises(ValueError, match="Cannot convert"):
            str_to_bool(string)
    ```

    The `match` argument checks the exception message with a regular expression. Here, the test only checks the stable part of the message so it doesn't depend on the exact invalid value.

> [!NOTE]
> For simplicity, this exercise keeps the code under test and the tests in the same file. In real Python projects, application code and tests are usually separated into different files and directories, such as a `src/` package and a `tests/` directory.

## Step 2 - Run the tests and explore the report

After you add the tests, run pytest and inspect the output. Use the increased verbosity flag (`-v`) so that you can see each input value treated as a separate test.

On Windows PowerShell:

```powershell
python -m pytest -v test_advanced.py
```

On macOS, Linux, or Windows Subsystem for Linux:

```bash
python -m pytest -v test_advanced.py
```

The output should be similar to the following report:

```output
============================= test session starts ==============================
platform ... -- Python 3.x.y, pytest-x.y.z, pluggy-x.y.z -- ...
rootdir: ...
...
collected 10 items

test_advanced.py::test_str_to_bool_true[Y] PASSED                        [ 10%]
test_advanced.py::test_str_to_bool_true[y] PASSED                        [ 20%]
test_advanced.py::test_str_to_bool_true[1] PASSED                        [ 30%]
test_advanced.py::test_str_to_bool_true[YES] PASSED                      [ 40%]
test_advanced.py::test_str_to_bool_false[N] PASSED                       [ 50%]
test_advanced.py::test_str_to_bool_false[n] PASSED                       [ 60%]
test_advanced.py::test_str_to_bool_false[0] PASSED                       [ 70%]
test_advanced.py::test_str_to_bool_false[NO] PASSED                      [ 80%]
test_advanced.py::test_str_to_bool_invalid[maybe] PASSED                 [ 90%]
test_advanced.py::test_str_to_bool_invalid[2] PASSED                     [100%]

============================== 10 passed in 0.01s ==============================
```

Your operating system, Python version, pytest version, executable path, root directory, plugin and cache lines, collection-progress formatting, line wrapping, and run time might differ. Although you wrote only three test functions, pytest collected 10 tests because each parametrized input value runs as its own test case.

## Step 3 - Refactor setup and teardown into a fixture

1. Append a class-based test to the _test_advanced.py_ file. This test uses xUnit-style `setup_method()` and `teardown_method()` methods to create and remove a file around each test method:

    ```python
    from pathlib import Path


    class TestFile:

        def setup_method(self):
            self.path = Path("done")
            self.path.write_text("1", encoding="utf-8")

        def teardown_method(self):
            self.path.unlink(missing_ok=True)

        def test_done_file(self):
            contents = self.path.read_text(encoding="utf-8")
            assert contents == "1"
    ```

    This test can pass, but it writes a fixed file name in the current working directory and requires separate cleanup code. If a test run is interrupted or tests run concurrently, such as with `pytest-xdist` or overlapping local runs, this approach can leave stale files, overwrite an existing file named _done_, or cause tests to affect each other.

2. Add a module-level fixture that uses the built-in `tmp_path` fixture to create a temporary file. In the next step, you'll update the class to use this fixture instead of the setup and teardown methods. For readability, place this module-level fixture after the parametrized `str_to_bool` tests and before the `TestFile` class. Pytest discovers module-level fixtures regardless of where they appear in the module, so the position is for human readers, not pytest:

    ```python
    @pytest.fixture
    def tmp_file(tmp_path):
        def write():
            path = tmp_path / "done"
            path.write_text("1", encoding="utf-8")
            return path
        return write
    ```

    The `tmp_file()` fixture uses pytest's `tmp_path` fixture, which provides a unique `pathlib.Path` temporary directory for each test function invocation, including each parametrized case. Pytest manages the temporary directory, so the test doesn't depend on a hard-coded file path.

3. Delete the earlier `TestFile` class, including its `setup_method()` and `teardown_method()` methods, and replace it with this final version that uses the fixture _instead of_ the setup and teardown methods:

    ```python
    class TestFile:

        def test_done_file(self, tmp_file):
            path = tmp_file()
            contents = path.read_text(encoding="utf-8")
            assert contents == "1"
    ```

    You can also remove the `from pathlib import Path` import you added in the previous step, because the test no longer creates a `Path` object directly.

## Check your work

By now you should have a Python file named _test_advanced.py_ that contains:

- A `str_to_bool()` function that accepts a string and returns a boolean value for recognized true and false values.
- Three parametrized tests for the `str_to_bool()` function: one that tests `True` values, one that tests `False` values, and one that checks invalid values raise `ValueError`.
- A custom pytest fixture that uses the built-in `tmp_path` fixture to create a temporary _done_ file with some contents.
- A single `TestFile` class with one method that uses the custom `tmp_file` fixture to create and read the file.
- No `from pathlib import Path` import and no `setup_method()`/`teardown_method()` methods in the final version.

The final file should look similar to the following:

```python
import pytest


def str_to_bool(string):
    normalized = string.lower()
    if normalized in ["yes", "y", "1"]:
        return True
    if normalized in ["no", "n", "0"]:
        return False
    raise ValueError(f"Cannot convert {string!r} to a boolean")


@pytest.mark.parametrize("string", ["Y", "y", "1", "YES"])
def test_str_to_bool_true(string):
    assert str_to_bool(string) is True


@pytest.mark.parametrize("string", ["N", "n", "0", "NO"])
def test_str_to_bool_false(string):
    assert str_to_bool(string) is False


@pytest.mark.parametrize("string", ["maybe", "2"])
def test_str_to_bool_invalid(string):
    with pytest.raises(ValueError, match="Cannot convert"):
        str_to_bool(string)


@pytest.fixture
def tmp_file(tmp_path):
    def write():
        path = tmp_path / "done"
        path.write_text("1", encoding="utf-8")
        return path
    return write


class TestFile:

    def test_done_file(self, tmp_file):
        path = tmp_file()
        contents = path.read_text(encoding="utf-8")
        assert contents == "1"
```

Run the test file again.

On Windows PowerShell:

```powershell
python -m pytest -v test_advanced.py
```

On macOS, Linux, or Windows Subsystem for Linux:

```bash
python -m pytest -v test_advanced.py
```

The final report should show 11 collected tests: 10 cases from the parametrized tests and one class-based test.

```output
============================= test session starts ==============================
platform ... -- Python 3.x.y, pytest-x.y.z, pluggy-x.y.z -- ...
rootdir: ...
...
collected 11 items

test_advanced.py::test_str_to_bool_true[Y] PASSED                        [  9%]
test_advanced.py::test_str_to_bool_true[y] PASSED                        [ 18%]
test_advanced.py::test_str_to_bool_true[1] PASSED                        [ 27%]
test_advanced.py::test_str_to_bool_true[YES] PASSED                      [ 36%]
test_advanced.py::test_str_to_bool_false[N] PASSED                       [ 45%]
test_advanced.py::test_str_to_bool_false[n] PASSED                       [ 54%]
test_advanced.py::test_str_to_bool_false[0] PASSED                       [ 63%]
test_advanced.py::test_str_to_bool_false[NO] PASSED                      [ 72%]
test_advanced.py::test_str_to_bool_invalid[maybe] PASSED                 [ 81%]
test_advanced.py::test_str_to_bool_invalid[2] PASSED                     [ 90%]
test_advanced.py::TestFile::test_done_file PASSED                        [100%]

============================== 11 passed in 0.01s ==============================
```

All tests should pass with no errors.
