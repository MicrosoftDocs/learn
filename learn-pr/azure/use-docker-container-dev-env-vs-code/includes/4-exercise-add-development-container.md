When you're setting up the dev container for a project, you'll need to add a container configuration to that project first. A container configuration sets up your environment in Visual Studio Code.

In this exercise, you'll add a dev container and open the Products Dashboard project in the container. 

## Add a dev container

1. Open the Command Palette.
2. Type **add dev container**.
3. Select **Remote-Containers: Add Development Container Configuration Files**.
4. Select the following options:

   | Option                                      | Value       |
   | ------------------------------------------- | ----------- |
   | Select a container configuration definition | Python 3    |
   | Python version                              | 3 (default) |
   | Install Node.js                              | none        |

5. Select **OK**.

A Remote Container configuration will be added to your project. Visual Studio Code will notify you that you can now open the project in a container. For now, dismiss this notification.

:::image type="content" source="../media/open-in-container-notification.jpg" alt-text="Screenshot of the Visual Studio Code notification that asks you to reopen the project in a container.":::

## Inspect configuration files

1. Notice that a new folder called _.devcontainer_ has been added to the project.
1. Expand that folder and notice that it contains both a Dockerfile and a devcontainer.json file.

## Open the project in a container

1. Open the Command Palette.
1. Type **reopen in container**.
1. Select **Remote Containers: Reopen in Container** from the list of available options.

The container will begin building. The initial build might take a few minutes because a new image has to be pulled down and built on your machine. After the container has been built the first time, later builds will be much faster.

> [!IMPORTANT]
> If you're on Windows, you might see a Windows notification from Docker Desktop warning you that performance might be affected. You can safely ignore this warning for this tutorial.

## Inspect the container

1.  Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in Visual Studio Code if it is not already open.
1.  Notice that the terminal probably looks different from your normal terminal.
1.  Run the following command to ensure that Python is there:

    ```bash
    python --version
    ```

    The terminal's output should be the version of Python being used in the container.

## Install project dependencies

Run the following command in the terminal to install the [Flask](https://flask.palletsprojects.com/en/2.0.x/) dependencies that you need to run the project:

```bash
pip3 install --user -r requirements.txt
```

## Run the project

1.  Enter the following command in the terminal to start the project:

    ```bash
    python app.py
    ```

1.  Open the project in a browser by navigating to [http://127.0.0.1:5000](http://127.0.0.1:5000).

    :::image type="content" source="../media/products-dashboard.jpg" alt-text="Screenshot of the Python Products Dashboard application.":::

Great work! You have a Python web application with [Flask](https://flask.palletsprojects.com/en/2.0.x/) running on your machine, and you might not know what those things even are. That's OK! You don't have to. The container takes care of setting up the entire environment.

In the next section, you'll learn how Visual Studio Code uses something called "port forwarding" to allow access to the application in your browser even though it's running within a container. 
