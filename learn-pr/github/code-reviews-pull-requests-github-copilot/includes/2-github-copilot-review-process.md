Code reviews and pull request reviews are essential for quality, but they can also be time-consuming and uneven. Developers often juggle multiple languages, inconsistent formatting, and large diffs while trying to provide thoughtful feedback. GitHub Copilot helps ease this workload by acting as a collaborative reviewer and assistant. It catches common issues, drafts review comments, summarizes pull requests, and even highlights security risks-giving reviewers a clear starting point. With custom review instructions, you can guide Copilot to watch for the same patterns you do, ensuring consistency across teams and repositories.

By the end of this unit, you'll be able to:

- Identify the key features of Copilot in code reviews.
- Explain how PRUs unlock advanced review capabilities.
- Recognize different ways Copilot review complements and helps developers.

## Key features of Copilot in code reviews 

Copilot introduces several features designed to streamline reviews:

- **PR Summaries**: Copilot can automatically draft pull request descriptions that include a clear summary of changes and a list of affected files. This ensures reviewers start with context, not guesswork.

- **Security Fixes:** With Copilot code review integrated into GitHub Code Scanning, vulnerabilities are flagged across languages. For example, in **JavaScript**, Copilot can spot unsanitized input passed to eval() and comment:

  "eval() with user input can lead to code injection. Replace it with a safe parser like JSON.parse()." It then offers an inline patch aligned with your repository's security guidelines.

- **Line-by-Line Explanations**: Reviewers can highlight code and ask Copilot to explain functionality, helping them understand unfamiliar code quickly.
- **Drafting Comments**: Copilot can generate review comments based on best practices or team guidelines, making feedback clear and actionable.
- **Reviews in Your IDE**: In addition to working directly on GitHub.com, Copilot can also review code inside your IDE. This allows developers to catch and resolve issues before opening a pull request, speeding up the process and reducing rework.

## Understand how PRUs unlock advanced review capabilities

PRUs power these advanced capabilities. For example, assigning Copilot as a PR reviewer uses a PRU each time it posts comments. When combined with custom `.github/copilot-instructions.md` files, PRU-powered reviews align with your team's rules, whether they focus on readability, security, or style.

Example:

Without Copilot, a PR might include vague comments from a reviewer like *"Fix security issue here"*. With the help of Copilot + PRUs, the review becomes:

  "The use of `exec()` introduces a code injection vulnerability. Consider replacing it with `subprocess.run()` for safer command execution. Here's a suggested patch:"

And it provides the code fix inline.

## 5 different ways Copilot review helps developers

Next up we'll review how Copilot review can help you work smarter with:

- Code review Suggestions
- Copilot reviews across multiple languages
- Formatting data in Pull requests
- Writing Effective Pull Request Summaries
- Explaining and Reviewing Code

## Using Copilot suggestions in code reviews

When you're reviewing a pull request, you might spot areas that could be improved but not have the time to draft the perfect example or snippet yourself. GitHub Copilot helps fill that gap without taking over the author's work. Inside the pull request "Files changed" view, you can highlight a line or block of code and ask Copilot to suggest improvements or flag potential issues. Copilot then generates a concrete, context-aware suggestion that you can copy into your review comment, making your feedback clearer and easier for the author to act on.

For example, while reviewing a Ruby file with repeated logic, you could highlight the relevant lines and ask:

  "Suggest a cleaner Ruby refactor for this repeated code."

Copilot will propose an updated version that follows common Ruby best practices. You can paste its recommendation (or parts of it) into your review comment along with your own explanation. This keeps you focused on the overall quality and design while still giving the author actionable, high-value feedback-without blurring the line between reviewing and coding on their behalf.

## Reviewing across multiple languages

When you request a code review, Copilot can automatically highlight areas that don't follow best practices or team guidelines

Copilot will quickly generate improvements that align with the conventions of the language, enabling you to give stronger, more accurate review feedback even outside your primary area of expertise.

:::image type="content" source="../media/pull-request-go-short-variable-declaration.png" alt-text="Screenshot of a GitHub pull request showing a code suggestion to replace a variable declaration with a short variable declaration in a Go program." lightbox="../media/pull-request-go-short-variable-declaration.png":::

## Formatting data for pull requests

Pull requests are much clearer when they include well-formatted context such as metrics, screenshots, or test results. However, teams often forget to format this content consistently. GitHub Copilot can act as a second set of eyes during code review, automatically flagging poorly formatted tables in a pull request description and proposing a cleaner version that aligns with your company's style guidelines.

Example: A developer submits a pull request with the following table of page load times. It's hard to read and doesn't follow the team's Markdown style guide:

| Test Run | LoadTimeBefore | LoadTimeAfter |
| -------- | -------------- | ------------- |
|          | 1.3            | 1.2           |
|          | 1.2            | 1.1           |
|          | 1.1            | 0.885         |
|          | 1.3            | 1.3           |
|          | 1.2            | 0.918         |
| Average  | 1.22           | 1.0806        |

During the review, Copilot posts a comment:

  "This table doesn't follow your repository's Markdown guidelines. Here's a cleaned-up version based on your company's style guide."

And it includes a corrected version ready to paste into the PR description:

| Test Run    | Load Time Before (seconds) | Load Time After Updates (seconds) |
| ----------- | -------------------------- | --------------------------------- |
| 1           | 1.3                        | 1.2                               |
| 2           | 1.2                        | 1.1                               |
| 3           | 1.1                        | 0.885                             |
| 4           | 1.3                        | 1.3                               |
| 5           | 1.2                        | 0.918                             |
| **Average** | **1.22**                   | **1.0806**                        |

The reviewer can accept Copilot's suggestion with one click, ensuring the PR follows company style without spending time reformatting.

This shows Copilot acting as an automatic reviewer (not a coding agent): it sees the unformatted table, applies the company guidelines from `.github/copilot-instructions.md`, and supplies a corrected version inline.

## Writing effective pull request summaries

Writing PR descriptions is often the last step in the process and can feel like a hurdle. Copilot makes this easier. From the PR description editor, you can use the Copilot icon to generate a draft summary or outline. Even if you make edits, having a well-structured starting point saves time and ensures reviewers have the information they need.

:::image type="content" source="../media/pull-request-comment-copilot-summary.png" alt-text="Screenshot of a GitHub pull request showing a comment box with GitHub Copilot options to generate a summary or outline of the changes." lightbox="../media/pull-request-comment-copilot-summary.png":::

## Explaining and reviewing code

Sometimes you may be unfamiliar with the code in a pull request. Instead of struggling through it, you can ask Copilot to explain the changes. Copilot can also run an initial review of your own PRs before you request feedback from teammates. This helps catch smaller issues, validates best practices, and gives you more confidence in the quality of your submission.

You now know what Copilot is capable of when it comes to code reviews. Next, let's see how to use Copilot reviews directly on [GitHub.com](https://github.com/).