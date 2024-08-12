In order for Kubernetes to create a container image, it needs a place from which to get it. Docker Hub is a central place to upload Docker images. Many products, including Kubernetes, can create containers based on images in Docker Hub.

> [!NOTE]
> You will complete this exercise in a GitHub Codespace that has [Docker](https://www.docker.com/products/docker-desktop) and the [.NET SDK](https://dotnet.microsoft.com/download) pre-installed. When you use these techniques in your own development environment, make sure you have these prerequisites installed.

## Open the development environment

You can choose to use a GitHub codespace that hosts the exercise, or complete the exercise locally in Visual Studio Code.

To use a **codespace**, create a preconfigured GitHub Codespace with [this Codespace creation link](https://codespaces.new/MicrosoftDocs/mslearn-dotnet-cloudnative?devcontainer_path=.devcontainer%2Fdotnet-kubernetes%2Fdevcontainer.json).

The process takes several minutes while GitHub creates and configures the codespace. Once finished, the code used for the rest of this module is in the **/dotnet-kubernetes** directory.

To use **Visual Studio Code**, clone the [https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative) repository to your local machine. Then:

1. Install any [system requiements](https://code.visualstudio.com/docs/devcontainers/containers) to run Dev Container in Visual Studio Code.
1. Make sure Docker is running. 
1. In a new Visual Studio Code window open the folder of the cloned repository
1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
1. Search: **>Dev Containers: Rebuild and Reopen in Container**
1. Select **eShopLite - dotnet-kubernetes** from the drop down. Visual Studio Code creates your development container locally.

### Verify the Docker images by creating containers in the codespace

There are two containers in the Contoso Shop project. Before pushing the images to Docker Hub, let's use them to create the containers in the codespace. After the containers are created and running, we'll be able to browse the Contoso company website and verify the microservices are running OK.

Follow these steps to create and run Docker containers in the codespace.

1. Switch to the **TERMINAL** tab and run the following command to go to the code root:

   ```bash
   cd dotnet-kubernetes
   ```

1. Run the following command to build the containers:

    ```dotnetcli
    dotnet publish /p:PublishProfile=DefaultContainer
    ```

    It might take a while to build the containers.

1. Run the following command to run the app and attach the containers:

    ```bash
    docker compose up
    ```

1. To test the front end service, switch to the **PORTS** tab, then to the right of the local address for the **Front End** port, select the globe icon. The browser displays the homepage.
1. Select **Products**. The catalog shows Contoso's merchandise.
1. Close the web site, return to the **TERMINAL** tab, and then press <kbd>CTRL</kbd> + <kbd>C</kbd>. Docker compose halts the containers.

## Sign in to Docker Hub

The next step in uploading the images to Docker Hub is to sign into Docker Hub. From the command prompt, enter the following:

```bash
docker login
```

> [!IMPORTANT]
> Use the same username and password from when you created your Docker account. You can visit the [Docker Hub website](https://hub.docker.com) to reset your password, if needed.

## Upload the images to Docker Hub

1. Enter the following code to retag or rename the Docker images you created under your Docker username.

    ```bash
    docker tag store [YOUR DOCKER USER NAME]/storeimage
    docker tag products [YOUR DOCKER USER NAME]/productservice
    ```

1. Then finally upload, or push, the Docker images to Docker Hub.

    ```bash
    docker push [YOUR DOCKER USER NAME]/storeimage
    docker push [YOUR DOCKER USER NAME]/productservice
    ```

    If you receive an authentication error, you can run `docker logout` followed by `docker login` to reauthenticate.

In this exercise, you used Dockerfiles and docker compose to create two Docker images and containers, and pushed those images to Docker Hub.

Now, you're ready to use Kubernetes to manage Contoso's microservices deployment.
