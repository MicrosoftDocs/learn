# Remediate issues using GitHub Copilot Agent mode

After analyzing security issues using Ask mode, you're ready to implement fixes. GitHub Copilot's Agent mode enables you to execute complex remediation tasks safely while ensuring functionality is preserved and code quality is improved.

> [!NOTE]
> Always use GitHub Copilot's Ask mode to analyze security issues and formulate a remediation plan before using Agent mode to implement changes. This approach ensures that refactoring is done thoughtfully and safely.

## What is Agent mode?

GitHub Copilot's Agent mode works autonomously to execute complex remediation tasks across your codebase. Unlike Ask mode, which provides guidance and suggestions in the chat panel, Agent mode implements suggested updates as edits directly in your code files.

Agent mode capabilities include:

- Editing files with precise code modifications.
- Applying changes across multiple files simultaneously.
- Running tests to verify changes.
- Executing commands based on your instructions.
- Understanding project context and dependencies.
- Maintaining consistency across the codebase.

Agent mode is ideal for implementing multi-step security fixes that require careful handling of dependencies, edge cases, and testing. Agent mode automatically defines the required context and executes the necessary steps to achieve your remediation goals.

## Remediate security issues using Agent mode

You can use Agent mode to implement the security fixes identified during your Ask mode analysis. Agent mode can execute multiple remediation steps automatically while preserving the original functionality and improving code security.

### Strategies for remediating security issues

Here are key strategies for using Agent mode to remediate security issues:

- **Fix injection vulnerabilities**: Instruct Agent mode to replace string concatenation with parameterized queries or prepared statements.

- **Implement secure encryption**: Have Agent mode upgrade weak hashing algorithms using secure alternatives like bcrypt or Argon2.

- **Sanitize logging**: Use Agent mode to remove sensitive data from log statements while maintaining useful diagnostic information.

- **Validate file paths**: Let Agent mode add proper path validation that prevents directory traversal attacks.

- **Add input validation**: Have Agent mode implement comprehensive input validation and sanitization.

- **Ensure security**: Instruct Agent mode to validate that fixes maintain all existing security checks and don't introduce new vulnerabilities.

- **Maintain functionality**: Use Agent mode to preserve all existing business logic and error handling while improving security.

### Agent mode prompts for remediating security issues

When using Agent mode to remediate security issues, your prompts should be specific, actionable, and include safety considerations. Here are examples of natural language text that you can include in your prompt when remediating security issues:

#### Preparation and safety

These prompts help you establish safety measures before making security changes to your codebase.

- "Before making security fixes, create unit tests that verify the current behavior of the selected functions."
- "Analyze the selected code for dependencies and ensure fixes maintain all existing functionality."
- "Create a backup branch and run existing tests before implementing security fixes to the selected code."

#### Basic remediation operations

Use these prompts to address common security vulnerabilities with straightforward fixes.

- "Refactor the selected SQL query to use parameterized queries instead of string concatenation."
- "Replace the selected MD5 password hashing with bcrypt including proper salt generation."
- "Remove sensitive information from the selected logging statements while maintaining diagnostic value."
- "Add path validation to the selected file operations to prevent directory traversal attacks."

#### Advanced remediation patterns

These prompts guide Agent mode through more complex security improvements that involve multiple components or architectural changes.

- "Refactor the selected authentication function to use secure token-based authentication with proper expiration."
- "Implement comprehensive input validation for the selected user data processing functions."
- "Replace the selected weak encryption implementation with AES-256 encryption following best practices."
- "Refactor the selected error handling to provide user-friendly messages while logging detailed errors securely."

#### Quality and validation

Use these prompts to ensure that security fixes meet quality standards and don't introduce regressions.

- "After implementing security fixes, run all tests and verify that functionality remains identical."
- "Ensure the fixed code follows Microsoft's C# security guidelines and coding conventions."
- "Validate that the security fixes don't introduce performance regressions."
- "Create security-focused unit tests to verify the vulnerabilities are fully addressed."

## Agent mode workflow for remediating security issues

Follow this systematic workflow to remediate security issues using Agent mode:

### Step 1: Prepare your workspace

Starting with a clean workspace ensures you can track changes accurately and roll back if needed.

Ensure you're working in a clean git branch with all existing work committed. Navigate to the file containing the security vulnerability analyzed in Ask mode and have your remediation plan ready to reference.

### Step 2: Set up safety measures

Create baseline tests before making changes to your code. When code updates are complete, use baseline tests to verify that functionality remains intact.

Before making changes, create tests to verify current behavior.

Example prompt: "Create comprehensive unit tests for the `SearchProducts` function to verify current behavior before implementing security fixes."

Agent mode creates tests that capture current behavior, providing a baseline for validation.

### Step 3: Start with critical security fixes

Addressing the highest-risk vulnerabilities first ensures that the most dangerous issues are resolved promptly.

Begin with the highest-priority vulnerabilities.

Example prompt: "Refactor the `SearchProducts` method to use parameterized queries instead of string concatenation. Ensure all SQL injection vectors are eliminated."

Agent mode analyzes the code, replaces vulnerable string concatenation with parameterized queries, and adds input validation to eliminate the SQL injection vulnerability.

### Step 4: Implement secure cryptography

Upgrading weak cryptography protects sensitive data like passwords from being compromised even if storage is breached.

Continue with cryptographic improvements.

Example prompt: "Replace the MD5 password hashing in `HashPassword` method with bcrypt implementation including proper salt generation."

Agent mode upgrades weak hashing algorithms to secure alternatives like bcrypt, adds password validation, and creates a verification method.

### Step 5: Sanitize logging and error handling

Removing sensitive information from logs prevents data exposure while maintaining the diagnostic capabilities needed for debugging.

Address information disclosure issues.

Example prompt: "Remove sensitive information from logging statements in the authentication module while maintaining diagnostic value."

Agent mode removes sensitive data from logs and replaces detailed error messages with user-friendly alternatives while preserving diagnostic information in secure logs.

### Step 6: Add path validation

Validating file paths prevents attackers from accessing files outside the intended directory scope.

Implement file path security.

Example prompt: "Add comprehensive path validation to the `SaveFile` method to prevent directory traversal attacks."

Agent mode implements path validation using `Path.GetFileName()`, verifies paths remain within intended directories, and adds checks for invalid characters.

### Step 7: Validate changes

Testing after each major fix ensures that the vulnerability is resolved and that no new issues were introduced.

After each major security fix, validate the changes.

Example prompt: "Run all unit tests and create security-specific tests to verify the SQL injection vulnerability is fully fixed."

Agent mode runs existing tests and creates other security tests that attempt SQL injection attacks to verify the vulnerability is resolved.

### Step 8: Review and iterate

Addressing test failures and refining implementations ensures that all requirements are met before considering the remediation complete.

If issues are found, provide specific instructions for refinements.

Example prompt: "The password length validation test is failing. Update the validation to allow passwords between 8 and 128 characters."

Agent mode analyzes failing tests and makes necessary corrections to ensure all requirements are met.

This structured approach ensures remediation is done safely and systematically, with validation at each step.

## Security and quality considerations

When using Agent mode for security remediation, always consider security and quality implications:

### Security best practices

Following these security practices ensures that your fixes are comprehensive and don't introduce new vulnerabilities.

Consider the following security practices when remediating vulnerabilities:

- **Validate thoroughly**: Ensure all input validation is comprehensive and handles edge cases.
- **Preserve authorization**: Verify that security fixes don't bypass authentication or authorization checks.
- **Maintain defense in depth**: Ensure multiple security layers remain intact.
- **Review dependencies**: Check that security fixes don't introduce vulnerable dependencies.
- **Test extensively**: Include both positive and negative security test cases.

### Code quality standards

Maintaining code quality alongside security improvements ensures that your codebase remains maintainable and professional.

Maintain high code quality by following these guidelines:

- **Follow conventions**: Ensure fixed code follows Microsoft's C# coding conventions.
- **Maintain readability**: Verify that security fixes don't compromise code clarity.
- **Document changes**: Add comments explaining security-critical code.
- **Update documentation**: Ensure README, security policies, and API docs reflect changes.
- **Consider performance**: Validate that security improvements don't degrade performance significantly.

## Agent mode safety guidelines

Agent mode is powerful but requires careful oversight.

### Before remediation

Taking these precautions before starting remediation minimizes the risk of losing work or introducing breaking changes.

- Always work in a feature branch.
- Ensure comprehensive test coverage exists.
- Review the remediation plan from Ask mode analysis.
- Understand the security vulnerability and its potential effects.
- Back up any critical data or configurations.

### During remediation

Following these practices during remediation helps you catch and address issues as they arise rather than discovering them later.

- Make incremental changes rather than large transformations.
- Validate each step before proceeding to the next.
- Review generated code for correctness and security.
- Test frequently to catch issues early.
- Monitor for unintended side effects.

### After remediation

These post-remediation steps verify that your fixes are complete, correct, and ready for deployment.

- Run comprehensive tests including security tests.
- Perform code review with team members.
- Validate security characteristics using security tools.
- Update GitHub issue with fix details.
- Document lessons learned for future reference.

## Treat Agent mode as a powerful assistant

While Agent mode can perform complex remediation tasks, it requires human oversight:

- Review all changes before accepting them.
- Validate that security vulnerabilities are fully addressed.
- Ensure no new vulnerabilities are introduced.
- Test thoroughly to catch subtle issues.
- Verify compliance with security policies.

Agent mode accelerates security remediation but doesn't replace the need for careful review and testing.

## Integration with Git workflow

Incorporate Agent mode changes into your Git workflow seamlessly using Visual Studio Code's built-in tools.

### Commit changes using Source Control view

Visual Studio Code's integrated Source Control view streamlines the process of committing and pushing security fixes to your repository.

Visual Studio Code's Source Control view provides an integrated way to review and commit your security fixes:

1. Open the Source Control view by selecting the Source Control icon in the Activity Bar or pressing **Ctrl+Shift+G**.

1. Review the changes listed under "Changes" to verify all security fixes are included.

1. Stage files by hovering over them and selecting the **+** icon, or stage all changes using the **+** icon next to "Changes".

1. Enter a descriptive commit message in the message box that references the GitHub issue:

    ``` plaintext
    Fix SQL injection vulnerability in SearchProducts
    
    - Replace string concatenation with parameterized queries
    - Add input validation for search terms
    - Implement security tests for injection attempts
    
    Fixes #42
    ```

    > [!NOTE]
    > To link your commits to GitHub issues, include the issue number in your commit message using the **Fixes #issue-number** syntax. This syntax automatically closes the issue when the commit is merged.

1. Select the **Commit** button to commit your changes.

1. Select the **Sync Changes** button to push your branch to the remote repository.

Alternatively, you can use Git commands in the integrated terminal:

``` bash
# Stage all changes
git add .

# Commit with a descriptive message referencing the GitHub issue
git commit -m "Fix SQL injection vulnerability in SearchProducts

- Replace string concatenation with parameterized queries
- Add input validation for search terms
- Implement security tests for injection attempts

Fixes #42"

# Push changes to the remote repository
git push origin your-branch-name
```

## Summary

Using GitHub Copilot's Agent mode enables developers to efficiently remediate security issues while maintaining code quality and functionality. By combining the analytical insights from Ask mode with Agent mode's execution capabilities, you can systematically address vulnerabilities in your codebase. The key to success is providing clear instructions, maintaining safety practices, thoroughly validating all changes, and ensuring proper documentation. GitHub Copilot's Agent mode is a powerful assistant that accelerates remediation. However, human oversight remains essential to ensuring security fixes are complete, correct, and don't introduce new vulnerabilities.
