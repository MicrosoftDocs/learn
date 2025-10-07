> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

This exercise guides you through the process of consolidating duplicate logic in a C# codebase using GitHub Copilot. Tasks include:

- Review an existing C# codebase, manually identify instances of redundant/duplicate code, and test the application.
- Use GitHub Copilot's Ask mode to explain the codebase and identify redundant/duplicate code.
- Use GitHub Copilot's Agent mode to consolidate redundant/duplicate code.
- Test the refactored application to ensure functionality remains intact.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.

**TODO UPDATE THE LINK BELOW WHEN THE EXERCISE IS READY FOR PRODUCTION**

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2329902&azure-portal=true)

---

# Consolidate duplicate code using GitHub Copilot

Duplicate code logic is often introduced when developing/extending a codebase that includes similar or related features. It may not be intentional, and it can be as simple as reusing code to prototype a new feature. If duplicated logic evolves to match the surrounding code over time, the issue can become more complicated. Changes to variable names, function names, and code structures in one location (but not the another) can mask duplicated logic. A rushed schedule, poor documentation, and a lack of proper code reviews can exacerbate the issue. In the end, duplicated logic makes the code difficult to read, maintain, debug, and test.

In this exercise, you review an existing project that contains duplicated code logic, analyze your options for consolidation, consolidate the duplicated code logic, and test the refactored code to ensure it works as intended. You use GitHub Copilot in Ask mode to gain an understanding of an existing code project and explore options for consolidating the logic. You use GitHub Copilot in Agent mode to refactor the code by combining duplicate logic into shared helper methods. You test the original and refactored code to ensure the consolidated logic works as intended.

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

1. To download a zip file containing the sample app project, open the following URL in your browser: [GitHub Copilot lab - consolidate duplicate code](https://github.com/MicrosoftLearning/mslearn-github-copilot-dev/raw/refs/heads/main/DownloadableCodeProjects/Downloads/GHCopilotEx7LabApps.zip)

    The zip file is named **GHCopilotEx7LabApps.zip**.

1. Extract the files from the **GHCopilotEx7LabApps.zip** file.

    For example:

    1. Navigate to the downloads folder in your lab environment.

    1. Right-click **GHCopilotEx7LabApps.zip**, and then select **Extract all**.

    1. Select **Show extracted files when complete**, and then select **Extract**.

1. Copy the **GHCopilotEx7LabApps** folder to a location that's easy to access, such as your Windows Desktop folder.

1. Open the **GHCopilotEx7LabApps** folder in Visual Studio Code.

    For example:

    1. Open Visual Studio Code in your lab environment.

    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.

    1. Navigate to the Windows Desktop folder, select **GHCopilotEx7LabApps** and then select **Select Folder**.

1. In the Visual Studio Code SOLUTION EXPLORER view, verify the following project structure:

    - GHCopilotEx7LabApps\
        - ECommerceOrderAndReturn\
            - Dependencies\
            - Configuration\
                - AppConfig.cs
            - Models\
                - Order.cs
                - Return.cs
            - Security\
                - SecurityValidator.cs
            - Services\
                - AuditService.cs
                - EmailService.cs
                - InventoryService.cs
            - EXPECTED_OUTPUT.md
            - OrderProcessor.cs
            - Program.cs
            - README.md
            - ReturnProcessor.cs

## Exercise scenario

You're a software developer working for a consulting firm. Your clients need help consolidating duplicate code logic. Your goal is to improve code maintainability while preserving the existing functionality. You're assigned to the following app:

- E-CommerceOrdersAndReturns: This is an E-commerce app that processes customer orders and handles product returns. It includes core business logic for validating orders and returns, calculating shipping costs, sending email notifications, logging audit activities, and managing inventory levels.

This exercise includes the following tasks:

1. Review the E-commerce orders and returns codebase manually.
1. Identify duplicate code using GitHub Copilot Chat (Ask mode).
1. Consolidate duplicate logic using GitHub Copilot Chat (Agent mode).
1. Test the refactored E-commerce orders and returns code.

### Review the E-commerce orders and returns codebase manually

The first step in any refactoring effort is to ensure that you understand the existing codebase. It's important to understand the code structure, the business logic, and the results generated when the code runs.

In this task, you'll review the main components of the E-commerce order and return processing project, scan the code for duplicate code patterns, and test the code.

Use the following steps to complete this task:

1. Take a minute to review the ECommerceOrderAndReturn project structure.

    The codebase follows a layered architecture typical of enterprise applications. The main architectural layers include: Models, Configuration, Security, Services, and Processing.

1. Examine the main processing classes.

    Open **OrderProcessor.cs** and **ReturnProcessor.cs** side by side. These classes represent the core business logic for processing customer orders and product returns respectively.

    Notice that the two classes have similar method signatures and processing patterns. This is the most obvious type of duplication, but there are additional, more subtle duplications throughout the codebase.

1. Review the Services layer.

    Navigate to the **Services** folder and examine **EmailService.cs**, **AuditService.cs**, and **InventoryService.cs**.

    You may notice that these services implement similar patterns for handling email notifications, audit logging, and inventory management. Each service has methods that follow similar structures but are duplicated for different business processes (orders vs returns).

1. Run the application and review the console output.

    > **NOTE**: A copy of the console output is stored in the EXPECTED_OUTPUT.md file that's included in the project directory. You'll use this file to verify that the application behavior hasn't changed after consolidating the duplicate code.

    You can run the application from the SOLUTION EXPLORER view by right-clicking **ECommerceOrdersAndReturns**, selecting **Debug**, and then selecting **Start New Instance**.

    The console output includes:

    - Initial inventory levels
    - Order processing with validation, shipping calculation, payment processing, inventory reservation, email notifications, and audit logging
    - Return processing with similar steps but adapted for returns
    - Updated inventory levels
    - Security validation tests with various invalid inputs

    The application runs 5 test scenarios to demonstrate both successful processing and security validation failures.

1. Take a minute to categorize any duplicate code patterns that you observed.

    For example:

    **Duplicated Methods**: OrderProcessor and ReturnProcessor have identical `Validate()` and similar `CalculateShipping()` methods.

    **Similar Patterns in the Service Layer**: Each service has methods that follow similar patterns but are duplicated for different business processes (orders vs returns).

It's important to understand the existing functionality before making changes. By running the code and reviewing the output, you establish a baseline that you can use to verify that your refactoring doesn't break existing functionality.

### Identify duplicate code using GitHub Copilot Chat (Ask mode)

GitHub Copilot Chat's Ask mode is a great tool for analyzing complex codebases and identifying subtle duplication patterns that might not be immediately obvious. In Ask mode, Copilot acts as an intelligent code reviewer that can analyze multiple files simultaneously and identify both obvious and hidden (code logic) duplications.

In this task, you'll use GitHub Copilot to systematically identify the various types of duplicate code patterns in the e-commerce application.

Use the following steps to complete this task:

1. Open the GitHub Copilot Chat view, and then configure Ask mode and the GPT-4.1 model.

    If the Chat view isn't already open, select the **Chat** icon at the top of the Visual Studio Code window. Ensure that the chat mode is set to **Ask** and you're using the **GPT-4.1** model.

    The GPT-4.1 model is available with the GitHub Copilot Free plan, is designed to handle complex tasks, and provides intelligent code analysis/suggestions.

1. Close any files that are open in the editor.

    GitHub Copilot uses files that are open in the editor to establish context. Closing unwanted file tabs helps to reduce noise in the analysis.

1. Add the OrderProcessor and ReturnProcessor files to the Chat context.

    Use a drag-and-drop operation to add the **OrderProcessor.cs** and **ReturnProcessor.cs** files from the SOLUTION EXPLORER to the Chat context.

    Adding a file to the chat context tells GitHub Copilot to include that file in context when analyzing your prompt.

    If you're using the default folder view rather than SOLUTION EXPLORER, you can right-click a file and then select **Add File to Chat**. You can also open a file in the code editor to help establish context.

1. Ask GitHub Copilot to identify duplicate code patterns in the selected files.

    For example, submit the following prompt to analyze the core duplication:

    ```text
    What duplicate code exists between OrderProcessor.cs and ReturnProcessor.cs? Identify specific methods and logic that are duplicated between these classes. Describe opportunities to consolidate duplicate code.
    ```

1. Take a minute to review GitHub Copilot's response.

    GitHub Copilot should identify the `Validate()` method duplication and the similar patterns in `CalculateShipping()` methods. It may also note similar patterns in relation to audit logging, error handling, and payment/refund processing.

1. Update the chat context to specify the **EmailService.cs** file.

    Open **EmailService.cs** in the editor. You can also add the **EmailService.cs** file to the Chat context using a drag-and-drop operation. Remove all other files from the context.

1. Ask GitHub Copilot to identify duplications in the EmailService class.

    For example:

    ```text
    Analyze the EmailService class. What duplicate logic exists within this service for handling order confirmations versus return confirmations? Describe opportunities to consolidate duplicate code.
    ```

1. Take a minute to review GitHub Copilot's response.

    GitHub Copilot should identify the duplicate logic for handling order confirmations and return confirmations. This includes a templated approach to preparing and sending emails. GitHub Copilot may also identify duplicate patterns related to helper methods and console output.

1. Update the chat context to specify the **AuditService.cs** and **InventoryService.cs** files.

    Open **AuditService.cs** and **InventoryService.cs** in the editor. You can also add these files to the Chat context using a drag-and-drop operation. Remove all other files from the context.

1. Ask GitHub Copilot to identify duplications in the audit and inventory service files.

    For example:

    ```text
    Analyze the AuditService and InventoryService classes. Identify the methods that contain duplicate logic patterns that could be consolidated. Describe opportunities to consolidate duplicate code.
    ```

1. Take a minute to review GitHub Copilot's response.

    GitHub Copilot should identify patterns like audit entry creation/validation/storage in AuditService, and inventory validation/updating/logging in InventoryService. GitHub Copilot may also identify duplicate patterns related to helper methods.

1. Ask GitHub Copilot to perform a comprehensive duplication analysis.

    For example:

    ```text
    @workspace Analyze the entire ECommerceOrderAndReturn codebase and identify all forms of code duplication, including method-level, service-level, and architectural pattern duplications. Prioritize the duplications by impact and refactoring difficulty. Describe an approach for consolidating this code.
    ```

    After analyzing specific files, you can get a broader view by asking GitHub Copilot to include the entire codebase in its analysis. The increased scope can reveal additional duplication patterns, such as similar error handling, logging, and validation logic across multiple files or layers. Having a single response that informs and prioritizes your refactoring strategy is often helpful.

    > **NOTE**: The `@workspace` and `#codebase` keywords tell GitHub Copilot to include the entire codebase in the context of its analysis. The `@workspace` keyword is only available when using GitHub Copilot in the Ask mode. The `#codebase` keyword can be used in any mode (Ask, Edit, or Agent).

1. Take a minute to review GitHub Copilot's response.

    The response should provide a comprehensive analysis of all duplication patterns and suggest an approach for consolidating duplicate code. In a production scenario, you should analyze each section of the response, and consider using follow-up prompts to dig deeper into specific areas.

    For this training exercise, it's important to understand what types of information GitHub Copilot can provide, but you can focus on the summary section when considering your refactoring strategy.

    For example:

    ```md
    
    **Summary**

    The codebase contains significant method-level and service-level duplication, especially in validation, shipping calculation, audit logging, email notification, and inventory management. The highest priority and easiest wins are consolidating validation and shipping logic. Service-level helper methods should be refactored next. The processor workflow pattern can be abstracted for further maintainability, though this is more complex.

    Start with shared services for validation and shipping, then refactor service helpers, and finally consider architectural abstraction for processors.

    ```

1. Verify GitHub Copilot's analysis with manual code review.

    Cross-reference GitHub Copilot's findings with your own observations. Ensure that you understand not just what is duplicated, but why these patterns exist and how they should be consolidated while maintaining the business logic integrity.

GitHub Copilot's Ask mode is particularly powerful for identifying subtle duplications that go beyond simple copy-paste scenarios. It can recognize similar logical patterns, equivalent business rules implemented differently, and architectural duplications that span multiple files.

> **NOTE**: The analysis generated during this task is used to inform the refactoring strategy that you implement in the next section.

### Consolidate duplicate logic using GitHub Copilot Chat (Agent mode)

GitHub Copilot's Agent mode enables you to assign complex, multi-step refactoring tasks that span multiple files and architectural layers. The agent can autonomously create new files, modify existing code, and implement comprehensive refactoring strategies while keeping you informed of its progress.

In this task, you'll use GitHub Copilot Agent to systematically eliminate the duplicate code patterns identified in the previous task, starting with the most straightforward duplications and progressing to more complex service-layer consolidations.

Use the following steps to complete this task:

1. Switch the GitHub Copilot Chat view to Agent mode.

    When using Agent mode, GitHub Copilot can make autonomous changes to your codebase. Agent mode is particularly useful for complex, multi-step refactoring tasks.

    To change modes, locate the mode selector (typically in the bottom-left corner of the Chat view) and select **Agent**.

1. Take a minute to plan your refactoring strategy.

    Before assigning tasks to GitHub Copilot Agent, consider the logical order for refactoring. Use the analysis from the previous task to inform your decisions.

    For example:

    If GitHub Copilot suggested:

    "Start with shared services for validation and shipping, then refactor service helpers, and finally consider architectural abstraction for processors."

    You can use the following phased approach:

    - **Phase 1**: Core business logic duplication (validation and shipping calculation)
    - **Phase 2**: Service-layer duplications (email, audit, inventory services)
    - **Phase 3**: Cross-cutting concerns and architectural improvements

    This phased approach ensures that changes are manageable and can be tested incrementally.

1. Ask GitHub Copilot Agent to consolidate the validation logic in the OrderProcessor and ReturnProcessor classes.

    For example, submit the following task to GitHub Copilot Agent:

    ```text
    Create a shared ValidationService class that consolidates the duplicate Validate() method logic from OrderProcessor and ReturnProcessor. The service should handle ID validation for both orders and returns while maintaining all existing security checks, business rules, and logging. Update both processor classes to use the new shared service and remove the duplicate private methods. Build and test the code to ensure the functionality remains intact. Continue working until the validation service is fully integrated.
    ```

1. Monitor the agent's progress in the Chat view.

    The agent's progress should be visible in the chat as it completes the assigned task.

    To assist the agent as the task is being processed, provide permission to continue or supply additional context as needed. For example, if the agent asks for permission to Build or Run the application, select **Continue**

    The agent will accomplish the following during this task:

    - Create a new **ValidationService.cs** file in the Services folder
    - Extract the validation logic into a reusable method
    - Update both processor classes to use the new service
    - Remove the duplicate private validation methods
    - Verify functionality with a successful build and test run

1. Review and accept the validation service changes.

    Use the code editor tabs to examine the changes proposed by the agent. You can scroll through the chat edits to see the specific code modifications. Select **Keep** on the editor tab to accept the current edit. You can select **Undo** on the editor tab to reject an edit.

    Select **Keep** or **Undo** in the Chat view to accept or reject all changes

    The new validation service should maintain all the existing validation logic while providing a single, reusable implementation. If the changes look correct, accept them.

    > **NOTE**: When you're working on production code, it's important to thoroughly test your code after significant refactoring operations. This involves building and testing the application to verify that features are working as intended, unit tests are passing, and the output remains consistent with the original behavior. To save time during this training exercise, we're relying on the agent to perform incremental testing. An additional (manual verification) test will be done after all refactoring tasks are complete.

1. Ask GitHub Copilot Agent to consolidate shipping calculation logic.

    For example, use the following task to consolidate shipping calculations:

    ```text
    Create a shared ShippingCalculationService that consolidates the similar CalculateShipping() logic from OrderProcessor and ReturnProcessor. The service should handle both order shipping (with free shipping thresholds) and return shipping (with processing fees) while maintaining the different business rules for each type. Update both processor classes to use the new shared service. Build and test the code to ensure the functionality remains intact. Continue working until the shipping calculation service is fully integrated.
    ```

    The agent should create a shipping service that handles both scenarios while preserving the different business rules for orders versus returns.

    > **NOTE**: If the agent encounters any issues during the code refactoring process, it should refer to the original processor classes for guidance, and it should continue to update and test the code until the shipping calculation service is fully integrated. If the agent fails to accomplish the assigned task, or if the agent enters a code revision loop that it's unable to resolve, stop the agent and undo the edits. The chat session should include sufficient context to troubleshoot the issue and update the task (prompt). You can also ask GitHub Copilot for help updating the assigned task in a way that resolves the issue.

1. Review and accept the changes.

1. Ask GitHub Copilot Agent to refactor the EmailService duplications.

    For example, use the following task to consolidate the email service duplications:

    ```text
    Refactor the EmailService class to eliminate duplicate logic in the helper methods. Create a unified approach for template building, subject formatting, email sending, and activity logging that can handle both order and return confirmations. The public methods SendOrderConfirmation and SendReturnConfirmation should remain, but they should use shared private helper methods. Build and test the code to ensure the functionality remains intact. Continue working until the unified approach is fully integrated.
    ```

1. Review and accept the changes.

1. Ask GitHub Copilot Agent to consolidate AuditService duplications.

    For example, use the following task to consolidate the audit service duplications:

    ```text
    Refactor the AuditService class to consolidate the duplicate logic in LogOrderActivity and LogReturnActivity. Create shared helper methods for audit entry creation, validation, storage, and compliance checking. The public methods should remain but use common underlying logic. Build and test the code to ensure the functionality remains intact. Continue working until the shared helper methods are fully integrated.
    ```

1. Review and accept the changes.

1. Ask GitHub Copilot Agent to address InventoryService duplications.

    For example, use the following task to handle the inventory service duplications:

    ```text
    Refactor the InventoryService class to eliminate duplicate logic between ReserveOrderInventory and RestoreReturnInventory. Create shared helper methods for inventory validation, level updates, and transaction logging while maintaining the different business logic for reservations versus restorations. Build and test the code to ensure the functionality remains intact. Continue working until the shared helper methods are fully integrated.
    ```

1. Ask GitHub Copilot Agent to consolidate any remaining duplications in the codebase.

    For example, use the following task to address any remaining duplications:

    ```text
    Analyze the entire ECommerceOrderAndReturn codebase and identify any remaining duplicate code patterns that should be consolidated. Focus on cross-cutting concerns like payment processing, status updates, and error handling. Create shared services or helper methods as needed to eliminate these duplications while maintaining existing functionality. Build and test the code to ensure the functionality remains intact. Continue working until all identified duplications are fully integrated.
    ```

    Assigning tasks like this "catch any remaining issues" to GitHub Copilot Agent should only be done at the end of the refactoring process, and should only be used when necessary. Attempting this type of broad stroke analysis too early can produce unexpected results or task failures that need to be rolled back. It's best to create a planned approach and address revisions on a priority basis using a staged process.

    > **Note:** Even after GitHub Copilot "consolidates the remaining duplicated code patterns", there may be opportunities for further consolidation. However, the planned approach that you implemented should consolidate all major duplications in the codebase. If you have concerns, you can repeat the analysis and refactoring process. Remember that GitHub Copilot should not be used as a substitute for a formal code review process.

GitHub Copilot Agent excels at complex, multi-file refactoring tasks that require understanding of business logic and architectural patterns. By breaking the refactoring into logical phases and testing incrementally, you ensure that the consolidation maintains system integrity while significantly improving code quality, maintainability, extensibility, and reusability.

### Test the refactored E-commerce orders and returns code

Manual testing and verification is crucial to ensure that your refactored code maintains the intended business logic and functionality. A successful refactoring process should achieve the intended goal (such as consolidating duplicate code logic) while producing identical behavior to the original implementation.

In this task, you'll verify that the refactored code maintains all original functionality and that the consolidation has been successful.

Use the following steps to complete this task:

1. Build the refactored project to check for compilation errors.

    If there are any compilation errors, review the refactored code and resolve issues. You can use GitHub Copilot to help diagnose and fix any problems that arise from the refactoring process.

1. Run the refactored application and capture the output.

    The application should run all 5 test scenarios exactly as before:

    - Initial inventory display
    - Valid order processing with complete workflow
    - Valid return processing with complete workflow
    - Updated inventory levels
    - Security validation tests with invalid inputs

1. Ask GitHub Copilot to compare the output generated by the refactored code with the original output.

    For example:

    ```text
    Run the app and compare the generated output with the contents of the EXPECTED_OUTPUT.md file. Does the current output match the stored output? Explain any differences.
    ```

    The original output, **EXPECTED_OUTPUT.md**, is included in the ECommerceOrderAndReturn folder.

    You can create a second output file and ask GitHub Copilot to identify any differences between the two files.

    The output should be identical, confirming that the business logic remains unchanged while consolidating the duplicate code logic.

1. Perform a final code review.

    Review the refactored codebase to ensure:

    - **Code Quality**: Methods are well-named and follow consistent patterns
    - **Maintainability**: Changes to business rules now require updates in only one location
    - **Readability**: The code structure is clear and logical
    - **Reusability**: Shared services can be easily extended for future requirements
    - **Extensibility**: New features can be added with minimal impact on existing code

Manual testing verifies that your consolidation efforts have achieved the intended goal: eliminating duplicate code while maintaining system functionality. The architecture now provides a more maintainable foundation for future development, where business rule changes can be implemented in a single location rather than requiring updates across multiple duplicate implementations.

## Summary

In this exercise, you learned how to use GitHub Copilot to consolidate duplicate code in an application. You explored the E-commerce Order and Return Processing System, identified duplicate code patterns, and used GitHub Copilot to refactor the codebase for improved maintainability and readability.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. If you made any changes, revert them as needed. If you're using a local PC as your lab environment, you can archive or delete the sample projects folder that you created for this exercise.
