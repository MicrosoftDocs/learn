.NET is a cross-platform, open-source developer platform that can be used to develop different types of applications. It includes the software languages and code libraries used to develop .NET applications. You can write .NET applications in C#, F#, or Visual Basic.

The .NET runtime is the code library that's required to run your C# applications. You may also see the .NET runtime referred to as the Common Language Runtime, or CLR. The .NET runtime isn't required to *write* your code, but it's required to actually *run* your applications.

## Check to see if .NET is already installed

1. Open the Windows **Command Prompt** app or another application that displays a terminal command prompt.

    The Command Prompt and Windows PowerShell apps can be found on the Windows Start menu. You can also open either of these apps from the Windows Taskbar by entering either **cmd** or **powershell** respectively.

    A command prompt, such as `C:\Users\AccountName>`, should be displayed.

1. At the command prompt, type: `dotnet --version` and then press the Enter key.

    This command displays the version number if .NET is installed on your PC.

1. Take a moment to view the response to your `dotnet --version` command.

    If you receive an error message telling you that the term `dotnet` isn't recognized, then you don't have the .NET SDK installed.

    If a version of .NET is installed, you should see a response message listing the version number similar to the following:

    `7.0.306`

1. Close the command prompt window.

## Install the .NET 7 Software Development Kit

If the .NET 7 Software Development Kit isn't already installed, install it now. Having the latest supported version of the .NET platform installed is recommended. Although .NET 6 is also supported, .NET 7 includes improvements that you may find helpful.

> [!NOTE]
> The C# training series that's available on Microsoft Learn uses .NET 7. Ensure that you have .NET 7 installed if you plan on completing this training.

1. Open a new Internet browser window.

1. To open the download page for the .NET SDK, navigate to the following URL:

    [https://dotnet.microsoft.com/download](https://dotnet.microsoft.com/download)

1. On the **Download .NET** page, select the *recommended* version of the .NET SDK.

    Your browser downloads the .NET SDK installer file.

1. Wait for the installer file to finish downloading.

1. Run the .NET SDK installer file.

    On a Windows PC, you can find your Downloads folder using File Explorer. Double-click the installation file to begin the installation process.

1. On the .NET SDK Installer window, select **Install**.

1. Wait for the installation to complete.

    Installation should take about a minute. Once installation is complete, a message displays confirming the installation was successful.

1. To close the installer window, select **Close**.

## Verify your installation

1. Open an application that displays a terminal command prompt.

1. At the command prompt, type: `dotnet --version` and then press the Enter key.

    You need to open a new command prompt window after installing the .NET SDK to ensure that it's detected.

1. Verify that a .NET 7 version number is listed.

    The version number displayed should be similar to: `7.0.306`

    You're likely to see a more recent version number. But it should begin with `7.` if you installed the .NET 7 SDK.

Congratulations on getting .NET installed. You're now ready to start working in Visual Studio Code.
