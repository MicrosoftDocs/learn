In order for Kubernetes to create a container image, it needs a place to get it from. Docker Hub is a central place to upload Docker images. Many products, including Kubernetes, can create containers based on images in Docker Hub.

> [!IMPORTANT]
> To complete this exercise, you will need the Docker Desktop application, a Docker Hub account, and a text editor such as [Visual Studio Code](https://code.visualstudio.com/).
>
> - Download [Docker Desktop here](https://www.docker.com/products/docker-desktop).
> - Follow the [directions here to sign up for a Docker Hub account](https://hub.docker.com/).

## Retrieve the Contoso Pizza Shop microservice container images

The code for the Contoso Pizza Shop and the Dockerfiles to build the container images have already been created for you. Clone the [repository from GitHub](https://github.com/microsoftdocs/mslearn-dotnet-kubernetes) to retrieve the code.

1. Open up a command prompt or terminal window.
1. Change to a directory you want the code downloaded to.
1. Run the following command to download, or clone, the sample repository.

    ```bash
    git clone https://github.com/microsoftdocs/mslearn-dotnet-kubernetes
    ```

The code will be downloaded into a new folder called **mslearn-dotnet-kubernetes**.

### Verify the Docker images by creating containers locally

There are 2 containers in the Contoso Pizza Shop project. Before pushing the images to Docker Hub, let's use them to create the containers locally. After the containers are created and running, we will be able to browse the Contoso Pizza Company website and verify the microservices are running OK.

Follow these steps to create and run Docker containers from the Docker files you just downloaded.

1. Make sure Docker Desktop is running.
1. Open up a command prompt and switch to the directory where the code you just downloaded resides.
1. Run the following command to build the containers.

    ```bash
    docker-compose build
    ```

    It may take a while to build the containers.

1. To run the images run this command.

    ```bash
    docker-compose up
    ```

1. When that is finished, you can browse to `http:\\localhost:5902` to see the Contoso Pizza Shop's menu.

## Sign in to Docker Hub

The next step in uploading the images to Docker Hub is to sign into Docker Hub. From a command prompt, enter the following:

```bash
docker login
```

> [!IMPORTANT]
> Use the username and password from when you created your Docker account. You can visit the [Docker Hub website](https://hub.docker.com) to reset your password if needed.

## Upload the images to Docker Hub

1. Re-tag, or rename, the Docker image you just created under your Docker username.

    ```bash
    docker tag pizzafrontend [YOUR DOCKER USER NAME]/pizzafrontend
    docker tag pizzabackend [YOUR DOCKER USER NAME]/pizzabackend
    ```

1. Then finally upload, or push, the Docker image to Docker Hub.

    ```bash
    docker push [YOUR DOCKER USER NAME]/pizzafrontend
    docker push [YOUR DOCKER USER NAME/pizzabackend
    ```

In the course of this exercise, you cloned the Contoso Pizza Shop's code from GitHub. Used Dockerfiles contained within that code to create 2 Docker images and containers, and then pushed those images to Docker Hub.

Now you're ready to use Kubernetes to manage the deployment of Contoso Pizza Company's microservices.
