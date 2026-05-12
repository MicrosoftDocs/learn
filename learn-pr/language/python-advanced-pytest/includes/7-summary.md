In this module, you explored pytest features that help you write more expressive and maintainable tests. You used `@pytest.mark.parametrize` to run the same test function with multiple input values. Pytest collects each parameter set as a separate test case, so reports can identify exactly which input passed or failed.

You also worked with fixtures. Fixtures provide reusable setup code, make test dependencies explicit through function arguments, and can manage cleanup using `yield`-based teardown and appropriate fixture scopes. You applied these ideas by writing parametrized tests and refactoring a class-based test from the xUnit-style `setup_method()` and `teardown_method()` approach to a custom fixture that uses pytest's `tmp_path` fixture for temporary file handling. You also reviewed built-in fixtures, including `tmp_path`, which provides a `pathlib.Path` temporary directory for each test function invocation, and `monkeypatch`, which temporarily changes attributes, dictionary values, environment variables, `sys.path`, or the current working directory and restores those changes after the requesting test or fixture finishes.

You can now:

- Use parametrization to cover multiple inputs without repeating test functions.
- Read pytest output to diagnose which parameter values pass or fail.
- Create custom fixtures to share setup and cleanup logic.
- Choose fixture scopes based on how often setup should run and when cleanup should occur.
- Place shared fixtures in `conftest.py` so tests in the same directory and its subdirectories can request them without explicit imports.
- Use built-in fixtures, including `tmp_path` for temporary files and `monkeypatch` for scoped state changes, to isolate tests that depend on files, environment variables, imports, or external state.

For more information, see the pytest documentation for [parametrizing tests](https://docs.pytest.org/en/stable/how-to/parametrize.html), [fixtures](https://docs.pytest.org/en/stable/how-to/fixtures.html), [built-in fixtures](https://docs.pytest.org/en/stable/reference/fixtures.html#built-in-fixtures), [temporary directories and files](https://docs.pytest.org/en/stable/how-to/tmp_path.html), [xUnit-style setup](https://docs.pytest.org/en/stable/how-to/xunit_setup.html), and [monkeypatch](https://docs.pytest.org/en/stable/how-to/monkeypatch.html).
