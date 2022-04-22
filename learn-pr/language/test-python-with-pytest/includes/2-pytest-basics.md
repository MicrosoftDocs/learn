Let's get started testing with Pytest. As we've mentioned before, Pytest is highly configurable and can handle complex test suites. But it doesn't require much to start writing tests. In fact, the easier a framework allows you to write tests, the better. 

By the end of this section you'll have everything you need to start writing your first tests and run them with Pytest.

## Conventions

Before diving into writing tests, we must cover some of the testing conventions that Pytest relies on.

There aren't hard rules about test files, test directories, or general testing layouts in Python. By knowing these rules, you can take advantage of automatic test discovery and execution without the need for any extra configuration.

### Tests directory and test files

The main directory for tests is the _tests_ directory. You can place this directory at the root level of the project, but it is also not unusual to see it alongside code modules.

> [!NOTE]
> In this module we'll default to using _tests_ at the root of a project. 

Let's see how the root of a small Python project named `jformat` looks:

```text
.
├── README.md
├── jformat
│   ├── __init__.py
│   └── main.py
├── setup.py
└── tests
    └── test_main.py
```

The _tests_ directory is at the root of the project with a single test file. In this case, the test file is called _test_main.py_. These are two critical conventions:

- Use a _tests_ directory to place test files and nested test directories
- Prefix test files with _test_. The prefix indicates the file contains test code.

> [!CAUTION]
> Avoid using `test` (singular form) as the directory name. The `test` name is a Python module, so creating a directory named the same would override it. Always use the plural _tests_ instead.

### Test functions

One of the strong arguments to use Pytest is that it allows writing test functions. Similar to test files, function must be prefixed with `test_`. Using the `test_` prefix, you'll ensure that Pytest collects the test and executes it.

The following is how a simple test function looks:

```python
def test_main():
    assert "a string value" == "a string value"
```

> [!NOTE]
> If you are familiar with `unittest`, it might be surprising to see the use of `assert` in the test function. We'll cover plain asserts in more detail later, but with Pytest, you get rich failure reporting with plain asserts.

### Test classes and test methods

Similar to the conventions already mentioned, test classes and methods must be prefixed with `test`. 

Following other naming conventions in Python for classes and methods, this is how a small testing class that is checking usernames in an application would look like:

```python
class TestUser:

    def test_username(self):
        assert default() == "default username"
```

This is a core difference with Python's `unittest` library: there is no need to do any inheritance. These are the additional conventions:

- Test classes are prefixed with `Test`
- Test methods are prefixed with `test_`


## Run tests

Pytest is both a test framework and a test runner. The test runner is an executable in the command line that at a high level can:

- Perform collection of tests by finding all test files, test classes, and test functions for a test run
- Initiate a test run by executing all tests
- Keep track of failures, errors, and passing tests 
- Provide rich reporting at the end of a test run

> [!NOTE]
> Since Pytest is an external library it _must_ be installed in order to use it. 

Given these contents in a _test_main.py_ file, we can see how Pytest behaves running the tests:

```python
# contents of test_main.py file

def test_main():
    assert True
```

In the command line, in the same path where the _test_main.py_ file exists we can run the `pytest` executable:

```text
 $ pytest
=========================== test session starts ============================
platform -- Python 3.10.1, pytest-6.2.5, py-1.11.0, pluggy-1.0.0
rootdir: /private/tmp/project
collected 1 item

test_main.py .                                                       [100%]

============================ 1 passed in 0.00s =============================
```

Behind the scenes, Pytest collected the example test in the test file without any configuration needed. 

### The powerful assert statement

As you may have noticed already, the test examples are all using the plain `assert` call. Usually, in Python, the `assert` statement is not used for tests because it lacks right reporting when the assertion fails. When using Pytest, however, this is not the case. Behind the scenes, Pytest is enabling the statement to perform rich comparisons without forcing the user to write more code or configure anything. 

By using the plain `assert` statement, you can make use of Python's operators. For example: `>`, `<`, `!=`, `>=`, or `<=`. All of Python's operators are valid. This capability might be the single most crucial feature of Pytest: you aren't required to learn new syntax to write assertions.

Let's see how that translates when dealing with common comparisons with Python objects. In this case, let's go through the failure report when comparing very long strings:

```text
================================= FAILURES =================================
____________________________ test_long_strings _____________________________

    def test_long_strings():
        left = "this is a very long strings to be compared with another long string"
        right = "This is a very long string to be compared with another long string"
>       assert left == right
E       AssertionError: assert 'this is a ve...r long string' == 'This is a ve...r long string'
E         - This is a very long string to be compared with another long string
E         ? ^
E         + this is a very long strings to be compared with another long string
E         ? ^                         +

test_main.py:4: AssertionError
```

Pytest shows useful context around the failure. An incorrect casing at the beginning of the string, and an extra character in a word. But beyond strings, Pytest can help with other objects and data structures. This is how it behaves with lists:

```text
________________________________ test_lists ________________________________

    def test_lists():
        left = ["sugar", "wheat", "coffee", "salt", "water", "milk"]
        right = ["sugar", "coffee", "wheat", "salt", "water", "milk"]
>       assert left == right
E       AssertionError: assert ['sugar', 'wh...ater', 'milk'] == ['sugar', 'co...ater', 'milk']
E         At index 1 diff: 'wheat' != 'coffee'
E         Full diff:
E         - ['sugar', 'coffee', 'wheat', 'salt', 'water', 'milk']
E         ?                     ---------
E         + ['sugar', 'wheat', 'coffee', 'salt', 'water', 'milk']
E         ?           +++++++++

test_main.py:9: AssertionError
```

This report identifies that the index 1 (second item in the list) is different. Not only it identifies the index number, but also provides a representation of the failure. Aside from item comparisons, it can also report if items are missing, and provide information that can tell you exactly which item that might be. In the following case, that is `"milk"`:

```text
________________________________ test_lists ________________________________

    def test_lists():
        left = ["sugar", "wheat", "coffee", "salt", "water", "milk"]
        right = ["sugar", "wheat", "salt", "water", "milk"]
>       assert left == right
E       AssertionError: assert ['sugar', 'wh...ater', 'milk'] == ['sugar', 'wh...ater', 'milk']
E         At index 2 diff: 'coffee' != 'salt'
E         Left contains one more item: 'milk'
E         Full diff:
E         - ['sugar', 'wheat', 'salt', 'water', 'milk']
E         + ['sugar', 'wheat', 'coffee', 'salt', 'water', 'milk']
E         ?                    ++++++++++

test_main.py:9: AssertionError
```

Finally, let's see how it behaves with dictionaries. Comparing two large dictionaries can be overwhelming if there are failures, but Pytest does an outstanding job at providing context and pinpoint the failure:

```text
____________________________ test_dictionaries _____________________________

    def test_dictionaries():
        left = {"street": "Ferry Ln.", "number": 39, "state": "Nevada", "zipcode": 30877, "county": "Frett"}
        right = {"street": "Ferry Lane", "number": 38, "state": "Nevada", "zipcode": 30877, "county": "Frett"}
>       assert left == right
E       AssertionError: assert {'county': 'F...rry Ln.', ...} == {'county': 'F...ry Lane', ...}
E         Omitting 3 identical items, use -vv to show
E         Differing items:
E         {'street': 'Ferry Ln.'} != {'street': 'Ferry Lane'}
E         {'number': 39} != {'number': 38}
E         Full diff:
E           {
E            'county': 'Frett',...
E
E         ...Full output truncated (12 lines hidden), use '-vv' to show
```

In this test, there are two failures in the dictionary. One is that the `"street"` value is different, and the other one is that `"number"` doesn't match.

Pytest is accurately detecting these differences (even though it is one failure in a single test). Since the dictionaries contain many items, Pytest omits the identical parts and only shows relevant content. Let's see what happens if we make use of the suggested `-vv` flag to increase the verbosity in the output:

```text
____________________________ test_dictionaries _____________________________

    def test_dictionaries():
        left = {"street": "Ferry Ln.", "number": 39, "state": "Nevada", "zipcode": 30877, "county": "Frett"}
        right = {"street": "Ferry Lane", "number": 38, "state": "Nevada", "zipcode": 30877, "county": "Frett"}
>       assert left == right
E       AssertionError: assert {'county': 'Frett',\n 'number': 39,\n 'state': 'Nevada',\n 'street': 'Ferry Ln.',\n 'zipcode': 30877} == {'county': 'Frett',\n 'number': 38,\n 'state': 'Nevada',\n 'street': 'Ferry Lane',\n 'zipcode': 30877}
E         Common items:
E         {'county': 'Frett', 'state': 'Nevada', 'zipcode': 30877}
E         Differing items:
E         {'number': 39} != {'number': 38}
E         {'street': 'Ferry Ln.'} != {'street': 'Ferry Lane'}
E         Full diff:
E           {
E            'county': 'Frett',
E         -  'number': 38,
E         ?             ^
E         +  'number': 39,
E         ?             ^
E            'state': 'Nevada',
E         -  'street': 'Ferry Lane',
E         ?                    - ^
E         +  'street': 'Ferry Ln.',
E         ?                     ^
E            'zipcode': 30877,
E           }
```

By running `pytest -vv`, the reporting increases the amount of detail and provides a granular comparison. Not only this report detects and shows the failure, but it allows you to quickly make changes to remediate the problem.