Fixtures provide a defined, reliable context for tests. Custom fixtures are Python functions decorated with `@pytest.fixture`. You use them to arrange preconditions such as test data, environment variables, database connections, or files that a test needs before it runs. Fixtures can also define teardown steps that clean up resources after the test or fixture scope is complete.

A test requests a fixture by declaring an argument with the same name as the fixture. Pytest finds the fixture, runs it, and passes the returned or yielded value into the test. For more information about the fixture lifecycle, see the pytest documentation for [fixtures](https://docs.pytest.org/en/stable/how-to/fixtures.html).

Fixtures are most helpful when setup or cleanup is reused, complex, or clearer when named. For simple one-off values, keeping setup code directly in the test can be easier to read.

Key characteristics of pytest fixtures include:

- **Scope control**: Fixtures can use the `scope` parameter to control how often pytest creates and destroys the fixture value. Broader scopes can improve performance, but they also share state for longer.
- **Setup and teardown**: Fixtures can use `yield` for cleanup. Advanced fixtures can also receive the built-in `request` fixture (introduced later in this unit) to inspect the requesting test and call `request.addfinalizer()` to register cleanup callbacks.
- **Dependency injection**: Tests and fixtures request fixtures as arguments, making dependencies explicit.
- **Reusability and modularity**: Fixtures can be defined once and reused across test functions, modules, directories, or projects.
- **Automatic activation**: A fixture defined with `@pytest.fixture(autouse=True)` runs for every test in its availability scope without being listed as an argument. Use this option sparingly because it hides test dependencies.

## Creating a temporary file fixture

When writing tests that interact with files, it's common to need isolated paths that don't conflict with other tests or depend on a hard-coded location. Pytest provides built-in temporary directory fixtures that are usually the best choice for new tests because pytest creates unique directories and manages their retention. However, creating a small custom fixture is a useful way to understand fixture requests and return values.

The following fixture returns a factory function. The fixture itself doesn't create a file during setup. Instead, the nested `create()` function creates a file when the test calls `tmp_file()`:

```python
from pathlib import Path
import tempfile

import pytest


@pytest.fixture
def tmp_file():
    def create(contents=""):
        temp = tempfile.NamedTemporaryFile(delete=False)
        try:
            path = Path(temp.name)
        finally:
            temp.close()

        path.write_text(contents, encoding="utf-8")
        return path

    return create
```

The fixture uses Python's `tempfile.NamedTemporaryFile()` function with `delete=False` so that the file still exists after it is closed. The file handle is closed before the test receives the path, which is important when tests need to reopen or delete the file, especially on Windows.

Here's an example of how a test might use the fixture:

```python
def test_file(tmp_file):
    path = tmp_file("ready")
    assert path.read_text(encoding="utf-8") == "ready"
```

In this setup, `tmp_file` is the fixture name, and the test receives the `create()` function that the fixture returns. Calling `tmp_file()` inside the test creates the file, writes the requested contents, and returns a `pathlib.Path` object for it.

> [!NOTE]
> Be careful when combining fixtures with context managers. If a fixture returns a path or handle from inside a `with` block, the context manager might close or delete the resource before the test uses it. Keep the context manager open across a `yield` when the test needs the managed resource, or close the resource intentionally before returning and clean it up later.

## Scope management

By default, pytest fixtures use `function` scope. A function-scoped fixture is created when a test requests it and is destroyed at the end of that test. If the fixture uses teardown code, pytest runs that teardown code at the end of the fixture's scope.

Pytest also allows broader fixture scopes to optimize expensive setup work. The built-in fixture scope names are:

- `function`: The default scope. The fixture is created once per test function.
- `class`: The fixture is created once per test class.
- `module`: The fixture is created once for the module.
- `package`: The fixture is created once for the package where it's defined and torn down after the last test in that package, including tests in subpackages and subdirectories.
- `session`: The fixture is created once for the test session.

For advanced cases, `scope` can also be a callable that returns one of these scope names. Pytest calls the function once when it defines the fixture and passes the keyword arguments `fixture_name` and `config`. See the pytest docs on [dynamic scope](https://docs.pytest.org/en/stable/how-to/fixtures.html#dynamic-scope) for details.

In this context, _created once_ means that pytest caches the fixture value for that scope. For example, a module-scoped fixture can be requested by several tests in one module, but those tests receive the same cached fixture value. A parametrized fixture is the exception: pytest may create a new value for each parameter set within the scope.

Keep fixtures function-scoped unless sharing setup is safe and useful. Mutable objects, open connections, environment changes, and files can leak state between tests when they're cached by a broader scope.

Here's how the `tmp_file` fixture would look with a module scope:

```python
from pathlib import Path
import tempfile

import pytest


@pytest.fixture(scope="module")
def tmp_file():
    def create(contents=""):
        temp = tempfile.NamedTemporaryFile(delete=False)
        try:
            path = Path(temp.name)
        finally:
            temp.close()

        path.write_text(contents, encoding="utf-8")
        return path

    return create
```

Because this fixture returns a factory function, `scope="module"` caches the factory function for the module. The factory still creates a new file each time a test calls `tmp_file()`. If the fixture created and returned a file path directly, then every test in the module would receive the same path.

## Cleanup management

The previous versions of the `tmp_file` fixture create temporary files, but they don't remove those files. Pytest recommends `yield` fixtures for straightforward cleanup. Code before `yield` performs setup and supplies a value to the test. Code after `yield` runs during teardown, even when the test fails after setup completes. If a `yield` fixture raises before it reaches `yield`, pytest doesn't run the teardown code after that `yield`, but it still tears down any earlier fixtures that completed successfully for the same test.

The following version tracks every file created by the factory and attempts to delete those files after the test finishes:

```python
from pathlib import Path
import tempfile

import pytest


@pytest.fixture
def tmp_file():
    paths = []

    def create(contents=""):
        temp = tempfile.NamedTemporaryFile(delete=False)
        try:
            path = Path(temp.name)
        finally:
            temp.close()

        paths.append(path)
        path.write_text(contents, encoding="utf-8")
        return path

    yield create

    for path in paths:
        try:
            path.unlink()
        except FileNotFoundError:
            pass
```

With the default `function` scope, pytest runs the cleanup code after each test that requests `tmp_file`. If you change the fixture to `scope="module"`, pytest runs the cleanup during module teardown, after pytest finishes running tests in that module. When several `yield` fixtures are active, pytest runs their teardown code in reverse order of setup.

The cleanup uses `try`/`except FileNotFoundError` because a test might delete the file itself. On Windows, deletion can also fail with `PermissionError` if a test left the file open, so make sure tests close any handles they create. You can also use `request.addfinalizer()` for cleanup when you need more control. Register the finalizer only after the resource has been created, because pytest runs an added finalizer during teardown even if the fixture later raises. For straightforward cleanup, `yield` fixtures are usually easier to read.

## Using conftest.py

Instead of defining fixtures in each test file, you can save shared fixtures in a file named `conftest.py`. Fixtures in `conftest.py` are automatically available to tests in the same directory and its subdirectories without explicit imports.

You can have multiple `conftest.py` files in a test suite. Pytest resolves fixture availability from the perspective of the requesting test: fixtures in the test class or module are considered in that local scope, then fixtures from `conftest.py` files in the same directory and parent directories. Tests can search upward for fixtures, but they don't search downward into sibling or child directories. Plugin fixtures are searched after local fixtures. Don't import from `conftest.py` in test files; let pytest discover it.

## Exploring built-in fixtures

Pytest has many built-in fixtures designed to streamline testing. These fixtures handle common setup and cleanup tasks so that you can focus on writing test assertions. To review the complete list, see the pytest reference for [built-in fixtures](https://docs.pytest.org/en/stable/reference/fixtures.html#built-in-fixtures).

Key built-in fixtures include:

- `cache`: Stores and retrieves values across pytest runs.
- `capsys`: Captures text written to `stdout` and `stderr`.
- `tmp_path`: Provides a `pathlib.Path` object for a temporary directory that's unique to each test function invocation, including each parametrized case.
- `tmpdir`: Provides a temporary directory as a legacy `py.path.local` object. For new tests, pytest recommends `tmp_path`.
- `monkeypatch`: Temporarily modifies classes, functions, dictionaries, environment variables, and other objects.
- `request`: Provides information about the currently executing test or fixture and supports finalizers.

Other commonly used built-in fixtures include `caplog` (captures log records), `capfd` (captures file-descriptor-level output), `tmp_path_factory` (creates session-scoped temporary directories), and `pytestconfig` (exposes the active pytest configuration). For the full list, see the pytest reference for [built-in fixtures](https://docs.pytest.org/en/stable/reference/fixtures.html#built-in-fixtures).

The next exercise uses `tmp_path` and `pathlib.Path` to create temporary files in a per-test directory. You might encounter `tmpdir` in existing pytest projects, but for new code, prefer `tmp_path`. By default, pytest keeps temporary directories from the last few test runs, so seeing recent pytest-managed temporary folders after a run is expected. For more information, see the pytest documentation for [temporary directories and files](https://docs.pytest.org/en/stable/how-to/tmp_path.html).

## The role of monkeypatching in testing

The previous fixtures created and cleaned up test resources. Another common use of fixtures is *temporary state modification* in tests that need to isolate code from external state. For those cases, pytest provides the built-in `monkeypatch` fixture, which is itself a pytest fixture and a good example of automatic teardown.

Testing code that depends on external resources, global configuration, or operating system state can be challenging. The `monkeypatch` fixture lets you temporarily change attributes, dictionary values, environment variables, the current working directory, or `sys.path` for a test. Pytest automatically undoes those changes after the requesting test function or fixture finishes.

Here's an example that replaces a function attribute on a small project module for one test. Patching narrowly scoped application code (instead of standard-library functions used by pytest itself) keeps the test focused and avoids accidentally breaking pytest's own behavior:

```python
# project_module.py
def get_user_id():
    # Imagine this calls a remote service.
    return "real-user"
```

```python
# test_project.py
import project_module


def test_user_id(monkeypatch):
    monkeypatch.setattr(project_module, "get_user_id", lambda: "test-user")
    assert project_module.get_user_id() == "test-user"
```

You can also specify the target as a dotted import path string. Pytest resolves and imports the named module when it applies the patch, which is convenient when the test file doesn't already need the module. The later `import project_module` in this example is only so the test can reference the patched function for the assertion:

```python
# test_project.py
def test_user_id_by_path(monkeypatch):
    monkeypatch.setattr("project_module.get_user_id", lambda: "test-user")

    import project_module
    assert project_module.get_user_id() == "test-user"
```

Aside from setting attributes and overriding methods with `setattr()`, the `monkeypatch` fixture can delete attributes with `delattr()`, set and delete environment variables (`setenv`, `delenv`), set and delete dictionary items (`setitem`, `delitem`), prepend to `sys.path` (`syspath_prepend`), change the current working directory (`chdir`), and create a nested patching scope with `context()`. The default `raising=True` behavior for `setattr()` and `delattr()` helps catch misspelled targets. Use `monkeypatch.context()` when a patch should be undone before the rest of a test or fixture teardown continues. For more information, see the pytest documentation for [monkeypatching](https://docs.pytest.org/en/stable/how-to/monkeypatch.html).

While `monkeypatch` is powerful, use it carefully:

- **Code clarity and maintenance**: Overusing `monkeypatch` or using it in complex ways can make tests harder to understand and maintain.
- **Test validity**: Monkeypatching can create tests that pass under artificial conditions that are very different from production behavior.
- **Overdependence on implementation details**: Tests that patch internal implementation details can become brittle when the underlying code changes.
- **Debugging complexity**: Debugging tests that use `monkeypatch` can be harder when a patch changes fundamental application behavior.

Use `monkeypatch` when it helps isolate a focused behavior, and keep each patch as small and explicit as possible.
