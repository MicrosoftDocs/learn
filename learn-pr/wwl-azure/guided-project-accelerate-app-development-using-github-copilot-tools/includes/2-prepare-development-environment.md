In this guided project, you'll use GitHub Copilot in a Visual Studio Code environment to review, document, and complete an in-process application.

> [!IMPORTANT]
> To complete this guided project module, you must have an active subscription for GitHub Copilot in your personal GitHub account, or you must be assigned to a subscription managed by an organization or enterprise. To complete guided project exercises, you must configure your account to allow suggestions that match public code. If you're a member of an organization on GitHub Enterprise Cloud who has been assigned a GitHub Copilot seat through your organization, the setting for suggestions matching public code will be inherited from your organization or enterprise. If your account blocks suggestions that match public code, project exercises won't work as expected.

## Project overview

An accident damaged the servers that host the library database and backend services. It'll take weeks for administrators to obtain the funding/authorization required to replace the servers and get the system back online. Your department needs to develop a temporary solution that will enable librarians to perform basic functions.

Your team has met with the librarians. They need a minimal solution that enables them to provide library patrons with essential services like book loans and returns. Your team investigates the available resources and develops a plan. Initially, only you and one other coworker will be assigned to the project. The local government has closed the library until your temporary solution is available. You have three days develop a v1 solution that enables the library to reopen.

While your colleague begins working on the software, you use library records to create JSON files that represent the library's patron accounts, books, and book loans. By the end of the second day you're ready to begin helping with the code. The solution is a console application that can be run on one of the library's laptop computers. The librarians understand that there isn't time for a pretty interface, but stress that the app must be secure and reliable. You have one more day before you need to demonstrate version 1.0 of your app.

You'll use GitHub Copilot to help get the work done as efficiently as possible. If all goes well, your app will be used to support the library's book drives and other offsite functions in the future.

## Setup

This guided project module can be run on a local PC or hosted environment. The setup process includes the following steps:

- Review the resource requirements.
- Install or update coding tools.
- Configure Visual Studio Code extensions.
- Download the library application code developed by your coworker.

### Resource requirements

The development environment must include the following resources:

- A local PC or hosted environment with the following software provisioned:

    - Git version control software.
    - The .NET SDK 8.0 (or the latest LTS version).
    - Visual Studio Code updated to the latest version.
    - The C# Dev Kit extension (from Microsoft) installed in Visual Studio Code.
    - The GitHub Copilot and GitHub Copilot Chat extensions (from GitHub) installed in Visual Studio Code.

- A GitHub account with an active GitHub Copilot subscription.

### Install or update coding tools

Ensure that your development environment is set up with the following software:

- Install/update Git version control software.
- Install/update .NET SDK 8.0 or latest LTS version.
- Install/update the latest version Visual Studio Code.

### Configure Visual Studio Code

Ensure that Visual Studio Code is configured with the C# Dev Kit and GitHub Copilot extensions:

- Install the C# Dev Kit extension from the Visual Studio Code marketplace. For .NET debugging, follow the instructions in the C# Dev Kit debugging documentation.
- Install the GitHub Copilot extension from the Visual Studio Code marketplace. Ensure that you have a GitHub account with an active subscription for GitHub Copilot.

### Set up the library application in Visual Studio Code

Your colleague has developed an initial version of the library application and has made it available as a .zip file. To prepare for the guided project exercises, you need to perform the following tasks:

- Download the zip file.
- Extract the code files.
- Ensure that the solution builds in your development environment.

Use the following steps to set up the library application:

1. To download the zip file containing your code project, select the following link: [GuidedProjectApp](https://raw.githubusercontent.com/MicrosoftLearning/APL-2007-Accelerate-app-development-by-using-GitHub-Copilot/master/LearnModuleExercises/Downloads/GuidedProjectApp.zip).

1. Unzip the downloaded project files.

    Unzip the code project in your development environment. For example:

    1. On your local machine, navigate to your downloads folder.

    1. Right-click **GuidedProjectApp.zip**, and then select **Extract all**.

    1. Select **Show extracted files when complete**, and then select **Extract**.

    1. Make note of the extracted folder location.

1. Copy the extracted **GuidedProjectApp** folder to a location that easy to access, such as your Windows Desktop folder.

1. Open the **AccelerateDevGitHubCopilot** folder in Visual Studio Code.

    For example:

    1. Open Visual Studio Code on your PC.

    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.

    1. Navigate to the Windows Desktop folder, open the **GuidedProjectApp** folder, and locate the **AccelerateDevGitHubCopilot** folder.

    1. Select **AccelerateDevGitHubCopilot** and then select **Select Folder**.

1. In the Visual Studio Code SOLUTION EXPLORER view, verify the following solution structure:

    - AccelerateDevGitHubCopilot\
        - src\
            - Library.ApplicationCore\
            - Library.Console\
            - Library.Infrastructure\
        - tests\
            - UnitTests\

1. Ensure that the solution builds successfully.

    For example, in the SOLUTION EXPLORER view, right-click **AccelerateDevGitHubCopilot**, and then select **Build**.

    You'll see several Warnings, but there shouldn't be any Errors.

You're now ready to begin the guided project exercises.
