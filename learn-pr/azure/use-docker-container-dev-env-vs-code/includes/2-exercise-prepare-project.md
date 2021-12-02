You'll be working with a Python project that shows a dashboard of products. In order to eventually run this project in a container, you'll need the Remote Containers extension for Visual Studio Code. 

In this exercise, you'll clone one of the agency's projects: a Products Dashboard written in Python and install the Remote Containers extension for Visual Studio Code.

## Clone the sample repo

1.  Ensure that [Docker Desktop](https://www.docker.com/products/docker-desktop) is installed and running on your machine.
1.  Copy the URL for the sample repo to your clipboard.

    ```bash
    https://github.com/MicrosoftDocs/mslearn-python-products
    ```

1.  Open a new instance of Visual Studio Code.
1.  Select the **Clone Repository** button in the sidebar, or press <kbd>F1</kbd> to open the Command Palette and search for **Git: Clone**.
1.  Paste in the URL from your clipboard.
1.  Select a location on your disk where the project can be cloned to.
1.  Select **Open** from the notification in Visual Studio Code.
1.  If you see a pop-up that asks if you trust the authors, select "Yes, I trust the authors". 

The project should now be open in Visual Studio Code.

> [!NOTE]
> If you receive a warning in Visual Studio Code about selecting a Python interpreter, you can safely ignore it.

## Install the Remote - Containers extension

1. Press <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>X</kbd> to open the **Extensions** viewlet, or click on the "Extensions" icon in the activity bar.
1. Type **remote containers**.
1. Locate the **Remote - Containers** extension and select the **Install** button.

   :::image type="content" source="../media/install-remote-containers.png" alt-text="Screenshot of the Visual Studio Code extension gallery showing Remote Containers extension." loc-scope="other"::: <!-- no-loc -->

The Remote - Containers extension will be installed, and you'll have access to the commands that it adds to Visual Studio Code.

### Windows Only : Configure Docker

> [!IMPORTANT]
> If you are using Windows Subsystem for Linux (WSL) with Docker, you can skip this section. If you aren't sure, follow the steps below.

If you are using Windows you _may_ need to allow Docker to access the sample project through the File Sharing settings.

1. Right-click on the Docker task bar item, select Settings > Resources > File Sharing and add the location where you cloned the sample project in the previous step. **If you do not see the File Sharing option, you are using WSL with Docker. You can skip this step.**

   :::image type="content" source="../media/docker-file-sharing.png" alt-text="Screenshot of the Docker Desktop client with File Sharing settings open." loc-scope="other"::: <!-- no-loc -->