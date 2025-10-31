GitHub Advanced Security (GHAS) helps you find and fix security issues that can become technical debt. It works with both GitHub and Azure DevOps, giving you powerful tools to keep your code healthy.

While GHAS focuses on security, it also helps you discover technical debt. Its scanning tools find code problems, dependency issues, and security vulnerabilities that slow down development over time.

## How GHAS helps with technical debt

GHAS provides three main tools to help you:

- **Code analysis** - Finds patterns that create technical debt
- **Dependency scanning** - Identifies outdated or risky dependencies
- **Security scanning** - Catches vulnerabilities that become debt

By using these tools early in development, you can prevent technical debt from building up. This keeps your code secure, maintainable, and easier to work with.

## CodeQL analysis: Find code problems automatically

CodeQL is a smart code analysis tool that searches for problematic patterns in your code. It helps you find:

- Coding errors that slow down development
- Design flaws that make code hard to maintain
- Security vulnerabilities like injection attacks
- Authentication and access control issues

Think of CodeQL as a detective that looks for clues about potential problems in your codebase. It uses patterns to identify areas where technical debt might be hiding.

## Dependency management: Keep your dependencies healthy

Outdated dependencies are a common source of technical debt. GHAS dependency scanning helps you:

- See all your project dependencies in one place
- Find packages with security vulnerabilities
- Identify outdated libraries that need updates
- Check for licensing issues

**Dependabot** automatically creates pull requests to update vulnerable dependencies. This saves you time and keeps your code secure without manual work.

## Code scanning: Catch issues before they become debt

Code scanning automatically checks your code for:

- Security vulnerabilities (like XSS and SQL injection)
- Code smells that indicate poor design
- Anti-patterns that make code hard to maintain
- Quality issues that slow down development

Each scan provides clear, actionable recommendations. You'll see exactly what's wrong and how to fix it, helping you prioritize the most important issues first.
