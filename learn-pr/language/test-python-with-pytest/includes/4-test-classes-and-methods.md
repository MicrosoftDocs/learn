In addition to writing test functions, Pytest allows you to use classes. As we already mentioned, there's no need for inheritance and the test classes follow a few simple rules. Using classes gives you more flexibility and reusability. As you see next, Pytest keeps out of the way and avoids forcing you to write tests in a certain way.

Just like functions, you can still write assertions using the `assert` statement.

## Build a test class

Let's use a real-world scenario to see how test classes can help. The following function checks if a given file contains "yes" in its content. If so, it returns `True`. If the file doesn't exist or if it contains "no" in its content, it returns `False`. This scenario is common in asynchronous tasks that use the filesystem to indicate completion.

Here's how the function looks:

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

Now, here's how a class with two tests (one for each condition) in a file named *test_files.py* looks:

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
> The test methods are using the */tmp* path for a temporary test file because it's easier to use for the example. However, if you need to use temporary files, consider using a library like `tempfile` that can create (and remove) them safely for you. Not every system has a */tmp* directory and that location might not be temporary depending on the operating system.

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

Although the tests are passing, they look repetitive and they're also leaving files after the test is done. Before we see how we can improve them, let's cover helper methods in the next section.

## Helper methods

In a test class, there are a few methods you can use to setup and teardown test execution. Pytest executes them automatically if they're defined. To use these methods, you should know that they have a specific order and behavior.

- `setup`: Executes once before each test in a class
- `teardown`: Executes once after each test in a class
- `setup_class`: Executes once before all tests in a class
- `teardown_class`: Executes once after all tests in a class

When tests require similar (or identical) resources to work, it's useful to write setup methods. Ideally, a test shouldn't leave resources when it completes, so teardown methods can help in test cleanup in those situations.

### Cleanup

Let's look at an updated test class that cleans up the files after each test:

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

Because we used the `teardown()` method, this test class no longer leaves a */tmp/test_file* behind.

### Setup

Another improvement that we can make to this class is to add a variable that points to the file. Since the file is now declared in six places, any changes to the path would mean changing it in all of those spots. This example shows how the class looks with an added `setup()` method that declares the path variable:

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

You can create custom helper methods in a class. These methods must not be prefixed with the name `test` and can't be named as the setup or cleanup methods. In the `TestIsDone` class, we could automate the creation of the temporary file in a custom helper. That custom helper method might look like this example:

```python
    def write_tmp_file(self, content):
        with open(self.tmp_file, "w") as _f:
            _f.write(content)
```

Pytest doesn't automatically execute the `write_tmp_file()` method, and other methods can call it directly to save on repetitive tasks like writing to a file.

The whole class looks like this example, after updating the test methods to use the custom helper:

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

There aren't any strict rules as to when to use a class instead of a function. It's always a good idea to follow the conventions in current projects and teams that you're working with. Here are some general questions to ask that can help you determine when to use a class:

- Do your tests need similar setup or cleanup helper code?
- Does grouping your tests together make logical sense?
- Are there at least a few tests in your test suite?
- Could your tests benefit from a common set of helper functions?
