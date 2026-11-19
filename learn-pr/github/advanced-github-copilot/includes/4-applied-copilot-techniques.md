
In previous units, we showed how to set up Copilot and mentioned how it can make you faster as a developer starting to write code.

In this unit, let's discuss how Copilot can help you with existing projects and help you with more complicated tasks.

## Advanced tasks with GitHub Copilot

It's common to work with an existing project as an engineer. When fixing code or implementing features, we need to write documentation and tests and work with terminal commands. Let's go through some ways you can accomplish this using GitHub Copilot.

### Focused fixes with inline chat

When a problem is limited to a few lines, a short, specific request in inline chat can get you a good answer without a long prompt.

For example, suppose you're working on a Python project and have a file open with the following code that has a bug in it. To try the example yourself, first create a file named `file.txt` in the directory from which you'll run the code, and add a short line of text to it.

```python
with open("file.txt", "r") as file:
    # Read the file and print the content
    contents = file.read
```

Select the code, and then press **Ctrl+I** on Windows or **Command+I** on macOS, or select **Chat** > **Open Inline Chat**. If the shortcut opens **Ask in Chat** instead, the file is part of an active chat editing session, so use a file outside that session. Ask GitHub Copilot to fix the code:

```text
Fix the selected code so it reads the file contents and prints them.
```

Check that Copilot's suggestion addresses the actual bug. The expression `file.read` refers to the method without calling it, so `contents` holds the method rather than the text of the file. Call `file.read()` to obtain the contents, and then print the returned value. There's no typo in the method name. The corrected code looks like this:

```python
with open("file.txt", "r") as file:
    contents = file.read()
    print(contents)
```

When you run the corrected code, it prints the line of text from `file.txt`.

### Plan larger changes

Use the Chat view's `/plan` command when you want to examine an approach before making changes, such as the planning request for a new route shown earlier in this module. For focused fixes, explanations, test generation, or documentation, describe the desired result in natural language and provide the relevant code. The prompt in the previous example does this: it states what the selected code should do, which gives inline chat a clear task.

Review the plan with the controls described earlier. A plan doesn't implement the application change or establish that tests pass. Use **Approve Plan Only** when you'll make the change yourself or through inline chat, or **Implement Plan** when you want the agent to start the reviewed implementation. Combining planning in the Chat view with focused requests in inline chat lets you choose the approach that works best for you and the code you're working on.

### Provide relevant context

Copilot can search your project for relevant code, but this doesn't mean every file is included in every request. Attach important files explicitly. For example, in the weather API codespace that you created during setup:

1. Open the Chat view and choose **Ask**.
1. Select **Add Context**, choose **Files**, and attach `main.py`, `weather.json`, and `test_main.py`. Confirm that the attachments appear in the prompt.
1. Ask the following question, and compare the response with the attached files.

   ```text
   Explain how this API loads weather data and how its routes use the region, city, and month keys. Identify the existing tests. Don't change files.
   ```

Explicit context also helps when a request depends on several files. Imagine you need to package your project using a Dockerfile. A Dockerfile is a special file that needs to have specific instructions to package your project. Before you ask for one, attach `requirements.txt` and `main.py` so that the response can reflect the project's actual dependencies and application code. Then, with **Ask** selected, enter a prompt like this one:

```text
I need to create a Dockerfile for this project. Using the attached requirements.txt and main.py, can you generate one that will help me package it?
```

You'll get a response back that explains the steps to create a _Dockerfile_ for your project, along with some explanation on what the steps of the file are going to do.

As always, if the suggestions aren't exactly what you're looking for, you can reword the prompt and be more specific. For example, you could ask GitHub Copilot to use a specific step when creating the _Dockerfile_:

```text
Help me create a Dockerfile to package this project, but make sure you're using a virtual environment for Python.
```

Treat the response as a proposal to inspect, not proof that the generated image runs. This example shows how context shapes a response. You don't need to create, build, or deploy a container for this module.

### Include terminal output

When you need help with a command or an error, give Copilot the actual output rather than referring to "the error I'm seeing." Attach the relevant terminal output if your context picker offers it, or paste the command and its error text into the prompt. Attach the related source and test files, too. Remove secrets, such as tokens or passwords, before you share output. For example:

```text
Explain the failure in the test output below. Identify the relevant code and suggest a focused correction.

<paste the test command and its complete output here>
```

If you're stuck or not getting the results you want, then you can reword the prompt or start writing code for Copilot to autocomplete.

> [!NOTE]
> Copilot can use editor context and retrieve relevant project content, but opening files doesn't guarantee that all their contents are included. Check the supplied context and confirm generated claims against your source.
