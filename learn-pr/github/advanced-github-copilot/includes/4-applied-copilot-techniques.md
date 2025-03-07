
In previous units, we showed how to set up Copilot and mentioned how it can make you faster as a developer starting to write code.

In this unit, let's discuss how Copilot can help you with existing projects and help you with more complicated tasks.

## Advanced tasks with GitHub Copilot

It's common to work with an existing project as an engineer. When fixing code or implementing features, we need to write documentation and tests and work with terminal commands. Let's go through some ways you can accomplish this using GitHub Copilot.

### Implicit prompts

Although you can be specific in prompts for getting GitHub Copilot guidance, you can take advantage of features that implicitly provide a precrafted prompt to get a good answer.

For example, if you're working on a Python project, and you have a file open with the following code that has a bug in it:

```python
with open("file.txt", "r") as file:
    # Read the file and print the content
    contents = file.read
```

After selecting the code and using **Ctrl+i** on Windows or **Command+i** on a Mac, you can ask GitHub Copilot to help you fix the code using the inline chat and the `/fix` slash command.

If you only type `/fix`, you might get a response from GitHub Copilot similar to this: _"To fix the code, I would add parentheses after file.read to call the read method and fix the typo in the method name."_

Using slash commands allows for easier interaction with GitHub Copilot and helps you get better responses without having to write longer prompts.

Combining features like slash commands with inline chat allows you to choose the way that works best for you and the code you're working on.

### Selective context

GitHub Copilot can be customized to provide suggestions based on the context you're working on. For example, you can ask GitHub Copilot to provide suggestions based on the entire workspace or the terminal output.

GitHub Copilot can give you an accurate suggestion for your project without requiring you to open many files. Imagine you need to package your project using a _Dockerfile_. A _Dockerfile_ is a special file that needs to have specific instructions to package your project. You can use the `@workspace` agent to ask GitHub Copilot how to help you out. For example, open GitHub Copilot Chat and type the following:

```text
@workspace I need to create a Dockerfile for this project, can you generate one that will help me package it?
```

You'll get a response back that explains the steps to create a _Dockerfile_ for your project, along with some explanation on what the steps of the file are going to do.

As always, if the suggestions aren't exactly what you are looking for, you can reword the prompt and be more specific. For example, you could ask GitHub Copilot to use a specific step when creating the _Dockerfile_:

```text
@workspace help me create a Dockerfile to package this project but make sure you are using a Virtual Environment for Python.
```

If you're stuck or not getting the results you want, then you can reword the prompt or start writing code for Copilot to autocomplete.

>[!Note]
> Although you can be specific with `@workspace`, by default GitHub Copilot uses open files in your text editor as additional context.
