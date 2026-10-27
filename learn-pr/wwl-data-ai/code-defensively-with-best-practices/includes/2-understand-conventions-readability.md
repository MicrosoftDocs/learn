## Understand conventions and readability

Code with variables named `a`, `b`, `x1`, and `x2` and inconsistent formatting is hard to read. **Code conventions** are agreed-upon rules that keep code consistent. Code that follows them is easier to read, in the same way that complete sentences are easier to read than random words.

Python's official style guide is **PEP 8** (Python Enhancement Proposal 8). You don't need to memorize it. Learn the basic conventions in this unit.

### Use clear, descriptive names

The most important convention is to use **clear, descriptive names**:

```python
# Hard to understand
def calc(a, b):
    return a * b

# Clear and understandable
def calculate_area(width, height):
    return width * height
```

The name `calculate_area(width, height)` tells you what the function does and what it needs. The name `calc(a, b)` tells you nothing.

### Follow naming patterns

Python uses a different naming style for each kind of name:

```python
# Variables and functions: lowercase with underscores
user_age = 25
calculate_total_price()

# Constants (values that shouldn't change): UPPERCASE with underscores
MAX_LOGIN_ATTEMPTS = 5
DAYS_IN_WEEK = 7

# Classes: CapWords (start with uppercase)
class BankAccount:
    pass
```

### Format code consistently

Use 4 spaces for indentation, not tabs. PEP 8 also recommends lines of 79 characters or fewer. Long lines are hard to read and force you to scroll sideways.

```python
# Too hard to read (one long line)
total = purchase_price + (purchase_price * tax_rate) + shipping_cost + handling_fee - applied_discount

# Clearer: name each part of the calculation
tax = purchase_price * tax_rate
fees = shipping_cost + handling_fee
total = purchase_price + tax + fees - applied_discount
```

If a line is still too long, break it inside parentheses:

```python
total = (
    purchase_price
    + tax
    + fees
    - applied_discount
)
```

You don't have to format code by hand. Tools such as Black, Ruff, and flake8 format your code or flag style problems for you.

### Why conventions matter

Working code isn't enough. Style matters for three reasons:
- **Other people read your code.** Teammates, code reviewers, and future maintainers all depend on it being clear.
- **You forget your own code.** In three months, you won't remember how your own function works.
- **Inconsistency hides bugs.** When code is written in different styles, mistakes are easier to miss during review.

Following conventions is a small habit that pays off immediately.

For now, focus on clear names and consistent indentation. Let a formatter or linter handle the rest.
