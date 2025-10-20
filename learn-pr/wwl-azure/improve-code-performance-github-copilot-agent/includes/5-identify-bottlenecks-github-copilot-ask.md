Identifying performance bottlenecks that can and should be optimized isn't always easy. Planning how to refactor your code for better performance can be even more difficult.

Developers can use GitHub Copilot's Ask mode to identify performance bottlenecks and plan optimization strategies to improve code performance.

## What is Ask mode?

GitHub Copilot's Ask mode is a conversational chat interface. You ask questions and GitHub Copilot answers using the context that you provide. It's like having a knowledgeable colleague who can read your code and give performance advice. For example, you can use Ask mode to explain what a function does, identify potential performance bottlenecks, or suggest optimization strategies.

Ask mode responds with explanations, insights, or code examples that you can use to improve your code's performance. In Ask mode, GitHub Copilot doesn't make any changes to your code files.

## Analyze performance bottlenecks using Ask mode

You can use Ask mode to identify and analyze performance bottlenecks in your code. GitHub Copilot can help you understand the performance characteristics, identify potential issues, and evaluate opportunities for optimization.

### Strategies for analyzing performance bottlenecks

Here are some strategies for using Ask mode to analyze performance bottlenecks:

- **Explain the code**: Ask GitHub Copilot to explain what the performance-critical code does. This question helps ensure you understand the current logic before making optimizations.

- **Identify inefficiencies**: Ask GitHub Copilot to identify which parts of the code are causing performance issues. This question can help you pinpoint areas to focus on.

- **Find algorithmic problems**: Ask GitHub Copilot to identify any algorithmic inefficiencies or complexity issues in the code. This question can help you understand the time and space complexity.

- **Suggest optimizations**: Ask GitHub Copilot for suggestions on how to optimize or refactor the performance-critical code. GitHub Copilot might suggest using better data structures, caching, or other techniques to improve performance.

- **Ask for examples**: If you're unsure how to implement a suggestion, ask GitHub Copilot for code examples. This question can help you understand how to apply the advice in your specific context.

- **Explore risks**: Ask GitHub Copilot about potential risks or side effects of optimizing the code. This question can help you avoid introducing new bugs or security vulnerabilities.

- **Iterate**: Use follow-up questions to drill down on specific suggestions or areas of concern. An iterative approach can help you refine your understanding and plan your optimization approach more effectively.

### Ask mode prompts for performance analysis

The prompts that you use to analyze performance bottlenecks should reflect your specific code and goals. However, here are some suggested best practices to consider:

- Focus on specific analysis techniques rather than generic requests for help.
- Reference established practices like algorithmic complexity, caching strategies, and performance patterns.
- Include performance metrics like time complexity, memory usage, and throughput considerations.
- Emphasize testing and measurement, which are crucial for validating performance improvements.
- Promote best practices for secure, maintainable, and performant code.
- Encourage systematic thinking about performance requirements and technical implementation.
- When applicable, address scalability considerations that are important for production code.

#### Establish the required chat context

When using Ask mode, it's important to provide sufficient context for GitHub Copilot to understand the code you're analyzing. Here are some tips:

- Use the **Add Context** button in the chat interface to include relevant files or folders from your codebase.
- Include relevant code snippets or examples that illustrate your performance concerns.
- Describe the specific goals you have for the analysis (for example, reducing latency, improving throughput).
- Mention any constraints or requirements that are important for the analysis (for example, memory limitations, scalability requirements).

Here are some examples of natural language text that you can include in your prompt when analyzing performance bottlenecks:

#### Understanding and analysis

- "Analyze the selected code and explain what performance bottlenecks might exist."
- "What is the time complexity of the selected algorithm and why?"
- "Review the selected code and identify the main performance concerns and their impact."
- "What are the memory usage patterns in the selected code and how could they be optimized?"

#### Performance assessment

- "Evaluate the selected code for potential scalability issues."
- "Are there any performance anti-patterns or inefficiencies in the selected code?"
- "Review the selected code and identify areas where caching could improve performance."
- "Does the selected code follow performance best practices? If not, how could it be improved?"

#### Optimization opportunities

- "Suggest specific optimization techniques to improve the performance of the selected code (caching, better algorithms, data structures, etc.)."
- "How could I reduce the time complexity of the selected algorithm?"
- "What design patterns could help improve the performance of the selected code?"
- "Show me how to apply asynchronous processing to the selected performance-critical operations."

#### Testing and measurement

- "What performance metrics should I measure to validate improvements to the selected code?"
- "What are the risks of optimizing the selected code, and how can I mitigate them?"
- "How can I verify that optimized code maintains the same functionality as the original?"
- "Review your suggested approaches for optimizing the selected code. What are the trade-offs associated with each approach?"

#### Best practices application

- "Does the selected code follow Microsoft's C# performance guidelines? What improvements are needed?"
- "How can I make the selected code more performant while maintaining readability?"
- "What are the security implications of the suggested performance optimizations?"
- "How can I ensure that performance improvements don't introduce threading or concurrency issues?"

## Performance analysis workflow

The following workflow demonstrates how to use Ask mode on performance-critical code:

1. **Open the problematic code**

    Navigate to the file and function that contains the performance bottleneck you intend to optimize. For example, suppose you have a method `ProcessOrders()` that profiling shows is taking excessive time.

1. **Select the relevant code**

    By selecting the specific block of code (the performance-critical method or loop, for instance), you give Copilot a clear focus. Copilot uses this selection as context for answering.

1. **Ask for an explanation of the code**

    Start simple. For instance:

    "Copilot, can you explain what this `ProcessOrders` method is doing and identify any performance concerns?"

    In Ask mode, Copilot reads through the code and produces an explanation in plain English. This step is useful to ensure you (and GitHub Copilot) fully understand the current logic before optimizing it. The explanation might come back like:

    "This method processes a list of orders by iterating through each order and making individual database calls to retrieve product information. This process creates an N+1 query problem where you make one query to get orders, then N more queries for each product. This pattern can be very slow when processing large numbers of orders..."

    Use the explanation to confirm the code's intent and identify performance bottlenecks.

1. **Ask pointed questions about performance**

    Now you can get analytical. For instance:

    - "What is the time complexity of this algorithm and how does it scale?"
    - "Which parts of this code are likely causing performance bottlenecks?"
    - "Are there any redundant operations or inefficient patterns here?"

    Use GitHub Copilot's responses to identify opportunities for optimization. For example:

    "The nested loop creates O(n²) complexity, and the database call inside the loop creates an N+1 query problem. The string concatenation in the loop also creates unnecessary memory allocations."

    Use the feedback to continue your analysis.

1. **Ask for optimization suggestions**

    Now the key question:

    "How can I optimize this code to improve performance while maintaining the same functionality?"

    Copilot, in Ask mode, might respond with a list of suggestions. For example:

    - Replace the nested loop with a dictionary lookup that reduces complexity from O(n²) to O(n).
    - Batch the database queries to eliminate the N+1 problem.
    - Use StringBuilder instead of string concatenation to reduce memory allocations.
    - Consider caching frequently accessed data to avoid repeated computations.

    It might even sketch out brief pseudo-code or show how a piece of the code would look after applying these optimizations.

1. **Iterate with follow-up questions**

    You can drill down on any suggestion:

    - "Show me how to implement the dictionary lookup optimization."
    - "What caching strategy would be most effective for this code?"
    - "What are the memory implications of the suggested optimizations?"

    Through this dialogue, GitHub Copilot helps you to form an optimization plan. By the end of the Ask mode exploration, you might have a list of specific changes to implement, such as:

    - Batch database queries to reduce round trips.
    - Replace linear search with hash-based lookups.
    - Implement intelligent caching for frequently accessed data.
    - Use more efficient data structures and algorithms.

This structured approach helps ensure that any optimization maintains the original functionality while significantly improving performance.

> [!NOTE]
> GitHub Copilot's Ask mode doesn't modify your code, so you're free to explore different approaches to optimization and evaluate suggestions without any risk.

## Manage GitHub Copilot suggestions

Treat GitHub Copilot's responses as guidance, not absolute truth. For instance, GitHub Copilot might suggest an optimization that alters behavior if it misinterprets code requirements. Always validate any critical performance optimization suggestions against your specific requirements and constraints.

### Review and interpret GitHub Copilot's analysis

Keep in mind that GitHub Copilot's analysis is based on known patterns and static code examination. GitHub Copilot doesn't have runtime data (that's your job via profiling). So it might warn you about code that isn't actually a bottleneck, or it might not realize an issue is expensive if it's not obvious from the code. For example, an innocuous looking method call that actually does heavy work.

Use GitHub Copilot Ask to complement your own analysis and use your own judgment:

- If GitHub Copilot flags the database-in-loop issue, and your profiling confirmed `GetPriceFromDatabase` as hot, that's clearly a solid lead.

- If GitHub Copilot says "this sorting algorithm is O(n log n)" as a potential issue, but your profile shows sorting is a minor cost compared to database calls, you know to prioritize the database calls first.

- If GitHub Copilot misses a suspected issue, try asking about the code in a different way. You should also ensure that required code is added to the chat context. For example, you might need to add helper functions or related classes to the chat.

> [!NOTE]
> GitHub Copilot doesn't have context beyond what you provide. Ensure that relevant code is open in the editor or added to the chat context. If performance issues are spread across the codebase, you can specify `@workspace` or `@codebase` at the start of your prompt to specify a maximum context.

## Key benefits of using Ask mode to identify bottlenecks

Using GitHub Copilot's Ask mode is like having a seasoned code reviewer ready to comment on performance aspects:

- It's fast – you get answers in seconds, which can validate your own thoughts or bring up something you missed.
- It's knowledgeable – it draws from a huge corpus of code and discussions, essentially distilling common wisdom.
- It's context-aware – it looks at *your* code when giving advice, making it more relevant than generic documentation.

## Summary

Using GitHub Copilot's Ask mode is a powerful way to analyze and plan the optimization of performance-critical code. By engaging in a conversational manner, you can gain insights into the existing performance characteristics, identify bottlenecks and inefficiencies, and receive tailored suggestions for optimization. This approach helps ensure that any performance improvements maintain the original functionality while significantly enhancing code performance and scalability.
