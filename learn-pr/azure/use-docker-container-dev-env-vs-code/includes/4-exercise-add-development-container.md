When you're setting up the dev container for a project, you'll need to add a container configuration to that project first. A container configuration sets up your environment in Visual Studio Code.

In this exercise, you'll add a dev container and open the Products Dashboard project in the container.

## Add a dev container

1. Return to VS Code and the project you cloned earlier.
1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **add dev container** and select **Dev Containers: Add Development Container Configuration Files**.
1. Select the following options:

   | Option                                      | Value       |
   | ------------------------------------------- | ----------- |
   | Select a container configuration template   | Python 3    |
   | Python version                              | 3.11        |
   | Select additional features to install       | Select **OK** |

> [!IMPORTANT]
> In the first step when selecting a configuration template, you may need to select "Show All Definitions..." from the list, and then select Python once the full set of templates loads.

A Dev Container configuration will be added to your project. Visual Studio Code will notify you that you can now open the project in a container. For now, dismiss this notification.

## Inspect configuration files

1. Notice that a new folder called _'.devcontainer'_ has been added to the project.
1. Expand that folder and notice that it contains a devcontainer.json file.

## Open the project in a container

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **reopen in container**.
1. Select **Dev Containers: Reopen in Container** from the list of available options.

The container will begin building. The initial build might take a few minutes because a new image has to be pulled down and built on your machine. After the container has been built the first time, later builds will be much faster.

## View the Remote Indicator

When the container build is complete, you can confirm that you're connected to the container by examining the Remote Indicator. You should also now see your project files loaded in VS Code.

- Examine the Remote Indicator by viewing the bottom left-hand corner of VS Code. Notice that it now displays "Dev Container: Python 3".

    :::image type="content" source="../media/remote-indicator.png" alt-text="Screenshot of the Remote Indicator with text that says dev container python 3":::

> [!IMPORTANT]
> You might see notifications about Pylance or improving performance on Windows. You can safely dismiss any notifications that you see in VS Code. You won't need to do those things.

## Inspect the container

1. Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in Visual Studio Code if it isn't already open.
1. Notice that the terminal prompt might look different than your normal terminal prompt.

    :::image type="content" source="../media/terminal-prompt.png" alt-text="VS Code integrated terminal prompt":::

1. Run the following command to ensure that Python is installed:

    ```bash
    python --version
    ```

    The terminal's output should be the version of Python used in the container.

## Install project dependencies

- Run the following command in the terminal to install the [Flask](https://flask.palletsprojects.com/) dependencies that you need to run the project:

    ```bash
    pip3 install --user -r requirements.txt
    ```

## Run the project

1. Enter the following command in the terminal to start the project:

    ```bash
    python app.py
    ```

1. Open the project in a browser by navigating to [http://127.0.0.1:5000](http://127.0.0.1:5000).

    :::image type="content" source="../media/products-dashboard.jpg" alt-text="Screenshot of the Python Products Dashboard application.":::

Great work! You have a Python web application with [Flask](https://flask.palletsprojects.com/) running on your machine, and you might not know what those things even are. That's OK! You don't have to. The container takes care of setting up the entire environment.

In the next section, you'll learn how to use the `devcontainer.json` file to automate the dependency install and customize VS Code for this Python project.
