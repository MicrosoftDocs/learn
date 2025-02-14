You'll be working with a Python project that shows a dashboard of products. To run this project in a container, you'll need the Dev Containers extension for Visual Studio Code.

In this exercise, you'll clone one of the agency's projects—a Products Dashboard written in Python—and install the Dev Containers extension for Visual Studio Code.

## Clone the sample repo

1. Ensure that [Docker Desktop](https://www.docker.com/products/docker-desktop) is installed and running on your machine.
1. Copy the URL for the sample repo to your clipboard.

    ```bash
    https://github.com/MicrosoftDocs/mslearn-python-products
    ```

1. Open a new instance of Visual Studio Code.
1. Select the **Clone Repository** button in the sidebar, or press <kbd>F1</kbd> to open the Command Palette and search for **Git: Clone**.
1. Paste in the URL from your clipboard.
1. Select a location on your disk where the project can be cloned to.
1. Select **Open** from the notification in Visual Studio Code.
1. If you see a pop-up that asks if you trust the authors, select **Yes, I trust the authors**.

The project should now be open in Visual Studio Code.

> [!NOTE]
> If you receive a warning in Visual Studio Code about selecting a Python interpreter, you can safely ignore it.

## Install the Dev Containers extension

1. Select the "Extensions" icon in the Activity Bar to open the **Extensions** viewlet.

   :::image type="content" source="../media/extensions-icon.png" alt-text="Screenshot of the Visual Studio Code activity bar with Extension icon highlighted"::: <!-- no-loc -->

1. Type **dev containers**.
1. Locate the **Dev Containers** extension and select the **Install** button.

   :::image type="content" source="../media/install-remote-containers.png" alt-text="Screenshot of the Visual Studio Code extension gallery showing Dev Containers extension." loc-scope="other"::: <!-- no-loc -->

The Dev Containers extension will install, and you'll have access to the commands that it adds to Visual Studio Code.
