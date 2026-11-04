After you break a feature into pieces, write each piece as an **explicit specification**. An explicit specification leaves no ambiguity about what the code should do, so a reader, human or AI, can implement it without guessing.

## Replace vague wording with explicit details

Compare two descriptions of the same function.

**Vague**: "Validate a password."

This description leaves open how many characters are required, whether uppercase letters are required, and which special characters are allowed.

**Explicit**: "Validate a password: it must be at least 8 characters and include at least one uppercase letter, one number, and one special character (`!@#$%`)."

The explicit version answers each of those questions.

## Include four parts

A good specification states:

- **Input**: What data the function receives.
- **Processing**: What the function does with the data.
- **Output**: What the function returns.
- **Errors**: Which problems can occur and how the function handles them.

## Example: validate an email address

The following specification includes all four parts and adds examples:

```text
Function: validate_email
Input: a string that might be an email address
Processing:
  1. Check that the string has exactly one @ symbol.
  2. Check that at least one character comes before the @.
  3. Check that at least one dot comes after the @.
  4. Check that at least 2 characters come after the last dot.
Output: True if all checks pass, False otherwise
Errors: If the input is None or not a string, return False.

Examples:
  validate_email("user@example.com")  → True
  validate_email("invalid@")          → False
  validate_email("no-at-sign.com")    → False
```

A developer or an AI assistant can implement this function exactly as described.

## Example: calculate a discount

**Vague**: "Apply a discount."

**Explicit**:

```text
Function: apply_discount
Input:
  - original_price: a number (the price before the discount)
  - discount_percent: a number (for example, 10 means 10% off)
Processing:
  1. Calculate the discount amount: original_price × (discount_percent ÷ 100)
  2. Subtract the discount amount from the original price.
Output: the final price after the discount
Errors:
  - If discount_percent is less than 0 or greater than 100, return an error message.
  - If original_price is less than 0, return an error message.

Examples:
  apply_discount(100, 20)  → 80
  apply_discount(50, 0)    → 50
  apply_discount(100, -10) → error: discount must be from 0 through 100
```

This specification states the formula, the valid ranges, and the expected result for each case.

## Why this matters for AI

If you ask an AI assistant to "apply a discount," it must decide how to handle negative percentages, whether to validate the inputs, and which formula to use. An explicit specification answers those questions in advance.

The specification also serves two other purposes:

- It guides the implementation.
- Its examples become a test checklist. You can check whether the code returns the expected result for each one.

A specification describes what the code does, not how to write it. Be specific, include examples, and remove ambiguity.
