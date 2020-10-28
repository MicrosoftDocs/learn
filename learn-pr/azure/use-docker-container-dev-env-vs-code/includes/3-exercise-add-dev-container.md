When setting up the dev container for a project, you'll need to add a container configuration to that project first. In this exercise, you'll clone one of the agencies projects - a Products Dashboard written in Python. You'll then add a dev container and then open that project in the container.

## Clone the sample repo

1.  Ensure Docker Desktop is running on your machine
1.  Copy the URL for the sample repo to your clipboard

        https://github.com/burkeholland/python-products.git

1.  Open a new instance of Visual Studio Code
1.  Press <kbd>F1</kbd> to open the Command Palette
1.  Type "clone"
1.  Select "Git: Clone"
1.  Paste in the URL to the sample repo
1.  Select a location on your disk where the project can be cloned to

The project should now be open in VS Code. Next, you'll add a dev container to this project. You'll be able to run the project, even if you don't have Python installed.

## Add a Dev Container

1. Open the Command Palette
1. Type "add dev container"
1. Select "Remote-Containers: Add Development Container Configuration Files"
1. Select the following options...

| Option         | Value       |
| -------------- | ----------- |
| Python version | 3 (default) |
| Install Nodejs | Uncheck     |

A Remote Container configuration will be added to your project. VS Code will notify you that you can now open the project in a container. For now, dismiss this notification.

:::image type="content" source="../media/open-in-container-notification.jpg" alt-text="VS Code notification asking to reopen the project in a container":::

## Inspect configuration files

1. Notice that a new folder has been added to the project called ".devcontainer"
1. Expand that folder and notice that it contains both a `Dockerfile` and a `devcontainer.json` file

## Open the project in a container

1. Open the Command Palette
1. Type "reopen in container"
1. Select "Reopen in Container" from the list of available options

The container will begin building. The initial build may take a few minutes as a new image has to be pulled down and built on your machine. Once the container has been built the first time, subsequent builds will be much faster.

> [!IMPORTANT]
> If you are on Windows, you may see a Windows Notification from Docker Desktop warning you that performance may be affected. You can safely ignore this warning for this tutorial.

## Inspect the container

1.  Press <kbd>Ctrl</kbd> + <kbd>`</kbd> to open the integrated terminal in VS Code
1.  Notice that the terminal probably looks different than your normal terminal
1.  Run the following command to ensure Python is there...

        python --version

    The terminal should output the version of Python being used in the container, i.e. "Python 3.9.0"

## Install Project Dependencies

1.  Run the following command in the terminal to install the Flask dependencies needed to run the project...

        pip3 install --user -r requirements.txt

## Run the project

1.  Enter the following command in the terminal to start the project...

        python app.py

1.  Click "Open in Browser"

    This should open a browser pointed to "localhost:5000" and you will see the Products Dashboard.

    :::image type="content" source="../media/products-dashboard.jpg" alt-text="Python Products Dashboard application":::

Great work! You've got a Python web application with Flask running on your machine and you might not know what either of those things even are. That's OK! You don't have to. The container takes care of setting up the entire environment.

You may have noticed in that last notification that VS Code said that "127.0.0.1:5000 on remote is now forwarded to 127.0.0.1:5000 locally." This is called "Port Forwarding," and it's what allows you to access an application running inside the container. In the next section, you'll learn more about Port Forwarding and how you can use it to make anything in a container feel like it's running locally.
