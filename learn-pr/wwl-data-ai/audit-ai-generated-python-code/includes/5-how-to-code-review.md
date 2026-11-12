Code review is a structured process for checking code. Applying the same steps to every piece of AI-generated code helps you catch problems consistently.

### The review process

**Step 1: Understand what it's supposed to do**

Read the function or code block. What is it supposed to accomplish? If you can't understand the purpose, the code is probably unclear.

**Step 2: Test manually and with unit tests**

Running the code is the fastest way to find obvious problems. Test:

- The normal case (does it work?)
- Edge cases (what about empty input, zero, negative numbers?)

Manual checks are useful for a first look, but they aren't repeatable. Unit tests record the expected behavior so you can rerun them after every change.

```python
# AI-generated function
def calculate_average(numbers):
    return sum(numbers) / len(numbers)

# Test normal case
calculate_average([10, 20, 30])  # Returns 20

# Test edge case
calculate_average([])  # Raises ZeroDivisionError
```

These checks expose the problem.

### Write unit tests

Write unit tests with a framework such as pytest. Each test asserts the result you expect, including the edge cases:

```python
import pytest

def test_average_of_normal_values():
    assert calculate_average([10, 20, 30]) == 20

def test_average_of_single_value():
    assert calculate_average([5]) == 5

def test_average_of_empty_list_raises_value_error():
    with pytest.raises(ValueError):
        calculate_average([])
```

The last test fails against the AI-generated version, because it raises `ZeroDivisionError` instead of a `ValueError` with a clear message. A failing test is useful: it documents the expected behavior and shows what to fix. Run the tests with `pytest` after each change.

### Generate unit tests with AI, then review them

An AI assistant can generate tests for you. Give it the function and the cases you want covered:

> Write pytest unit tests for `calculate_average`. Include normal input, a single value, negative numbers, and an empty list. For empty input, expect a `ValueError` with a clear message.

Review generated tests as carefully as the code they check. Confirm that:
- Each expected value is correct for the specification, not copied from the function's output. A test that asserts whatever the code returns can't catch a bug.
- The tests cover the edge cases you care about, not only the normal case.
- Each test checks a specific behavior. A test that only confirms the function runs without an error doesn't prove much.
- The tests fail when the behavior is wrong. Temporarily break the function to verify that the tests detect the error.

**Step 3: Look for incorrect information**

Verify that functions and methods actually exist. Use your editor's autocomplete to check.

**Step 4: Audit for efficiency**

Think about scale:
- Are there nested loops?
- Would the code be slow with 1 million items?
- Are there simpler built-in methods?

**Step 5: Check security**

Look for input that reaches a query, a command, or a file path without validation, and for secrets written directly in the code. The security unit covers these checks in detail.

**Step 6: Check error handling**

Does the code handle problems gracefully? Or does it crash on unusual input?

```python
# Poor error handling
def convert_to_int(text):
    return int(text)  # Crashes if text isn't a number

# Better error handling
def convert_to_int(text):
    try:
        return int(text)
    except ValueError as error:
        raise ValueError(f"Expected a whole number, got {text!r}") from error
```

Returning `None` on failure isn't a good fix. The caller doesn't know the conversion failed, so the error appears later in an unrelated place. Raising a clear error at the point of failure makes the problem easier to find.

### Review example

AI-generated code:

```python
def find_user_by_email(email):
    for user in all_users:
        if user.email == email:
            return user
    return None
```

Review results:

- **Understand**: Searches for a user with the given email
- **Run**: Works with normal input
- **Edge cases**:
  - Empty all_users list? Returns None ✓
  - Email not found? Returns None ✓
  - None passed as email? Returns None without an error, which can hide a bug in the caller ✗
- **Efficiency** ✗: If all_users has 1 million users, the loop does 1 million comparisons. Could use a dictionary instead.
- **Error handling** ✗: Doesn't handle None email gracefully

Verdict: **Works but needs improvement**. Fix it by building the lookup once and validating the input:

```python
def build_email_index(users):
    return {user.email: user for user in users}

def find_user_by_email(email, email_index):
    if not email:
        raise ValueError("An email address is required")
    return email_index.get(email)
```

The dictionary lookup takes about the same time regardless of how many users there are. Building the index once, before the searches, avoids scanning the full list for each search.

### Questions to ask during review

- Does it actually do what it's supposed to?
- Does it crash on normal edge cases?
- Are the functions/methods real?
- Would it be slow with lots of data?
- Does it handle errors gracefully?
- Is the code readable?
- Do unit tests cover the normal and edge cases, and do they check the expected behavior?
- Does it contain security risks, such as unvalidated input in queries, commands, or file paths?

### Common mistakes in AI code

- Incorrect information (such as functions that don't exist)
- Inefficient algorithms (nested loops when not needed)
- Security risks (injection, hardcoded secrets, unsafe file paths)
- Missing error handling
- Edge cases not considered
- Overly complex when simpler approaches exist
- No input validation

### What to accept vs fix

**Accept**: Code that works correctly and efficiently

**Fix or reject**:

- Code that relies on incorrect information
- Code that's inefficient for realistic data sizes
- Code with poor error handling
- Code that's unclear

### Reviewer responsibilities

AI-generated code needs the same scrutiny as code written by a person. As a reviewer, you:

1. Catch obvious problems, such as nonexistent functions and crashes.
2. Suggest better approaches where they exist.
3. Confirm that the code handles edge cases.
4. Verify that the code scales to realistic data sizes.

Finding problems during review is part of delivering quality code to production.
