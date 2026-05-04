Pytest can do more than discover tests and report assertion results. As a Python test suite grows, repeated test logic and shared setup code make tests harder to read, debug, and extend. In this module, you'll learn three pytest features that help keep Python tests readable and maintainable: parametrization, fixtures, and the built-in `monkeypatch` fixture.

This module assumes that you can write Python scripts, run commands in a terminal, and run simple pytest tests in a virtual environment with Python 3.10 or later. If you need setup help on Windows, see [Set up your Python development environment on Windows](/windows/dev-environment/python). For virtual environment details, see Python's [`venv` documentation](https://docs.python.org/3/tutorial/venv.html).

Parametrization with `@pytest.mark.parametrize` runs the same test function with multiple sets of arguments, and pytest collects each generated invocation as its own test item. Fixtures are functions registered with pytest, usually with `@pytest.fixture`, that tests or other fixtures request by name. They can return reusable values and, when needed, run cleanup after the test or fixture scope finishes. The `monkeypatch` fixture temporarily changes attributes, dictionary items, environment variables, `sys.path`, or the current working directory, then automatically undoes those changes after the requesting test or fixture finishes.

The examples in this module are unit-style tests, but the same pytest features apply to larger integration or functional test suites. The examples use Python's `assert` statement; pytest provides assertion introspection so failure reports include useful values from the expression.

## When to use these features

- Use **parametrization** when you find yourself looping over inputs in a test or copying near-duplicate test functions for slightly different inputs. Parametrization expands one test definition into many test items, so each input gets its own pass/fail report.
- Use **fixtures** when several tests need the same setup (such as test data, a temporary file, or a database connection) or need predictable cleanup after they run.
- Use **`monkeypatch`** when a test needs to isolate code from external state—for example, environment variables, the current working directory, or a function that calls a remote service—without permanently changing that state.

You'll start by replacing loops and near-duplicate tests with parametrization. Then you'll use fixtures to share setup and cleanup, review built-in fixtures such as `tmp_path` and `monkeypatch`, and practice refactoring xUnit-style setup and teardown methods into a fixture.

By the end of this module, you'll be ready to apply these pytest features to reduce repetition, expand coverage, and improve failure diagnostics in your Python test suites.

For more information, see the pytest documentation for [assertions](https://docs.pytest.org/en/stable/how-to/assert.html), [parametrizing tests](https://docs.pytest.org/en/stable/how-to/parametrize.html), [fixtures](https://docs.pytest.org/en/stable/how-to/fixtures.html), and [monkeypatch](https://docs.pytest.org/en/stable/how-to/monkeypatch.html).
