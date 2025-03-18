The devcontainer.json file helps you configure various settings in your containerized Visual Studio Code setup. So far, you've configured a dev container for a Python project. However, there are still some rough edges and setup tasks that you can further automate.

In this exercise, you'll use the `devcontainer.json` file to smooth these edges and make the project work with no setup steps from the developer.

## Install Visual Studio Code extensions

The container comes with the Microsoft Python extension ([as you can see in its base image](https://github.com/devcontainers/images/blob/main/src/python/.devcontainer/devcontainer.json#L42)). The Python extension enables snippets, linting, and IntelliSense in Python files. But the index.html file in the templates folder is a Jinja template, and you need to install a different extension to get syntax highlighting in that file.

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **extension** and select **Extensions: Install Extensions**.
1. In the extension explorer on the right, search for **jinja**.
1. Select **Install**.
1. Right-click the **Jinja** extension from **wholroyd** and select **Add to devcontainer.json**.
1. Return to the devcontainer.json file and notice that the Jinja extension has been added to the `extensions` section.
1. Save the devcontainer.json file.

## Automate dependency installation

Right now, a developer who's setting up the project for the first time has to know to run `pip3 install --user -r requirements.txt` to install dependencies. Without these dependencies, the project won't run, and other developers might not know why.

1. Uncomment the `postCreateCommand` option.

    ```json
    "postCreateCommand": "pip3 install --user -r requirements.txt"
    ```

1. Save the devcontainer.json file.

The container will automatically install dependencies whenever a container is created.

## Rebuild the new container

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **rebuild** and select **Dev Containers: Rebuild Container**.

The container will be rebuilt with the changes you've specified in the devcontainer.json file.

> [!NOTE]
> Whenever a container is rebuilt, the container is removed and completely recreated. Terminal history is not persisted when a container is rebuilt.

## Examine syntax highlighting provided by the Jinja extension

1. Open the `templates/index.html` file.
1. Scroll down to line 33 and notice that syntax highlighting is on the `for` loop. This syntax highlighting is enabled by the Jinja extension.

   :::image type="content" source="../media/for-loop.jpg" alt-text="Screenshot of a Jinja template, emphasizing a for loop with syntax highlighting.":::

## Run the app

1. Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the Visual Studio Code integrated terminal.
1. Run the app by using the following command:

    ```bash
    python app.py
    ```

1. Notice that you didn't have to install any dependencies. The application simply runs.

The container is now customized and automated for your agency. Any developer who opens this project by using Dev Containers can immediately run it and get to work writing code.

In the next unit, you'll learn how to install additional software in the dev container.
