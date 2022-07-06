In Pytest, fixtures are helpers for tests. In their simplest form, that means they aren't much different than a helper function or method. But fixtures, like most Pytest features, are simple to get started with, but powerful enough to accommodate for highly complex scenarios.

Fixtures, unlike plain helper functions, can have their own setup and tear down code, which guarantees these helpers can be reused safely across a test suite.

The following list might help you think about fixtures beyond test helpers, they can be used in these ways:

- Provide ready-to-use data, like a file, or a complex JSON string
- Start, stop, or interact with external services like a database
- Create objects that offer specific behavior for tests

Lastly, fixtures can be treated as plugins to Pytest. When fixtures are defined in specific files, Pytest ensures these are available to any test that requires them without importing them explicitly.

## Build a fixture

A common scenario for tests is to deal with files. Let's create a fixture that creates a temporary file. This involves using a temporary directory, and returning the path for a test to consume.

This is how the fixture looks in a test file:

```python
import pytest
import tempfile

@pytest.fixture
def tmp_file():
    def create():
        temp = tempfile.NamedTemporaryFile(delete=False)
        return temp.name
    return create
```

The `tmp_file()` function is the fixture itself. The name is important because that is how you'll require it later in tests. The function has a nested function. This is needed because the fixture is _called_ when used, making it eager. In this case, we need to control the creation of the file, so nesting with another function allows delaying the creation of a file.

Within the nested function `create()`, a temporary file is created and then returns the absolute path to it. This is how a test can use that fixture:

```python
import os

def test_file(tmp_file):
    path = tmp_file()
    assert os.path.exists(path)
```

A test can require a fixture by specifying _the name of the fixture_ as an argument. Now any test that needs the newly written fixture can require it and use it. Although the use case is overly simple, you could expand on the fixture to optionally write contents or make modifications to the file, like permissions or ownership for example.

### Work with scopes

If you've worked with test methods, you might have used a `setup()` or `teardown()` method for setting or cleaning up a test. Fixtures have a scope of "function" by default. This means two things:

- The returned value is calculated for every test that uses it
- If there’s cleanup needed for the function, it’s done after every test that uses it.

Fixtures can define other scopes. For example, if you need a fixture that starts a database, you may want that to be run once at the beginning of the test session and not for every test. There are four supported scopes for fixtures:

- `function`: Runs once per test
- `class`: Runs once per class
- `module`: Runs once for a module
- `session`: Runs once for a test session

In this case, _running once_ means that the return value is cached. So a fixture that has a scope of "module" can get called several times in a test module, but the return value is going to be that of the first test that called it. This feature allows time savings and creating a highly efficient test suite without extra effort.

This is how the `tmp_file()` fixture would look with a module scope:

```python
@pytest.fixture(scope="module")
def tmp_file():
    def create(contents):
        temp = tempfile.NamedTemporaryFile(delete=False)
        return temp.name
    return create
```

### Cleanup

So far the fixture you've seen creates a file and then leaves it around. You can _register_ a cleanup function by using a special internal fixture called `request`. This means that a fixture can require other fixtures as well. To remove the temporary file, we can update the `tmp_file()` fixture to look like this:

```python
@pytest.fixture(scope="module")
def tmp_file(request):
    temp = tempfile.NamedTemporaryFile(delete=False)
    def create():
        return temp.name

    def cleanup():
        os.remove(temp.name)

    request.addfinalizer(cleanup)
    return create
```

By using `request.addfinalizer()` and passing the nested `cleanup()` function, the cleanup will get called depending on the scope. In this case, the scope is "module", so after all tests in a module Pytest will call that cleanup function.

## Use conftest.py

Now that you've seen fixtures in test files, you should be aware of _conftest.py_ files. These files hold special meaning for Pytest. Whenever there’s a _conftest.py_ file in a test directory, it means that you can add code like fixtures. When a fixture is in a conftest.py,_ it will be automatically available for tests without importing it. 


## Built-in fixtures

Aside from being able to create your own fixtures, there are plenty of built-in fixtures in Pytest. Most these fixtures come with their own cleanup functions so you can concentrate in their usage, and not worry about cleaning up.

These are some interesting fixtures from Pytest:

- `cache`: Allows to create and manage a caching system for tests
- `capsys`: Helper for capturing and recording `stderr` and `stdout`
- `tmpdir`: Create and manage temporary directories
- `monkeypatch`: Patch modules, classes, or functions with specific behavior

### Patch and override 

Sometimes production code is written in a way that tightly depends on other resources to work. This makes it hard to write tests. For example, imagine a function that requires a database running, or if a function is making HTTP requests to an external API. When code is not decoupled of external functionality, you can use a pattern called _monkey patching_. 

This pattern (and in this case, a fixture) means that it will override a named module, function, or class, with specific behavior. 

Patching might sound straightforward but it fact, it’s very difficult to get right. This is why you should always prefer to make production code easier to test. 

This is how overriding the `os.path.exists()` function would look using the `monkeypatch` fixture:

```python
import os

def test_os(monkeypatch):
    monkeypatch.setattr('os.path.exists', lambda x: False)
    assert os.path.exists('/') is False
```

The `setattr()` method can take a string with the module to patch (`os.path.exists` in this case), and then the overriding code. This test is using a `lambda` function, which accepts a single argument and always returns false. Optionally, the `setattr()` methods allows using an object and an attribute to patch as a string. This is how you could use it in the same test:

```python
def test_os(monkeypatch):
    monkeypatch.setattr(os.path, 'exists', lambda x: False)
    assert os.path.exists('/') is False
```

Aside from setting attributes and overriding methods, the `monkeypatch` fixture can set and delete environment variables, change dictionary values, and modify system paths. 

Modifying the environment in this way can be very problematic, but the fixture takes care of leaving everything as it was before the test started, making it a robust solution when modifying the environment is needed.