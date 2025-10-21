Developers can use GitHub Copilot's Agent mode to safely refactor low-performance code while ensuring functionality is preserved and code quality is improved.

> [!NOTE]
> Use GitHub Copilot's Ask mode to analyze performance bottlenecks and formulate an optimization plan before using Agent mode to implement changes. This approach ensures that refactoring is done thoughtfully and safely.

## What is Agent mode?

GitHub Copilot's Agent mode works autonomously to execute complex refactoring tasks across your codebase. Unlike Ask mode, which provides guidance and suggestions in the chat panel, Agent mode implements suggested updates as edits directly in your code files.

Agent mode can edit files, apply changes, run tests, and execute commands based on your instructions. It understands project context and can maintain consistency across multiple files, ensuring that refactoring changes don't break existing functionality.

Agent mode is ideal for implementing multi-step optimization strategies that require careful handling of dependencies, edge cases, and testing. Agent mode automatically defines the required context and executes the necessary steps to achieve your performance improvement goals.

## Refactor low-performance code using Agent mode

You can use Agent mode to implement the optimization strategies identified during your Ask mode analysis. Agent mode can execute multiple refactoring steps automatically while preserving the original functionality and improving code performance.

### Strategies for refactoring low-performance code

Here are key strategies for using Agent mode to refactor low-performance code:

- **Optimize data structures**: Instruct Agent mode to replace inefficient data structures like linear searches with optimized alternatives like dictionaries or hash sets.

- **Implement caching mechanisms**: Have Agent mode add intelligent caching to avoid redundant computations or expensive operations.

- **Eliminate N+1 query patterns**: Use Agent mode to consolidate multiple queries or operations into batch operations for better performance.

- **Add asynchronous processing**: Let Agent mode convert blocking operations to asynchronous patterns that improve scalability and responsiveness.

- **Reduce algorithmic complexity**: Have Agent mode refactor algorithms to use more efficient approaches with better time complexity.

- **Ensure security**: Instruct Agent mode to validate that performance optimizations don't introduce security vulnerabilities or bypass existing security checks.

- **Maintain functionality**: Use Agent mode to preserve all existing business logic and error handling while improving performance characteristics.

### Agent mode prompts for refactoring low-performance code

When using Agent mode to refactor low-performance code, your prompts should be specific, actionable, and include safety considerations. Here are some examples of natural language text that you can include in your prompt when refactoring low-performance code:

#### Preparation and safety

- "Before refactoring, create unit tests that verify the current behavior of the selected performance-critical methods."
- "Analyze the selected code for security implications and ensure refactoring maintains all security checks."
- "Create a backup branch and run existing tests before making any performance optimizations to the selected code."

#### Basic optimization operations

- "Refactor the selected method to use a dictionary lookup instead of linear search to improve performance."
- "Optimize the selected code by implementing caching mechanisms for expensive operations."
- "Replace the selected N+1 query pattern with batch operations to reduce database calls."
- "Convert the selected blocking operations to asynchronous patterns for better scalability."

#### Advanced optimization patterns

- "Refactor the selected code using parallel processing to improve throughput while maintaining thread safety."
- "Optimize the selected algorithm to reduce time complexity from O(n²) to O(n log n) or better."
- "Replace the selected inefficient data structure with optimized collections for faster lookups."
- "Refactor the selected code to use lazy loading patterns to improve initialization performance."

#### Quality and validation

- "After refactoring, run all tests and verify that performance has improved while maintaining identical functionality."
- "Ensure the refactored code follows Microsoft's C# coding conventions and performance best practices."
- "Validate that the refactored code maintains the same security characteristics as the original implementation."
- "Create performance benchmarks to measure the improvement achieved through refactoring."

## Agent mode workflow for refactoring low-performance code

The following workflow demonstrates how to use Agent mode to safely refactor low-performance code:

1. **Prepare your workspace**

    Ensure you're working in a clean git branch and any existing work is committed. Working in a clean branch allows you to easily revert changes if needed. Navigate to the file containing the performance bottlenecks that you analyzed in Ask mode.

1. **Set up safety measures**

    Before making changes, ask Agent mode to create or run existing unit tests:

    "Create comprehensive unit tests for the `ProcessOrders` method to verify current behavior before refactoring for performance."

    This step ensures you have a safety net to verify that your refactoring preserves functionality.

1. **Start with simple optimization steps**

    Begin with low-risk changes like replacing linear searches:

    "Refactor the `GetProductById` method by replacing the linear search with a dictionary lookup for O(1) performance instead of O(n)."

    Agent mode analyzes the code and implements the dictionary-based approach, significantly improving lookup performance.

1. **Implement caching strategies**

    Continue with caching optimizations:

    "Add intelligent caching to the `GetExchangeRate` method to avoid redundant API calls for the same currency within a short time period."

    Agent mode creates appropriate caching logic, reducing expensive external service calls.

1. **Optimize algorithmic complexity**

    Address more complex performance issues:

    "Refactor the nested loop in `CalculateDiscounts` to use a more efficient algorithm that processes bulk operations in a single pass."

    Agent mode identifies the inefficient nested loops and replaces them with optimized algorithms.

1. **Validate changes**

    After each major refactoring step, validate the changes:

    "Run all unit tests and performance benchmarks to verify that the refactored code produces identical results with improved performance."

    Agent mode can execute tests and report any failures that need to be addressed.

1. **Review and iterate**

    If issues are found, provide specific instructions for fixes:

    "The performance test shows only marginal improvement. Review the refactored caching logic and ensure that cache hits are being utilized effectively."

    Agent mode analyzes the performance metrics and makes necessary corrections to achieve the expected improvements.

This structured approach ensures that performance optimization is done safely and systematically, with validation at each step.

## Common scenarios for refactoring low-performance code

Reviewing common scenarios can help you understand how to effectively use Agent mode for performance refactoring.

### Optimize data access patterns (eliminate N+1 queries)

Data access patterns that result in N+1 queries can severely degrade performance. Refactoring to batch data retrieval can significantly improve efficiency.

This scenario can be illustrated using the following code snippet:

```csharp
foreach (var order in orders)
{
    decimal price = GetProductPrice(order.ProductId); // database call
    order.TotalPrice = order.Quantity * price;
}
```

Profiling analysis shows that `GetProductPrice` (which queries a database) is a bottleneck when processing large orders.

You can use Agent mode to refactor the code by batching product price lookups. For example:

Agent mode prompt: "Optimize this code to eliminate N+1 query pattern by batching product price lookups."

The agent refactors the code as follows:

1. Collect all unique product IDs.
1. Fetch the prices in a single database call.
1. Map prices back to orders.

The refactored code should look similar to the following code snippet:

```csharp
var productIds = orders.Select(o => o.ProductId).Distinct().ToList();
var priceCache = GetProductPrices(productIds).ToDictionary(p => p.ProductId, p => p.Price);

foreach (var order in orders)
{
    if (priceCache.TryGetValue(order.ProductId, out decimal price))
    {
        order.TotalPrice = order.Quantity * price;
    }
}
```

Notice the following improvements:

- The updated code batches all required price lookups into a single database call.
- Error handling for missing products is properly maintained.
- The code maintains the same business logic while dramatically improving performance.

### Replace inefficient algorithms

Replacing linear search with optimized data structures for better performance.

This scenario can be illustrated using the following code snippet:

```csharp
public Product FindProductByName(string name)
{
    foreach (var product in products) // O(n) linear search
    {
        if (product.Name.Equals(name, StringComparison.OrdinalIgnoreCase))
        {
            return product;
        }
    }
    return null;
}
```

You can use Agent mode to refactor the code by using a dictionary for O(1) lookups. For example:

Agent mode prompt: "Optimize product lookups by using a dictionary-based approach for O(1) performance."

The agent refactors the code as follows:

1. Initialize a dictionary mapping product names to product objects.
1. Use the dictionary for lookups.

The refactored code should look similar to the following code snippet:

```csharp
private readonly Dictionary<string, Product> _productsByName = 
    products.ToDictionary(p => p.Name, StringComparer.OrdinalIgnoreCase);

public Product FindProductByName(string name)
{
    _productsByName.TryGetValue(name, out Product product);
    return product;
}
```

Notice the following improvements:

- The lookup time complexity improves from O(n) to O(1).
- String comparison logic is preserved using the appropriate comparer.
- The initialization cost is amortized over multiple lookup operations.

### Implement asynchronous processing

Converting blocking operations to async patterns for better scalability. Refactoring synchronous code to use asynchronous programming can improve responsiveness and scalability.

This scenario can be illustrated using the following code snippet:

```csharp
public void ProcessOrderNotification(Order order)
{
    var emailContent = GenerateEmailContent(order);
    Thread.Sleep(1000); // simulate email service delay
    SendEmail(order.CustomerEmail, emailContent);
}
```

You can use Agent mode to refactor the code by converting it to an asynchronous pattern. For example:

Agent mode prompt: "Convert this synchronous email processing to asynchronous to improve scalability and responsiveness."

The agent refactors the code as follows:

1. Make the method async.
1. Use `await` for asynchronous operations.

The refactored code should look similar to the following code snippet:

```csharp
public async Task ProcessOrderNotificationAsync(Order order)
{
    var emailContent = await GenerateEmailContentAsync(order);
    await Task.Delay(1000); // simulate async email service delay
    await SendEmailAsync(order.CustomerEmail, emailContent);
}
```

Notice the following improvements:

- All callers are updated to await the async method.
- The async pattern is consistently applied throughout the call chain.
- Error handling and cancellation tokens are properly implemented where needed.

## Security and quality considerations

When using Agent mode for performance refactoring, always consider security and quality implications:

### Security best practices

Consider the following security practices when refactoring for performance:

- **Validate input handling**: Ensure that performance optimizations don't bypass input validation or introduce injection vulnerabilities.

- **Preserve authorization checks**: Verify that security-related validations aren't accidentally removed or weakened during optimization.

- **Secure caching practices**: Ensure that cached data doesn't expose sensitive information or create unauthorized access paths.

- **Maintain audit trails**: Ensure that logging and monitoring logic is preserved during performance improvements.

### Code quality standards

Businesses generally adopt a specific set of coding standards. If you don't have guidelines, Microsoft publishes recommendations for C# coding conventions that you can follow.

Maintain high code quality by following these guidelines:

- **Follow established patterns**: Ensure refactored code follows your team's coding standards and architectural patterns.

- **Maintain readability**: Verify that the optimized code remains readable and maintainable, even with performance improvements.

- **Preserve error handling**: Ensure that all error handling logic is maintained during performance optimizations.

- **Document complex optimizations**: Add comments explaining nonobvious performance optimizations for future maintainers.

## Agent mode safety guidelines

Agent mode is powerful but requires careful oversight:

### Before refactoring

- Always work in a feature branch.
- Ensure comprehensive test coverage exists.
- Review the optimization plan from Ask mode analysis.
- Understand the performance characteristics and business logic.

### During refactoring

- Make incremental changes rather than large transformations.
- Validate each optimization step before proceeding to the next.
- Review generated code for correctness and performance improvements.
- Test frequently to catch regressions early.

### After refactoring

- Run comprehensive performance benchmarks including baseline comparisons.
- Perform code review with team members.
- Validate security and functionality characteristics.
- Update documentation to reflect performance improvements.

## Treat Agent mode as a powerful assistant

While Agent mode can perform complex performance optimizations, it requires human oversight:

- Review all changes before accepting them.
- Validate that performance improvements are measurable and significant.
- Ensure security and functionality requirements are met.
- Test thoroughly to catch subtle behavioral changes.

Agent mode accelerates performance optimization but doesn't replace the need for careful review, testing, and measurement.

## Summary

Using GitHub Copilot's Agent mode enables developers to efficiently refactor low-performance code while maintaining code quality and functionality. By combining the analytical insights from Ask mode with Agent mode's execution capabilities, you can systematically improve application performance, scalability, and efficiency. The key to success is providing clear instructions, maintaining safety practices, and thoroughly validating all changes through comprehensive testing and performance measurement.
