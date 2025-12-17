The C# Dev Kit extension for Visual Studio Code helps you to install the .NET Software Development Kit (SDK). The .NET SDK is required to run and debug C# applications.

In this exercise, you install the .NET SDK on your computer.

## Check to see if .NET is already installed

Use the following steps to complete this section of the exercise:

1. Ensure that you have Visual Studio Code open.

1. On the Terminal menu, select **New Terminal**.

    A command prompt, such as `C:\Users\AccountName>`, should be displayed.

1. At the command prompt, type: `dotnet --version` and then press the Enter key.

    This command displays the version number if .NET is installed on your PC.

1. Take a moment to view the response to your `dotnet --version` command.

    If you receive an error message telling you that the term `dotnet` isn't recognized, the .NET SDK isn't installed.

    If a version of .NET is installed, you should see a response message listing the version number similar to the following:

    `10.0.100`

1. Close the Terminal panel.

## Install the .NET SDK

Having one of the latest supported versions of the .NET SDK installed is recommended. Although .NET 8 and 9 are also supported, .NET 10 (long term support) includes the latest improvements and features.

Visual Studio Code and the C# Dev Kit helps you to install the .NET SDK.

> [!NOTE]
> The C# training series that's available on Microsoft Learn was developed using .NET 10, and is compatible with .NET 10 and later versions. Ensure that you have .NET 10 installed if you plan on completing this training.

Use the following steps to complete this section of the exercise:

1. On the View menu, select **Command Palette**.

1. At the Command Palette prompt, type **.NET: Install** and then select **.NET: Install New .NET SDK**.

1. Under **Latest**, ensure that **.NET 10** is selected, and then select **Install**.

1. Wait for the .NET SDK to download and install.

    The installation process may take a few minutes to complete.

1. When the installation is complete, close Visual Studio Code.

## Verify your installation

Visual Studio Code searches for the .NET SDK when it opens. If the .NET SDK is installed, Visual Studio Code should detect it.

Use the following steps to complete this section of the exercise:

1. Open Visual Studio Code.

1. Close the Welcome page, and then open a Terminal panel.

    To open the Terminal panel, on the Terminal menu, select **New Terminal**.

1. At the Terminal command prompt, type: `dotnet --version` and then press the Enter key.

    You need to open a new command prompt window after installing the .NET SDK to ensure that it's detected.

1. Verify that the .NET SDK is installed.

    If you installed the .NET 10 SDK, the version number will begin with `10.`, for example: `10.0.100`.

    You may see a more recent version number, that's okay.

1. Close the Terminal panel.

Congratulations on getting .NET installed. You're now ready to start writing, running, and debugging C# applications using Visual Studio Code.
