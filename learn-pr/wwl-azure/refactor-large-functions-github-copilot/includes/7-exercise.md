> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you use a vibe coding process and GitHub Copilot Agent to create a prototype e-commerce app. Tasks include:

- Define your app requirements.
- Create an initial prototype of your e-commerce app.
- Refine your prototype app by iterating on the design and functionality.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.


**TODO** - update the link below to point to the correct lab exercise when available.

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2329902&azure-portal=true)







---
lab:
    title: 'Exercise - Refactor large functions using GitHub Copilot'
    description: 'Learn how to analyze complex code and refactor large functions into smaller, more focused methods using GitHub Copilot tools.'
---

# Refactor large functions using GitHub Copilot

Large functions can be difficult to read, maintain, and test. They often contain multiple responsibilities and can be challenging to understand at a glance. Refactoring large functions into smaller, more focused functions can improve code readability and maintainability.

In this exercise, you review an existing project that contains a large function, analyze your options for smaller single-responsibility functions, refactor the large function into smaller functions, and test the refactored code to ensure it works as intended. You use GitHub Copilot in Ask mode to gain an understanding of an existing code project and explore options for refactoring the logic. You use GitHub Copilot in Agent mode to refactor the code by extracting code sections from the large function to create smaller functions. You test the original and refactored code to ensure the refactored code works as intended.

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

1. To download a zip file containing the sample app project, open the following URL in your browser: [GitHub Copilot lab - refactor large functions](https://github.com/MicrosoftLearning/mslearn-github-copilot-dev/raw/refs/heads/main/DownloadableCodeProjects/Downloads/GHCopilotEx8LabApps.zip)

    The zip file is named **GHCopilotEx8LabApps.zip**.

1. Extract the files from the **GHCopilotEx8LabApps.zip** file.

    For example:

    1. Navigate to the downloads folder in your lab environment.

    1. Right-click **GHCopilotEx8LabApps.zip**, and then select **Extract all**.

    1. Select **Show extracted files when complete**, and then select **Extract**.

1. Copy the **GHCopilotEx8LabApps** folder to a location that's easy to access, such as your Windows Desktop folder.

1. Open the **GHCopilotEx8LabApps** folder in Visual Studio Code.

    For example:

    1. Open Visual Studio Code in your lab environment.

    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.

    1. Navigate to the Windows Desktop folder, select **GHCopilotEx8LabApps** and then select **Select Folder**.

1. In the Visual Studio Code SOLUTION EXPLORER view, verify the following project structure:

    - GHCopilotEx8LabApps\
        - ECommerceOrderProcessing\
            - src\
                - ECommerce.ApplicationCore\
                    - Entities\
                    - Exceptions\
                    - Interfaces\
                    - Services\
                        - OrderProcessor.cs
                - ECommerce.Console\
                    - order_audit_log.txt
                    - Program.cs
                - ECommerce.Infrastructure\
                    - Services\
        - ServerLogAnalysisUtility\

## Exercise scenario

You're a software developer working for a consulting firm. Your clients need help refactoring large functions in legacy applications. Your goal is to improve code readability and maintainability while preserving the existing functionality. You're assigned to the following app:

- E-CommerceOrderProcessing: This e-commerce app is used to process customer orders. The process includes order validation, inventory management, payment processing, shipping coordination, and customer notifications. The application uses Clean Architecture principles with a layered structure, but contains a large method in the **OrderProcessor** class that handles multiple responsibilities and needs to be refactored into smaller, more focused methods.

This exercise includes the following tasks:

1. Review the e-commerce order processing codebase manually.
1. Identify refactoring opportunities using GitHub Copilot Chat (Ask mode).
1. Refactor a large function into smaller, more manageable functions using GitHub Copilot Chat (Agent mode).
1. Test the refactored e-commerce order processing code.

### Review the e-commerce order processing codebase manually

The first step in any refactoring effort is to ensure that you understand the existing codebase. It's important to understand the code structure, the business logic, and the results generated when the code runs.

In this task, you'll review the main components of the E-commerce order processing project and run the app to observe its functionality.

Use the following steps to complete this task:

1. Ensure that you have the GHCopilotEx8LabApps folder open in Visual Studio Code.

    Refer to the **Before you start** section if you haven't downloaded the sample code project.

1. Take a minute to review the ECommerceOrderProcessing project structure.

    The codebase follows a layered architecture pattern with three main projects:

    - **ECommerce.ApplicationCore**: Contains domain entities, business logic interfaces, and the main OrderProcessor service.
    - **ECommerce.Console**: Contains the console application entry point and dependency injection setup.
    - **ECommerce.Infrastructure**: Contains service implementations for external integrations (payment, shipping, inventory, etc.).

    This structure represents a real-world .NET application using Clean Architecture principles, where business logic is separated from infrastructure concerns.

1. Open the GitHub Copilot Chat view.

    If the Chat view isn't already open, you can open it by selecting the **Chat** icon at the top of the Visual Studio Code window.

1. In the Chat view, ensure that the chat mode is set to **Ask** and the model is set to **GPT-4o**.

    These settings are available in the bottom-left corner of the Chat view. GitHub Copilot's **Ask** mode is used to ask general coding questions and generate code-related explanations. The **GPT-4o** model, which is included with the GitHub Copilot Free plan, is a good choice for code analysis and refactoring guidance.

    You'll be using GitHub Copilot's **Agent** mode later in this exercise, but for now you should use **Ask** mode for code analysis and explanations.

    > **NOTE**: GitHub Copilot's responses can vary based on the selected model. We suggest that you use the specified model when performing this lab exercise. You can repeat the exercise with a different model if you want to see the differences.

1. Use the SOLUTION EXPLORER view to locate the **OrderProcessor.cs** file.

    The **OrderProcessor.cs** file is located in the **src/ECommerce.ApplicationCore/Services** folder.

1. Open the **OrderProcessor.cs** file in the code editor.

    The OrderProcessor class is responsible for processing customer orders. It contains the main business logic for order processing, including validation, payment processing, and notification.

1. Take a minute to review the **OrderProcessor** class.

    Notice the ProcessOrder method. This method represents the core business logic for processing customer orders. Notice that it handles multiple distinct operations. The ProcessOrder method is intentionally large and complex to demonstrate real-world scenarios where business logic has accumulated over time, making it difficult to read, test, and maintain.

1. Right-click the **ProcessOrder** method, and then select **Copilot** > **Explain**.

    If prompted to **Select an enclosing range to explain**, select **ProcessOrder**.

    GitHub Copilot will analyze the ProcessOrder method and provide a detailed explanation of what the code does, helping you understand the business logic before you investigate refactoring options.

1. Take a couple minutes to review GitHub Copilot's explanation.

    The explanation should highlight the main processing steps and business rules, such as the comprehensive validation procedures, security risk assessments, multi-service coordination, and error handling with rollback capabilities.

1. Run the application to gain an understanding of its current behavior.

    You have several options for running the application. For example:

    In the SOLUTION EXPLORER view, right-click the **ECommerce.Console** project, select **Debug**, and then select **Start New Instance**. Or, if you have the **Program.cs** file open in Visual Studio Code, you can select the run button above the editor.

    You can also navigate to the **src/ECommerce.Console** folder in the terminal and enter the following .NET CLI command:

    ```bash
    dotnet run
    ```

1. Review the console output that's generated when the application runs.

    The application generates output for four test cases. Each test case demonstrates a different scenario:

    - **Test 1**: Valid order processing with multiple items.
    - **Test 2**: Invalid email address validation.
    - **Test 3**: Declined payment handling.
    - **Test 4**: Suspicious order security checks.

    The output for each test case shows the step-by-step processing including validation messages, inventory checks, payment processing, shipping scheduling, and notifications. The output also shows how different failure scenarios are handled with appropriate error messages and cleanup procedures.

1. Take a minute to consider your refactoring opportunities for the ProcessOrder method.

    The ProcessOrder method has several distinct responsibilities. Each of the corresponding code sections could be extracted into a separate method.

Understanding the existing functionality and identifying refactoring opportunities will help you create a refactoring strategy that maintains business logic while improving code structure. The layered architecture already provides good separation of concerns at the project level, but the large ProcessOrder method needs attention.

### Identify refactoring opportunities using GitHub Copilot Chat (Ask mode)

GitHub Copilot Chat's Ask mode is a great tool for analyzing complex code and identifying opportunities for refactoring large methods. In Ask mode, Copilot can analyze your code structure and suggest ways to break down monolithic methods into smaller, more focused methods.

In this task, you'll use GitHub Copilot to evaluate the ProcessOrder method and identify refactoring opportunities that maintain business logic while improving code structure.

Use the following steps to complete this task:

1. Ensure that you have the GitHub Copilot Chat view open with **Ask** mode and the **GPT-4o** model selected.

1. If you opened any files other than OrderProcessor.cs, close them now.

    GitHub Copilot uses files that are open in the editor to establish context. Having only the target file open helps focus the analysis on the code you want to refactor and ensures GitHub Copilot provides the most relevant suggestions.

1. Add the OrderProcessor.cs file to the Chat context.

    Use a drag-and-drop operation to add the **src/ECommerce.ApplicationCore/Services/OrderProcessor.cs** file from the SOLUTION EXPLORER to the Chat context. Adding a file to the chat context tells GitHub Copilot to include that file when analyzing your prompt, which improves the accuracy of its analysis.

1. Ask GitHub Copilot to analyze the ProcessOrder method for refactoring opportunities.

    Submit a prompt that asks GitHub Copilot to analyze the ProcessOrder method and identify specific areas for improvement. Consider including details about what you want to achieve with the refactoring.

    For example:

    ```text
    Analyze the ProcessOrder method in the OrderProcessor class. This method handles multiple responsibilities. Identify opportunities to break this large method into smaller, more focused methods. What specific functions could be extracted, and what would be the benefits of doing so?
    ```

1. Take a couple minutes to review GitHub Copilot's response.

    GitHub Copilot should identify the various responsibilities within the ProcessOrder method and suggest how to extract them into separate methods. The analysis should identify distinct logical sections that can become individual methods, such as validation logic, security assessments, inventory operations, payment processing, shipping coordination, notification handling, and order finalization.

    For example, GitHub Copilot might identify:

    - Input validation and security checks as candidates for extraction.
    - Inventory management operations that could be grouped together.
    - Payment processing logic with its own error handling.
    - Shipping and notification logic as separate concerns.
    - Order finalization steps that could be isolated.

1. Ask GitHub Copilot to provide a detailed refactoring plan.

    For example:

    ```text
    Create a detailed refactoring plan for the ProcessOrder method. Show me what the ProcessOrder method would look like after refactoring and provide a list of the methods that should be extracted. I'd like to keep the input validation and security checks together in a single method. Include suggestions for method signatures and return types that would maintain the current error handling behavior.
    ```

    Follow-up prompts like this one can be used to gain additional insights, but you should avoid prompts that deviate from your goal. Side-tracking the chat conversation can influence GitHub Copilot's responses. A clean chat history is important.

1. Take a few minutes to review GitHub Copilot's refactoring plan.

    GitHub Copilot should provide a clear outline showing how the ProcessOrder method could be transformed from a large monolithic method into a series of smaller, focused method calls. This plan should maintain the existing business logic while improving code structure and readability.

    The response should include:
    - A high-level flow showing the main steps as separate method calls.
    - Suggested method names and signatures for the extracted methods.
    - Guidance on how to handle errors consistently across methods.
    - Explanations of how the refactored structure improves maintainability.

1. Ask for additional guidance on error handling patterns.

    Understanding the error handling process is crucial for maintaining existing behavior when you refactor the ProcessOrder method. You can have GitHub Copilot analyze the current error handling strategy and suggest a way to maintain or improve the existing behavior.

    For example:

    ```text
    In the current ProcessOrder method, there are multiple error scenarios with specific cleanup procedures (like releasing inventory on payment failure). In the refactored version, how should I handle errors consistently across the extracted methods? Should each method return an OrderResult object, throw exceptions, or use another pattern to maintain the existing error handling behavior?
    ```

1. Take a couple minutes to review the error handling recommendations.

    GitHub Copilot should provide guidance on maintaining consistent error handling patterns across the refactored methods. This is critical because the current method has complex error handling with rollback procedures that must be preserved.

    The recommendations should address:
    - How to maintain the current rollback behavior (like releasing inventory on payment failures).
    - Whether to use return values, exceptions, or result objects for error signaling.
    - How to preserve audit logging throughout the refactored methods.
    - Ways to ensure cleanup procedures are still executed in error scenarios.

GitHub Copilot's Ask mode excels at analyzing complex code structures and providing strategic guidance for refactoring. The insights from this analysis will inform the specific refactoring approach you implement in the next section, ensuring that you maintain business logic integrity while achieving better code organization.

### Refactor large functions using GitHub Copilot Chat (Agent mode)

Agent mode enables you to assign complex code refactoring tasks to GitHub Copilot. The assigned tasks can include creating and/or updating multiple files. GitHub Copilot Agent processes tasks autonomously, testing and debugging updates as it works, and keeps you informed by reporting its progress in the Chat view.

In this task, you'll use GitHub Copilot Agent to systematically refactor the ProcessOrder method by extracting smaller, focused methods while preserving the existing business logic and error handling behavior.

Use the following steps to complete this task:

1. Ensure that the GitHub Copilot Chat view is open in Visual Studio Code.

1. In the Chat view, select the **Agent** mode.

    The **Set Mode** dropdown is located in the bottom-left corner of the Chat view. In **Agent** mode, GitHub Copilot processes its assigned tasks (your prompts) autonomously.

1. Take a minute to consider your refactoring strategy.

    Use the analysis from the previous task to formulate a strategy for refactoring the ProcessOrder method. Your approach should support incremental testing.

    For example, consider this phased refactoring strategy:

    - **Phase 1**: Create stub methods inside the OrderProcessor class.
    - **Phase 2**: Extract input validation and security assessment logic.
    - **Phase 3**: Extract inventory management operations (checking and reservation).
    - **Phase 4**: Extract payment processing with fraud detection and error handling.
    - **Phase 5**: Extract shipping coordination and tracking management.
    - **Phase 6**: Extract notification and communication logic.
    - **Phase 7**: Extract order finalization and completion procedures.

    This phased approach ensures that changes are manageable and that updates can be tested incrementally. The refactored code should maintain the same business logic and error handling as the original method.

1. In the code editor, scroll to the bottom of the OrderProcessor class, and then create the following code comment after the closing brace of the ProcessOrder method:

    ```csharp

        }
    
        // Add stub methods here
        
    }

    ```

    The code comment should be located after the final closing brace of the ProcessOrder method and before the closing brace of the OrderProcessor class.

    You'll instruct GitHub Copilot to use this location when it creates the new single-purpose methods inside the OrderProcessor class.

1. Ask GitHub Copilot Agent to create stub methods that can be used to hold the extracted code.

    For example:

    ```text
    Review the current conversation. I want to start by creating stub code for the new single-purpose methods that will be used when refactoring the ProcessOrder method. Use the method declarations that you proposed in this conversation. Create the new stub methods below the "Add stub methods here" comment in the OrderProcessor class. Ensure that you're using appropriate method parameters and return types. Do not extract any code from the ProcessOrder method, just create the stub methods. After the stub methods are created, open the terminal, navigate to the "ECommerceOrderProcessing/src/ECommerce.Console" directory, then run a "dotnet build" command. Ensure that there are no build errors.
    ```

    Building the stub methods first helps ensure that the new methods are correctly defined and integrated into the existing code structure. This approach allows for incremental testing and validation of each method's functionality before fully extracting the code from ProcessOrder.

1. Monitor the agent's progress and provide assistance when required.

    GitHub Copilot Agent will create the new methods in the specified location, then ask for permission to run a build command in the terminal. Select the **Continue** button when prompted (to allow the agent to proceed).

    If the agent encounters an issue, it should notify you, and then attempt to fix the issue automatically. Continue to provide assistance when required.

    After performing the build task, the agent should inform you that the new methods are correctly defined and that there are no syntax errors.

1. To accept the edits, select **Keep**.

    You can accept (or reject) edits individually in the code editor, or all at once in the GitHub Copilot chat interface.

1. Ask GitHub Copilot Agent to refactor the ProcessOrder method.

    Refactoring large methods works best when you're able to break the task down into manageable stages. In this case, the stages align to the single-process methods that you've already identified. The same approach should be applied when using an agent to refactor the code for you. Write a task that instructs the agent to refactor one section at a time, and then test the updates before moving on to the next section.

    However, working with GitHub Copilot Agent can be like having a developer available who can work independently on a series of assignments. In this case, the series of assignments is to refactor each code section and test the updates before moving on to the next section. In other words, you can write a single task (prompt) that asks GitHub Copilot Agent to refactor each of the code sections, testing each of the single-purpose methods before it moves on to the refactoring the next section.

    For example:

    ```text
    Review the current conversation. Examine the ProcessOrder method and identify the code sections that should be extracted into the single-purpose stub methods that you already created. Move the identified code sections into the associated single-purpose stub methods, constructing and testing the methods in the suggested order. Replace the extracted code sections with a call to the associated single-purpose method. Use local variables of the associated return value type to ensure that the ProcessOrder method maintains the same error handling behavior that's provided by the original code. As each method is updated, use a "dotnet run" command to ensure that the code features and error handling processes work correctly (including rollback features, like releasing inventory on payment failure). Also verify that the four test case scenarios generate the expected console output when the app is run (all test cases should pass). Continue extracting code into the new single-purpose methods (and testing the app) until all methods are complete and the application generates the expected console output for the four test case scenarios. Don't stop working on this task until all methods are constructed and tested. Display the step-by-step approach that you'll use to complete this task and then begin.
    ```

    > **NOTE**: When you're working on production code, it's important to thoroughly test your code after significant refactoring operations. This involves building and testing the application to verify that features are working as intended, unit tests are passing, and the output remains consistent with the original behavior. To save time during this training exercise, we're relying on the agent to perform incremental testing. You'll complete an additional (manual verification) test after the code refactoring tasks are completed.

1. Monitor the agent's progress and provide assistance when required.

    GitHub Copilot Agent should start by describing its plan for refactoring each section of the ProcessOrder method. The plan should include a step-by-step approach for each code section that includes: moving code from the ProcessOrder method into the corresponding single-process method, replacing the extracted code in ProcessOrder with a method call, and testing the app to ensure that the refactored code works as intended.

    The agent will also provide updates in the Chat view that describe its progress, including any issues it encounters. You can interact with the agent to clarify instructions or provide additional context as needed.

    GitHub Copilot Agent usually asks for permission to Build or Run the application during the refactoring process. When this occurs, select the **Continue** button in the Chat view to allow the agent to proceed.

    > **IMPORTANT**: If GitHub Copilot Agent stops processing the assigned task before all of the sections in the ProcessOrder method are refactored, enter a prompt telling the agent to proceed with the refactoring task.

1. Once the refactoring process is complete, accept the changes.

    Select the **Keep** button in the Chat view to accept all changes made by the agent.

1. Take a minute to review the updated OrderProcessor class.

    After the agent completes its refactoring tasks, the OrderProcessor class should contain several smaller, focused methods that handle specific aspects of order processing. The ProcessOrder method should be significantly shorter and more readable, with each step of the order processing workflow clearly defined in its own method.

    For example, the updated ProcessOrder method should look similar to the following:

    ```csharp
    public OrderResult ProcessOrder(Order order)
    {
        // Log the start of order processing for audit trail
        _auditLogger.LogOrderProcessingStarted(order.Id, order.CustomerEmail);

        try
        {
            // Validate order and perform security checks
            if (!ValidateOrderAndSecurity(order, out string? validationFailure))
            {
                return OrderResult.Failure(validationFailure ?? "Validation failed for unknown reasons");
            }

            Console.WriteLine($"Processing Order {order.Id} for {_securityValidator.MaskEmail(order.CustomerEmail)}...");
            Console.WriteLine($"Order contains {order.Items.Count} items, Total: ${order.TotalAmount:F2}");

            // Check inventory and reserve stock
            if (!CheckAndReserveInventory(order, out string? inventoryFailure))
            {
                return OrderResult.Failure(inventoryFailure ?? "Inventory check failed for unknown reasons");
            }
            Console.WriteLine("Inventory reserved successfully.");
            _auditLogger.LogInventoryReserved(order.Id, order.Items.Count);

            // Payment Processing with Enhanced Security
            Console.WriteLine("Processing payment...");
            // Process payment
            if (!ProcessPayment(order, out string? paymentFailure))
            {
                return OrderResult.Failure(paymentFailure ?? "Payment processing failed for unknown reasons");
            }

            // Shipping and Logistics Management
            Console.WriteLine("Scheduling shipping...");
            // Schedule shipping
            if (!ScheduleShipping(order, out string? shippingFailure))
            {
                return OrderResult.Failure(shippingFailure ?? "Shipping scheduling failed for unknown reasons");
            }

            // Customer Communication and Notifications
            Console.WriteLine("Sending notifications...");
            // Send notifications
            SendNotifications(order);

            // Order Finalization and Data Recording
            Console.WriteLine("Finalizing order...");
            order.Status = OrderStatus.Completed;
            order.CompletionDate = DateTime.UtcNow;
            order.ProcessingDuration = DateTime.UtcNow - order.OrderDate;

            // In a real app, this would update the order record in a database
            // _orderRepository.UpdateOrder(order);

            Console.WriteLine($"Order {order.Id} completed successfully in {order.ProcessingDuration.TotalSeconds:F1} seconds.");
            _auditLogger.LogOrderCompleted(order.Id, order.TotalAmount);

            // Finalize the order
            FinalizeOrder(order);

            return OrderResult.Success(order.Id, order.TrackingNumber ?? "");
        }
        catch (Exception ex)
        {
            HandleUnexpectedError(order, ex);
            return OrderResult.Failure("An unexpected error occurred during order processing");
        }
    }

    ```

GitHub Copilot Agent excels at systematic refactoring tasks that require understanding of code flow, business logic, and error handling patterns. By breaking the refactoring into logical phases, you ensure that each change is manageable, testable, and maintains the original system behavior while significantly improving code organization and maintainability.

### Test the refactored e-commerce order processing code

Manual testing and verification ensures that your refactored code maintains the intended business logic and functionality. A successful refactoring process should improve code structure while producing identical behavior to the original implementation.

In this task, you'll test the refactored code to verify that all business logic has been preserved and that the refactoring has achieved its goals of improved maintainability and readability.

Use the following steps to complete this task:

1. Run the refactored application and verify expected behavior.

    Compare the output with the behavior you observed before refactoring. The console output should be identical, including:

    - **Test 1 (Valid Order)**: Should complete successfully with payment processing, shipping scheduling, and notifications
    - **Test 2 (Invalid Email)**: Should fail validation with the same error message
    - **Test 3 (Declined Payment)**: Should fail payment processing and trigger inventory rollback
    - **Test 4 (Suspicious Order)**: Should be flagged by security assessment and rejected

    The refactored code should produce exactly the same results, demonstrating that the business logic has been preserved throughout the refactoring process.

1. Create and test additional edge case scenarios to ensure robustness.

    Create additional test scenarios to verify that error handling still works correctly in various edge cases. You can modify the test cases in **Program.cs** temporarily to test additional scenarios.

    For example, you can add the following code snippet before the code that displays the test summary:

    ```csharp
    // Test with empty items list (should fail validation)
    System.Console.WriteLine("\n--- Test Case 5: Empty Order ---");
    var emptyOrder = CreateSampleOrder("ORD-EMPTY", "test@example.com", "123 Test St",
        new List<OrderItem>(),
        new PaymentInfo { CardNumber = "4111111111111111", CardCVV = "123", CardHolderName = "Test User", ExpiryMonth = "12", ExpiryYear = "2025", BillingAddress = "123 Test St" });

    var result5 = processor.ProcessOrder(emptyOrder);
    testResults.Add($"Test 5: {(result5.IsSuccess ? "FAILED" : "PASSED")} - Should reject empty order");

    // Test with invalid shipping address (should fail validation)
    System.Console.WriteLine("\n--- Test Case 6: Invalid Shipping Address ---");
    var invalidAddressOrder = CreateSampleOrder("ORD-ADDR", "user@example.com", "",
        new List<OrderItem> { new() { ProductId = "BOOK-001", Quantity = 1, Price = 15.99m } },
        new PaymentInfo { CardNumber = "4111111111111111", CardCVV = "123", CardHolderName = "Test User", ExpiryMonth = "12", ExpiryYear = "2025", BillingAddress = "123 Test St" });

    var result6 = processor.ProcessOrder(invalidAddressOrder);
    testResults.Add($"Test 6: {(result6.IsSuccess ? "FAILED" : "PASSED")} - Should reject invalid shipping address");
    ```

    These additional tests help verify that the refactored validation logic handles edge cases correctly and that error messages remain consistent with the original implementation.

1. Run the application and verify test results.

    When you run the application, you should see the test results displayed in the console, indicating whether each test case passed or failed. Pay attention to any error messages or logs that are generated during the test runs.

    For example, if you added the test 5 and test 6 scenarios listed above, the new test output and updated summary should look similar to the following:

    ```text

    --- Test Case 5: Empty Order ---
    [AUDIT] 2025-08-20 18:28:11.099 UTC | ORDER_PROCESSING_STARTED | Order: ORD-EMPTY | Started processing order for t***@example.com
    [AUDIT] 2025-08-20 18:28:11.100 UTC | VALIDATION_FAILURE | Order: ORD-EMPTY | Empty order items
    
    --- Test Case 6: Invalid Shipping Address ---
    [AUDIT] 2025-08-20 18:28:11.101 UTC | ORDER_PROCESSING_STARTED | Order: ORD-ADDR | Started processing order for u***@example.com
    [AUDIT] 2025-08-20 18:28:11.101 UTC | VALIDATION_FAILURE | Order: ORD-ADDR | Invalid shipping address
    
    === TEST SUMMARY ===
    Test 1: PASSED - ORD-001
    Test 2: PASSED - Should reject invalid email
    Test 3: PASSED - Should reject declined payment
    Test 4: PASSED - Should flag suspicious order
    Test 5: PASSED - Should reject empty order
    Test 6: PASSED - Should reject invalid shipping address

    ```

1. Run the application again to verify that audit logging continues to work correctly.

    Check the **order_audit_log.txt** file to ensure that audit logging is still functioning properly throughout the refactored methods. The most recent events are located at the bottom of the file.

    The audit trail should be complete and demonstrate that logging has been preserved across all the extracted methods.

    > **TIP**: The order_audit_log.txt file is created/updated in the current working directory of the application. Depending on how you choose to run the ECommerce.Console project, the working directory could be the "src/ECommerce.Console/bin/Debug/net9.0" directory rather than the "src/ECommerce.Console" directory. To generate the audit file in the "src/ECommerce.Console" directory, run the application from the Terminal using a .NET CLI command.

    The following event types can be stored in the order audit log file:

    - Order Processing Events:
        - LogOrderProcessingStarted(string orderId, string email)
        - LogOrderCompleted(string orderId, decimal amount)
    - Security Events:
        - LogSecurityEvent(string eventType, string details)
    - Validation Events:
        - LogValidationFailure(string orderId, string reason)
    - Inventory Events:
        - LogInventoryIssue(string orderId, string productId, string issue)
        - LogInventoryReserved(string orderId, int itemCount)
    - Payment Events:
        - LogPaymentProcessed(string orderId, decimal amount, string reference)
        - LogPaymentFailure(string orderId, string reason)
    - Shipping Events:
        - LogShippingScheduled(string orderId, string trackingNumber)
        - LogShippingFailure(string orderId, string reason)
    - Notification Events:
        - LogNotificationSent(string orderId, string type)
        - LogNotificationFailure(string orderId, string reason)
    - Unexpected Errors:
        - LogUnexpectedError(string orderId, string error)

Manual testing verifies that your refactoring efforts have successfully achieved the goal of improving code structure while maintaining system functionality. The refactored code now provides a much more maintainable foundation where each method has a clear, focused responsibility, making future enhancements and bug fixes significantly easier to implement.

## Summary

In this exercise, you learned how to use GitHub Copilot to refactor large functions in an application. You explored the E-commerce Order Processing System, identified large functions that needed refactoring, and used GitHub Copilot to break down monolithic methods into smaller, more focused functions for improved maintainability and readability.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. If you made any changes, revert them as needed. If you're using a local PC as your lab environment, you can archive or delete the sample projects folder that you created for this exercise.
