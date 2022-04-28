Aside from writing test functions, Pytest allows using classes. As we've already mentioned, there is no need for inheritance and the test classes follow a few simple rules. Using classes gives you more flexibility and reusability. As you will see next, Pytest keeps out of the way and avoids forcing you to write tests in a certain way. 

Just like functions, you can still write assertions using the `assert` statement. 

## Build a test class

Let's use a real-world scenario to see how test classes can help. The following function checks if a given file has a content of "yes" to return `True`. If the file doesn't exist or if it contains a "no", it returns `False`.
This scenario is common in asynchronous tasks that use the filesystem to indicate completion.

This is how the function looks:

```python
import os

def is_done(path):
    if not os.path.exists(path):
        return False
    with open(path) as _f:
        contents = _f.read()
    if "yes" in contents.lower():
        return True
    elif "no" in contents.lower():
        return False
```

This is how a class with two tests (one for each condition) would look like in a file named _test_files.py_:

```python
class TestIsDone:

    def test_yes(self):
        with open("/tmp/test_file", "w") as _f:
            _f.write("yes")
        assert is_done("/tmp/test_file") is True

    def test_no(self):
        with open("/tmp/test_file", "w") as _f:
            _f.write("no")
        assert is_done("/tmp/test_file") is False
```

> [!CAUTION]
> The test methods are using the _/tmp_ path for a temporary test file because it's easier to use for the example. However, if you need to use temporary files, consider using a library like `tempfile` that can create (and remove) them safely for you. Not every system has a _/tmp_ directory and that location might not be temporary depending on the operating system.

Running the tests with the `-v` flag to increase verbosity shows the tests passing:

```bash
pytest -v test_files.py
============================= test session starts ==============================
Python 3.9.6, pytest-6.2.5, py-1.11.0, pluggy-1.0.0 
cachedir: .pytest_cache
rootdir: /private/
collected 2 items

test_files.py::TestIsDone::test_yes PASSED                               [ 50%]
test_files.py::TestIsDone::test_no PASSED                                [100%]

============================== 2 passed in 0.00s ===============================
```

Although the tests are passing, they look somewhat repetitive and they are also leaving files after the test is done. Before we see how we can improve this, let's cover helper methods in the next section.

## Helper methods

In a test class, there are a few methods you can use to setup and teardown test execution. Pytest will execute them automatically if defined. To use these methods, you should know that they have a specific order and behavior.

- `setup`: Executes once before each test in a class
- `teardown`: Executes once after each test in a class
- `setup_class`: Executes once before all tests in a class
- `teardown_class`: Executes once after all tests in a class

You'll find useful to write setup methods when tests are going to require similar (or identical) resources to work. Ideally, a test shouldn't leave resources when it completes, so teardown methods can help in test cleanup in those situations.

### Cleanup

Let's check an updated test class that cleans up the files after each test:

```python
class TestIsDone:

    def teardown(self):
        if os.path.exists("/tmp/test_file"):
            os.remove("/tmp/test_file")

    def test_yes(self):
        with open("/tmp/test_file", "w") as _f:
            _f.write("yes")
        assert is_done("/tmp/test_file") is True

    def test_no(self):
        with open("/tmp/test_file", "w") as _f:
            _f.write("no")
        assert is_done("/tmp/test_file") is False

```

By using the `teardown()` method, this test class will no longer leave a _/tmp/test_file_ behind. 

### Setup

Another improvement that we can do to this class is adding a variable that points to the file. Since the file is now declared in six places, any changes to the path would mean changing it in all of those spots. This is how the class looks with an added `setup()` method that declares the path variable:

```python
class TestIsDone:

    def setup(self):
        self.tmp_file = "/tmp/test_file"

    def teardown(self):
        if os.path.exists(self.tmp_file):
            os.remove(self.tmp_file)

    def test_yes(self):
        with open(self.tmp_file, "w") as _f:
            _f.write("yes")
        assert is_done(self.tmp_file) is True

    def test_no(self):
        with open(self.tmp_file, "w") as _f:
            _f.write("no")
        assert is_done(self.tmp_file) is False
```

### Custom helper methods

You can create custom helper methods in a class. These methods must not be prefixed with the name `test` and cannot be named as the setup or cleanup methods. In the `TestIsDone` class, we could automate the creation of the temporary file in a custom helper. This is how that helper method could look:

```python
    def write_tmp_file(self, content):
        with open(self.tmp_file, "w") as _f:
            _f.write(content)
```

The `write_tmp_file()` method will not get automatically executed by Pytest and other methods can call it directly to save on repetitive tasks like writing to a file.

This is how the whole class looks after updating the test methods to use the custom helper:

```python
class TestIsDone:

    def setup(self):
        self.tmp_file = "/tmp/test_file"

    def teardown(self):
        if os.path.exists(self.tmp_file):
            os.remove(self.tmp_file)

    def write_tmp_file(self, content):
        with open(self.tmp_file, "w") as _f:
            _f.write(content)

    def test_yes(self):
        self.write_tmp_file("yes")
        assert is_done(self.tmp_file) is True

    def test_no(self):
        self.write_tmp_file("no")
        assert is_done(self.tmp_file) is False
```

## When to use a class instead of a function

There aren't any strict rules as to when to use a class instead of a function. It's always a good idea to follow the conventions in current projects and teams you are working with, but here are some general ideas that you can use to determine when to use a class.

- When tests need a similar setup or cleanup
- When grouping them makes logical sense
- If there are at least a few tests
- When tests can benefit from a common set of helpers
