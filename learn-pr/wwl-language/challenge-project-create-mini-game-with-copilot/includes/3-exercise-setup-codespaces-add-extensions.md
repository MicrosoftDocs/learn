


Your goal is to develop a Python console minigame application using GitHub Copilot. As you're working in a Codespace, you'll need to install the GitHub Copilot extension by updating the dev container configuration file.

## What is a Dev Container?
Development containers, or dev containers, are Docker containers that are specifically configured to provide a fully featured development environment. Whenever you work in a codespace, you are using a dev container on a virtual machine.

You can configure the dev container for a repository so that codespaces created for that repository give you a tailored development environment, complete with all the tools and runtimes you need to work on a specific project.

The diagram below, taken directly from the official [Visual Studio Code docs](https://code.visualstudio.com/docs/remote/containers), illustrates this:

![Dev Container Diagram](./media/dev-container.png)

## Specification
In this challenge exercise, you'll need to open the `devcontainer` folder and update the `devcontainer.json` JSON file to add the GitHub Copilot extension.

- Codespaces identify the extensions that should be installed by the Visual Studio Code marketplace `id`.
- The GitHub Copilot extension identification is `GitHub.copilot`.

By adding the GitHub Copilot extension to this file, you're ensuring that it is installed in the development container and available for use in the Codespace.

## Check your work

1. Access your Codespaces and open the `app.py` file in Visual Studio Code.
2. Start typing the comment:

    ```python
    # write 'hello world' to the console
    ```

3. GitHub Copilot should complete the code for you. The result should be similar to the following:

    ```python
    # write 'hello world' to the console
    print('hello world')
    ```

4. Run the application with the `python app.py` command in the terminal and check if the result is similar to the following:

    ```bash
    hello world
    ```

After validating the results of this exercise, proceed to the next exercise in this challenge.