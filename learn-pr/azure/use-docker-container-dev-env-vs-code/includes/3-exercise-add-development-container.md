When you're setting up the dev container for a project, you'll need to add a container configuration to that project first. A container configuration sets up your environment in Visual Studio Code.

In this exercise, you'll clone one of the agency's projects: a Products Dashboard written in Python. You'll then add a dev container and open that project in the container. Don't worry if you aren't familiar with Python. This unit will give you all of the code and tools that you need to run your app.

## Clone the sample repo

1.  Ensure that [Docker Desktop](https://www.docker.com/products/docker-desktop) is installed and running on your machine.
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
1.  Select **Open** from the notification in Visual Studio Code.

The project should now be open in Visual Studio Code.

> [!NOTE]
> If you receive a warning in Visual Studio Code about selecting a Python interpreter, you can safely ignore it.

### Windows Only : Configure Docker

If you are using Windows and are **not** using the [Windows Subsystem For Linux (WSL)](https://docs.microsoft.com/windows/wsl/about?WT.mc_id=aiml-24635-ayyonet) backend, you will need to allow Docker to access the sample project through the File Sharing settings.

1. Right-click on the Docker task bar item, select Settings > Resources > File Sharing and add the location where you cloned the sample project in the previous step. This option is not available if you have enabled the WSL 2 back-end.

   :::image type="content" source="../media/docker-file-sharing.png" alt-text="Screenshot of the Docker Desktop client with File Sharing settings open." loc-scope="other"::: <!-- no-loc -->

## Install the Remote - Containers extension

1. Press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd> to open the **Extensions** viewlet, or click on the "Extensions" icon in the activity bar.
1. Type **remote containers**.
1. Locate the **Remote - Containers** extension and select the **Install** button.

   :::image type="content" source="../media/install-remote-containers.png" alt-text="Screenshot of the Visual Studio Code extension gallery showing Remote Containers extension." loc-scope="other"::: <!-- no-loc -->

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
   | Install Nodejs                              | Clear       |

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

    The terminal's output should be the version of Python being used in the container, such as `Python 3.9.0.`

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

1.  Select **Open in Browser**.

    This step should open a browser pointed to **localhost:5000**, and you'll see the Products Dashboard.

    :::image type="content" source="../media/products-dashboard.jpg" alt-text="Screenshot of the Python Products Dashboard application.":::

Great work! You have a Python web application with [Flask](https://flask.palletsprojects.com/en/2.0.x/) running on your machine, and you might not know what those things even are. That's OK! You don't have to. The container takes care of setting up the entire environment.

You might have noticed in the last notification that Visual Studio Code said: "127.0.0.1:5000 on remote is now forwarded to 127.0.0.1:5000 locally." This is called _port forwarding_, and it's what allows you to access an application running inside the container. In the next section, you'll learn more about port forwarding and how you can use it to make anything in a container feel like it's running locally.
