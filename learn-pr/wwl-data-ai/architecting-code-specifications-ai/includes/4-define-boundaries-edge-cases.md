Bugs often appear at the edges of what a function accepts, not in the normal case. A function that validates age works for 20, 35, and 67. But what about 0, -5, or 999?

**Edge cases** are inputs at the boundaries of what a function accepts. They're unusual inputs that can break code, and they need to be specified.

## What edge cases look like

For an age validator, a normal input is `age = 30`. Edge cases include:

- `age = 0`: A newborn. Is this valid?
- `age = -1`: Impossible, because the value is negative.
- `age = 150`: Very high. The specification must say whether it's valid.
- `age = "thirty"`: The wrong type.
- `age = None`: A missing value.

## Why edge cases matter

The following function calculates an average:

```python
def calculate_average_score(scores):
    return sum(scores) / len(scores)

# Works with typical input:
calculate_average_score([80, 90, 100])  # Returns 90.0

# Fails on an empty list:
calculate_average_score([])  # Raises ZeroDivisionError
```

The function works until it receives an empty list, and then it crashes. An AI assistant that has no edge cases in the specification is likely to write the function this way.

The following specification adds the edge cases:

```text
Function: calculate_average_score
Input: a list of test scores
Processing: add all the scores, then divide by the number of scores
Output: the average score as a number
Edge cases:
  - If the list is empty: return an error message.
  - If any score is negative: return an error message.
  - If any score is above 100: return an error message.
```

The specification chooses one behavior for the empty list. Returning 0 would also be reasonable, but the specification must state which behavior to use. The implementer shouldn't have to guess.

## Common edge cases by input type

Use the following table as a starting point:

| Input type | Edge cases to consider |
|---|---|
| Numbers | Zero, negative numbers, very large numbers, decimals when an integer is expected |
| Strings | Empty string, very long strings, special characters, only spaces |
| Lists | Empty list, one item, duplicate items, `None` values |
| Dates and times | Leap days (February 29), year boundaries (December 31 to January 1), midnight |

## Specify edge cases

Include edge cases in every specification. The following example specifies edge cases for a function that looks up a user:

```text
Function: get_user_by_id
Input: user_id (a number)
Output: a user object or an error
Edge cases:
  - If user_id is 0: return an "invalid ID" error.
  - If user_id is negative: return an "invalid ID" error.
  - If the user doesn't exist: return a "user not found" error.
  - If the database is unavailable: return a "connection error" message.
```

Include the edge cases in the examples as well:

```text
Examples:
  get_user_by_id(1)      → returns the user object
  get_user_by_id(99999)  → returns a "user not found" error
  get_user_by_id(0)      → returns an "invalid ID" error
```

## Why AI needs edge cases

Without edge cases in the specification, an AI assistant tends to write code that handles the expected input and fails on unusual input. With edge cases specified, the assistant knows what to handle.

The edge cases also serve as a review checklist:

- Does the code handle empty input?
- Does the code reject negative numbers?
- Does the code return clear error messages?

Specifying edge cases is what keeps code reliable when the input isn't normal.
