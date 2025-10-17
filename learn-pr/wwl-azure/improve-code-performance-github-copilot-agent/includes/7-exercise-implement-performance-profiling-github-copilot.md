> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment configured for C# development. For help with configuring your lab environment, see [Configure lab environment for GitHub Copilot Labs](https://go.microsoft.com/fwlink/?linkid=2320147&azure-portal=true). For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you use GitHub Copilot to identify and address performance bottlenecks and code inefficiencies in an e-commerce order processing application. You analyze the existing codebase, identify areas for improvement, refactor the code using GitHub Copilot, and test the refactored code to ensure performance enhancements while maintaining functionality.

Tasks include:

- Reviewing the existing codebase and establishing baseline performance metrics.
- Identifying performance bottlenecks using GitHub Copilot Chat (Ask mode).
- Refactoring performance-critical code using GitHub Copilot Chat (Agent mode).
- Testing and verifying the refactored code.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.


**TODO**: Update the link in the button below to point to the public GitHub page for this exercise.

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2338340&azure-portal=true)








---
lab:
    title: 'Exercise - Implement performance profiling using GitHub Copilot'
    description: 'Learn how to identify and address performance bottlenecks and code inefficiencies using GitHub Copilot tools.'
---

# Implement performance profiling using GitHub Copilot

Performance profiling is an important aspect of software development that helps identify and address performance bottlenecks and code inefficiencies.

In this exercise, you review an existing project that contains poor performing and inefficient code, analyze your options for improving code performance, refactor the code to address the identified issues, and test the refactored code to ensure code performance has improved while retaining functionality and readability. You use GitHub Copilot in Ask mode to gain an understanding of an existing code project and to explore options for refactoring the identified issues. You use GitHub Copilot in Agent mode to refactor the code and improve performance. You test the original and refactored code to measure the impact of your changes.

This exercise should take approximately **30** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment must include the following: Git 2.48 or later, .NET SDK 9.0 or later, Visual Studio Code with the C# Dev Kit extension, and access to a GitHub account with GitHub Copilot enabled.

### Configure your lab environment

If you're using a local PC as a lab environment for this exercise:

- For help configuring your local PC as your lab environment, open the following link in a browser: <a href="https://go.microsoft.com/fwlink/?linkid=2320147" target="_blank">Configure your lab environment resources</a>.

- For help enabling your GitHub Copilot subscription in Visual Studio Code, open the following link in a browser: <a href="https://go.microsoft.com/fwlink/?linkid=2320158" target="_blank">Enable GitHub Copilot within Visual Studio Code</a>.

If you're using a hosted lab environment for this exercise:

- For help enabling your GitHub Copilot subscription in Visual Studio Code, paste the following URL into a browser's site navigation bar: <a href="https://go.microsoft.com/fwlink/?linkid=2320158" target="_blank">Enable GitHub Copilot within Visual Studio Code</a>.

- To ensure that the .NET SDK is configured to use the official NuGet.org repository as a source for downloading and restoring packages:

    Open a command terminal and then run the following command:

    ```bash

    dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

    ```

### Download sample code project

Use the following steps to download the sample project and open it in Visual Studio Code:

1. Open a browser window in your lab environment.

1. To download a zip file containing the sample app projects, open the following URL in your browser: [GitHub Copilot lab - implement performance profiling](https://github.com/MicrosoftLearning/mslearn-github-copilot-dev/raw/refs/heads/main/DownloadableCodeProjects/Downloads/GHCopilotEx10LabApps.zip)

    The zip file is named **GHCopilotEx10LabApps.zip**.

1. Extract the files from the **GHCopilotEx10LabApps.zip** file.

    For example:

    1. Navigate to the downloads folder in your lab environment.

    1. Right-click **GHCopilotEx10LabApps.zip**, and then select **Extract all**.

    1. Select **Show extracted files when complete**, and then select **Extract**.

1. Copy the **GHCopilotEx10LabApps** folder to a location that's easy to access, such as your Windows Desktop folder.

1. Open the **GHCopilotEx10LabApps** folder in Visual Studio Code.

    For example:

    1. Open Visual Studio Code in your lab environment.

    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.

    1. Navigate to the Windows Desktop folder, select **GHCopilotEx10LabApps** and then select **Select Folder**.

1. In the Visual Studio Code SOLUTION EXPLORER view, verify the following project structure:

    - GHCopilotEx10LabApps\
        - ContosoOnlineStore\
            - Benchmarks\
            - Configuration\
            - Exceptions\
            - Services\
            - appsettings.json
            - InventoryManager.cs
            - Orders.cs
            - OrderItem.cs
            - OrderProcessor.cs
            - PERFORMANCE_GUIDE.md
            - Product.cs
            - ProductCatalog.cs
            - Program.cs
            - README.md
        - ContosoOnlineStore.Tests\
            - ContosoOnlineStoreTests.cs
            - Usings.cs
        - DataAnalyzerReporter\
            - data.txt
            - DataAnalyzer.cs
            - FileLoader.cs
            - output.txt
            - Program.cs
            - README.md
            - ReportGenerator.cs

## Exercise scenario

You're a software developer working for a consulting firm. Your clients need help implementing performance profiling in legacy applications. Your goal is to improve code performance while preserving readability and the existing functionality. You're assigned to the following app:

- ContosoOnlineStore: This is an e-commerce application that processes customer orders. The application includes product catalog management with search capabilities, inventory tracking with stock reservations, order processing with validation and receipts, email notification services, and security validation. The application uses modern .NET architecture patterns including dependency injection, structured logging, and configuration management, but contains performance bottlenecks that mirror real-world scenarios.

> **NOTE**: Code bottlenecks include intentional inefficiencies and performance issues, as well as simulated delays that approximate real-world timing for external dependencies. Simulated delays should be retained when the code is refactored to allow for "before and after" performance comparisons.

This exercise includes the following tasks:

1. Review the ContosoOnlineStore codebase manually.
1. Identify performance bottlenecks using GitHub Copilot Chat (Ask mode).
1. Refactor performance-critical code using GitHub Copilot Chat (Agent mode).
1. Test and verify the refactored ContosoOnlineStore code.

### Review the ContosoOnlineStore codebase manually

The first step in any code refactoring effort is to understand the existing codebase, including the project structure and business logic. When you're working on performance improvements, it's also important to establish baseline performance metrics.

In this task, you'll examine the main components of the ContosoOnlineStore project, run the application to establish baseline performance metrics, and identify potential areas for optimization.

Use the following steps to complete this task:

1. Take a minute to examine the ContosoOnlineStore project structure.

    The codebase follows modern .NET architecture patterns with clear separation of concerns. The main architectural components include:

    - **Configuration**: Strongly-typed configuration with validation
    - **Services**: Business services with interfaces for testability  
    - **Exceptions**: Custom domain-specific exceptions
    - **Benchmarks**: Professional performance testing with BenchmarkDotNet
    - **Tests**: Unit tests with mocking framework

1. Take a few minutes to review the **ProductCatalog.cs**, **OrderProcessor.cs**, and **InventoryManager.cs** classes.

    These classes contain the core business logic and are likely candidates for performance optimization.

    > **NOTE**: The codebase includes comments that help identify performance issues. Look for comments marked "Performance bottleneck" or "Performance issue" that highlight intentional inefficiencies. Simulated delays are also included to approximate real-world timing for external dependencies (slow queries, network calls, etc.). These delays will be retained when refactoring the codebase to allow for "before and after" performance comparisons.

    - **ProductCatalog.cs**: The ProductCatalog class provides methods for retrieving, searching, and categorizing products, as well as caching search results.

    - **OrderProcessor.cs**: The OrderProcessor class handles order validation, total calculation, and finalization, including inventory updates and email notifications.

    - **InventoryManager.cs**: The InventoryManager class manages stock levels, reservations, and low-stock alerts.

1. Expand the **Services** and **Configuration** folders.

    These folders contain additional business logic and configuration settings that support the main application functionality.

1. Take a few minutes to review the **Program.cs** and **AppSettings.cs** files.

    Examine the relationship between the Program.cs and AppSettings.cs files. Notice that the Program.cs file initializes and injects the AppSettings configuration into the application's services, enabling centralized and flexible control over application behavior. The application configuration is strongly typed and validated at startup, ensuring that all required settings are present and correctly formatted.

1. Take a few minutes to review the **EmailService.cs** and **SecurityValidationService.cs** files.

    Examine the implementation of these services. Notice that they supply business logic with configurable timeouts, security validation rules, and email notification workflows. The services use dependency injection and logging, following enterprise development patterns.

1. Run the application and observe the baseline performance.

    You can run the application from the Visual Studio Code integrated terminal by navigating to the project folder and running the following .NET CLI command:

    ```bash
    dotnet run
    ```

    The application will execute a comprehensive performance test that includes:

    - Order processing with timing measurements.
    - Product catalog operations (search, lookup, category filtering).
    - Inventory management operations.
    - Concurrent operation testing.
    - Email notification simulation.

1. Store the baseline performance metrics in a file named **baseline_metrics.txt**.

    Use the EXPLORER view to create a text file named baseline_metrics.txt in the Benchmarks folder, and then copy the console output into the baseline_metrics.txt file.

1. Review the baseline_metrics.txt file.

    Notice the timing information displayed under the *Running Performance Analysis* section. Key performance metrics include:

    - Product lookup performance.
    - Search performance.
    - Order processing performance.
    - Inventory operations performance.
    - Concurrent operation performance.

    The application also runs a comprehensive performance analysis suite that tests various operations and reports timing details.

1. Take a minute to examine the performance benchmark capabilities provided by the OrderProcessingBenchmarks.cs file.

    The application includes professional benchmarking using BenchmarkDotNet. You can run detailed performance benchmarks by executing:

    ```bash
    dotnet run -c Release -- benchmark
    ```

    Executing this command will generate detailed performance reports including memory allocation patterns and statistical analysis. If you want, you can save the detailed performance benchmark reports for later comparison.

Understanding the existing architecture and baseline performance metrics prepares the way for identifying optimization opportunities.

### Identify performance bottlenecks using GitHub Copilot Chat (Ask mode)

GitHub Copilot Chat's Ask mode is an excellent tool for analyzing complex codebases and identifying performance bottlenecks. In Ask mode, Copilot can analyze your code patterns, identify inefficient algorithms, and suggest optimization strategies based on best practices.

In this task, you'll use GitHub Copilot to systematically analyze the ContosoOnlineStore application and identify specific performance improvement opportunities.

Use the following steps to complete this task:

1. Open the GitHub Copilot Chat view, and then configure **Ask** mode and the **GPT-4o** model.

    To open the Chat view, select the **Toggle Chat** icon at the top of the Visual Studio Code window.

    > **NOTE**: The GPT-4o model provides excellent code analysis capabilities and is included with the GitHub Copilot Free plan. Choosing a different model may yield different results.

1. Close any files that you have open in the editor.

    GitHub Copilot uses files that are open in the editor to establish context. Having only the target files open helps focus the analysis on the code you want to optimize.

1. Add the **InventoryManager.cs**, **OrderProcessor.cs**, and **ProductCatalog.cs** files to the Chat context.

    Use a drag-and-drop operation to add **InventoryManager.cs**, **OrderProcessor.cs**, and **ProductCatalog.cs** from the SOLUTION EXPLORER to the Chat context.

    Adding files to the chat context tells GitHub Copilot to include those files when analyzing your prompts, which improves the accuracy and relevance of its analysis.

1. Ask GitHub Copilot to identify performance bottlenecks in the ProductCatalog class and suggest optimizations.

    For example, enter the following prompt in the Chat view:

    ```text
    Analyze the ProductCatalog class for performance bottlenecks. Focus on the GetProductById, SearchProducts, and GetProductsByCategory methods. What are the main inefficiencies and how could they be optimized?
    ```

1. Review the analysis generated by GitHub Copilot for the ProductCatalog class.

    The analysis should identify issues such as:

    - Linear search performance in GetProductById for certain conditions.
    - Inefficient cache key generation in SearchProducts.
    - Missing optimized data structures for category filtering in GetProductsByCategory.
    - Sequential processing with artificial delays in several of the methods.

1. Ask GitHub Copilot to evaluate the suggested optimizations for potential risks.

    For example, enter the following prompt in the Chat view:

    ```text
    Do any of the suggested optimizations include security risks or introduce other adverse effects?
    ```

    > **IMPORTANT**: Blindly adopting code refactoring suggestions can introduce security risks and other issues. It's important to evaluate the suggested optimizations and identify any potential issues. For example, optimizations that involve caching or parallel processing may introduce thread safety concerns or data consistency issues. Manual code review is recommended to ensure that AI suggested optimizations do not compromise security or functionality. Periodic security reviews and testing should be part of any code refactoring effort.

1. Review the risk analysis generated by GitHub Copilot.

    The risk analysis should highlight any potential security vulnerabilities or other issues associated with the suggested optimizations. This information helps you make informed decisions about which optimizations to implement when refactoring the code.

1. Ask GitHub Copilot to identify performance issues in the OrderProcessor class and suggest optimizations.

    For example, submit the following prompt:

    ```text
    Examine the OrderProcessor class, particularly the CalculateOrderTotal and FinalizeOrderAsync methods. What performance problems do you see and what optimization strategies would you recommend?
    ```

1. Review the analysis generated by GitHub Copilot for the OrderProcessor class.

    The analysis should identify issues such as:

    - Individual product lookups in loops (N+1 query pattern).
    - Redundant tax and shipping calculations.
    - Sequential processing of order items.
    - Blocking operations that could be made asynchronous.

1. Ask GitHub Copilot to evaluate the suggested optimizations for potential risks.

    For example, enter the following prompt in the Chat view:

    ```text
    Do any of the suggested optimizations include security risks or introduce other adverse effects?
    ```

1. Review the risk analysis generated by GitHub Copilot.

1. Ask GitHub Copilot to identify performance issues in the InventoryManager class and suggest optimizations.

    For example, use this prompt to examine inventory operations:

    ```text
    Review the InventoryManager class, especially the GetLowStockProducts and UpdateStockLevels methods. What are the performance concerns and how could the inventory operations be improved?
    ```

1. Review the analysis generated by GitHub Copilot for the InventoryManager class.

    The analysis should identify issues such as:

    - Individual database query simulation in loops.
    - Inefficient logging implementation with blocking operations.
    - Missing batch operation support.
    - Unnecessary thread delays in stock level checks.

1. Ask GitHub Copilot to evaluate the suggested optimizations for potential risks.

    For example, enter the following prompt in the Chat view:

    ```text
    Do any of the suggested optimizations include security risks or introduce other adverse effects?
    ```

1. Review the risk analysis generated by GitHub Copilot.

1. Ask GitHub Copilot to identify performance issues in the EmailService class and suggest optimizations.

    For example, submit this prompt to analyze the email service:

    ```text
    Analyze the EmailService class for performance issues. How does the email sending process impact overall application performance and what improvements could be made?
    ```

1. Review the analysis generated by GitHub Copilot for the EmailService class.

    The analysis should identify issues such as:

    - Sequential email content generation with blocking operations.
    - Individual product lookups within email templates.
    - Synchronous validation operations.
    - Missing parallelization opportunities for multiple recipients.

1. Ask GitHub Copilot to evaluate the suggested optimizations for potential risks.

    For example, enter the following prompt in the Chat view:

    ```text
    Do any of the suggested optimizations include security risks or introduce other adverse effects?
    ```

1. Review the risk analysis generated by GitHub Copilot.

By using GitHub Copilot's analytical capabilities, you've identified performance bottlenecks in the ContosoOnlineStore application. The analysis provides a roadmap for optimization efforts, focusing on algorithmic improvements, caching strategies, and asynchronous processing patterns. Analyzing AI-suggested code optimizations helps to identify risks associated with potential performance improvements. Manual code reviews, security reviews, and testing should be part of any code refactoring effort.

### Refactor performance-critical code using GitHub Copilot Chat (Agent mode)

GitHub Copilot's Agent mode provides an autonomous agent that assists with programming tasks. Developers assign high-level tasks to the agent and then start an agentic code editing session to complete the task. The GitHub Copilot agent autonomously evaluates the required work, determines the relevant files and context, and plans how to complete the task. The agent can make changes to your code, run tests, and even deploy your application.

In Agent mode, GitHub Copilot can generate optimized code implementations, suggest architectural improvements, and help implement performance enhancements.

In this task, you'll use GitHub Copilot Agent mode to systematically address the performance bottlenecks identified in the previous task.

Use the following steps to complete this task:

1. Configure GitHub Copilot Chat for Agent mode.

    In the Chat view, change the mode from **Ask** to **Agent**. Agent mode provides more targeted code generation and modification capabilities.

1. Open the **ProductCatalog.cs** file, and then select the **GetProductById** method.

1. Assign a task to the agent that optimizes the GetProductById method.

    For example, enter the following task in the Chat view:

    ```text
    Review the current chat session. Optimize the GetProductById method to improve performance. Consider using a dictionary lookup instead of linear search and implement proper caching mechanisms. Retain any existing artificial/simulated delays for "before and after" performance comparisons. Ensure that the refactored code doesn't introduce security vulnerabilities or other issues.
    ```

1. Take a minute to review the edits suggested by GitHub Copilot, and then accept the changes.

    The optimized version should include:

    - Dictionary-based product lookups for O(1) performance.
    - Proper cache initialization and management.
    - Reduced redundant operations.

    You can review and accept (or reject) individual edits in the code editor, or you can accept all changes at once by selecting **Keep** in the Chat view.

    > **NOTE**: As you complete this section of the exercise, consider the security vulnerabilities and other issues that were identified in the previous task. Developers should ensure that no new vulnerabilities are introduced during the optimization process. In a production environment, manual code reviews, security reviews, and testing should be part of your process.

1. In the code editor, select the **SearchProducts** method.

1. Assign a task to the agent that enhances the efficiency of the SearchProducts method.

    For example, enter the following task in the Chat view:

    ```text
    Review the current chat session. Refactor the SearchProducts method to eliminate performance bottlenecks. Optimize the search algorithm while maintaining search functionality. Retain any existing artificial/simulated delays for "before and after" performance comparisons. Ensure that the refactored code doesn't introduce security vulnerabilities or other issues.
    ```

1. Take a minute to review the edits suggested by GitHub Copilot, and then accept the changes.

    The optimized version should include:

    - Efficient string matching algorithms.
    - Parallel processing for multiple search criteria.
    - Optimized cache key generation.

1. Save and then close the **ProductCatalog.cs** file.

1. Open the **OrderProcessor.cs** file, and then select the **CalculateOrderTotal** method.

1. Assign a task to the agent that improves the performance of the CalculateOrderTotal method.

    For example, enter the following task in the Chat view:

    ```text
    Review the current chat session. Optimize the CalculateOrderTotal method to reduce redundant product lookups and improve calculation performance. Consider batch operations and caching strategies. Retain any existing artificial/simulated delays for "before and after" performance comparisons. Ensure that the refactored code doesn't introduce security vulnerabilities or other issues.
    ```

1. Take a minute to review the edits suggested by GitHub Copilot, and then accept the changes.

    The optimized version should include:

    - Batch product retrieval to eliminate N+1 query patterns.
    - Cached product information during order processing.
    - Optimized tax and shipping calculations.

1. In the code editor, select the **FinalizeOrderAsync** method.

1. Assign a task to the agent that improves the performance of the FinalizeOrderAsync method.

    For example, enter the following task in the Chat view:

    ```text
    Review the current chat session. Refactor the FinalizeOrderAsync method to improve async performance. Focus on parallel processing where possible and optimizing await patterns. Retain any existing artificial/simulated delays for "before and after" performance comparisons. Ensure that the refactored code doesn't introduce security vulnerabilities or other issues.
    ```

1. Take a minute to review the edits suggested by GitHub Copilot, and then accept the changes.

    The optimized version should include:

    - Parallel processing of independent operations
    - Optimized async/await usage
    - Better exception handling in async contexts

1. Save and then close the **OrderProcessor.cs** file.

1. Open the **InventoryManager.cs** file, and then select the **UpdateStockLevels** method.

1. Assign a task to the agent that improves the performance of the UpdateStockLevels method.

    For example, enter the following task in the Chat view:

    ```text
    Review the current chat session. Optimize the UpdateStockLevels method to support batch operations and reduce individual update overhead. Implement efficient logging, but retain any existing artificial delays for performance comparison. Ensure that the refactored code doesn't introduce security vulnerabilities or other issues.
    ```

1. Take a minute to review the edits suggested by GitHub Copilot, and then accept the changes.

    The optimized version should include:

    - Batch stock level updates
    - Efficient logging strategies
    - Reduced blocking operations

1. Save and then close the **OrderProcessor.cs** file.

1. Open the **EmailService.cs** file.

1. Assign a task to the agent that improves the performance of the email sending methods.

1. Improve EmailService asynchronous processing.

    For example, enter the following task in the Chat view:

    ```text
    Review the current chat session. Optimize the email service methods to support parallel email processing and improve async performance. Consider implementing email queuing and batch operations. Retain any existing artificial/simulated delays for "before and after" performance comparisons. Ensure that the refactored code doesn't introduce security vulnerabilities or other issues.
    ```

1. Take a minute to review the edits suggested by GitHub Copilot, and then accept the changes.

    The optimized version should include:

    - Parallel email content generation
    - Asynchronous email sending operations
    - Improved error handling and retry logic

Throughout this refactoring process, GitHub Copilot Agent mode serves as your collaborative partner, providing specific code improvements and optimization strategies. The key is to review each suggestion carefully and adapt it to fit your specific requirements and coding standards.

### Test and verify the refactored ContosoOnlineStore code

After implementing performance optimizations, it's crucial to validate that the changes improve performance while maintaining functional correctness. This task focuses on comprehensive testing and performance measurement.

Use the following steps to complete this task:

1. Build and run the refactored application.

    Run the following command in the Visual Studio Code terminal to ensure the application builds successfully:

    ```bash
    dotnet build
    ```

    Address any compilation errors that may have been introduced during the refactoring process.

1. Run the performance test suite.

    Run the following command in the Visual Studio Code terminal to generate performance metrics for the refactored code:

    ```bash
    dotnet run
    ```

1. Save the new performance metrics in a file named **optimized_metrics.txt**.

    Use the EXPLORER view to create a text file named optimized_metrics.txt in the Benchmarks folder, and then copy the console output into the optimized_metrics.txt file.

1. Take a minute to manually compare the optimized performance metrics with your baseline measurements from the first task.

    You should observe the following performance improvements:

    - Significantly faster product lookup operations.
    - Improved search performance.
    - Reduced order processing time.
    - Improved performance of concurrent operations.

    Verify the functional correctness for the refactored code.

    - Verify that order totals are calculated correctly.
    - Confirm that inventory levels are updated properly.
    - Verify that email notifications are sent successfully.
    - Validate that security validation still functions.

1. Build and run the unit test project.

    For example, in the Visual Studio Code terminal, navigate to the **ContosoOnlineStore.Tests** folder and run the following command:

    ```bash
    dotnet test
    ```

    All tests should pass, confirming that the refactored code maintains the expected behavior.

    The output should look similar to the following:

    ```plaintext
    Restore complete (0.6s)
      ContosoOnlineStore succeeded (0.6s) → C:\Users\cahowd\Desktop\GHCopilotEx10LabApps\ContosoOnlineStore\bin\Debug\net9.0\ContosoOnlineStore.dll
      ContosoOnlineStore.Tests succeeded (0.2s) → bin\Debug\net9.0\ContosoOnlineStore.Tests.dll
    [xUnit.net 00:00:00.00] xUnit.net VSTest Adapter v2.4.5+1caef2f33e (64-bit .NET 9.0.9)
    [xUnit.net 00:00:02.94]   Discovering: ContosoOnlineStore.Tests
    [xUnit.net 00:00:03.02]   Discovered:  ContosoOnlineStore.Tests
    [xUnit.net 00:00:03.02]   Starting:    ContosoOnlineStore.Tests
    [xUnit.net 00:00:03.18]   Finished:    ContosoOnlineStore.Tests
      ContosoOnlineStore.Tests test succeeded (4.7s)
    
    Test summary: total: 16, failed: 0, succeeded: 16, skipped: 0, duration: 4.7s
    Build succeeded in 7.0s
    ```

1. Ask GitHub Copilot to help analyze the performance improvements.

    For example, enter the following prompt in the Chat view:

    ```text
    Compare the baseline_metrics.txt and optimized_metrics.txt files. Summarize the performance improvements achieved through the optimizations. Review the codebase and calculate the time associated with simulated delays for each performance test. Subtract the time associated with simulated delays from the performance data and summarize the impact of code optimizations.
    ```

1. Take a minute to review the (performance improvements) analysis generated by GitHub Copilot.

    The analysis should highlight the specific performance improvements achieved through the optimizations, excluding the impact of simulated delays. This provides a clearer picture of the effectiveness of the code changes.

1. Optional - If you ran the detailed performance benchmark suite at the start of this exercise and saved the results, you can run the detailed performance benchmark again and have GitHub Copilot compare the results.

    To run the detailed performance benchmarks, execute the following command in the Visual Studio Code terminal:

    ```bash
    dotnet run -c Release -- benchmark
    ```

    Ask GitHub Copilot to help you review the BenchmarkDotNet reports.

The testing and verification process confirms that your performance optimization efforts have been successful. The ContosoOnlineStore application now demonstrates improved performance while maintaining its functional requirements and architectural integrity.

## Summary

In this exercise, you successfully used GitHub Copilot to identify and resolve performance bottlenecks in a complex e-commerce application. Key accomplishments include:

- **Performance Analysis**: Used GitHub Copilot Ask mode to systematically analyze code and identify bottlenecks
- **Strategic Optimization**: Applied targeted optimizations addressing N+1 query patterns, inefficient algorithms, and blocking operations
- **Collaborative Refactoring**: Leveraged GitHub Copilot Agent mode to implement performance improvements
- **Validation**: Confirmed both performance improvements and functional correctness through comprehensive testing

The optimized ContosoOnlineStore demonstrates dramatic performance improvements while maintaining code quality and architectural best practices. This approach showcases how AI-powered development tools can accelerate performance optimization efforts and help developers make data-driven improvements to complex applications.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. If you made any changes, revert them as needed. If you're using a local PC as your lab environment, you can archive or delete the sample projects folder that you created for this exercise.

