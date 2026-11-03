A request such as "Build a login system" is too broad to implement directly. It doesn't say whether the system covers authentication only, or also password reset, session management, and security requirements. **Deconstructing** a request means breaking it into smaller pieces that you can specify and build one at a time.

## Why deconstruction matters

Skipping this step leads to missing pieces. A developer might build authentication but forget that users need a way to reset a forgotten password, or might not plan for session timeouts. Deconstruction exposes these gaps before you write any code.

## Break a feature into actions

Start by asking what the user does. For the login system, the main actions are:

- Create an account.
- Log in.
- Get logged out after a period of inactivity.
- Reset a forgotten password.

Then, for each action, ask what goes in, what the system does, what comes out, and what can go wrong. The following example applies these questions to creating an account:

```text
Create an account:
- Input: email, password
- Processing:
  - Check that the email has a valid format.
  - Check that the password is strong enough (at least 8 characters).
  - Store the email.
  - Store a protected (hashed) version of the password, not the password itself.
- Output: success message, redirect to the login page
- Errors:
  - Email already in use
  - Password too weak
  - Email format invalid
```

This description is far more useful than "Build a login system". It lists specific behaviors that you can build and test.

## Apply the approach to another feature

The following example deconstructs "Build a shopping cart":

```text
Shopping cart:

1. Add an item
   - Input: product ID, quantity
   - Checks: the product exists, the quantity is positive, the product is in stock
   - Action: add the item to the user's cart
   - Errors: product doesn't exist, product out of stock, invalid quantity

2. View the cart
   - Input: user ID
   - Action: show all items in the cart
   - Errors: user has no cart, database error

3. Remove an item
   - Input: product ID
   - Action: remove the item from the user's cart
   - Errors: item isn't in the cart

4. Check out
   - Input: user information, payment information
   - Checks: the payment succeeds
   - Action: clear the cart and create an order
   - Errors: payment fails, inventory changes during checkout
```

The result is a list of pieces that you can estimate, build, and test separately.

## Questions to ask

Use these questions to deconstruct any feature:

- **What does the user do?** These are the main actions.
- **What information goes in?** These are the inputs.
- **What information comes out?** These are the results.
- **What can go wrong?** These are the error cases.
- **Are there dependencies?** Some pieces must happen before others.

## Why this matters for AI

If you ask an AI assistant to "build a login system," it produces something based on its own assumptions about what the system includes. If you deconstruct the request first, you can ask for one precise piece at a time, such as "Write a function that checks whether an email address has a valid format." Each request is easier to check, and the result is more likely to match what you need.
