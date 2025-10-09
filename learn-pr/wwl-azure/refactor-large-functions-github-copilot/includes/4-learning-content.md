GitHub Copilot Chat’s Ask Mode is like having a knowledgeable colleague you can ask about your code. It does not modify your code (read-only), but it can:

- Interpret
- Summarize
- Suggest improvements
- Answer questions

This is incredibly useful for understanding a large function and planning a refactor.

## What Ask Mode Can Do

- **Summarize code:** Plain English breakdown of what the function does.
- **Identify logical sections:** Often returns a numbered list of steps.
- **Highlight problems:** May point out repetition or complexity.
- **Answer specific questions:** “What does this loop do?” or “Why are these parameters needed?”
- **Suggest refactoring approaches:** “You could extract these steps into separate functions…”

## How to Use Ask Mode

1. **Open the file** with the large function in VS Code.

1. **Highlight the function** or place your cursor inside it.

1. **Ask a question** in natural language:

   - “Can you summarize what this function does?”
   - “List the distinct tasks this function performs.”
   - “How can I refactor this function to be shorter?”

1. **Review Copilot’s answer:**

   - Look for logical breakdowns.
   - Identify candidate blocks for extraction.

1. **Ask follow-ups:**

   - “Explain the error handling in more detail.”
   - “Is this function following the single responsibility principle?”

## Example Prompt and Response

Prompt:

```plaintext
This function parses a file and then does several calculations. It's over 100 lines. How can I refactor it?”
```

Response:  

```plaintext
It looks like the function has distinct phases:  

1. Read and validate file data.
2. Compute statistics (sum, average, etc.).
3. Format and output results.

You could extract those into separate functions: `ParseFile`, `ComputeStats`, `PrintResults`.”
```

## Tips for Effective Use

- **Be specific:** Ask about particular sections if needed.
- **Keep context visible:** Ensure Copilot can “see” the whole function.
- **Don’t blindly trust suggestions:** Use your judgment.
- **Use Ask Mode output as a blueprint:** Plan your refactor based on its breakdown.

> 💡 **Expert Insight:** Ask Mode is your second opinion.  
> I use it to validate my plan. If Copilot describes the same sections I identified, I know I’m on the right track. If it finds more, I reconsider what I missed.

## Summary

Ask Mode helps you analyze and understand large functions.  
It’s your planning assistant before you start refactoring.  
Next, we’ll use Agent Mode to execute the refactor based on this analysis.
