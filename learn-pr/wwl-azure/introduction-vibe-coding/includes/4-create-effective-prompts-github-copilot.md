A **prompt** is a natural language instruction that tells GitHub Copilot what you want it to do. Prompts can be used to ask questions, communicate requests, or describe tasks.

For example, the following prompts represent a question, a request, and a task description.

```md
Question: How do I create a button that submits a form?

Request: Add a button that opens a modal dialog. The button should be blue with rounded corners.

Task: Build a product page that displays a product title, product image, product description, and price. Product information should be fetched from the attached ProductsList.json file. The price should be formatted as currency. The page should also include a button to add the product to the cart.
```

The quality of your prompt directly affects the quality of GitHub Copilot's response.

## What makes a good prompt?

Creating high-quality prompts is essential for getting the most value from GitHub Copilot. The following strategies will help you craft prompts that generate more accurate, relevant, and useful responses.

### Start general, then get specific

When writing a prompt for Copilot, begin with a broad description of your goal or scenario, then provide specific requirements. This approach gives Copilot the necessary context while ensuring your detailed needs are addressed.

**Example:**

```text
Write a function that tells me if a number is prime.

The function should take an integer and return true if the integer is prime.

The function should error if the input is not a positive integer.
```

### Provide concrete examples

Examples are one of the most effective ways to communicate your intent to Copilot. You can provide example input data, expected outputs, and even example implementations to guide the AI's understanding.

**Example**:

```text
Write a function that finds all dates in a string and returns them in an array. Dates can be formatted like:

- 05/02/24
- 05/02/2024
- 5/2/24
- 5/2/2024
- 05-02-24
- 05-02-2024
- 5-2-24
- 5-2-2024

Example usage:
findDates("I have a dentist appointment on 11/14/2023 and book club on 12-1-23")

Expected return: ["11/14/2023", "12-1-23"]
```

### Break complex tasks into simpler steps

When facing a complex or large task, decompose it into smaller, manageable components. This approach leads to better results and makes it easier to debug and refine individual pieces.

**Example**: Instead of asking Copilot to generate a complete word search puzzle, break it down:

1. `Write a function to generate a 10 by 10 grid of letters`
2. `Write a function to find all words in a grid of letters, given a list of valid words`
3. `Write a function that uses the previous functions to generate a 10 by 10 grid containing at least 10 words`
4. `Update the previous function to print the grid and 10 random words from the grid`

### Eliminate ambiguity

Avoid vague references and ambiguous terms that could be interpreted multiple ways. Be explicit about what you're referring to and what you want Copilot to do.

**Poor examples**:

- "What does this do?" (unclear what "this" refers to).
- "Fix the bug" (doesn't specify which bug or how to fix it).

**Better examples**:

- "What does the createUser function do?"
- "What does the code in your last response do?"
- "Fix the validation error in the email input field."

**Library considerations**:

- If using an uncommon library, describe its purpose.
- For specific libraries, include import statements or specify which library you want to use.

### Provide relevant context

Help Copilot understand your project structure and intentions by managing your development environment effectively.

**In your IDE**:

- Open relevant files and close unrelated ones.
- Highlight specific code sections you want Copilot to reference.
- Use chat participants like `@workspace` in Visual Studio Code or `@project` in JetBrains IDEs.

**In Copilot Chat**:

- Reference specific files or code blocks.
- Attach relevant documentation or specifications.
- Use clear file paths and function names.

### Iterate and refine

Don't expect perfect results on the first try. Copilot works best when you engage in an iterative conversation, refining your requests based on the responses you receive.

**Strategies for iteration**:

- If using inline suggestions, delete and try again with a modified prompt.
- In Copilot Chat, reference previous responses and ask for specific modifications.
- Build upon partial solutions by asking for incremental improvements.

### Maintain relevant conversation history

Copilot Chat uses conversation history to understand context, so manage this history strategically.

**Best practices**:

- Start new threads for different tasks or projects.
- Delete irrelevant or unsuccessful requests that might confuse future responses.
- Keep conversations focused on related functionality.

### Follow good coding practices

The quality of your existing codebase affects Copilot's ability to generate appropriate suggestions. Maintain high standards in your code to get better AI assistance.

**Code quality factors**:

- Use consistent code style and patterns.
- Choose descriptive names for variables and functions.
- Add meaningful comments to explain complex logic.
- Structure code into modular, well-scoped components.
- Include comprehensive unit tests.

> [!NOTE]
> You can ask Copilot to help improve your code quality by requesting comments, refactoring suggestions, or breaking large functions into smaller, more manageable pieces.

Good prompts are:

- Clear: Describe exactly what you want.
- Specific: Include layout, behavior, or styling details.
- Contextual: Reference existing code or structure.

## Iterating on prompts

If GitHub Copilot’s initial response doesn't align with your expectations, you may need to iterate on your prompt. Consider these strategies:

- Edit the prompt to be more specific.
- Add context to the chat that clarifies your goals or requirements.
- Use Copilot Chat to ask follow-up questions that build on previous responses.

### Evaluating and responding to Copilot's suggestions

Understanding how to assess Copilot's suggestions is crucial for effective vibe coding. Not every suggestion will be perfect, and knowing when to accept, reject, or modify responses will significantly improve your development experience.

#### When to accept suggestions

Accept Copilot's suggestions when they:

- Meet your requirements: The code does exactly what you asked for.
- Follow best practices: Uses appropriate patterns, naming conventions, and structure.
- Are well-structured: Code is readable, maintainable, and properly formatted.
- Include proper error handling: Edge cases and potential failures are addressed.
- Match your project's style: Consistent with existing codebase patterns and conventions.

**Example of a good suggestion to accept**:

*Prompt:* "Create a function to validate email addresses"

*Copilot suggests:*

```javascript
function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (typeof email !== 'string') {
        throw new Error('Email must be a string');
    }
    return emailRegex.test(email.toLowerCase());
}
```

This suggestion should be accepted because it includes input validation, error handling, and uses a reasonable regex pattern.

#### When to reject suggestions

Reject Copilot's suggestions when they:

- Don't address your prompt: The code solves a different problem than requested.
- Contain security vulnerabilities: Use unsafe practices or expose sensitive data.
- Are overly complex: Simple tasks implemented with unnecessary complexity.
- Use deprecated methods: Rely on outdated or obsolete APIs.
- Lack error handling: Don't account for potential failure scenarios.
- Violate coding standards: Don't follow your team's established practices.

**Example of a suggestion to reject**:

*Prompt:* "Create a secure password validation function"

*Poor suggestion:*

```javascript
function validatePassword(password) {
    return password.length > 6;
}
```

This should be rejected because it's too simplistic for security requirements and doesn't validate password strength properly.

#### When to modify suggestions

Modify Copilot's suggestions when they:

- Are mostly correct but need adjustments: Core logic is sound but details need tweaking.
- Need additional features: Base functionality is good but requires enhancements.
- Have minor style issues: Code works but doesn't match your formatting preferences.
- Require different variable names: Logic is correct but naming could be improved.
- Need performance optimizations: Functional but could be more efficient.

**Example of a suggestion to modify**:

*Copilot suggests:*

```javascript
function calculateTotal(items) {
    let total = 0;
    for (let i = 0; i < items.length; i++) {
        total += items[i].price;
    }
    return total;
}
```

*Your modification for better readability and modern JavaScript:*

```javascript
function calculateTotal(items) {
    return items.reduce((total, item) => total + item.price, 0);
}
```

#### Strategies for improving suggestions

When a suggestion isn't quite right, try these approaches:

**Refine your prompt**:

- Add more specific requirements.
- Include examples of expected input/output.
- Specify the programming style or framework you're using.

**Request modifications**:

- "Make the previous function more robust with error handling."
- "Simplify the code you just wrote."
- "Add TypeScript types to the previous function."

**Build incrementally**:

- Start with a basic version and ask for enhancements.
- Add features one at a time rather than requesting everything at once.
- Test each iteration before moving to the next enhancement.

> [!TIP]
> When modifying suggestions, keep the parts that work well and be specific about what needs to change. This helps Copilot understand your preferences and provide better future suggestions.

## Summary

Creating effective prompts for GitHub Copilot is essential for maximizing its potential in vibe coding. By starting with general descriptions, providing concrete examples, breaking down complex tasks, and maintaining clear communication, you can guide Copilot to generate high-quality code that meets your needs. Iterating on prompts and understanding how to evaluate suggestions will further enhance your development experience, allowing you to leverage AI assistance effectively while maintaining control over the coding process.
