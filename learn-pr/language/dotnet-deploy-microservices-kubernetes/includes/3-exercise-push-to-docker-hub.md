In order for Kubernetes to create a container image, it needs a place from which to get it. Docker Hub is a central place to upload Docker images. Many products, including Kubernetes, can create containers based on images in Docker Hub.

> [!IMPORTANT]
> To complete this exercise, you'll need the Docker Desktop application, a Docker Hub account, and a text editor such as [Visual Studio Code](https://code.visualstudio.com/).
>
> - Download [Docker Desktop here](https://www.docker.com/products/docker-desktop).
> - Follow the [directions here to sign up for a Docker Hub account](https://hub.docker.com/).

## Retrieve the Contoso Pizza Shop microservice container images

The code for the Contoso Pizza Shop and the Dockerfiles to build the container images have already been created for you. Clone the [repository from GitHub](https://github.com/microsoftdocs/mslearn-dotnet-kubernetes) to retrieve the code.

1. Open a command prompt or terminal window.

1. Open the root directory to which you want to download the code. The code download into a new folder in that location.

1. Run the following command to download—or *clone*—the sample repository:

    ```bash
    git clone https://github.com/microsoftdocs/mslearn-dotnet-kubernetes
    ```

The code is downloaded into a new folder called **mslearn-dotnet-kubernetes**.

### Verify the Docker images by creating containers locally

There are two containers in the Contoso Pizza Shop project. Before pushing the images to Docker Hub, let's use them to create the containers locally. After the containers are created and running, we'll be able to browse the Contoso Pizza Company website and verify the microservices are running OK.

Follow these steps to create and run Docker containers from the Docker files you downloaded.

1. Make sure Docker Desktop is running.

1. Open a command prompt and move to the **mslearn-dotnet-kubernetes** directory.

1. Run the following command to build the containers:

    ```bash
    docker-compose build
    ```

    It may take a while to build the containers.

1. Run the following command to run the app and attach the containers:

    ```bash
    docker-compose up
    ```

1. When the operation has finished, go to `http://localhost:5902` in a browser tab to view the Contoso Pizza Shop menu. When you're finished viewing the menu, return to the command prompt and press <kbd>CTRL</kbd> + <kbd>C</kbd> to stop the container instance.

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
    docker tag pizzafrontend [YOUR DOCKER USER NAME]/pizzafrontend
    docker tag pizzabackend [YOUR DOCKER USER NAME]/pizzabackend
    ```

1. Then finally upload, or push, the Docker images to Docker Hub.

    ```bash
    docker push [YOUR DOCKER USER NAME]/pizzafrontend
    docker push [YOUR DOCKER USER NAME]/pizzabackend
    ```

In this exercise, you cloned Contoso Pizza Shop code from GitHub, used Dockerfiles contained within that code to create two Docker images and containers, and pushed those images to Docker Hub.

Now, you're ready to use Kubernetes to manage Contoso Pizza Company's microservices deployment.
