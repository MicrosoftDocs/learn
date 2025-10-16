# Unit 5: Refactor Complex Conditionals using GitHub Copilot's Agent Mode

Developers can use GitHub Copilot's Agent mode to safely refactor complex conditionals while ensuring functionality is preserved and code quality is improved.

> [!NOTE]
> Use GitHub Copilot's Ask mode to analyze complex conditionals and formulate a refactoring plan before using Agent mode to implement changes. This approach ensures that refactoring is done thoughtfully and safely.

## What is Agent mode?

GitHub Copilot's Agent mode works autonomously to execute complex refactoring tasks across your codebase. Unlike Ask mode, which provides guidance and suggestions in the chat panel, Agent mode implements suggested updates as edits directly in your code files.

Agent mode can edit files, apply changes, run tests, and execute commands based on your instructions. It understands project context and can maintain consistency across multiple files, ensuring that refactoring changes don't break existing functionality.

Agent mode is ideal for implementing multi-step refactoring strategies that require careful handling of dependencies, edge cases, and testing. Agent mode automatically defines the required context and executes the necessary steps to achieve your refactoring goals.

## Refactor complex conditionals using Agent mode

You can use Agent mode to implement the refactoring strategies identified during your Ask mode analysis. Agent mode can execute multiple refactoring steps automatically while preserving the original functionality and improving code quality.

### Strategies for refactoring complex conditionals

Here are key strategies for using Agent mode to refactor complex conditionals:

- **Apply guard clauses**: Instruct Agent mode to add early returns that handle edge cases and invalid states, reducing nesting levels.

- **Extract methods**: Have Agent mode break down complex conditionals into smaller, focused methods with descriptive names.

- **Eliminate duplication**: Use Agent mode to identify and consolidate repeated conditional logic into reusable components.

- **Simplify boolean expressions**: Let Agent mode refactor complex boolean conditions using mathematical logic principles (such as "De Morgan's laws") and logical simplification.

- **Replace conditional chains**: Have Agent mode convert complex if-else chains into more maintainable patterns like strategy or state patterns.

- **Ensure security**: Instruct Agent mode to validate that refactoring doesn't introduce security vulnerabilities or bypass existing security checks.

- **Maintain performance**: Use Agent mode to preserve or improve performance characteristics during refactoring.

### Agent mode prompts for refactoring complex conditionals

When using Agent mode to refactor complex conditionals, your prompts should be specific, actionable, and include safety considerations. Here are some examples of natural language text that you can include in your prompt when refactoring complex conditionals:

#### Preparation and safety

- "Before refactoring, create unit tests that verify the current behavior of the selected conditional logic."
- "Analyze the selected conditional for security implications and ensure refactoring maintains all security checks."
- "Create a backup branch and run existing tests before making any changes to the selected conditional."

#### Basic refactoring operations

- "Refactor the selected conditional using guard clauses to reduce nesting and improve readability."
- "Extract the complex conditional logic into separate, well-named methods."
- "Simplify the selected boolean expression while preserving the exact same logical behavior."
- "Replace the selected nested if-else chain with a more maintainable pattern."

#### Advanced refactoring patterns

- "Refactor the selected conditional using the strategy pattern to eliminate multiple if-else branches."
- "Convert the selected complex state checking logic into a state machine pattern."
- "Replace the selected conditional chain with a lookup table or dictionary-based approach."
- "Refactor the selected conditional to use polymorphism instead of type checking."

#### Quality and validation

- "After refactoring, run all tests and verify that behavior is identical to the original code."
- "Ensure the refactored conditional follows Microsoft's C# coding conventions."
- "Validate that the refactored code maintains the same performance characteristics."
- "Create additional test cases to cover edge cases exposed during refactoring."

## Agent mode workflow for refactoring complex conditionals

The following workflow demonstrates how to use Agent mode to safely refactor complex conditionals:

1. **Prepare your workspace**

    Ensure you're working in a clean git branch and any existing work is committed. Working in a clean branch allows you to easily revert changes if needed. Navigate to the file containing the complex conditional that you analyzed in Ask mode.

1. **Set up safety measures**

    Before making changes, ask Agent mode to create or run existing unit tests:

    "Create comprehensive unit tests for the `CalculateDiscount` method to verify current behavior before refactoring."

    This step ensures you have a safety net to verify that your refactoring preserves functionality.

1. **Start with simple refactoring steps**

    Begin with low-risk changes like adding guard clauses:

    "Refactor the `CalculateDiscount` method by adding guard clauses for null order and invalid coupon at the beginning of the method."

    Agent mode analyzes the code and adds appropriate early returns, reducing the complexity of the remaining logic.

1. **Extract complex logic into methods**

    Continue with method extraction:

    "Extract the coupon validation and discount calculation logic into a separate `ApplyCouponDiscount` method. Ensure all edge cases are properly handled."

    Agent mode creates the new method, moves the relevant code, and updates the original method to call the extracted logic.

1. **Consolidate and simplify**

    Address duplication and complex boolean logic:

    "Consolidate the premium member discount logic so that the logic is applied in one place, and simplify any complex boolean expressions."

    Agent mode identifies scattered logic and consolidates it while maintaining the same behavior.

1. **Validate changes**

    After each major refactoring step, validate the changes:

    "Run all unit tests and verify that the refactored code produces identical results to the original implementation."

    Agent mode can execute tests and report any failures that need to be addressed.

1. **Review and iterate**

    If issues are found, provide specific instructions for fixes:

    "The test for holiday discounts is failing. Review the refactored logic and ensure that holiday multipliers are applied correctly."

    Agent mode analyzes the failing test and make necessary corrections.

This structured approach ensures that refactoring is done safely and systematically, with validation at each step.

## Security and quality considerations

When using Agent mode for refactoring, always consider security and quality implications:

### Security best practices

Consider the following security practices when refactoring conditionals:

- **Validate input handling**: Ensure that refactored conditionals don't bypass input validation or introduce injection vulnerabilities.

- **Preserve authorization checks**: Verify that security-related conditionals aren't accidentally removed or weakened during refactoring.

- **Maintain audit trails**: Ensure that logging and monitoring logic within conditionals is preserved.

### Code quality standards

Businesses generally adopt a specific set of coding standards. If you don't have guidelines, Microsoft publishes recommendations for C# coding conventions that you can follow.

Maintain high code quality by following these guidelines:

- **Follow established patterns**: Ensure refactored code follows your team's coding standards and architectural patterns.

- **Maintain readability**: Verify that the refactored code is more readable and maintainable than the original.

- **Preserve performance**: Ensure that refactoring doesn't introduce performance regressions.

## Agent mode safety guidelines

Agent mode is powerful but requires careful oversight:

### Before refactoring

- Always work in a feature branch.
- Ensure comprehensive test coverage exists.
- Review the refactoring plan from Ask mode analysis.
- Understand the business logic and edge cases.

### During refactoring

- Make incremental changes rather than large transformations.
- Validate each step before proceeding to the next.
- Review generated code for correctness and style.
- Test frequently to catch issues early.

### After refactoring

- Run comprehensive tests including edge cases.
- Perform code review with team members.
- Validate performance and security characteristics.
- Update documentation if necessary.

## Treat Agent mode as a powerful assistant

While Agent mode can perform complex refactoring tasks, it requires human oversight:

- Review all changes before accepting them.
- Validate that business logic is preserved.
- Ensure security and performance requirements are met.
- Test thoroughly to catch subtle behavioral changes.

Agent mode accelerates refactoring but doesn't replace the need for careful review and testing.

## Summary

Using GitHub Copilot's Agent mode enables developers to efficiently refactor complex conditionals while maintaining code quality and functionality. By combining the analytical insights from Ask mode with Agent mode's execution capabilities, you can systematically improve code maintainability, readability, and performance. The key to success is providing clear instructions, maintaining safety practices, and thoroughly validating all changes.
