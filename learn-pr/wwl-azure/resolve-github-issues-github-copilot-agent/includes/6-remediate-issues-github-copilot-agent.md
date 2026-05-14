After analyzing security issues using the Ask agent, you're ready to implement fixes. GitHub Copilot's Agent enables you to execute complex remediation tasks safely while ensuring functionality is preserved and code quality is improved.

> [!NOTE]
> Consider using the Ask agent to analyze security issues and formulate a remediation plan before using the Agent to implement changes. This approach ensures that refactoring is done thoughtfully and safely.

## What is Agent mode?

GitHub Copilot's Agent mode is one of three built-in agents in GitHub Copilot Chat. Unlike the Ask agent, which provides guidance and suggestions in the chat panel, Agent mode implements changes as edits directly in your code files.

Agent mode capabilities include:

- Editing files with precise code modifications.
- Applying changes across multiple files simultaneously.
- Running tests to verify changes.
- Executing commands based on your instructions.
- Understanding project context and dependencies.
- Maintaining consistency across the codebase.

Agent mode is ideal for implementing multi-step security fixes that require careful handling of dependencies, edge cases, and testing. It automatically determines the required context and executes the necessary steps to achieve your remediation goals.

### Agent types for security remediation

GitHub Copilot offers multiple agent types that run in different environments. For security remediation workflows, the two most relevant types are:

- **Local agent (Agent in VS Code)**: runs interactively in the editor with full access to your workspace, tools, and models. This is the agent type described throughout this unit — ideal for hands-on, step-by-step security remediation where you review each change.
- **Copilot cloud agent**: runs remotely and integrates with GitHub pull requests. You can assign a GitHub issue directly to the cloud agent, which then researches the codebase, creates an implementation plan, and makes code changes on a branch for your review. Available with Copilot Pro+, Business, and Enterprise plans.

For most security remediation, the local Agent is recommended because it gives you real-time visibility into each change. The cloud agent is useful for well-defined, lower-risk issues where autonomous implementation is acceptable.

### Permission levels

Before starting a remediation session, choose a permission level that matches the complexity and risk of the work:

| Permission level | Description | Recommended for |
|---|---|---|
| **Default Approvals** | Only read-only and safe tools run without confirmation. All file edits and terminal commands require your approval. | Security-sensitive remediation — maximum oversight |
| **Bypass Approvals** | Auto-approves all tool calls without confirmation dialogs. | Routine fixes where you trust the plan |
| **Autopilot** (Preview) | Fully autonomous — auto-approves tools and auto-responds until the task is complete. | Not recommended for security changes |

Select the permission level from the permissions picker in the Chat view. For security remediation, **Default Approvals** is recommended so you can review each file edit before it's applied.

## Remediate security issues using the Agent

You can use the Agent to implement the security fixes identified during your Ask agent analysis. The Agent can execute multiple remediation steps automatically while preserving the original functionality and improving code security.

### Strategies for remediating security issues

Here are key strategies for using Agent mode to remediate security issues:

- **Fix injection vulnerabilities**: Instruct Agent mode to replace string concatenation with parameterized queries or prepared statements.

- **Implement secure encryption**: Have the Agent upgrade weak hashing algorithms using secure alternatives like bcrypt or Argon2.

- **Sanitize logging**: Use the Agent to remove sensitive data from log statements while maintaining useful diagnostic information.

- **Validate file paths**: Let the Agent add proper path validation that prevents directory traversal attacks.

- **Add input validation**: Have the Agent implement comprehensive input validation and sanitization.

- **Ensure security**: Instruct the Agent to validate that fixes maintain all existing security checks and don't introduce new vulnerabilities.

- **Maintain functionality**: Use the Agent to preserve all existing business logic and error handling while improving security.

### Agent prompts for remediating security issues

When using the Agent to remediate security issues, your prompts should be specific, actionable, and include safety considerations. Here are examples of natural language text that you can include in your prompt when remediating security issues:

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

Ensure you're working in a clean git branch with all existing work committed. Navigate to the file containing the security vulnerability identified during your Ask agent analysis and have your remediation plan ready to reference.

### Step 2: Set up safety measures

Create baseline tests before making changes to your code. When code updates are complete, use baseline tests to verify that functionality remains intact.

Before making changes, create tests to verify current behavior.

Example prompt: "Create comprehensive unit tests for the `SearchProducts` function to verify current behavior before implementing security fixes."

The Agent creates tests that capture current behavior, providing a baseline for validation.

> [!TIP]
> VS Code automatically creates checkpoints at key points during agent sessions. If a security fix introduces unexpected issues, use checkpoints to roll back to a known good state without losing other work. This complements your feature branch strategy with a fine-grained undo option.

### Step 3: Start with critical security fixes

Addressing the highest-risk vulnerabilities first ensures that the most dangerous issues are resolved promptly.

Begin with the highest-priority vulnerabilities.

Example prompt: "Refactor the `SearchProducts` method to use parameterized queries instead of string concatenation. Ensure all SQL injection vectors are eliminated."

The Agent analyzes the code, replaces vulnerable string concatenation with parameterized queries, and adds input validation to eliminate the SQL injection vulnerability.

### Step 4: Implement secure cryptography

Upgrading weak cryptography protects sensitive data like passwords from being compromised even if storage is breached.

Continue with cryptographic improvements.

Example prompt: "Replace the MD5 password hashing in `HashPassword` method with bcrypt implementation including proper salt generation."

The Agent upgrades weak hashing algorithms to secure alternatives like bcrypt, adds password validation, and creates a verification method.

### Step 5: Sanitize logging and error handling

Removing sensitive information from logs prevents data exposure while maintaining the diagnostic capabilities needed for debugging.

Address information disclosure issues.

Example prompt: "Remove sensitive information from logging statements in the authentication module while maintaining diagnostic value."

The Agent removes sensitive data from logs and replaces detailed error messages with user-friendly alternatives while preserving diagnostic information in secure logs.

### Step 6: Add path validation

Validating file paths prevents attackers from accessing files outside the intended directory scope.

Implement file path security.

Example prompt: "Add comprehensive path validation to the `SaveFile` method to prevent directory traversal attacks."

The Agent implements path validation using `Path.GetFileName()`, verifies paths remain within intended directories, and adds checks for invalid characters.

### Step 7: Validate changes

Testing after each major fix ensures that the vulnerability is resolved and that no new issues were introduced.

After each major security fix, validate the changes.

Example prompt: "Run all unit tests and create security-specific tests to verify the SQL injection vulnerability is fully fixed."

The Agent runs existing tests and creates other security tests that attempt SQL injection attacks to verify the vulnerability is resolved.

### Step 8: Review and iterate

Addressing test failures and refining implementations ensures that all requirements are met before considering the remediation complete.

If issues are found, provide specific instructions for refinements.

Example prompt: "The password length validation test is failing. Update the validation to allow passwords between 8 and 128 characters."

The Agent analyzes failing tests and makes necessary corrections to ensure all requirements are met.

This structured approach ensures remediation is done safely and systematically, with validation at each step.

## Security and quality considerations

When using the Agent for security remediation, always consider security and quality implications:

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

The Agent is powerful but requires careful oversight.

### Before remediation

Taking these precautions before starting remediation minimizes the risk of losing work or introducing breaking changes.

- Always work in a feature branch.
- Ensure comprehensive test coverage exists.
- Review the remediation plan from the Ask agent analysis.
- Set the permission level to **Default Approvals** so you review each tool call.
- Understand the security vulnerability and its potential effects.
- Back up any critical data or configurations.

### During remediation

Following these practices during remediation helps you catch and address issues as they arise rather than discovering them later.

- Make incremental changes rather than large transformations.
- Validate each step before proceeding to the next.
- Review generated code for correctness and security.
- Test frequently to catch issues early.
- Monitor for unintended side effects.
- Use Visual Studio Code checkpoints to roll back to a known good state if needed.

### After remediation

These post-remediation steps verify that your fixes are complete, correct, and ready for deployment.

- Run comprehensive tests including security tests.
- Perform code review with team members.
- Validate security characteristics using security tools.
- Update GitHub issue with fix details.
- Document lessons learned for future reference.

## Treat Agent mode as a powerful assistant

While the Agent can perform complex remediation tasks, it requires human oversight:

- Review all changes before accepting them.
- Validate that security vulnerabilities are fully addressed.
- Ensure no new vulnerabilities are introduced.
- Test thoroughly to catch subtle issues.
- Verify compliance with security policies.

The Agent accelerates security remediation but doesn't replace the need for careful review and testing.

## Integration with Git workflow

Incorporate Agent changes into your Git workflow seamlessly using Visual Studio Code's built-in tools.

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

Using GitHub Copilot's Agent mode enables developers to efficiently remediate security issues while maintaining code quality and functionality. By combining the analytical insights from the Ask agent with the Agent's execution capabilities, you can systematically address vulnerabilities in your codebase. Choose the right agent type for your situation — use the local Agent for interactive, step-by-step remediation, or the cloud agent to assign well-defined issues for autonomous resolution. The key to success is providing clear instructions, setting appropriate permission levels, maintaining safety practices, thoroughly validating all changes, and ensuring proper documentation. The Agent is a powerful assistant that accelerates remediation, but human oversight remains essential to ensuring security fixes are complete, correct, and don't introduce new vulnerabilities.
