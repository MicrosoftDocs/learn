> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you use GitHub Copilot to analyze and resolve issues in an e-commerce app. Tasks include:

- Import the ContosoShopEasy repository.
- Review the issues in GitHub.
- Clone the repository locally and review the codebase.
- Analyze issues using GitHub Copilot's Ask mode.
- Resolve issues using GitHub Copilot's Agent mode.
- Test and verify the refactored code.
- Commit changes and close issues.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.





**TODO:** Replace the URL in the button link below with the correct link to the exercise instructions page.



[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2339108&azure-portal=true)



---



# Resolve GitHub issues using GitHub Copilot

GitHub issues are a powerful way to track bugs, enhancements, and tasks for a project.

In this exercise, you use GitHub Copilot to help you analyze and resolve GitHub issues that relate to security vulnerabilities in an e-commerce application.

This exercise should take approximately **40** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment must include the following: Git 2.48 or later, .NET SDK 9.0 or later, Visual Studio Code with the C# Dev Kit extension, and access to a GitHub account with GitHub Copilot enabled.

If you're using a local PC as a lab environment for this exercise:

- For help with configuring your local PC as your lab environment, open the following link in a browser: <a href="https://go.microsoft.com/fwlink/?linkid=2320147" target="_blank">Configure your lab environment resources</a>.

- For help with enabling your GitHub Copilot subscription in Visual Studio Code, open the following link in a browser: <a href="https://go.microsoft.com/fwlink/?linkid=2320158" target="_blank">Enable GitHub Copilot within Visual Studio Code</a>.

If you're using a hosted lab environment for this exercise:

- For help with enabling your GitHub Copilot subscription in Visual Studio Code, paste the following URL into a browser's site navigation bar: <a href="https://go.microsoft.com/fwlink/?linkid=2320158" target="_blank">Enable GitHub Copilot within Visual Studio Code</a>.

- To ensure that the .NET SDK is configured to use the official NuGet.org repository as a source for downloading and restoring packages:

    Open a command terminal and then run the following command:

    ```bash

    dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

    ```

- To ensure that Git is configured to use your name and email address:

    Update the following commands with your information, and then run the commands:

    ```bash

    git config --global user.name "Julie Miller"

    ```

    ```bash

    git config --global user.email julie.miller@example.com

    ```

## Exercise scenario

You're a software developer working for a consulting firm. Your clients need help with resolving issues in their GitHub repositories. You need to ensure that all issues are addressed and closed. You use Visual Studio Code as your development environment and GitHub Copilot to assist with development tasks. You're assigned to the following app:

- ContosoShopEasy: ContosoShopEasy is an e-commerce application that contains multiple security vulnerabilities. The vulnerabilities represent common security issues found in real-world applications.

This exercise includes the following tasks:

1. Import the ContosoShopEasy repository.
1. Review the issues in GitHub.
1. Clone the repository locally and review the codebase.
1. Analyze issues using GitHub Copilot's Ask mode.
1. Resolve issues using GitHub Copilot's Agent mode.
1. Test and verify the refactored code.
1. Commit changes and close issues.

### Import the ContosoShopEasy repository

GitHub Importer allows you to create a copy of an existing repository in your own GitHub account, giving you full control over the imported copy. Although GitHub Importer doesn't migrate Issues, PRs, or Discussions, it does import GitHub Actions workflows. The repository that you import includes a GitHub Actions workflow that creates issues associated with the codebase.

In this task, you import the ContosoShopEasy repository and run a workflow to create GitHub issues for the security vulnerabilities included in the codebase.

Use the following steps to complete this task:

1. Open a browser window and navigate to GitHub.com.

1. Sign in to your GitHub account, and then open your repositories tab.

    You can open your repositories tab by clicking on your profile icon in the top-right corner, then selecting **Repositories**.

1. On the Repositories tab, select the **New** button.

1. Under the **Create a new repository** section, select **Import a repository**.

    The **Import your project to GitHub** page appears.

1. On the Import your project to GitHub page, under **Your source repository details**, enter the following URL for the source repository:

    ```plaintext
    https://github.com/MicrosoftLearning/resolve-github-issues-lab-project
    ```

1. Under the **Your new repository details** section, in the **Owner** dropdown, select your GitHub username.

1. In the **Repository name** field, enter **ResolveGitHubIssues** and then select **Begin import**.

    GitHub creates the new repository in your account with the ContosoShopEasy project files.

1. Wait for the import process to complete, and then open your new repository.

    > **NOTE**: It can take a minute or two to import the repository.

1. Open the Actions tab of your repository.

1. On the left side of the page under **All workflows**, select the **Create ContosoShopEasy Training Issues** workflow, and then select **Run workflow**.

1. In the workflow dialog that appears, type **CREATE** and then select **Run workflow**.

1. Monitor the onscreen progress of the workflow.

    After a moment, the page will refresh and display a progress bar. The workflow should complete successfully in less than a minute.

1. Ensure that the workflow completes successfully before proceeding.

    A checkmark inside a green circle indicates that the workflow ran successfully (should appear on the left of the workflow name).

    If an X inside a red circle appears to the left of the workflow name, it means that the workflow failed. If the workflow fails to run successfully, ensure that you selected your account when you imported the repository and that your account has read and write permissions. You can use GitHub's **Chat with Copilot** feature to help diagnose the issue.

### Review the issues in GitHub

GitHub issues serve as a centralized tracking system for bugs, security vulnerabilities, and enhancement requests. Each issue provides context about the problem, its severity, and potential impact on the application. Understanding these issues before diving into the code helps establish priorities and ensures comprehensive remediation.

In this task, you review the GitHub issues and examine the security vulnerabilities that need to be addressed.

Use the following steps to complete this task:

1. Select the **Issues** tab of your repository, and then take a minute to review the Issues page.

    You should see 10 issues open listed. Notice the following:

    - All of the issues are labeled as bugs.
    - All of the issues have a priority level.
    - None of the issues are assigned to anyone.

1. To display only the critical issues, select the **Labels** dropdown, and then select the **critical** label.

    The issues list should update to show only the critical issues.

    - **🔐 Remove Hardcoded Admin Credentials**  

    - **🔐 Fix Credit Card Data Storage Violations**  

1. To display only the high-priority issues, select the **Labels** dropdown, deselect **critical**, and then select the **high-priority** label.

    The issues list should update to show only the high-priority issues.

    - **🔐 Fix Input Validation Security Bypass**  

    - **🔐 Remove Sensitive Data from Debug Logging**  

    - **🔐 Replace MD5 Password Hashing with Secure Alternative**  

    - **🔐 Fix SQL Injection Vulnerability in Product Search**  

1. Select the **Fix SQL Injection Vulnerability in Product Search** issue.

1. Take a minute to review the issue details.

    Issue details should describe the problem and the expected fix.

    > **NOTE**: The process used to document issues, including manual versus AI-automated processes, can affect the overall quality and accuracy of the issue descriptions. The issues included in this training were written using GitHub Copilot's Agent mode after the agent reviewed the codebase. GitHub Copilot can be used to generate highly detailed descriptions of the vulnerabilities, code locations, examples of the vulnerable code, security risks, and acceptance criteria for fixes.

1. Notice that no one is assigned to the issue.

1. Navigate back to the Issues tab and clear the filters.

1. Select the following critical and high-priority issues, and then use the **Assign** dropdown to assign them to yourself.

    - **🔐 Fix Credit Card Data Storage Violations**  

    - **🔐 Fix SQL Injection Vulnerability in Product Search**  

    It's generally best to work on the higher priority issues first. Assigning issues to yourself helps you track your progress as you work through the remediation process.

### Clone the repository locally and review the codebase

The ContosoShopEasy application follows a layered architecture typical of enterprise applications, with clear separation between models, services, data access, and security components.

Taking the time to understand the basic structure, behavior, and features of an existing codebase is an important first step when resolving security issues.

In this task, you create a local clone of your repository, examine the project structure in Visual Studio Code, review the application's console output, and identify security vulnerabilities within the codebase.

Use the following steps to complete this task:

1. Navigate back to the root page of your repository (Code tab).

1. Clone the ResolveGitHubIssues repository to your local development environment.

    For example, you can use the following steps to clone the repository using Git CLI:

    1. Copy the repository URL by selecting the **Code** button and then copying the HTTPS URL.

    1. Open a terminal window, navigate to the directory where you want to clone the repository, and then run a "git clone" command that uses the repository URL.

        For example, open Windows PowerShell, navigate to C:\TrainingProjects, and then run the following command (replacing **your-username** with your GitHub username):

        ```bash
        git clone https://github.com/your-username/ResolveGitHubIssues.git
        ```

1. Open the cloned repository in Visual Studio Code.

    Ensure that you're using the latest version of Visual Studio Code and that you have the GitHub Copilot and GitHub Copilot Chat extensions installed and enabled.

1. Examine the project structure in the EXPLORER view.

    The ContosoShopEasy application follows a layered architecture with the following components:

    - **Data/**: Contains data repositories in **OrderRepository.cs**, **ProductRepository.cs**, and **UserRepository.cs**.

    - **Models/**: Contains data models for **Category.cs**, **Order.cs**, **Product.cs**, and **User.cs**.

    - **Security/**: Contains security validation logic in **SecurityValidator.cs**

    - **Services/**: Contains business logic in **OrderService.cs**, **PaymentService.cs**, **ProductService.cs**, and **UserService.cs**.

    - **Program.cs**: Main application entry point with dependency injection setup

    - **README.md**: Documentation explaining the application's purpose and vulnerabilities

1. To observe the application's current behavior, build and run the application.

    For example, you can open Visual Studio Code's integrated terminal window and run the following commands:

    ```bash
    cd ContosoShopEasy
    dotnet build
    dotnet run
    ```

    The application runs an e-commerce workflow simulation that exposes security vulnerabilities through detailed console logging.

1. Take a minute to review the console output.

    The ContosoShopEasy application uses intentionally excessive logging as an educational tool. In addition to exposing security issues in the codebase, some of the logs actually create the issues. Including logs that create security issues demonstrates actual over-logging problems found in some production systems. Logging in the ContosoShopEasy application is used to help developers distinguish between two types of issues:

    - Issues created by logging: Approximately 40% of the vulnerabilities in the ContosoShopEasy application are caused by over-logging. For example, password exposure, credit card number disclosure, session token exposure, and configuration information disclosure.

    - Issues that exist independently of logging: Approximately 60% of the vulnerabilities in the ContosoShopEasy application exist independently of logging. For example, SQL injection, weak password hashing, hardcoded credentials, predictable tokens, input validation bypass, credit card storage, and weak email validation. Although logging doesn't create these vulnerabilities, logging does help to expose the issues within the training environment.

1. To begin your review of security vulnerabilities in the codebase, expand the **Models** folder, and then open the **Order.cs** file.

1. Scroll down to find the **PaymentInfo** class.

    Notice the comments regarding the CardNumber and CVV properties. This code is related to the **Fix Credit Card Data Storage Violations** issue that you assigned to yourself.

1. Expand the **Security** folder and then open the **SecurityValidator.cs** file.

    Notice that the ContosoShopEasy application uses code comments, logic, and logging to expose security issues. Although the implementation is contrived, this approach helps to highlight vulnerabilities that are common in real-world applications.

    > **NOTE**: The SecurityValidator.cs class is designed to centralize security-related logic for the ContosoShopEasy application, making it easier to locate, manage, and resolve security issues. In a real-world application, a class like SecurityValidator could be used to enforce security best practices and input validation. However, the specific implementation in ContosoShopEasy is intentionally insecure and contrived to expose vulnerabilities.

1. Take a minute to find the following security issues:

    - Near the top of the file, notice the comment related to the admin credential constants (lines 7-9). This code is related to the "Remove Hardcoded Admin Credentials" issue.

    - Locate the ValidateInput method and review the comments describing security vulnerabilities. This code is related to the "Fix Input Validation Security Bypass" issue.

    - Locate the ValidateEmail method and review the comments describing security vulnerabilities. This code is related to the "Improve Email Validation Security" issue.

    - Locate the ValidatePasswordStrength method and review the comments describing security vulnerabilities. This code is related to the "Strengthen Password Security Requirements" issue.

    - Locate the ValidateCreditCard method and review the comments describing security vulnerabilities. This code is related to the **Fix Credit Card Data Storage Violations** issue that you assigned to yourself.

    - Locate the GenerateSessionToken method and review the comments describing security vulnerabilities. This code is related to the "Fix Predictable Session Token Generation" issue.

    - Locate the RunSecurityAudit method and review the comments describing security vulnerabilities. This code is related to the "Reduce Information Disclosure in Error Messages (Console Output)" issue.

    Several of the methods in the SecurityValidator.cs file are also related to the "Remove Sensitive Data from Debug Logging" issue.

    The issues exposed by the SecurityValidator class are commonly found distributed among the classes of real-world applications, especially legacy or poorly maintained codebases.

1. Expand the **Services** folder and then open the **UserService.cs** file.

1. Take a minute to find the following security issues:

    - Locate the RegisterUser, LoginUser, and ValidateUserInput methods and review the comments describing security vulnerabilities. This code is related to the "Remove Sensitive Data from Debug Logging" issue.

    - Locate the GetMd5Hash method and review the comments describing security vulnerabilities. This code is related to the "Replace MD5 Password Hashing with Secure Alternative" issue.

1. Open the **PaymentService.cs** file.

1. Take a minute to review the comments in the payment and validation methods.

    The security vulnerabilities in this code are related to the **Fix Credit Card Data Storage Violations** issue that you assigned to yourself.

    The PaymentService class is also related to other issues. For example, the "Remove Sensitive Data from Debug Logging" and "Reduce Information Disclosure in Error Messages (Console Output )" issues.

    Notice that the PaymentService class uses OrderRepository to persist payment-related order data. If the OrderRepository class doesn't handle sensitive data properly, it could lead to data exposure vulnerabilities in the OrderRepository class.

1. Open the **ProductService.cs** file.

1. Take a minute to review the SearchProducts method.

    The security vulnerabilities in this code are related to the **Fix SQL Injection Vulnerability in Product Search** issue that you assigned to yourself.

    Notice that the SearchProducts method in ProductService calls the SearchProducts method in ProductRepository. You might want to analyze the repository method to determine whether it requires security improvements as well.

1. Make a list of the code files related to the issues assigned to you.

    The issues that you assigned to yourself are:

    - **🔐 Fix Credit Card Data Storage Violations**
    - **🔐 Fix SQL Injection Vulnerability in Product Search**

    The code files related to the "Fix Credit Card Data Storage Violations" issue are:

    - Models/Orders.cs/PaymentInfo class
    - Security/SecurityValidator.cs/ValidateCreditCard method
    - Data/OrderRepository.cs

    The code files related to the "Fix SQL Injection Vulnerability in Product Search" issue are:

    - Services/ProductService.cs/SearchProducts method
    - Data/ProductRepository.cs/SearchProducts method

### Analyze issues using GitHub Copilot's Ask mode

GitHub issues often contain complex problems that require careful analysis before implementing fixes. Understanding the root causes, potential impacts, and best remediation strategies is crucial for effective resolution.

The following GitHub extensions for Visual Studio Code can help you analyze GitHub issues:

- **GitHub Copilot Chat**: GitHub Copilot's Ask mode provides intelligent code analysis capabilities that can help identify security vulnerabilities, understand their potential impact, and suggest remediation strategies.

- **GitHub Pull Requests**: The GitHub Pull Requests extension integrates GitHub issues directly into Visual Studio Code, allowing you to manage and interact with issues without leaving your development environment.

By systematically analyzing security issues, you can develop a comprehensive understanding of the problems before implementing fixes. This approach ensures that solutions address root causes rather than just symptoms.

In this task, you use GitHub Copilot's Ask mode to analyze the GitHub issues assigned to you.

Use the following steps to complete this task:

1. Ensure that the GitHub Copilot Chat and GitHub Pull Requests extensions are installed in Visual Studio Code.

    Open the Extensions view in Visual Studio Code and review your installed extensions. If either extension is missing, install it before proceeding.

    For example, you can use the following steps to install the GitHub Pull Requests extension:

    1. Open the Extensions view in Visual Studio Code.

    1. In the Extensions view, search for **GitHub Pull Requests**.

    1. Select **GitHub Pull Requests** from the search results, and then install the extension.

        After the installation is complete, you may need to reload Visual Studio Code for the changes to take effect. A **GitHub** icon should be added to Visual Studio Code's Activity Bar.

1. To open the GitHub Pull Requests view, select the **GitHub** icon from the Activity Bar.

    If prompted, sign in to your GitHub account to connect Visual Studio Code to your GitHub repositories.

1. Notice that the GitHub view includes two sections, **Pull Requests** and **Issues**.

    The **Issues** section allows you to view and manage issues from your GitHub repositories directly within Visual Studio Code. The **Pull Requests** section allows you to manage pull requests.

1. Collapse the **Pull Requests** section.

1. Take a minute to review the **Issues** section.

    Notice that the issues you assigned to yourself are listed under the My Issues section (no milestones were defined). If you expand the **Recent Issues** section, you can see all of the issues that were added to the repository.

1. Under the My Issues section, select **Fix SQL Injection Vulnerability in Product Search**.

    The GitHub Pull Requests extension opens the issue details in a new editor tab. You can review the issue description, comments, and any related information in this tab. You can use issue details to help construct the prompts that you submit to GitHub Copilot in the Chat view.

1. Open GitHub Copilot's Chat view and ensure that the **Ask** mode is selected.

    If the Chat view isn't already open, select the **Chat** icon at the top of the Visual Studio Code window. Verify that the chat mode is set to **Ask** and that you're using the **GPT-4.1** model.

    > **NOTE**: The GPT-4.1 model provides excellent code analysis capabilities and is included with the GitHub Copilot Free plan. Choosing a different model may yield different results.

1. Ensure that you're starting with a clean chat session.

    Chat sessions help to organize your interactions with GitHub Copilot. Each session maintains its own context, allowing you to focus on specific tasks or issues. The conversation history within a session provides continuity, enabling GitHub Copilot to build on previous interactions for more accurate and relevant responses. This chat conversation will focus on analyzing and resolving the two security vulnerabilities assigned to you in the ContosoShopEasy application. After you complete your analysis of the GitHub issues using GitHub Copilot's Ask mode, you can use the same conversation to help implement code changes using GitHub Copilot's Agent mode. GitHub Copilot can use the detailed analysis from the Ask mode to inform its code generation in the Agent mode, ensuring that the fixes align with the identified vulnerabilities and recommended remediation strategies.

    If needed, you can start a new chat session by selecting the **New Chat** button (the **+** icon at the top of the Chat panel).

#### Analyze SQL Injection Vulnerability

The SQL injection vulnerability exists in the ProductService.cs file and potentially in the ProductRepository.cs file. You'll analyze both files to understand the full scope of the vulnerability.

Use the following steps to analyze the SQL injection vulnerability:

1. Open the **ProductService.cs** file, and then locate the **SearchProducts** method.

1. In the code editor, select the entire **SearchProducts** method.

    Selecting code in the editor helps to focus the Chat context. GitHub Copilot uses the selected code to provide relevant analysis and recommendations.

1. Ask GitHub Copilot to analyze the code for SQL injection vulnerability.

    For example, you can submit the following prompt:

    ```text
    Analyze the SearchProducts method for SQL injection vulnerabilities. Consider the following issue description: "The product search functionality is vulnerable to SQL injection attacks. User input is directly concatenated into SQL queries without proper parameterization or sanitization." Explain the impact of directly concatenating user input into SQL queries without proper parameterization or sanitization. What are the potential consequences if an attacker exploits this vulnerability?
    ```

1. Review GitHub Copilot's analysis.

    GitHub Copilot should identify that the method constructs SQL queries using user input without proper sanitization. The simulated SQL query demonstrates how user input is directly concatenated into the query string, which could allow attackers to manipulate the database query.

1. Ask for specific remediation guidance.

    For example, after reviewing the initial analysis, you can submit the following prompt:

    ```text
    How can I modify this method to prevent SQL injection attacks? What secure coding practices should I implement to safely handle user input in database queries? Where should user input be validated and sanitized? What techniques can I use to construct SQL queries safely?
    ```

1. Take a minute to review GitHub Copilot's remediation suggestions.

    You should see recommendations for using parameterized queries or ORM methods that help to manage SQL injection risks. You might also see suggestions for input validation and sanitization techniques. GitHub Copilot often provides code snippets that demonstrate how to implement suggestions.

1. Open the **ProductRepository.cs** file in the **Data** folder, and then locate the **SearchProducts** method.

    During your code review, you noted that the SearchProducts method in ProductRepository is called by the SearchProducts method in ProductService. You can analyze the repository method to determine if it requires security improvements as well.

1. In the code editor, select the entire **SearchProducts** method, and then ask GitHub Copilot to analyze the code for SQL injection vulnerability.

    For example, you can submit the following prompt:

    ```text
    Analyze the SearchProducts method in ProductRepository. Does this method properly handle the search term to prevent SQL injection, or are there vulnerabilities here as well? How does this method relate to the vulnerability in ProductService?
    ```

1. Review GitHub Copilot's analysis of the repository method.

    GitHub Copilot should note that while the repository method uses safe string operations (ToLower and Contains), the primary vulnerability is in the ProductService layer where the simulated SQL query is constructed with user input. The repository implementation itself is relatively safe, but the service layer exposes the vulnerability through improper SQL query construction.

1. Close the ProductRepository.cs file.

1. Ask GitHub Copilot to propose a comprehensive remediation strategy for the SQL injection vulnerability that includes input validation and sanitization techniques.

    For example, you can submit the following prompt:

    ```text
    #codebase I need to resolve SQL injection vulnerabilities associated with the SearchProducts method in the ProductService.cs file. Notice that user input is directly concatenated into SQL queries without proper parameterization or sanitization. The updated codebase should use parameterized queries or prepared statements, implement proper input validation and sanitization, remove debug logging of SQL queries, and add input length restrictions. My acceptance criteria includes: User input is properly parameterized; No raw SQL construction with user input; Input validation prevents malicious characters; Debug logging removed or sanitized. Review the codebase and identify the code files that must be updated to address the SQL injection vulnerability. Based on your code review and the current Chat conversation, suggest a phased approach to required file updates.
    ```

1. Document the analysis results for reference during the remediation phase.

    Take notes on GitHub Copilot's recommendations for both vulnerability categories. This documentation will guide your implementation of security fixes in the next task.

#### Analyze Credit Card Data Storage Violations

The credit card data storage vulnerability exists in multiple files: the Order.cs model, the PaymentService.cs service, the SecurityValidator.cs validator, and potentially the OrderRepository.cs data layer. You'll analyze these files to understand the full scope of the vulnerability.

Use the following steps to analyze the credit card data storage violations:

1. Under the **Models** folder, open the **Order.cs** file, and then locate the **PaymentInfo** class.

1. In the code editor, select the **CardNumber** and **CVV** properties within the **PaymentInfo** class.

    Notice the comments indicating these properties are security vulnerabilities. Storing full card numbers and CVV codes violates PCI DSS compliance requirements.

1. Ask GitHub Copilot to analyze the credit card data storage violations.

    For example, you can submit the following prompt:

    ```text
    Why is storing full credit card numbers and CVV codes in the PaymentInfo class a PCI DSS compliance violation? What are the proper ways to handle payment card data securely?
    ```

1. Review GitHub Copilot's analysis.

    GitHub Copilot should explain that PCI DSS requirements prohibit storing sensitive authentication data after authorization, including CVV codes. It should also explain that full card numbers should be tokenized or masked.

1. Ask for specific remediation guidance.

    For example, you can submit the following prompt:

    ```text
    How should I modify the PaymentInfo class to comply with PCI DSS requirements? What properties should I add or change to store payment information securely?
    ```

1. Take a minute to review GitHub Copilot's remediation suggestions.

    You should see recommendations for removing the CVV property entirely, replacing the CardNumber with a masked version or token, storing only the last 4 digits, and adding a card type property for display purposes.

1. Open the **PaymentService.cs** file, and then locate the **ProcessPayment** method.

1. In the code editor, select the entire **ProcessPayment** method.

    Notice that the method creates a PaymentInfo object and stores the full card number and CVV. This method also logs sensitive payment information.

1. Ask GitHub Copilot to analyze the ProcessPayment method for credit card data storage issues.

    For example, you can submit the following prompt:

    ```text
    What security vulnerabilities exist in the ProcessPayment method related to credit card data storage and logging? How does this method contribute to the PCI DSS violations?
    ```

1. Review GitHub Copilot's analysis.

    GitHub Copilot should identify multiple issues: logging full card numbers and CVV codes, storing these values in the PaymentInfo object, and exposing sensitive data throughout the processing flow.

1. Ask for specific remediation guidance for the ProcessPayment method.

    For example, you can submit the following prompt:

    ```text
    How should I modify the ProcessPayment method to handle credit card data securely? What changes are needed to prevent storing and logging sensitive card information?
    ```

1. Open the **SecurityValidator.cs** file, locate the **ValidateCreditCard** method.

1. In the code editor, select the entire **ValidateCreditCard** method.

    Notice that this method logs the full credit card number, which is a security vulnerability.

1. Ask GitHub Copilot to analyze the ValidateCreditCard method.

    For example, you can submit the following prompt:

    ```text
    What security issues exist in the ValidateCreditCard method? How should credit card validation be performed without logging sensitive data?
    ```

1. Review GitHub Copilot's analysis and remediation suggestions.

    GitHub Copilot should generate a list of security issues and some recommendations for secure coding practices. The recommendations may include removing or masking the credit card number in log statements, using algorithms validate card numbers, and improving card number length and format validation.

1. Open the **OrderRepository.cs** file in the **Data** folder.

1. Review the file to determine if it handles PaymentInfo objects.

    Notice that the OrderRepository class stores Order objects, which include PaymentInfo. If the PaymentInfo class stores full card numbers and CVV codes, the repository will persist this sensitive data.

1. Ask GitHub Copilot to analyze the impact of the OrderRepository on credit card data storage.

    For example, you can submit the following prompt:

    ```text
    How does the OrderRepository contribute to credit card data storage violations? What happens when Order objects containing PaymentInfo with full card numbers and CVV codes are stored?
    ```

1. Review GitHub Copilot's analysis.

    GitHub Copilot should explain that the repository persists whatever data is in the Order and PaymentInfo objects. If the PaymentInfo model is fixed to store only secure data (tokens, last 4 digits), the repository will automatically store secure data instead.

1. Close the OrderRepository.cs file.

1. Ask GitHub Copilot to propose a comprehensive remediation strategy for the Fix Credit Card Data Storage Violations issue that includes input validation and sanitization techniques.

    For example, you can submit the following prompt:

    ```text
    #codebase I need to resolve credit card data storage violations associated with the PaymentInfo model in the OrderRepository.cs file. Notice that the model currently stores full card numbers and CVV codes. The updated codebase should never store CVV codes (remove CVV storage completely), tokenize card numbers and store tokens instead of actual card numbers, mask the display of credit card numbers to show only last 4 digits, and implement proper encryption if card data must be stored temporarily. My acceptance criteria includes: CVV storage completely removed; Full card numbers replaced with tokens; Only the last 4 digits of a credit card are stored for display; Card type detection implemented. Review the codebase and identify the code files that must be updated to address the credit card data storage violations. Based on your code review and the current Chat conversation, suggest a phased approach to required file updates.
    ```

1. Document the analysis results for reference during the remediation phase.

    Take notes on GitHub Copilot's recommendations for both vulnerability categories. This documentation will guide your implementation of security fixes in the next task.

### Resolve issues using GitHub Copilot's Agent mode

GitHub Copilot's Agent mode enables autonomous implementation of complex security fixes across multiple files and methods. Unlike Ask mode, which provides analysis and recommendations, Agent mode can directly modify code to implement security improvements. This approach is particularly effective for systematic security remediation, where multiple related vulnerabilities need to be addressed consistently.

In this task, you use GitHub Copilot's Agent mode to remediate the GitHub issues assigned to you.

Use the following steps to complete this task:

1. Switch GitHub Copilot Chat to Agent mode.

    Agent mode allows GitHub Copilot to make direct code modifications based on your instructions. Agent mode works to establish an appropriate context by reviewing relevant files in the codebase. You can add files and folders to the context manually to ensure that the agent has the necessary information to perform complex tasks.

1. Take a minute to consider your remediation strategy.

    Create a remediation strategy that's based on the analysis you completed using GitHub Copilot's Ask mode. Consider the order in which you'll address your assigned issues, your approach for resolving the issue(s), and how to verify that code vulnerabilities have been successfully remediated.

    The two GitHub issues assigned to you are:

    1. 🔐 Fix SQL Injection Vulnerability in Product Search (High priority)
    1. 🔐 Fix Credit Card Data Storage Violations (Critical priority)

    Although the credit card storage issue has a higher severity, the SQL injection issue is more straightforward to fix and can be addressed first. This allows you to validate your workflow with a simpler fix before tackling the more complex credit card storage violations.

    These issues are associated with specific files and methods in the codebase:

    - **SQL Injection Issue**: ProductService.cs (SearchProducts method)
    - **Credit Card Storage Issue**: Models/Order.cs (PaymentInfo class), PaymentService.cs (ProcessPayment method), SecurityValidator.cs (ValidateCreditCard method), and OrderRepository.cs (data persistence)

    > **NOTE**: The GitHub Pull Requests extension supports processing issues individually and in separate branches. Resolving issues individually provides better traceability, easier code reviews, and safer rollback options if problems arise. In a production environment, you should address each issue individually with separate commits and pull requests.

#### Resolve SQL Injection Vulnerability

Use the following steps to resolve the SQL injection vulnerability:

1. Close all open files in the code editor.

    Closing files helps the agent focus on the files you add to the context. Files that are left open in the editor unintentionally can distract from the task at hand.

1. Add the **ProductService.cs** file to the chat context.

    The SQL injection issue is primarily located in the SearchProducts method of the ProductService.cs file.

1. Ask GitHub Copilot to address the SQL injection vulnerability.

    The analysis that you completed using GitHub Copilot's Ask mode revealed that the method constructs SQL queries using user input without proper sanitization. Use your analysis to construct clear task instructions that the agent can use to remediate the vulnerability.

    For example, you can assign the following task to the agent:

    ```text
    #codebase I need you to fix the SQL injection vulnerability in the SearchProducts method. Review the current Chat conversation related to SQL injection vulnerabilities to identify my expected code fixes and acceptance criteria. Remove the simulated SQL query logging that demonstrates the vulnerability, and implement proper input sanitization to safely handle search terms. Ensure that the method still functions correctly for legitimate searches while preventing malicious input. Update the DisplayKnownVulnerabilities method in SecurityValidator.cs to reflect that SQL injection protection is enabled.
    ```

1. Monitor the agent's progress.

    The agent will modify the code to remove vulnerable logging and implement safer input handling.

1. Take a minute to review the proposed changes, and then select **Keep** in the Chat view.

    Always review GitHub Copilot's suggested edits in the code editor. Ensure that they maintain functionality while addressing the security concern.

    The changes should include:
    - Removal of the simulated SQL query logging
    - Removal or sanitization of debug logging that exposes the search term
    - Addition of input validation or sanitization logic

    In a production environment, your team should complete the following checklist before moving on to the next issue:

    - Code no longer contains the vulnerability.
    - Application still functions correctly.
    - Security best practices are implemented and no new security issues are introduced.
    - Automated tests (if available) pass successfully.
    - Code updates are clearly documented.
    - Changes are committed with descriptive messages and peer-reviewed before merging and closing the issue.

#### Resolve Credit Card Data Storage Violations

The credit card data storage violations span multiple files and require coordinated changes. You'll need to modify the data model, update services that handle payment data, and remove sensitive data from logs.

Use the following steps to resolve the credit card data storage violations:

1. Close any files that are open in the editor, and then add the **Order.cs** file (in the Models folder) to the chat context.

    The PaymentInfo class in this file stores full card numbers and CVV codes, which violates PCI DSS compliance requirements.

1. Ask GitHub Copilot to fix the PaymentInfo class.

    For example, you can assign the following task to the agent:

    ```text
    Fix PCI DSS compliance violations in the PaymentInfo class in Order.cs. Remove the CVV property entirely as CVV codes should never be stored. Replace the CardNumber property with a CardLastFourDigits property that stores only the last 4 digits. Add a CardType property to identify the card brand (Visa, Mastercard, etc.). Update the constructor and any initializations accordingly.
    ```

1. Monitor the agent's progress and review the proposed changes.

    The agent should modify the PaymentInfo class to remove sensitive data storage. Review the changes and select **Keep** if they address the issue correctly.

1. Close the Order.cs file, and then add the **PaymentService.cs** file to the chat context.

    The ProcessPayment method in this file logs sensitive payment data and creates PaymentInfo objects with full card numbers and CVV codes.

1. Ask GitHub Copilot to fix the ProcessPayment method.

    For example, you can assign the following task to the agent:

    ```text
    Fix the credit card data handling in the ProcessPayment method in PaymentService.cs. Remove all logging of full card numbers, CVV codes, and other sensitive payment data. Update the PaymentInfo object creation to store only the last 4 digits of the card number and the card type, without storing CVV. Implement card number masking in any remaining log statements (show only last 4 digits). Ensure the payment processing logic still works correctly.
    ```

1. Monitor the agent's progress.

    The changes should include:
    - Removal or masking of sensitive data in log statements
    - Updates to PaymentInfo object creation to use only last 4 digits
    - Removal of CVV storage
    - Addition of card type detection logic if needed

1. Take a minute to review the proposed changes in the code editor, and then select **Keep** in the Chat view.

    Always review GitHub Copilot's suggested edits in the code editor. Ensure that they maintain functionality while addressing the security concern.

1. Close the PaymentService.cs file, and then add the **SecurityValidator.cs** file to the chat context.

    The ValidateCreditCard method logs full credit card numbers.

1. Ask GitHub Copilot to fix the ValidateCreditCard method.

    For example, you can assign the following task to the agent:

    ```text
    Fix the credit card validation logging in the ValidateCreditCard method in SecurityValidator.cs. Remove or mask the full credit card number in log statements, showing only the last 4 digits if logging is necessary. Ensure the validation logic continues to work correctly. Update the DisplayKnownVulnerabilities method to reflect that credit card data storage is now secure.
    ```

1. Monitor the agent's progress.

    The agent should update the logging to mask sensitive data while maintaining the validation functionality.

1. Take a minute to review the proposed changes in the code editor, and then select **Keep** in the Chat view.

    Always review GitHub Copilot's suggested edits in the code editor. Ensure that they maintain functionality while addressing the security concern.

1. Consider the impact on OrderRepository.

    The OrderRepository.cs file stores Order objects, which include PaymentInfo. Since you've updated the PaymentInfo class to only store secure data (last 4 digits, card type), the repository will automatically persist secure data instead of full card numbers and CVV codes. No direct changes to the repository are needed, but you should verify this during testing.

1. Build the application to ensure all changes compile successfully.

    Run the following command in the terminal:

    ```bash
    dotnet build
    ```

    If there are compilation errors, use GitHub Copilot to help identify and resolve any issues introduced during the security fixes. Common issues might include:
    - References to removed properties (CVV, full CardNumber)
    - Constructor parameter mismatches
    - Type mismatches in assignments

### Test and verify the refactored code

Comprehensive testing after security remediation ensures that vulnerability fixes don't introduce functional regressions while confirming that security improvements are effective. This verification process should test both the security aspects and the business functionality of the application. Proper testing validates that the application maintains its intended behavior while being more secure.

In this task, you systematically test the updated ContosoShopEasy application to verify that the two security issues have been resolved and that core functionality remains intact.

Use the following steps to complete this task:

1. Run the complete application to observe the overall behavior.

    Execute the application and review the console output:

    ```bash
    dotnet run
    ```

    Compare the output with your notes from the original application run. You should see significantly less sensitive information being logged.

1. Test the SQL injection fix.

    Verify that the SearchProducts method no longer logs the simulated SQL query with user input concatenated directly into the query string. The application should:

    - Still perform product searches correctly
    - Not display vulnerable SQL query logging
    - Handle search terms safely without exposing SQL injection vulnerability
    - Not log raw search terms excessively

1. Test the credit card data storage fix.

    Verify that the PaymentInfo class and related code no longer store or log full credit card numbers and CVV codes. The application should:

    - Not log full credit card numbers (check for masking, e.g., ****1234)
    - Not log CVV codes at all
    - Not store CVV codes in the PaymentInfo object
    - Store only the last 4 digits of card numbers
    - Continue to process payments correctly (simulated)

1. Verify the overall security improvements.

    Compare the console output with your initial observations. Key improvements should include:

    - **SQL Injection**: No simulated SQL queries showing user input concatenation
    - **Credit Card Data**: No full card numbers or CVV codes in logs or stored data
    - Application core functionality (product search, payment processing) still works correctly

1. Document any remaining issues or areas for improvement.

    Note any security concerns that may require additional attention or any functional issues that need to be addressed.

### Commit changes and close issues

Proper version control practices ensure that security improvements are properly documented and tracked. Commit messages should clearly describe the security fixes implemented, making it easy for team members to understand what changes were made and why. Closing GitHub issues with descriptive commit messages creates a clear audit trail of security remediation efforts.

In this task, you commit your security improvements to the repository and close the corresponding GitHub issues.

Use the following steps to complete this task:

1. Open Visual Studio Code's Source Control view, and then review the changes made to each of the updated files.

    Look for any unexpected changes that may have been introduced during the remediation process. Ensure that all changes align with your remediation strategy and that no new vulnerabilities were introduced.

1. Ask GitHub Copilot to craft a comprehensive commit message.

    For example, you can use the following prompt in the Chat view:

    ```text
    I need to create a commit message that summarizes the security fixes I implemented for two GitHub issues: "Fix SQL Injection Vulnerability in Product Search" and "Fix Credit Card Data Storage Violations." The commit message should clearly describe the changes made to address each issue, including specific code modifications and the overall impact on application security. Draft a detailed commit message that captures all relevant information.
    ```

1. Take a minute to review the proposed commit message.

    Ensure that it accurately reflects the security improvements made and provides sufficient detail for future reference.

    For example, the commit message might look similar to the following sample:

    ```text
    Fix SQL injection and credit card data storage vulnerabilities

    Security improvements implemented:
    - Fix SQL injection in ProductService SearchProducts method
      - Remove vulnerable SQL query logging with user input
      - Implement proper input handling and sanitization
    
    - Fix PCI DSS violations for credit card data storage
      - Remove CVV property from PaymentInfo class
      - Replace CardNumber with CardLastFourDigits
      - Add CardType property for card brand identification
      - Update PaymentService to not log or store sensitive card data
      - Mask credit card numbers in SecurityValidator logs
    
    Fixes #[SQL_INJECTION_ISSUE_NUMBER] #[CREDIT_CARD_ISSUE_NUMBER]
    ```

1. Replace `[SQL_INJECTION_ISSUE_NUMBER]` and `[CREDIT_CARD_ISSUE_NUMBER]` with the actual issue numbers from your GitHub repository.

    You can find these numbers in the GitHub Pull Requests view in Visual Studio Code or by viewing the issues on GitHub.

    > **NOTE**: In a production environment, each issue would typically be addressed in separate commits with individual testing and code review. Combining both fixes in a single commit is used here to streamline the training exercise workflow.

1. Stage and commit your changes, and then push changes to your GitHub repository (or synchronize).

1. Open GitHub and verify that the GitHub issues are automatically closed.

    Navigate to your repository on GitHub and check that the two issues you referenced in your commit message are marked as closed. GitHub automatically closes issues when commit messages include "Fixes #[issue_number]" syntax.

1. Review the commit history to ensure the security fixes are properly documented.

    Verify that the commit message clearly describes the security improvements and provides a good audit trail for future reference.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. For example, you might want to delete the ResolveGitHubIssues repository. If you're using a local PC as your lab environment, you can archive or delete the local clone of the repository created for this exercise.
