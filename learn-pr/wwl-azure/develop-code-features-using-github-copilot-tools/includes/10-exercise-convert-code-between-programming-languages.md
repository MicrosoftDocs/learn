GitHub Copilot can help you to convert code from one programming language to another. For example, you can ask GitHub Copilot to convert a function or code snippet to another programming language.

You can complete the following types of code conversions by using GitHub Copilot:

- Convert an entire code file to another programming language.
- Convert a function to another programming language.
- Convert a code snippet to another programming language.

Each of the chat interfaces (Chat view, Quick Chat window, and inline chat) can be used to convert code between programming languages. Your choice of chat interface depends on your preference and the complexity of the code that you want to convert.

## Convert code between programming languages by using the Chat view

Suppose you're just getting started on the `QuarterlyIncomeReport` project. You discuss the project goals with a colleague. They mention that they have a Python file that could provide some of the features that you're looking for. They point you the repository for the Python code. You decide to open the Python code project in Visual Studio Code and use the Chat view to convert the Python code to C#.

1. Open the SamplePython project.

    This project contains a Python version of the `QuarterlyIncomeReport` project that you've worked on during this module. You can have GitHub Copilot explain the code to you using the Chat view or Explain This smart action.

1. Run the Python application.

    Notice that the output from the Python application is essentially the same as the output from the C# application that you created earlier.

1. Open the `main.py` Python file.

    The Python file contains a function that generates sales data. You want to convert this Python code to C#.

1. Select the entire file contents.

1. Open the Chat view and then enter the following prompt:

    ```plaintext
    Convert #selection to C#
    ```

1. Take a moment to review the response from GitHub Copilot.

    The response should contain the C# version of the Python code that you selected.

1. Open a second instance of Visual Studio Code.

1. Open the Chat view, enter the following prompt:

    ```plaintext
    @workspace /new console application in C# NET8 named APL2007M3B. Only .cs and .csproj files. Enable ImplicitUsings and Nullable
    ```

    If Copilot responds with an error message about the "path argument", try the same prompt again.

1. Select **Create Workspace**

1. In the Open Folder dialog, select the **Desktop** folder and then select **Select as Parent Folder**.

    wait for the workspace to be created.

1. When the workspace is created, select **Program.cs**, and delete the file contents.

1. Switch to the instance of Visual Studio Code that contains the Python code.

1. Scroll to the top of the Chat view and click the **Copy** button to copy the generated C# code to the clipboard.

1. Switch to the instance of Visual Studio Code that contains the C# code.

1. Paste the C# code into the Program.cs file.

1. Save the Program.cs file.

1. Run the C# application.

    Notice that the output from the C# application is essentially the same as the output from the Python application.

    If you have time, take a few minutes to review the differences between the converted C# code and the C# code from the previous unit.

## Convert code between programming languages by using the inline chat

1. Switch back to the Visual Studio Code instance containing the Python project that you opened earlier.

1. Select the code in the main.py file.

1. Open the inline chat and enter the following prompt:

    ```plaintext
    Convert #selection to C#
    ```

1. Review the response from GitHub Copilot and then select **Accept**.

    The Python file should now contain C# code.

1. Copy the generated C# code to the clipboard.

1. Close the main.py file without saving the changes.

1. Switch to the Visual Studio Code instance that contains the C# project and open the Program.cs file.

1. To overwrite the existing C# code, paste the C# code from the clipboard (converted from Python using inline chat) over the contents of the Program.cs file.

1. Save the Program.cs file.

1. Run the C# application.

    Notice that the output from the C# application is essentially the same as the output from the Python application.

When you use GitHub Copilot to convert code between programming languages, try the conversion in both the Chat view and the inline chat. Although both tools share the same AI model, their results may differ. Trying both tools can help you to determine which tool is best for your specific use case.
