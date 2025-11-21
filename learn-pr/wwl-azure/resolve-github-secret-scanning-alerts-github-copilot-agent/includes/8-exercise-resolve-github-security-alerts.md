> [!IMPORTANT]
> To complete this exercise, you need an active GitHub account and a Visual Studio Code environment. If you don't have a GitHub account, you can [sign up](https://github.com/) for a free individual account and use a GitHub Copilot Free plan to complete the exercise. For help with enabling GitHub Copilot in Visual Studio Code, see [Enable GitHub Copilot in Visual Studio Code](https://go.microsoft.com/fwlink/?linkid=2320158&azure-portal=true).

In this exercise, you use GitHub and GitHub Copilot to analyze and remediate GitHub secret scanning alerts for the ContosoOrderProcessor legacy application. Tasks include:

1. Import the ContosoOrderProcessor repository to your GitHub account.
1. Review security alerts on GitHub.
1. Review the code project in Visual Studio Code.
1. Configure environment variables and run the application.
1. Use GitHub Copilot's Ask mode to analyze secret scanning alerts.
1. Use GitHub Copilot's Agent mode to remediate secret scanning alerts.
1. Push changes to GitHub and close secret scanning alerts.
1. Test the GitHub Push protection feature.

When you select the launch exercise button, the browser navigates to a public GitHub page that provides instructions for this exercise.

When you finish the exercise, return here for:

- A quick knowledge check.
- A summary of what you learned during this module.
- A badge for completing this module.

[![Button to launch exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?linkid=2343337&azure-portal=true)

---

GitHub secret scanning is a security feature that helps identify and prevent the exposure of sensitive information in your code repositories, such as API keys, tokens, and passwords. When a secret is detected, GitHub generates an alert to notify repository administrators and maintainers about the potential security risk.

In this exercise, you use GitHub and GitHub Copilot to help you analyze and resolve GitHub secret scanning alerts related to hard-coded secrets in a code repository.

This exercise should take approximately **40** minutes to complete.

> **IMPORTANT**: To complete this exercise, you must provide your own GitHub account and GitHub Copilot subscription. If you don't have a GitHub account, you can <a href="https://github.com/" target="_blank">sign up</a> for a free individual account and use a GitHub Copilot Free plan to complete the exercise. If you have access to a GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business, or GitHub Copilot Enterprise subscription from within your lab environment, you can use your existing GitHub Copilot subscription to complete this exercise.

## Before you start

Your lab environment must include the following resources: Git 2.48 or later, .NET SDK 9.0 or later, Visual Studio Code with the C# Dev Kit extension, and access to a GitHub account with GitHub Copilot enabled.

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

You're a software developer working for a consulting firm. Your clients need help with removing hard-coded secrets from legacy applications. You plan to use GitHub Secret Scanning, GitHub Push Protection, and GitHub Copilot to detect and remediate hard-coded secrets. You use Visual Studio Code as your development environment and GitHub Copilot to assist with development tasks. You're assigned to the following legacy app:

- ContosoOrderProcessor: An e-commerce app that provides an order processing workflow. The workflow includes customer validation, payment processing, email notifications, and database operations. The code contains hard-coded secrets that need to be managed in a secure manner.

This exercise includes the following tasks:

1. Import the ContosoOrderProcessor repository to your GitHub account.
1. Review security alerts on GitHub.
1. Review the code project in Visual Studio Code.
1. Configure environment variables and run the application.
1. Use GitHub Copilot's Ask mode to analyze secret scanning alerts.
1. Use GitHub Copilot's Agent mode to remediate secret scanning alerts.
1. Push changes to GitHub and close secret scanning alerts.
1. Test the GitHub Push protection feature.

### Import the ContosoOrderProcessor Repository to your GitHub account

GitHub Importer allows you to create a copy of an existing repository in your own GitHub account, giving you full control over the imported copy.

In this task, you use your GitHub account to import the ContosoOrderProcessor repository.

Use the following steps to complete this task:

1. Open a browser window and navigate to GitHub.com.

1. Sign in to your GitHub account, and then open your repositories tab.

    You can open your repositories tab by clicking on your profile icon in the top-right corner, then selecting **Repositories**.

1. On the Repositories tab, select the **New** button.

1. Under the **Create a new repository** section, select **Import a repository**.

1. On the **Import your project to GitHub** page, under **Your source repository details**, enter the following URL for the source repository:

    ```plaintext
    https://github.com/MicrosoftLearning/resolve-github-security-alerts-lab-project
    ```

1. Under the **Your new repository details** section, in the **Owner** dropdown, select your GitHub username.

1. Enter **ResolveGitHubSecurityAlerts** in the **Repository name** field.

    GitHub automatically checks the availability of the repository name. If this name is already taken, append a unique suffix (for example, your initials or a random number) to the repository name to make it unique.

1. Ensure that the repository is set to **Public**.

    Secret Scanning is enabled by default for public repositories.

1. Select the **Begin import** button.

    GitHub uses the import process to create the new repository in your account.

    > **NOTE**: It can take a minute or two for the import process to finish.

1. Wait for the import process to complete, and then open the **ResolveGitHubSecurityAlerts** repository.

    The ResolveGitHubSecurityAlerts repository contains the ContosoOrderProcessor application. Hard-coded secrets are included for training purposes.

### Review security alerts on GitHub

GitHub's secret scanning feature detects API keys, tokens, passwords, and other secrets that are accidentally committed to a repository. Security alerts are generated when secrets are detected, providing information about the type of secret, its location in the code, and recommendations for remediation.

In this task, you examine the code repository and review the security alerts generated by GitHub secret scanning.

Use the following steps to complete this task:

1. Take a minute to review the repository's README.md file.

    The README.md file provides an overview of the ContosoOrderProcessor application, including a description of the intentionally exposed secrets and instructions for running the application.

    > **IMPORTANT**: Notice that you need to set up environment variables before running the application.

1. Select the **Settings** tab.

1. In the left sidebar, select **Advanced Security**.

    The Advanced Security page displays various security features that you can enable for your repository.

1. Scroll to the bottom of the page, and then verify that **Secret Protection** and **Push protection** are enabled.

    The **Disable** buttons, which can be used to turn off the features, show that the two features are currently enabled.

    > **NOTE**: For public repositories, secret scanning (Secret Protection and Push protection) are enabled by default. For private repositories, you must enable secret scanning manually.

1. At the top of the page, select the **Security** tab.

    The Security tab displays a security overview for your repository, including any security advisories, Dependabot alerts, code scanning alerts, and secret scanning alerts.

    You can find the Security tab at the top of the repository page (alongside Code, Issues, Pull Requests, etc.).

1. In the left sidebar, under the **Vulnerability alerts** section, select **Secret scanning**.

    The Secret scanning alerts page displays the security alerts for secrets detected in your repository. Each alert includes information about the type of secret, the file and line number where the secret was found, and the status of the alert.

1. Take a minute to review the Secret scanning alerts page.

    You should see a list that includes the following alerts:

    - ✓ Square Access Token - PaymentService.cs.
    - ✓ Stripe API Key - PaymentService.cs.
    - ✓ Slack Incoming Webhook URL - AppConfig.cs.
    - ✓ Slack API Token - AppConfig.cs.
    - ✓ Mailgun API Key - EmailService.cs.
    - etc.

    > **NOTE**: GitHub's secret scanning feature uses pattern matching to detect secrets in your codebase. The alerts you see are based on the secrets that were intentionally included in the ContosoOrderProcessor application for training purposes.

1. To view one of the alerts, select the **Mailgun API Key** alert.

    The alert details page provides information about the secret, including:

    - The exposed secret.
    - Remediation steps.
    - The file path where the secret was found.
    - A code snippet showing the secret in context.
    - The commit that introduced the secret.

1. Take a minute to review the code snippet shown in the alert.

    Notice that the alert points to the EmailService.cs file (line 19). The code exposes a Mailgun API key.

1. Navigate back to the Secret scanning alerts page.

1. Select the **Stripe API Key** alert and review the details.

    Notice that this alert points to the PaymentService.cs file (line 24). The code exposes a Stripe live API key.

1. Navigate back to the Secret scanning alerts page and quickly review the other alerts.

    As you review the alerts, notice the following:

    - All of the alerts are currently in the "Open" status, indicating they need to be addressed.
    - Each alert identifies the file and line number where the secret was found.
    - The identified secrets are located in the following three files:
        - AppConfig.cs
        - EmailService.cs
        - PaymentService.cs
    - The alerts can be assigned to team members for resolution.

### Review the code project in Visual Studio Code

The ContosoOrderProcessor application is a C# console application that simulates an e-commerce order processing workflow. Hard-coded secrets are included in the code for training purposes, along with comments that indicate where the secrets are located. Other secrets are loaded securely from environment variables.

In this task, you clone the repository to your local development environment and review the project in Visual Studio Code.

Use the following steps to complete this task:

1. Navigate back to the root page of your repository.

    The root page displays the list of files and folders in the repository.

1. Clone the ResolveGitHubSecurityAlerts repository to your local development environment.

    For example:

    1. Open the **Code** button dropdown.

    1. Select the **Copy URL to clipboard** icon to copy the repository URL.

    1. Open a terminal or command prompt.

    1. Navigate to the directory where you want to clone the repository.

    1. Run the following command to clone the repository:

        ```bash
        git clone https://github.com/<your-account>/ResolveGitHubSecurityAlerts.git
        ```

        Replace **`<your-account>`** with your GitHub username.

1. Open the cloned repository in Visual Studio Code.

    For example:

    1. Launch Visual Studio Code.

    1. On the **File** menu, select **Open Folder**.

    1. Navigate to the directory where you cloned the repository.

    1. Select the **ResolveGitHubSecurityAlerts** folder and then select **Select Folder**.

1. Ensure that you're using the latest version of Visual Studio Code and that you have GitHub Copilot installed and enabled.

    You can verify that Visual Studio Code is up to date by selecting the Manage icon (gear icon) in the lower-left corner of the Visual Studio Code window, then selecting **Check for Updates**.

    You can verify that GitHub Copilot is enabled by selecting the Copilot icon in lower-right corner of the Visual Studio Code window, or by opening the Chat view and ensuring that the Chat features are active.

1. Use Visual Studio Code's EXPLORER view to expand the ContosoOrderProcessor folder, and then take a minute to review the project structure.

    The ContosoOrderProcessor application follows a simple layered architecture. It includes the following files and folders:

    - **Configuration**: Contains the AppConfig.cs file with application-wide configuration constants (including exposed secrets).
    - **Models**: Contains the Customer.cs and Order.cs model classes.
    - **Security**: Contains the SecurityValidator.cs file with security validation logic.
    - **Services**: Contains service classes for database access, email sending, and payment processing (DatabaseService.cs, EmailService.cs, PaymentService.cs).
    - **Program.cs**: The main entry point that demonstrates the order processing workflow.

1. Open the **Program.cs** file and take a minute to review the code.

    Notice that the Main method performs the following tasks:

    1. First, the Main method builds and validates a configuration object.

        Notice the ValidateRequiredConfiguration method at the bottom of the Program.cs file. This method validates that all required configuration values are present before the application starts. It checks for configuration data in appsettings.json and secrets in environment variables (AWS credentials, SendGrid API key, PayPal credentials, Azure storage connection, database connection, GitHub token, and NPM token). If any are missing, it displays a formatted error message listing the missing items, instructs the user to run a setup script, and exits the application with an error code.

        > **NOTE**: The application terminates early if the configuration isn't validated successfully. For example, if the environment variables haven't been set. This prevents the application from running with incomplete or incorrect settings.

    1. Second, after the configuration is validated, the Main method simulates an order processing workflow that includes the following tasks:

        - Customer retrieval.
        - Customer validation.
        - Order creation.
        - Order validation.
        - Fraud detection.
        - Payment processing.
        - Database persistence.
        - Email notification.
        - Shipping notification.

1. Use Visual Studio Code's EXPLORER view to expand the **Configuration** folder.

1. Open the **AppConfig.cs** file and take a minute to review the code.

    AppConfig.cs is a static configuration class that manages all application settings, credentials, and feature flags for ContosoOrderProcessor. It implements a dual-source configuration pattern where some secrets are loaded securely from IConfiguration (environment variables) with fallback chains, while others remain intentionally hard-coded as public constants for training purposes. The class provides utility methods for initialization, configuration validation, and credential retrieval.

1. Expand the **Services** folder, and then take a couple minutes to review the following files:

    - **PaymentService.cs**: This class handles payment processing using third-party payment gateways. It contains hard-coded secrets for Stripe and Square payment providers.
    - **EmailService.cs**: This class manages email notifications using the Mailgun email service. It contains a hard-coded Mailgun API key and SMTP credentials.

> **NOTE**: Hard-coded secrets are included in the application for training purposes only. In a real-world application, secrets should never be hard-coded.

### Configure environment variables and run the application

The ContosoOrderProcessor application verifies that all required configuration values, including environment variables, are present before running an order processing workflow. If the environment variables aren't set, the application displays an error message and exits.

Running the application and observing the console output helps you understand the intended behavior of the application before you remediate the secret scanning alerts.

> **NOTE**: Although environment variables can be used to manage secrets, they have limitations in terms of security and scalability. Azure Key Vault and other secret management solutions are recommended for production deployments.

In this task, you create a PowerShell script that sets up environment variables, run the application, and record the console output.

Use the following steps to complete this task:

1. Use Visual Studio Code's EXPLORER view to create a file named **setup-secrets.ps1** at the root of your project.

    The script file is used to set environment variables for the current PowerShell session.

1. Add the following PowerShell code to the **setup-secrets.ps1** file:

    ```powershell
    # This script sets environment variables for the current PowerShell session only.
    #
    # These variables are required to run the application.
    #
    # IMPORTANT NOTES:
    #   • These variables are set for THIS PowerShell session only
    #   • Variables will be lost when you close this window
    #   • All secret values are FICTIONAL for training purposes only
    #    
    Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  Contoso Order Processor - Environment Setup Script   " -ForegroundColor Cyan
    Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Setting environment variables for current session..." -ForegroundColor Yellow
    Write-Host ""
    
    # AWS Credentials
    $env:Aws__AccessKeyId = "AKIA1234567890EXAMPLE"
    $env:Aws__SecretAccessKey = "1234567890abcdefghijklmnopqrstuvwxyzABCD"
    Write-Host "✓ AWS credentials configured" -ForegroundColor Green
    
    # SendGrid API Key
    $env:SendGrid__ApiKey = "SG.1234567890abcdefghij.1234567890abcdefghijklmnopqrstuvwxyzABCDEF"
    Write-Host "✓ SendGrid API key configured" -ForegroundColor Green
    
    # PayPal Credentials
    $env:PayPal__ClientId = "AY1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmno"
    $env:PayPal__ClientSecret = "EJ1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklm"
    Write-Host "✓ PayPal credentials configured" -ForegroundColor Green
    
    # Azure Storage Connection String
    $env:Azure__StorageConnectionString = "DefaultEndpointsProtocol=https;AccountName=contosostorageacct;AccountKey=TRAINING-PURPOSE-ONLY-NOT-A-REAL-KEY-1234567890abcdefghijklmnopqrstuvwxyzABCDEFGH==;EndpointSuffix=core.windows.net"
    Write-Host "✓ Azure Storage connection string configured" -ForegroundColor Green
    
    # SQL Server Connection String
    $env:Database__ConnectionString = "Server=tcp:contoso-orders.database.windows.net,1433;Initial Catalog=ContosoOrdersDB;User ID=orderadmin;Password=MyPassword123!;Encrypt=True;TrustServerCertificate=False;MultipleActiveResultSets=False;Connection Timeout=30;"
    Write-Host "✓ SQL Server connection string configured" -ForegroundColor Green
    
    # GitHub Personal Access Token
    $env:GitHub__PersonalAccessToken = "ghp_1234567890abcdefghijklmnopqrstuvwxyzAB"
    Write-Host "✓ GitHub Personal Access Token configured" -ForegroundColor Green
    
    # npm Token
    $env:Npm__Token = "npm_1234567890abcdefghijklmnopqrstuvwxy"
    Write-Host "✓ npm Token configured" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "✓ All environment variables configured successfully!" -ForegroundColor Green
    Write-Host "════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    ```

    This script sets environment variables for AWS credentials, SendGrid API key, PayPal credentials, Azure Storage connection string, SQL Server connection string, GitHub Personal Access Token, and npm token. All secret values are fictional and intended for training purposes only.

1. Open Visual Studio Code's integrated terminal.

    On the top menu bar, select **Terminal**, and then select **New Terminal**.

1. To configure environment variables, enter the following command in the terminal:

    ```powershell
    . .\setup-secrets.ps1
    ```

    The script should generate the following output:

    ```plaintext
    ════════════════════════════════════════════════════════
      Contoso Order Processor - Environment Setup Script
    ════════════════════════════════════════════════════════
    Setting environment variables for current session...
    ✓ AWS credentials configured
    ✓ SendGrid API key configured
    ✓ PayPal credentials configured
    ✓ Azure Storage connection string configured
    ✓ SQL Server connection string configured
    ✓ GitHub Personal Access Token configured
    ✓ npm Token configured
    ════════════════════════════════════════════════════════
    ✓ All environment variables configured successfully!
    ════════════════════════════════════════════════════════
    ```

    > **NOTE**: The environment variables are temporary and only exist in the current PowerShell window. They're lost when the terminal closes. Environment variables are used to simplify the training environment. A more secure approach would involve using Azure Key Vault or other secure secret management solutions.

1. To run the application, enter the following commands in the terminal:

    ```powershell
    cd ContosoOrderProcessor
    dotnet run
    ```

    The application validates the configuration and then runs a simulated workflow.

    The steps of the order processing workflow include retrieving and validating customer information, creating an order, and performing security checks such as order validation and fraud risk assessment. If the order passes these checks, the workflow processes the payment, saves the order to the database, logs the transaction, and sends confirmation and shipping notification emails to the customer. Throughout, the workflow provides detailed console output for each step and handles errors gracefully, ensuring that missing configuration or failed operations are clearly reported.

1. Take a minute to review the console output generated by the ContosoOrderProcessor application.

    The application logs the entire workflow process, including configuration details and processing steps. Notice that some messages expose secrets. For example, you can see connection strings, API keys, and other sensitive information being logged to the console.

1. Add a file named **OriginalConsoleOutput.txt** to the root of your project.

    You can create the file by right-clicking in the EXPLORER view, selecting **New File**, naming it **OriginalConsoleOutput.txt**.

1. Copy the console output to the **OriginalConsoleOutput.txt** file.

    You compare this original console output with the final console output after remediating the secret scanning alerts.

### Use GitHub Copilot's Ask mode to analyze secret scanning alerts

GitHub Copilot's Ask mode provides intelligent code analysis that can help you understand security vulnerabilities, their potential impacts, and suggested remediation strategies. By analyzing the code that contains exposed secrets, you can develop a comprehensive understanding of the problems before implementing fixes.

In this task, you use GitHub Copilot's Ask mode to analyze the hard-coded secrets in the ContosoOrderProcessor application. You review the security risks associated with the exposed secrets and gather remediation suggestions.

Use the following steps to complete this task:

1. Ensure that GitHub Copilot's Chat view is open in Visual Studio Code.

    To open the Chat view, select the Toggle Chat button at the top of the Visual Studio Code window, or press `Ctrl+Alt+I` (Windows/Linux) or `Cmd+Option+I` (Mac).

1. Ensure that you're starting with a new/clean Chat session.

    If you analyzed or updated the codebase in the current Chat session, you might want to start fresh. Select the **New Chat** button (the **+** icon at the top of the Chat panel) to begin a new conversation. A new Chat session ensures that GitHub Copilot has no prior context that could influence its analysis.

1. Use the Set Agent button to select **Ask** mode, and then use the Pick Model button to select the **GPT-4.1** model.

    > **NOTE**: The **GPT-4.1** model is included with the GitHub Copilot Free plan. This model provides excellent code analysis capabilities. Choosing a different model might yield different results.

1. Open the **Services/PaymentService.cs** file in the code editor.

1. Ask GitHub Copilot to identify the secrets exposed in the PaymentService class, analyze the secrets, and explain the security risks.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Analyze the PaymentService class. Identify secrets exposed in the code. Analyze the secret types and providers. Explain the security risks associated with the identified secrets.
    ```

1. Take a minute to review GitHub Copilot's analysis.

    GitHub Copilot should provide a detailed analysis that identifies hard-coded secrets in the PaymentService class. The secrets should include a Stripe API Key and a Square Access Token. The explanation should describe the types of secrets, their providers, the locations in the code, and the associated security risks.

    The analysis should be similar to the following:

    ```md
    The `PaymentService` class exposes two hard-coded secrets:
    
    1. **Stripe API Key**
       - **Type:** API Key
       - **Provider:** Stripe
       - **Location:** `private const string StripeApiKey = "sk_live_51MqxYzABC123def456GHI789jklMNO012pqrSTU345vwxYZ678abcDEF901ghiJKL234mnoPQR567stuVWX890yzABC";`
       - **Risk:** Anyone with access to this key can make authenticated requests to Stripe, potentially initiating fraudulent transactions, accessing payment data, or causing financial loss.
    
    2. **Square Access Token**
       - **Type:** Access Token
       - **Provider:** Square
       - **Location:** `private const string SquareAccessToken = "EAAAEOuLQavTvyym5PByGZrGdRLWiL_RB0n8YF0gELTxFqLhNp6bKHRhA6P7Uv5F";`
       - **Risk:** Exposure allows attackers to access Square APIs, potentially viewing sensitive transaction data, issuing refunds, or manipulating payment flows.
    
    **Security Risks:**
    - **Credential Leakage:** Hard-coded secrets are easily discoverable in source code, especially if the repository is public or shared.
    - **Unauthorized Access:** Attackers can use these credentials to impersonate your service, access customer data, or perform malicious transactions.
    - **Compliance Violations:** Storing secrets in code might violate PCI DSS, GDPR, or other regulatory requirements.
    - **Lack of Rotation:** Hard-coded secrets are difficult to rotate, increasing the risk if they are ever compromised.
    
    **Best Practices:**
    - Remove hard-coded secrets from code.
    - Store secrets in secure configuration (environment variables, secret managers).
    - Audit and rotate exposed credentials immediately.
    
    You can find these exposed secrets in `PaymentService.StripeApiKey` and `PaymentService.SquareAccessToken`.
    ```

1. Ask GitHub Copilot for specific remediation guidance for the Stripe API key.

    For example, enter the following prompt in the Chat:

    ```plaintext
    What's the best practice for storing API keys like Stripe in a C# application? How should I refactor this code to remove the hard-coded Stripe API key?
    ```

1. Take a minute to review GitHub Copilot's remediation suggestions.

    GitHub Copilot should recommend best practices for securely storing API keys, such as using environment variables or secret management services. It should also provide code snippets demonstrating how to refactor the PaymentService class to read the Stripe API Key from a secure location instead of hard-coding the secret.

    GitHub Copilot will use the Ask mode conversation to inform the remediation steps you take in the next task using Agent mode. You can also take notes on GitHub Copilot's recommendations. Your insights can guide remediation.

1. Ask GitHub Copilot to suggest remediation strategies for the Square access token.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Suggest remediation strategies for the Square access token exposed in the PaymentService class. How can I securely manage this secret? Should I use the same approach to manage both the Square access token and the Stripe API key?
    ```

1. Take a minute to review GitHub Copilot's remediation suggestions.

    You should see that GitHub Copilot recommends using a consistent strategy for managing both the Square access token and the Stripe API key. GitHub Copilot suggests using environment variables or secret management services.

1. Open the **Services/EmailService.cs** file in the code editor.

1. Ask GitHub Copilot to analyze the EmailService class, identify secrets, and suggest remediation strategies.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Analyze the EmailService class. Identify secrets exposed in the code. Suggest remediation strategies for securely managing secrets.
    ```

1. Take a minute to review GitHub Copilot's remediation suggestions.

    You should see that GitHub Copilot identifies the hard-coded Mailgun API key as well as some SMTP credentials that were not recognized by GitHub Secret Scanning. Secret scanning tools might not detect all types of secrets, especially if they don't match known patterns.

    GitHub Copilot recommends using environment variables or secret management services to securely manage the secret.

1. Ask GitHub Copilot why GitHub Secret Scanning didn't detect the SMTP credentials.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Why didn't GitHub Secret Scanning detect the SMTP credentials in the EmailService class? Explain the limitations of secret scanning tools.
    ```

1. Review GitHub Copilot's response.

    GitHub Copilot should explain that secret scanning tools rely on pattern matching and might not detect all types of secrets, especially if they don't match known patterns or formats. It should also highlight the importance of using multiple layers of security, including code reviews and static analysis tools, to identify potential vulnerabilities.

1. Open the **Configuration/AppConfig.cs** file in the code editor.

1. Ask GitHub Copilot to review the AppConfig.cs file and then suggest the remediation strategy that should be used to manage all hard-coded secrets in the ContosoOrderProcessor application.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Review the AppConfig class and identify exposed secrets. Consider the secrets previously identified in the PaymentService and EmailService classes. Should the application's existing approach for securely managing secrets be extended for all secrets in the ContosoOrderProcessor application? Explain your reasoning and suggest a remediation strategy.
    ```

1. Take a minute to review GitHub Copilot's remediation suggestions.

    You should see that GitHub Copilot recommends extending the existing approach of using environment variables for securely managing all secrets in the ContosoOrderProcessor application (or using a secrets manager like Azure Key Vault). It should explain that this approach centralizes secret management, reduces the risk of exposure, and aligns with best practices for secure application development.

### Use GitHub Copilot's Agent mode to remediate secret scanning alerts

GitHub Copilot's Agent mode can help you implement security fixes by directly replacing hard-coded secrets with secure alternatives in your code files. The Agent mode goes beyond analysis to actively edit code files using security best practices.

In this task, you use GitHub Copilot's Agent mode to remediate some of the secret scanning alerts that you analyzed in the previous task. You apply the remediation strategy identified during your Ask mode analysis. You intentionally leave some secrets unfixed to test GitHub's Push Protection feature.

Use the following steps to complete this task:

1. In Visual Studio Code, close any files that are open in the editor.

    Agent mode reviews the codebase and the assigned task to establish context and identify areas that require remediation.

1. In the Chat view, switch to GitHub Copilot's **Agent** mode.

    In the lower-left corner of the Chat view, use the Set Agent dropdown to select **Agent** mode.

1. Assign a task to GitHub Copilot that remediates the security alerts associated with the PaymentService class.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Review the current conversation and then review the PaymentService.cs file. Notice how some secrets are managed using environment variables and others are hard-coded. I need you to remove hard-coded secrets from the PaymentService class and implement environment variables that securely manage the secrets. Update the setup-secrets.ps1 script for the new environment variables, and ensure that the formatting matches the existing environment variable declarations. Ensure that the suggested updates don't introduce errors and run a build task to verify the app builds correctly after the updates.
    ```

1. Run the task and monitor the agent's progress.

    The agent should begin analyzing the PaymentService.cs file and proposing code changes to remove the hard-coded secrets. Progress is reported in the Chat view. GitHub Copilot Agent suggests code updates directly within the code files.

    > **NOTE**: The agent might ask for permission to access certain files or perform specific actions. Grant permission as needed to allow the agent to complete the task.

1. Take a minute to review the changes proposed by GitHub Copilot Agent.

    Review the PaymentService.cs and setup-secrets.ps1 files in the editor.

    You can review each edit individually in the code editor. You can scroll through the edits manually, or use the Chat Edits navigation bar to move up and down through the proposed changes. The edits should align with the remediation strategy identified during your Ask mode analysis.

1. Apply the changes and save the updated files.

    Always review the edits suggested by GitHub Copilot.

    If the proposed changes look correct and match the remediation strategy from your analysis, select **Keep** to apply the edits to your PaymentService.cs and setup-secrets.ps1 files. You can use the **Keep** button in the Chat view accept all proposed changes (all files).

    After accepting the edits, the hard-coded secrets should be removed from the source code and the secrets should be securely managed using environment variables.

    > **NOTE**: If you notice any issues with the proposed changes, you can select **Undo** to reject the edits. You can also manually modify the code as needed. If you accept the changes and later find issues, you can use the Chat view's **Undo Last Request** feature to revert the most recent changes. You can also use Visual Studio Code's undo features to revert code changes.

1. Assign a task to GitHub Copilot that remediates the security alerts associated with the EmailService class.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Now review the EmailService.cs file. Remove hard-coded Mailgun and SMTP secrets from the EmailService class and implement environment variables that securely manage the secrets. Update the setup-secrets.ps1 script for the new environment variables, and ensure that the formatting matches the existing environment variable declarations. Ensure that the suggested updates don't introduce errors and run a build task to verify the app builds correctly after the updates.
    ```

1. Run the task and monitor the agent's progress.

    The agent should begin analyzing the EmailService.cs file and proposing code changes to remove the hard-coded secrets. If the agent asks for assistance or permission to access certain files, grant permission as needed to allow the agent to complete the task.

1. Take a minute to review the changes proposed and then accept the updates.

    The edits should align with the remediation strategy identified during your Ask mode analysis. If the proposed changes look correct and match the remediation strategy from your analysis, select **Keep** to apply the edits to your EmailService.cs and setup-secrets.ps1 files. The hard-coded secrets should now be removed from the source code and securely managed using environment variables.

1. Assign a task to GitHub Copilot that updates the code used to validate the configuration settings in Program.cs and AppConfig.cs.

    For example, enter the following prompt in the Chat:

    ```plaintext
    I need you to ensure that the app's configuration is validated correctly and that the app runs as expected. Review the Program.cs and AppConfig.cs files. Update the ValidateRequiredConfiguration method to include validation for all environment variables before starting the workflow. Update the ValidateRequiredConfiguration method to include error messages for any missing environment variable. Update console logging in Program.cs to use safe placeholder values for secrets. Also, update the AppConfig class to include static properties for the new secrets, loaded from configuration/environment variables. The validation in AppConfig.cs should also be updated to check all environment variables. Ensure that the suggested updates don't introduce errors and run a build task to verify the app builds correctly after the updates.
    ```

1. Run the task and monitor the agent's progress.

    The agent should begin analyzing the Program.cs and AppConfig.cs files and proposing code changes to update the configuration validation logic. Progress is reported in the Chat view. Code edits appear in the code editor as they're proposed by GitHub Copilot.

    > **NOTE**: The agent might not be able to run the setup script (setup-secrets.ps1) and the application in the same PowerShell session. It should be able to run the application (without the setup script) to demonstrate the validation logic.

1. Take a minute to review and apply the proposed changes, and then save the updated files.

    The Program.cs file should be updated to validate the new environment variables that were added to manage the secrets. The error message displayed when configuration validation fails should also be updated to include any missing secrets.

    The AppConfig.cs file should be updated to include static properties for the new secrets, loaded from configuration/environment variables. Adding the properties provides centralized, maintainable access to the secrets. Updates to AppConfig.cs enables proper validation, easier configuration management, and improved security practices.

    If the proposed changes look correct and match the remediation strategy from your analysis, select **Keep** to apply the edits. Save the files.

1. To verify that the application runs successfully after the changes, enter the following command in the terminal:

    Open the integrated terminal, and then run the following commands:

    ```powershell
    . .\setup-secrets.ps1
    cd ContosoOrderProcessor
    dotnet run
    ```

    The application should validate the configuration and run the simulated order processing workflow without errors.

1. Save the console output to a file named **RemediatedConsoleOutput.txt** at the root of your project.

    You can create the file by right-clicking in the EXPLORER view, selecting **New File**, naming it **RemediatedConsoleOutput.txt**, and then copying the console output into the file.

1. Compare the **OriginalConsoleOutput.txt** and **RemediatedConsoleOutput.txt** files to verify that the application behavior remains consistent after remediating the secret scanning alerts.

    The console output should show that the application runs successfully both before and after the remediation, with no errors related to missing configuration or secrets.

    The RemediatedConsoleOutput.txt file shouldn't display the remediated secrets.

1. Ask the Agent to compare the two console output files and verify that the application behavior remains consistent after remediating the secret scanning alerts.

    For example, enter the following prompt in the Chat:

    ```plaintext
    Compare the OriginalConsoleOutput.txt and RemediatedConsoleOutput.txt files. Verify that the application behavior remains consistent after remediating the secret scanning alerts. Highlight any differences in behavior or output.
    ```

1. Review GitHub Copilot's comparison of the two console output files.

    GitHub Copilot should confirm that the application behavior remains consistent after remediating the secret scanning alerts. It should highlight that the order processing workflow executed successfully in both cases, with no errors related to missing configuration or secrets. Any differences in output should be related to the removal of sensitive information from the console logs.

1. Delete the two output files and the setup-secrets.ps1 script file.

    These files were only needed to run and verify the application before and after remediating the secret scanning alerts. They should be removed to keep the repository clean.

### Push changes to GitHub and close secret scanning alerts

After removing hard-coded secrets, you need to commit and push your changes to GitHub. This allows you to observe how GitHub updates the security alerts based on the remediated code.

In this task, you commit and push your code updates, then review the process for closing GitHub secret scanning security alerts.

Use the following steps to complete this task:

1. Open the Source Control view in Visual Studio Code.

    Select the Source Control icon from the Activity Bar on the left side, or press `Ctrl+Shift+G` (Windows/Linux) or `Cmd+Shift+G` (Mac).

1. Take a minute to review the file changes.

    You should see the modified files (Program.cs, AppConfig.cs, EmailService.cs, and PaymentService.cs) listed under **Changes**. AppConfig.cs still includes some hard-coded secrets that you intentionally left unfixed to test Push Protection.

1. Create a commit message and the stage and commit the changes.

    Try using the AI-automated **Generate Commit Message** feature or enter a custom commit message.

    You can also enter your own commit message. For example:

    ```plaintext
    Replace hard-coded secrets with environment variables in PaymentService and EmailService classes. Update configuration validation in Program.cs and AppConfig.cs. 
    ```

    Once the commit message is created, click the **Commit** button (checkmark icon). If prompted to stage the changes, select **Yes**.

1. Push (or Sync) the changes to GitHub.

    Click the **Sync Changes** button or the **Push** option in the Source Control view. If you're using the command line, you can run:

    ```bash
    git push origin main
    ```

    > **NOTE**: If Push Protection is already enabled for your repository, you won't be blocked because you've removed secrets from the code rather than adding them.

1. Wait for the push/sync to complete.

1. Open your repository on GitHub.

1. Open the Security tab.

    Click the **Security** tab at the top of your repository page.

1. Select **Secret scanning** from the left sidebar.

1. Notice that Secret Scanning still flags the same secrets.

    Secret Scanning continues to flag secrets in past commits, even after they've been removed in the most recent commit. This behavior is by design to ensure that exposed secrets are properly remediated.

    Here are best practices for managing the Security alerts:

    1. Review the Alert Details: Open the security alert to confirm which secret(s) were detected and verify they are no longer present in the most recent commits.

    1. Invalidate the Secret (If Not Already Done): If the exposed secrets were for sensitive systems (API keys, credentials, etc.), make sure you rotate or invalidate them. Removing the secret from code does not protect you if it has been compromised.

    1. Document Your Actions: Include a comment in the alert that describes the remediation (including the commit SHA and date). This helps with auditing and future reference.

    1. Suppress or Dismiss the Alert: If the secret has been fully remediated (removed and rotated), you can dismiss the security alert in GitHub. Select an appropriate reason (such as “Revoked” or “Used in test”) to help others understand the context.

    1. Protect Your History (Optional): For public repositories or in highly sensitive cases, you may consider rewriting your git history to delete the secret entirely, but be aware this will force contributors to re-clone and can disrupt forks.

    1. Monitor for Future Leaks: Keep Secret Scanning enabled on the repo. Consider enabling push protection to prevent future accidental commits of secrets.

    Summary: Suppress/dismiss the alert only after removing and rotating the secret. Document your response and, if possible, communicate to your team. Be aware: even dismissed secrets remain visible in past commits unless you rewrite history.

1. Close the secret scanning alerts for the remediated secrets.

    Use the following steps to close each of the remediated alerts:

    1. Open an alert and review the details.

    1. Open the associated code file and verify that the secrets have been removed from the code in the current commit.

    1. Go back to the alert, select **Close as**, and then select appropriate reason (such as **Revoked** or **Used in test**). The selected reason should help others understand the context.

    1. Enter a comment summarizing the remediation steps taken. Include the commit number and date.

    1. Select **Close alert**.

    The Slack and Twilio secrets were not remediated. Leave those alerts open to test GitHub's Push Protection feature in the next task.

### Test the GitHub Push protection feature

GitHub's Push Protection feature prevents secrets from being accidentally pushed to your repository. When enabled, it scans commits for known secret patterns and blocks the push if secrets are detected, giving you a chance to remove them before they enter the repository history.

In this task, you enable Push Protection for your repository and test it by attempting to push a commit containing a dummy secret.

Use the following steps to complete this task:

1. Return to the ContosoOrderProcessor app in Visual Studio Code.

1. Open the **Configuration/AppConfig.cs** file in the code editor.

1. Scroll down to find the declaration statement for the **SlackBotToken** constant.

1. Change one digit of the assigned SlackBotToken to a different value.

    This simulates a developer accidentally adding a new hard-coded secret to the code.

1. Save the AppConfig.cs file.

1. Open the SOURCE CONTROL view, and then stage and commit the change.

    For example, enter a commit message, select **Commit**, and then select **Yes** to stage the changes if prompted.

1. Attempt to sync/push the commit.

    For example, select **Sync Changes** and then select **Ok** to push the commit.

1. Notice that the GitHub Push protection feature blocks the push.

    A dialog box appears with the message "Can't push refs to remote".

1. On the dialog box, select **Open Git Log**.

    The log should tell you that the push was rejected because secrets were detected. The error message will list the detected secret pattern and offer instructions on how to proceed.

1. Use the SOURCE CONTROL view to amend the commit and revert the SlackBotToken change in AppConfig.cs.

    For example, use the SOURCE CONTROL view as follows: select **Undo Last Commit**, select **Unstage All Changes**, and then select **Discard Changes**.

Push Protection has successfully prevented a secret from being pushed to your repository. In a real-world scenario, this feature would catch accidental commits of API keys, tokens, passwords, and other sensitive information before they become part of your repository history.

## Clean up

Now that you've finished the exercise, take a minute to ensure that you haven't made changes to your GitHub account or GitHub Copilot subscription that you don't want to keep. For example, you might want to delete the ResolveGitHubSecurityAlerts repository. If you're using a local PC as your lab environment, you can archive or delete the local clone of the repository created for this exercise.
