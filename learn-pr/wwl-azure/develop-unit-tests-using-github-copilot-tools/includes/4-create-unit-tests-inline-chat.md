The Inline Chat feature of GitHub Copilot allows you to create unit tests directly in the code editor. This is useful when you want to create tests for specific functions or methods without having to switch to the Chat view, but want more control than the Generate Tests smart action provides.

The Inline Chat feature can be used to create unit tests for an entire file, or a specific selection of code.

To create unit tests using Inline Chat, follow these steps:

1. Open the file that contains the code you want to test.

1. Select the code block that needs to be tested using a unit test (typically a function or method).

1. Open an Inline Chat session.

    Use the **Ctrl+I** keyboard shortcut to open the Inline Chat session. Alternatively, you can select **Editor Inline Chat** from one of the GitHub Copilot menus.

    > [!NOTE]
    > If the file is part of an active Chat agent session, pressing **Ctrl+I** generates the option to "Add File to Chat" or "Add Selection to Chat". To always use regular inline chat, set `inlineChat.askInChat` to `false` in Visual Studio Code settings.

1. Select the **Add Selection to Chat** option.

1. In the Chat view, enter a prompt that generates unit tests for the selected code.

    For example: "/tests Generate unit tests for this method. Validate both success and failure, and include edge cases."

1. Review the suggested unit tests.

    You can make adjustments, such as changing the test names, modifying or removing test cases, or adding additional assertions.

    The generated tests are displayed in the code editor. GitHub Copilot generates test code in an existing test file, or creates a new test file if one doesn't exist.

1. Select **Accept** or **Close** to accept or discard the suggested unit tests.

1. Save the test file.

    Test files are typically saved to a separate "tests" directory in a project that's configured for unit tests. Your options will depend on your project's structure and testing framework.

1. Build the project to ensure the test file is included in the build and can be executed.

    Resolve any build errors that may occur.

1. Run the tests to ensure they pass and verify the functionality of your code.

1. If necessary, refine the tests using Inline Chat to add or modify test cases.

## Summary

GitHub Copilot's Inline Chat feature allows you to create unit tests directly in the code editor. This is useful when you want to create tests for specific functions or methods without having to switch to the Chat view, but want more control than the Generate Tests smart action provides. The Inline Chat feature can be used to create unit tests for an entire file, or a specific selection of code. By using Inline Chat, you can generate unit tests that validate both success and failure scenarios, and include edge cases.
