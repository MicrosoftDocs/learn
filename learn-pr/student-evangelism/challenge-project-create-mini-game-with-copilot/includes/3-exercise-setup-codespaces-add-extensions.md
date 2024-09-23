Your goal is to develop a minigame in Python using GitHub Copilot. You have already learned a bit about GitHub Codespaces and GitHub Copilot and how they work. In this challenge exercise, you need to install the GitHub Copilot extension using the dev configuration file under `.devcontainer/devcontainer.json`.

## Specification

- GitHub Codespaces identifies the required extensions using their Visual Studio Code marketplace ID.
- Visit the GitHub Copilot extension on the Visual Studio Marketplace and find the ID.
- Analyze the `.devcontainer/devcontainer.json` file and add the extension.

By adding the GitHub Copilot extension to this file, you ensure that it's installed in the development container and available for use in the Codespace. With each configuration change, Codespaces displays a pop-up with a message indicating that an update has been detected, providing the option to rebuild.

## Check your work

1. Access your Codespaces and open the `app.py` file in Visual Studio Code.
2. Start typing the comment:

    ```python
    # write 'hello world' to the console
    ```

3. GitHub Copilot should complete the code for you. The result should be similar to the following code:

    ```python
    # write 'hello world' to the console
    print('hello world')
    ```

4. Run the application with the `python app.py` command in the terminal and check if the result is similar to the following console message:

    ```bash
    hello world
    ```

After validating the results of this exercise, proceed to the next exercise in this challenge.
