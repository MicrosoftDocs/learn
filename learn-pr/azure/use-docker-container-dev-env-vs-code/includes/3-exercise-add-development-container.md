When you're setting up the dev container for a project, you'll need to add a container configuration to that project first. A container configuration sets up your environment in Visual Studio Code. 

In this exercise, you'll clone one of the agency's projects: a Products Dashboard written in Python. You'll then add a dev container and open that project in the container. Don't worry if you aren't familiar with Python. This unit will give you all of the code and tools that you need to run your app.

## Clone the sample repo

1.  Ensure that Docker Desktop is running on your machine.
1.  Copy the URL for the sample repo to your clipboard.

    ```bash
    https://github.com/MicrosoftDocs/mslearn-python-products
    ```

1.  Open a new instance of Visual Studio Code.
1.  Press <kbd>F1</kbd> to open the Command Palette.
1.  Type **clone**.
1.  Select **Git: Clone**.
1.  Paste in the URL to the sample repo.
1.  Select a location on your disk where the project can be cloned to.

The project should now be open in Visual Studio Code. 

## Install the Remote - Containers extension

1. Press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd> to open the **Extensions** viewlet.
1. Type **remote containers**.
1. Locate the **Remote - Containers** extension and select the **Install** button.

The Remote - Containers extension will be installed, and you'll have access to the commands that it adds to Visual Studio Code.

## Add a dev container

1. Open the Command Palette.
2. Type **add dev container**.
3. Select **Remote-Containers: Add Development Container Configuration Files**.
4. Select the following options:

   | Option                                      | Value       |
   | ------------------------------------------- | ----------- |
   | Select a container configuration definition | Python 3    |
   | Python version                              | 3 (default) |
   | Install Nodejs                              | Clear     |

5. Select **OK**.

A Remote Container configuration will be added to your project. Visual Studio Code will notify you that you can now open the project in a container. For now, dismiss this notification.

:::image type="content" source="../media/open-in-container-notification.jpg" alt-text="Screenshot of the Visual Studio Code notification that asks you to reopen the project in a container.":::

## Inspect configuration files

1. Notice that a new folder called *.devcontainer* has been added to the project.
1. Expand that folder and notice that it contains both a Dockerfile and a devcontainer.json file.

## Open the project in a container

1. Open the Command Palette.
1. Type **reopen in container**.
1. Select **Reopen in Container** from the list of available options.

The container will begin building. The initial build might take a few minutes because a new image has to be pulled down and built on your machine. After the container has been built the first time, later builds will be much faster.

> [!IMPORTANT]
> If you're on Windows, you might see a Windows notification from Docker Desktop warning you that performance might be affected. You can safely ignore this warning for this tutorial.

## Inspect the container

1.  Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in Visual Studio Code.
1.  Notice that the terminal probably looks different from your normal terminal.
1.  Run the following command to ensure that Python is there:

    ```bash
    python --version
    ```

    The terminal's output should be the version of Python being used in the container, such as `Python 3.9.0.`

## Install project dependencies

Run the following command in the terminal to install the Flask dependencies that you need to run the project:

```bash
pip3 install --user -r requirements.txt
```

## Run the project

1.  Enter the following command in the terminal to start the project:

    ```bash
    python app.py
    ```

1.  Select **Open in Browser**.

    This step should open a browser pointed to **localhost:5000**, and you'll see the Products Dashboard.

    :::image type="content" source="../media/products-dashboard.jpg" alt-text="Screenshot of the Python Products Dashboard application.":::

Great work! You have a Python web application with Flask running on your machine, and you might not know what those things even are. That's OK! You don't have to. The container takes care of setting up the entire environment.

You might have noticed in the last notification that Visual Studio Code said: "127.0.0.1:5000 on remote is now forwarded to 127.0.0.1:5000 locally." This is called *port forwarding*, and it's what allows you to access an application running inside the container. In the next section, you'll learn more about port forwarding and how you can use it to make anything in a container feel like it's running locally.
