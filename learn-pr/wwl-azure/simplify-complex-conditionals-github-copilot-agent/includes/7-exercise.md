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

**TODO**: Update the link in the button below to point to the public GitHub page for this exercise.

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=???&azure-portal=true)








---
lab:
    title: 'Exercise - Simplify complex conditionals using GitHub Copilot'
    description: 'Learn how to refactor complex conditional logic in C# codebases using GitHub Copilot tools.'
---

# Simplify complex conditionals using GitHub Copilot

The conditional logic in business applications often grows more complex and deeply nested over time, making the code difficult to read, maintain, and test. Unfortunately, the same complexity that makes the code difficult to maintain can also make it difficult to refactor. The difficulty increases when the code is tightly coupled with business logic.

In this exercise, you use GitHub Copilot to analyze code that contains deeply nested conditional logic, refactor the code logic, and then test the refactored code to ensure it works as intended. You use GitHub Copilot in Ask mode to gain an understanding of the code and explore options simplifying the logic. You use GitHub Copilot in Agent mode to refactor the code by extracting complex conditional logic into smaller, focused helper methods, and to reduce nesting. Simplifying complex conditionals makes it easier to read, maintain, and test your code.

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

### Download sample code projects

Use the following steps to download the sample projects and open them in Visual Studio Code:

1. Open a browser window in your lab environment.

1. To download a zip file containing the sample app projects, open the following URL in your browser: [GitHub Copilot lab - develop code features](https://github.com/MicrosoftLearning/mslearn-github-copilot-dev/raw/refs/heads/main/DownloadableCodeProjects/Downloads/GHCopilotEx9LabApps.zip)

    The zip file is named **GHCopilotEx9LabApps.zip**.

1. Extract the files from the **GHCopilotEx9LabApps.zip** file.

    For example:

    1. Navigate to the downloads folder in your lab environment.

    1. Right-click **GHCopilotEx9LabApps.zip**, and then select **Extract all**.

    1. Select **Show extracted files when complete**, and then select **Extract**.

1. Copy the **GHCopilotEx9LabApps** folder to a location that's easy to access, such as your Windows Desktop folder.

1. Open the **GHCopilotEx9LabApps** folder in Visual Studio Code.

    For example:

    1. Open Visual Studio Code in your lab environment.

    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.

    1. Navigate to the Windows Desktop folder, select **GHCopilotEx9LabApps** and then select **Select Folder**.

1. In the Visual Studio Code SOLUTION EXPLORER view, verify the following project structure:

    - GHCopilotEx9LabApps\
        - ECommercePricingEngine\
            - Dependencies\
            - ECommercePricingDemo.cs
            - Output-ECommercePricingEngine.txt
            - SecurityTest.cs
        - LoanApprovalWorkflow\
            - Dependencies\
            - LoanApprovalDemo.cs
            - Output-LoanApprovalWorkflow.txt
            - SecurityTest.cs

## Exercise scenario

You're a software developer working for a consulting firm. Your clients need help refactoring complex conditional logic to improve code readability and maintainability. You're assigned to the following apps:

- E-commerce pricing engine: The first app is an E-commerce Pricing Engine that calculates dynamic pricing based on various business rules. Conditionals include membership levels, order values, coupon codes, product categories, and shipping rules.
- Loan approval workflow: The second app is a Loan Approval Workflow that evaluates loan applications based on various factors. Conditionals include income, employment status, debt ratios, collateral, and credit history.

This exercise includes the following tasks:

1. Review the E-commerce pricing engine codebase.
1. Identify refactoring opportunities in the E-commerce pricing code using GitHub Copilot.
1. Refactor the E-commerce pricing code using GitHub Copilot Agent.
1. Test the refactored E-commerce pricing code.
1. (OPTIONAL) Simplify complex conditionals in the LoanApprovalWorkflow demo app.

### Review the E-commerce pricing engine codebase

The first step in any refactoring effort is to ensure that you understand the existing codebase.

In this task, you'll open the E-commerce pricing engine project and use GitHub Copilot to help analyze the complex conditional logic.

Use the following steps to complete this task:

1. Ensure that you have the GHCopilotEx9LabApps folder open in Visual Studio Code.

    Refer to the **Before you start** section if you haven't downloaded the sample code projects.

1. Verify that the **ECommercePricingEngine** code project builds successfully.

    For example, in the SOLUTION EXPLORER view, right-click **ECommercePricingEngine**, and then select **Build**.

    You'll see warnings "Cannot convert null literal to non-nullable reference type." when you build the project, but there shouldn't be any errors. You can ignore the warnings for the purposes of this exercise.

1. Open the GitHub Copilot Chat view.

    If the Chat view isn't already open, you can open it by selecting the **Chat** icon at the top of the Visual Studio Code window, just to the right of the Search textbox.

1. In the Chat view, ensure that the chat mode is set to **Ask** and the model is set to **GPT-4.1**.

    These settings are available in the bottom-left corner of the Chat view. GitHub Copilot's **Ask** mode is used to ask general coding questions and to generate code related explanations. The **GPT-4.1** model, which is included with the GitHub Copilot Free plan, is a good choice for code analysis, explanations, and guidance related to code refactoring.

    You'll be using GitHub Copilot's **Agent** mode later in this exercise, but for now you'll use **Ask** mode for code analysis and explanations.

    > [!NOTE]
    > Some models are better suited for specific tasks than others. The model that you select can affect the responses generated by GitHub Copilot. After completing this lab exercise using the recommended settings, you may want to repeat the exercise using different models and compare the results.

1. In Visual Studio Code, open the **ECommercePricingDemo.cs** file.

    This file includes the following classes:

    - User: Represents a customer, with properties for membership level, purchase history, and special statuses (student, employee, corporate, etc.). Used to determine eligibility for various discounts and benefits.
    - Coupon: Represents a discount or shipping coupon, with properties for code, validity, type (percent or shipping), and value. Used in pricing calculations to apply additional discounts or free shipping.
    - Item: Represents a product in an order, with name, category, and price. Used to build up orders and calculate subtotals and category-specific discounts.
    - Order: Represents a customer’s order, containing a list of items, shipping region, coupon, event, payment method, and other order-specific flags. Provides methods to calculate subtotals, check for category presence, and determine order characteristics (e.g., high value, mixed categories).
    - PricingEngine: Contains the main logic for calculating the final price of an order. Applies discounts based on user status, order details, coupons, and category-specific rules. Handles security checks and ensures discounts and prices stay within safe bounds.
    - Program: The entry point. Creates test users, coupons, and orders, then runs a series of complex pricing scenarios using the above classes. Demonstrates how the pricing engine applies its logic in different situations.

    Each class models a real-world entity or process in an e-commerce pricing system, and they interact in the Program class to simulate and test pricing calculations. For example, User, Order, and Coupon instances are passed to PricingEngine.CalculateFinalPrice to compute and display the final price with all applicable discounts.

1. Locate the **PricingEngine** class, and then select the entire **CalculateFinalPrice** method.

    The CalculateFinalPrice method contains complex and deeply nested conditional logic that evaluates membership levels, seasonal events, corporate accounts, subscription services, and various discount scenarios.

1. Take a minute to scroll through the conditional logic in the **CalculateFinalPrice** method.

    The method is complex and difficult to read, with multiple nested conditionals that handle different discount scenarios. The complexity arises from the various business rules that need to be applied based on user status, order details, and coupon codes.

1. Right-click the selected code, and then select **Copilot** > **Explain**.

    GitHub Copilot will analyze the CalculateFinalPrice method and provide a detailed explanation of what the code does.

1. Take a few minutes to review GitHub Copilot's explanation.

    The explanation should highlight the main discount categories such as the hierarchical membership, coupon applications, bulk purchase incentives, and category-specific rules.

    For example:

    ```md
    The CalculateFinalPrice method is a comprehensive pricing engine for an e-commerce scenario. It starts by validating its inputs, ensuring that both the user and order objects are not null and that the order data is valid. This prevents null reference exceptions and guards against invalid or malicious input. The method then calculates the base total of the order and checks that it falls within a reasonable range, aborting the calculation if the total is suspiciously low or high.
    
    Next, the method initializes variables for the discount percentage, shipping cost, and a list to track all applied discounts. The core of the function is a series of nested conditional blocks that determine which discounts the user is eligible for. These are based on membership level (Premium, Gold, Silver), user attributes (such as being a student, employee, or first-time buyer), order characteristics (like high value, bulk purchase, or mixed categories), and special events (such as Black Friday or Back to School). Each eligible discount is added using the SafeAddDiscount helper, which ensures the total discount does not exceed a maximum cap and records a description of the discount.
    
    The method also handles coupon codes, applying either a percentage discount or free shipping, with additional enhancements for certain membership levels or order types. For example, Premium members may receive a boosted coupon value, and further stacking is possible during special events or for corporate accounts.
    
    After all discounts are considered, the method applies additional bulk purchase incentives if the order contains a large number of items. It then enforces a final cap on the total discount to prevent excessive reductions. The final price is calculated using ApplyCategorySpecificDiscounts, which applies category-based discount caps (e.g., electronics discounts are limited to 15%). The shipping cost is added, and the final price is ensured to be above a minimum threshold.
    
    Finally, the method outputs a summary of the calculation, including the base total, all applied discounts, the total discount percentage (with a note about category caps), the shipping cost, and the final price. This approach ensures transparency and traceability in how the final price is determined, while also enforcing business rules and security best practices.
    ```

    Taking the time to understand the existing code will help you recognize and select refactoring options later in this exercise.

1. In the Chat view, to get a deeper analysis of the calculation process, enter the following prompt:

    ```plaintext
    @workspace Explain the business logic flow in the CalculateFinalPrice method. What are the different discount paths and how do they interact with each other? What are the key business rules that govern pricing calculations?
    ```

    This analysis should help you understand how the different discount categories interact and what business rules are applied at each step of the pricing calculation.

1. Take a few minutes to review the explanation generated by GitHub Copilot.

    The response should identify the primary discount paths and how they interact with each other. For example:

    ```md
    The `CalculateFinalPrice` method in `ECommercePricing.PricingEngine` implements a layered, rule-driven approach to pricing calculation for an e-commerce order. Here’s how the business logic flows and how the discount paths interact:
    
    ### 1. **Input Validation**
    - The method first validates that both `user` and `order` are not null and that the order data is valid (e.g., no negative prices, all required fields present).
    - It checks that the order subtotal is within allowed bounds (greater than zero and less than $1,000,000).
    
    ### 2. **Base Discount Initialization**
    - The method initializes the discount percentage (`discountPercent`) to 0 and calculates the base shipping cost.
    
    ### 3. **Membership-Based Discount Paths**
    - The first major decision point is the user's membership level:
      - **Premium:** Starts with a 15% discount, then applies additional discounts for high-value orders, seasonal events, corporate accounts, subscriptions, loyalty (years as member), lifetime spending, and express shipping. Each condition is nested, so deeper benefits require all previous conditions to be met.
      - **Gold:** Starts with a 12% discount, then adds bonuses for seasonal events, bulk purchases, category diversity, employee status, pre-orders, and alternative payment methods. These are also nested, but less deeply than Premium.
      - **Silver:** Starts with 8%, with further bonuses for students, back-to-school events, bulk purchases, electronics focus, gift wrap, and express shipping. These are nested within the student path.
      - **First-Time Buyer:** If the user is a first-time buyer (and not a member), a 10% discount is applied, with further bonuses for seasonal events, order size, payment method, high-value orders, premium shipping regions, and express shipping.
    
    ### 4. **Coupon Application**
    - If a coupon is present:
      - **Valid Percent Coupon:** The coupon value is capped at 50%. Premium and Gold members get a multiplier (Premium: 1.3x up to 50%, Gold: 1.2x up to 40%). Additional stacking occurs for Premium members on Black Friday, corporate accounts, and bulk orders, with each step further capping the discount.
      - **Valid Shipping Coupon:** Shipping is set to zero for domestic orders or Premium members.
      - **Expired Coupon:** No discount is applied, and a message is logged.
    
    ### 5. **Bulk Purchase Incentives**
    - Additional discounts are applied for orders with 10+ items (5%) or 20+ items (8%).
    
    ### 6. **Discount Capping**
    - The total discount percentage is capped at 95% to prevent excessive reductions.
    
    ### 7. **Category-Specific Discount Rules**
    - The final discount is applied with category-specific caps:
      - **Electronics:** Discount capped at 15%.
      - **Clothing:** Discount capped at 20% (25% during Back-to-School).
      - **Accessories/Other:** Full discount applies.
    
    ### 8. **Final Price Calculation**
    - The final price is the sum of all discounted category subtotals plus shipping, with a minimum enforced price of $0.01.
    
    ### 9. **Result Output**
    - The method prints the base total, all applied discounts, the total discount percentage (with a note about the electronics cap), shipping cost, and the final price.
    
    ---
    
    ## **Discount Path Interactions**
    - **Nesting:** Many discounts are nested, meaning deeper discounts require all previous conditions to be true (e.g., Premium members with high-value orders, during Black Friday, who are also corporate accounts, etc.).
    - **Stacking:** Discounts from different sources (membership, coupons, bulk, etc.) are added together, but always subject to the overall cap.
    - **Category Caps:** Even if the total discount is high, certain categories (like electronics) have stricter caps, so the effective discount for those items may be lower than the overall discount.
    
    ---
    
    ## **Key Business Rules**
    - **Validation:** Orders and users must be valid; otherwise, pricing is aborted.
    - **Membership Drives Discounts:** Higher membership levels unlock deeper and more complex discount paths.
    - **Coupons Are Enhanced by Membership:** Premium and Gold members get more value from percent-off coupons.
    - **Bulk and Seasonal Bonuses:** Large orders and seasonal events can trigger additional discounts.
    - **Category Protection:** Electronics and clothing have maximum discount caps to protect margins.
    - **Shipping Can Be Discounted:** Shipping can be free with certain coupons or for Premium members.
    - **Discount Caps:** No combination of discounts can exceed 95% off the order.
    - **Transparency:** All applied discounts are tracked and displayed for auditability.
    
    For more details, see the full implementation in ECommercePricingDemo.cs, especially the `ECommercePricing.PricingEngine.CalculateFinalPrice` method.
    ```

1. Compare GitHub Copilot's explanation with your own observations of the complex conditional logic in the `CalculateFinalPrice` method.

    Your own observations probably identified the primary discount sources: membership levels, coupon codes, and bulk purchase incentives. GitHub Copilot's explanation should support your observations and provide additional insights into how these discount paths interact and the key business rules that govern the pricing calculations.

    - Notice how the different membership levels (Premium, Gold, Silver) apply discounts and how first-time buyers are treated.
    - Notice how coupons validation is evaluated and applied, and how coupon discounts interact with membership discounts.
    - Notice how volume-based discounts are applied based on item counts.

    Business rules are enforced through the nested conditionals, ensuring that discounts are applied correctly based on user status, order details, and coupon codes. These rules must move forward with the refactoring process.

1. Run the ECommercePricingEngine project and review the output.

    The output should show the base and discounted prices for various combinations of user, order, and coupon. At the end of this exercise, your refactored code must produce the same results as the original code.

    You may have noticed that the output includes basic security testing for invalid inputs and malicious attempts to manipulate pricing. Although these tests don't represent all possible attack vectors or the level of testing required in a production app, they serve as a reminder that ensuring code quality and security is a requirement. The **SecurityTest.cs** file is part of the ECommercePricingEngine project.

    > [!NOTE]
    > A copy of the output can be found in the **Output-ECommercePricingEngine.txt** file that's included in the ECommercePricingEngine folder. You can create your own output file if you want to compare results or if you modify sample data. When you reach the end of this exercise, you'll use the output file to ensure that your refactored code produces the same results as the original code.

    To run the project: If you have the ECommercePricingDemo.cs file open in the Visual Studio Code editor, you can run the project by selecting the run button (Run project associated with this file) that's located above the top-right corner of the editor pane. To run the project from the SOLUTION EXPLORER view, right-click **ECommercePricingEngine**, select **Debug**, and then select **Start New Instance**.

### Identify refactoring opportunities in the E-commerce pricing code using GitHub Copilot

GitHub Copilot is a great tool for analyzing complex code and identifying code refactoring opportunities.

In this task, you'll use GitHub Copilot to identify specific refactoring opportunities and suggest helper methods that simplify the complex conditions. You'll use observations from the previous task to help construct the prompts that you supply to GitHub Copilot.

Use the following steps to complete this task:

1. Ensure you have the GitHub Copilot Chat view open with **Ask** mode and the **GPT-4.1** model selected.

1. Add the **ECommercePricingDemo.cs** file to the Chat context using drag-and-drop operation.

    Although ECommercePricingDemo.cs is already open in the Visual Studio Code editor, adding it to the Chat context encourages GitHub Copilot to analyze the entire code file, which can result in more accurate suggestions. Adding relevant files to the Chat context is a best practice when using GitHub Copilot, even when you include the **@workspace** or **#codebase** tags in your prompt.

1. Submit a prompt that asks GitHub Copilot to identify refactoring opportunities that improve code modularity related to the main discount paths.

    Consider the following items when constructing your prompt:

    - Tell GitHub Copilot to focus on the **CalculateFinalPrice** method and its nested conditionals.
    - Ask GitHub Copilot to suggest options that move complex logic into more manageable, single-responsibility helper methods.
    - List the main discount paths that should be considered for extraction into helper methods.
    - Emphasize the importance of maintaining the business logic while simplifying the code structure.

    It's often beneficial to have GitHub Copilot consider code interactions when analyzing your code. You can use the **@workspace** or **#codebase** tag to tell GitHub Copilot to include your entire codebase in its analysis.

    For example:

    ```plaintext
    @workspace Analyze the CalculateFinalPrice method and suggest refactoring opportunities. Include options that move the nested conditional logic into more manageable, single-responsibility helper methods. Focus on the main discount paths: membership discounts, coupon discounts, and bulk discounts. Maintain the business logic while simplifying the code structure.
    ```

    GitHub Copilot will analyze the method and suggest specific refactoring opportunities, identifying patterns in the nested conditionals that can be extracted into helper methods.

1. Take a couple minutes to review GitHub Copilot's suggestions.

    The response should identify opportunities that improve code manageability and modularity, such as extracting the major discount paths into helper methods and one or more approaches to reducing nesting.

    For example:

    ```md
    Collecting workspace informationThe `ECommercePricing.PricingEngine.CalculateFinalPrice` method is functionally rich but contains deeply nested conditional logic, especially for membership, coupon, and bulk discounts. This makes the code harder to read, maintain, and test. Here are refactoring opportunities and suggestions:
    
    ## **Refactoring Opportunities**
    
    ### 1. **Extract Membership Discount Logic**
    Move the entire membership-based discount logic into a helper method, e.g., `ApplyMembershipDiscounts`. This method would encapsulate all the nested membership, event, and user-attribute checks, returning the updated discount and applied discounts.
    
    ### 2. **Extract Coupon Discount Logic**
    Move coupon handling into a method like `ApplyCouponDiscounts`. This would handle coupon validation, membership-based coupon boosts, and shipping coupon logic.
    
    ### 3. **Extract Bulk Discount Logic**
    Move the bulk purchase logic into a method such as `ApplyBulkDiscounts`.
    
    ### 4. **Reduce Nesting**
    Within each helper, use early returns or guard clauses where possible to reduce nesting.
    
    ### 5. **Encapsulate Discount State**
    Consider using a small struct or class (e.g., `DiscountContext`) to pass and update the discount percent and applied discounts list, reducing parameter clutter.
    ```

1. Submit a follow-up prompt that asks GitHub Copilot how to simplify complex conditional logic and reduce nesting levels in the CalculateFinalPrice method.

    Follow-up prompts are a great way to refine your analysis and get more specific suggestions from GitHub Copilot. In this case, you want additional information on reducing nesting levels, still within the context of complex conditionals in the CalculateFinalPrice method. You can also use follow-up prompts to ask for best practices or to understand the impact that suggested changes might have on the code.

    For example:

    ```plaintext
    How can I simplify the complex conditional logic and reduce nesting levels in the CalculateFinalPrice method? For example, the method has multiple nested conditionals that apply different membership discounts based on user status and order details. What are some best practices for reducing nesting levels and improving readability? Explain the benefit of each approach when applied to the CalculateFinalPrice method.
    ```

1. Take a minute to review GitHub Copilot's suggestions for simplifying the conditional logic and reducing nesting levels.

    GitHub Copilot should provide a list of suggestions for simplifying the conditional logic and reducing nesting levels. Some of the suggestions may be repeats of previous suggestions, that's to be expected. However, you should see new suggestions related to reducing nesting levels and improving readability, such as:

    - Use early returns or guard clauses to flatten logic, reduce indentation, and clarify flow.
    - Use local helper functions to remove duplication and clarify intent.
    - Use switch expressions or pattern matching to make membership logic explicit and maintainable.
    - Use smaller methods per membership to modularize logic and make it easier to test and update.
    - Use Boolean variables for conditions to improve readability of complex checks.

> [!NOTE]
> You'll use the results of your analysis to help construct the task assigned to GitHub Copilot Agent in the next section of the exercise.

### Refactor the E-commerce pricing code using GitHub Copilot Agent

GitHub Copilot has three modes, **Ask**, **Edit**, and **Agent**. When running in Agent mode, GitHub Copilot works as an autonomous AI agent.

In Agent mode:

- Your prompt specifies the task assigned to GitHub Copilot Agent.
- GitHub Copilot uses the task information and your codebase to identify the relevant code files and establish the context for the task.
- GitHub Copilot formulates a process that it can use to accomplish the task. The agent uses an iterative approach and code reviews to help ensure the task is completed successfully.
- GitHub Copilot uses the Chat view to keep you informed as it works on the assigned task. It may also provide explanations or justifications for the changes being made.
- GitHub Copilot can invoke tools to help it accomplish the task or to verify that code changes are working correctly.
- GitHub Copilot may pause during the task and ask you for assistance or clarification. It's important to monitor the chat and respond when prompted to assist the autonomous agent.
- GitHub Copilot updates your code file in the Visual Studio Code editor. Once the task is complete, you should review the changes made by GitHub Copilot before applying them to your codebase (individually or collectively).

In this section of the exercise, you'll use GitHub Copilot Agent to refactor the PricingEngine class and simplify the complex conditional logic in the CalculateFinalPrice method. The task that you assign to GitHub Copilot Agent will be based on the suggestions provided by GitHub Copilot during your code analysis (the previous task).

Use the following steps to complete this task:

1. Ensure that the GitHub Copilot Chat view is open in Visual Studio Code.

1. In the chat view, select the **Agent** mode.

    The **Set Mode** dropdown is located in the bottom-left corner of the Chat view. When you select **Agent**, GitHub Copilot will switch to Agent mode, which allows it to autonomously work on tasks that you assign.

1. Take a minute to identify the requirements for the task that you'll assign to GitHub Copilot Agent.

    You need to write a task that explains your goal and describes the steps that GitHub Copilot Agent can use to achieve that goal.

    In this case, your goal includes the following items:

    - Simplify the complex conditional logic and reduce nesting levels.
    - Improve code maintainability and readability.
    - Preserve existing functionality and ensure that the refactored code produces the same output as the original code.

    In the previous task, you asked GitHub Copilot to analyze the code and identify refactoring opportunities. You generated two sets of suggestions, one for extracting complex logic into helper methods to improve modularity and another for reducing nesting levels and improving code readability.

    The refactoring opportunities identified in the previous task may include:

    - Extract membership-level discount logic into a helper method.
    - Extract coupon validation and application logic into a helper method.
    - Extract volume-based discount logic into a helper method.
    - Use early returns or guard clauses to flatten logic, reduce indentation, and clarify flow.
    - Use local helper functions to remove duplication and clarify intent.
    - Use switch expressions or pattern matching to make membership logic explicit and maintainable.
    - Use smaller methods per membership to modularize logic and make it easier to test and update.
    - Use Boolean variables for conditions to improve readability of complex checks.

    The task that you create for GitHub Copilot Agent should combine your goal statement and the refactoring opportunities that you identified.

    The task should implement the following organizational structure:

    1. Goal statement: Explain the overall goal of the task.
    1. Code structure/modularity updates: Identify any large code sections that can be extracted to improve modularity.
    1. Small or detailed code improvements: Describe the specific approaches to reduce nesting levels and improve readability.
    1. Outcome: Describe the expected outcome of the refactoring process.

1. Construct a task that meets your requirements.

    Your task should include your goal and the suggested refactoring opportunities arranged using the suggested organizational structure.

    For example:

    ```plaintext
    I need to simplify the complex conditional logic and reduce nesting levels in the CalculateFinalPrice method. The main areas of complexity are associated with membership discounts, coupon processing, and bulk discounts. Each of these areas could be moved into separate helper methods that are called from CalculateFinalPrice. There are several options to reduce nesting levels in the helper methods. Use early returns or guard clauses to flatten logic, reduce indentation, and clarify flow. Use local helper functions to remove duplication and clarify intent. Use switch expressions or pattern matching to make membership logic explicit and maintainable. Use smaller methods per membership to modularize logic and make it easier to test and update. Use Boolean variables for conditions to improve readability of complex checks. The goal is to improve code maintainability and readability while preserving the existing functionality and generated output.
    ```

    This task uses natural language text to describe the goal, major restructuring opportunities, and specific approaches to reduce nesting levels and improve readability. The task also describes the expected outcome of the refactoring process.

1. Use the Chat view to assign your task to GitHub Copilot Agent.

    GitHub Copilot Agent will evaluate the task and the codebase to develop an approach for refactoring CalculateFinalPrice and extracting the membership discount logic into a new helper method. The agent will test the code updates at various stages to ensure that the refactoring is successful and that the business logic remains intact.

    After submitting the task, GitHub Copilot Agent will start working on the task. You can monitor its progress in the Chat view.

    > [!NOTE]
    > If you need to make changes to the task, you can edit the text in the Chat view and resubmit it. GitHub Copilot Agent will re-evaluate the task and continue working on it.

1. Monitor the Chat view as GitHub Copilot Agent works on the task.

    The agent will provide updates on its progress, including any challenges it encounters and how it plans to address them. It may also ask for clarification or additional information if needed. If necessary, provide assistance by responding to the agent's prompts in the Chat view.

1. Once the refactoring task is complete, review the suggested updates in the Visual Studio Code editor.

    Always review the changes suggested by GitHub Copilot before accepting them. Verify that the updates align with your intended business logic, app functionality, and coding standards.

    The refactored code should include a greatly simplified **CalculateFinalPrice** method that primarily consists of method calls to helper methods that manage membership discounts, coupon discounts, and bulk discounts. The complexity of the original method should be significantly reduced, making it easier to read and maintain.

    The membership discounts helper method should also be refactored to handle the complex logic around membership levels, with an additional helper method for each level (Premium, Gold, Silver, and first-time buyers).

1. In the Chat view, to accept all edits, select **Keep**.

    You can reject the suggested changes if they don't meet your expectations, or you can accept a subset of the changes and reject others. Working with GitHub Copilot to refactor your code is often an iterative process that includes refining your prompts to achieve the intended results.

    If you accept GitHub Copilot's suggested updates, and then realize that the suggestions introduced issues that may be difficult to resolve moving forward, you can revert the changes by selecting **Undo Last Request** in the Chat view, or by using Visual Studio Code's undo functionality.

1. Ask GitHub Copilot to explain the code refactoring updates that it implemented.

    For example:

    ```plaintext
    Explain the refactoring updates that you implemented to simplify the complex conditional logic, reduce nesting levels, and improve code maintainability and readability.
    ```

    GitHub Copilot will provide an explanation of the changes it made, including how the complex conditional logic was simplified and how the code structure was improved.

    For example:

    ```md
    Here’s an explanation of the refactoring updates made to simplify the complex conditional logic, reduce nesting, and improve maintainability and readability in the `CalculateFinalPrice` method:
    
    ### 1. **Separation of Concerns with Helper Methods**
    - The main discount logic was split into three focused helper methods: `ApplyMembershipDiscounts`, `ApplyCouponDiscounts`, and `ApplyBulkDiscounts`.
    - Each helper method is responsible for a single aspect of the discount calculation, making the main method concise and easy to follow.
    
    ### 2. **Flattened Membership Discount Logic**
    - The deeply nested membership discount logic was moved into `ApplyMembershipDiscounts`, which uses a `switch` statement to dispatch to smaller, membership-specific methods (`ApplyPremiumDiscounts`, `ApplyGoldDiscounts`, `ApplySilverDiscounts`, `ApplyFirstTimeBuyerDiscounts`).
    - Each of these methods uses guard clauses (early returns) and Boolean variables to flatten the logic, reducing indentation and clarifying the flow.
    
    ### 3. **Guard Clauses and Early Returns**
    - Instead of multiple nested `if` statements, each helper method uses guard clauses to exit early when a condition is not met. This keeps the main logic path at the top level and reduces cognitive load.
    
    ### 4. **Switch Expressions and Pattern Matching**
    - The use of `switch` in `ApplyMembershipDiscounts` makes the membership logic explicit and easy to extend or modify.
    - This approach also makes it clear which logic applies to which membership type.
    
    ### 5. **Boolean Variables for Readability**
    - Boolean variables (e.g., `altPayment`, `premiumPayment`) are used to clarify complex conditions, making the code more self-documenting and easier to read.
    
    ### 6. **Local Helper Methods for Duplication and Intent**
    - Smaller, focused methods encapsulate repeated or complex logic, such as safe discount addition and category percentage calculation.
    - This reduces code duplication and clarifies the intent of each operation.
    
    ### 7. **Preserved Business Logic and Output**
    - All business rules, discount caps, and output formatting are preserved, ensuring that the refactoring does not change the program’s behavior.
    
    ## **Benefits**
    - **Readability:** The main method is now a clear sequence of high-level steps.
    - **Maintainability:** Each discount rule is isolated, making it easier to update or test.
    - **Extensibility:** Adding or modifying discount rules is straightforward.
    - **Testability:** Each helper method can be unit tested independently.
    
    This refactoring transforms a complex, deeply nested method into a modular, maintainable, and readable pricing engine, while preserving all business requirements and output.
    ```

1. Take a minute to review the refactored code in the PricingEngine class.

1. Submit a follow-up prompt that asks GitHub Copilot to explain specific parts of the refactored code or to compare the original and refactored versions.

    For example:

    ```plaintext
    Compare the original PricingEngine class with the new refactored version of the PricingEngine class. Explain the relationship between methods in the two versions. Explain the implementation of business rules in the two versions.
    ```

### Test the refactored E-commerce pricing code

Testing is crucial to ensure that your refactoring doesn't change the business logic behavior. You'll run the code with various scenarios to verify that the calculations remain consistent.

Use the following steps to complete this task:

1. Build the project to ensure there are no compilation errors.

    For example, in the SOLUTION EXPLORER view, right-click **ECommercePricingEngine**, and then select **Build**.

    If there are any compilation errors, review the refactored code and fix any issues. GitHub Copilot can help resolve compilation errors if needed.

1. Run the application to test the refactored pricing logic.

    If you have the ECommercePricingDemo.cs file open in the Visual Studio Code editor, you can run the project by selecting the run button (Run project associated with this file) that's located above the top-right corner of the editor pane. To run the project from the SOLUTION EXPLORER view, right-click **ECommercePricingEngine**, select **Debug**, and then select **Start New Instance**.

    The application should execute without errors and display pricing calculations for various test scenarios.

    > [!IMPORTANT]
    > If the refactored code encounters a runtime error, review the changes made by GitHub Copilot Agent and resolve the issues using GitHub Copilot. If necessary, you can use the **Undo Last Request** option in the Chat view to revert the last set of changes and then update the task assigned to GitHub Copilot Agent. Iterating your prompts/tasks to refine the results is standard practice when working with AI-enabled tools.

1. Ask GitHub Copilot to compare the output generated by the refactored code with the original output.

    The original output, **Output-ECommercePricingEngine.txt**, is included in the ECommercePricingEngine folder.

    You can create a second output file and ask GitHub Copilot to identify any differences between the two files.

    The output should be identical, confirming that the business logic remains unchanged while improving code maintainability and readability.

### (OPTIONAL) Simplify complex conditionals in the LoanApprovalWorkflow demo app

If time permits, simplify complex conditionals in the LoanApprovalWorkflow demo app using the same process that you used to simplify pricing logic in the Loan Approval Workflow sample app.

In this optional task, you'll apply the same techniques you used in the E-commerce pricing engine to refactor the complex conditional logic in the Loan Approval Workflow demo app. You'll analyze the loan approval code, identify refactoring opportunities, and then use GitHub Copilot Agent to extract complex conditionals into smaller, focused helper methods.

> [!IMPORTANT]
> The instructions for this task include the high-level process steps, but they don't include suggested prompts or detailed explanations. You can refer to the previous tasks in this exercise for examples of how to construct prompts and use GitHub Copilot effectively.

Use the following steps to complete this task:

1. Expand the **LoanApprovalWorkflow** project folder, open the **LoanApprovalDemo.cs** file, and then review the code.

1. Use GitHub Copilot to explain the **LoanApprovalDemo.cs** code, including the complex conditional logic in the Evaluate method of the LoanEvaluator class.

1. Run the LoanApprovalWorkflow project to test the initial loan approval logic and create a record of the output.

1. Use GitHub Copilot to identify code refactoring opportunities that simplify complex conditionals, reduce nesting levels, and improve readability and maintainability in the LoanEvaluator class.

1. Assign a task to GitHub Copilot Agent that simplifies complex conditional logic, reduces nesting levels, and improves readability and maintainability in the LoanEvaluator class (refactor the Evaluate method).

    For example, you could ask GitHub Copilot Agent to create helper methods for credit score evaluation, income and employment verification, financial ratio calculations, government program eligibility, and loan terms determination.

1. Use GitHub Copilot Agent to simplify complex conditional logic and reduce nesting levels in the helper methods.

1. Test your refactored code and ensure that the loan approval demo application produces the same results as the original implementation.

## Summary

In this exercise, you learned how to use GitHub Copilot to simplify complex conditional logic in a codebase. You explored the E-commerce pricing engine and Loan Approval Workflow demo apps, identified refactoring opportunities, and used GitHub Copilot Agent to extract complex conditionals into smaller, focused helper methods. You also learned how to reduce nesting levels in the code to improve readability while maintaining the same business logic.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. If you made any changes, revert them as needed. If you're using a local PC as your lab environment, you can archive or delete the sample projects folder that you created for this exercise.
