In this exercise, you'll learn to create a microservice endpoint and containerize it using Docker.

> [!IMPORTANT]
> To complete this exercise, please download and install both the [.NET SDK](https://dotnet.microsoft.com/download) and [Docker](https://www.docker.com/products/docker-desktop). You'll also need a text editor such as [Visual Studio Code](https://code.visualstudio.com/).

## Clone the code

We've already created the website and API for you. Clone the [repository from GitHub](https://github.com/MicrosoftDocs/mslearn-dotnetmicroservices/) to retrieve the code.

1. Open a command prompt.

1. Change to a directory to which you want to download the code.

1. Run the following command to download (or clone) the sample repository:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-dotnetmicroservices
    ```

The code downloads into a new folder named **mslearn-dotnetmicroservices**.

## Create the Dockerfile for the back-end web API

Now that you've downloaded the code, let's deploy our back-end and front-end microservices as Docker containers. To do that, we need to create a Dockerfile that tells Docker how to build the image.

1. First, ensure Docker Desktop is open on your computer.

1. Open the **backend** directory from the repository that you cloned in a text editor such as VS Code.

1. Within the **backend** directory, open the file named **Dockerfile**; this file will be empty.

1. Enter the following code:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
    WORKDIR /src
    COPY backend.csproj .
    RUN dotnet restore
    COPY . .
    RUN dotnet publish -c release -o /app
    ```

    This code performs the following steps sequentially when invoked:

    - Pulls the `mcr.microsoft.com/dotnet/sdk:6.0` image and name the image `build`
    - Sets the working directory within the image to `/src`
    - Copies the file named **backend.csproj** found locally to the `/src` directory that you created
    - Calls `dotnet restore` on the project
    - Copies everything in the local working directory to the image
    - Calls `dotnet publish` on the project

1. Directly under the last line, enter this code:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/aspnet:6.0
    WORKDIR /app
    EXPOSE 80
    EXPOSE 443
    COPY --from=build /app .
    ENTRYPOINT ["dotnet", "backend.dll"]
    ```

    This code performs the following steps sequentially when invoked:

    - Pulls the `mcr.microsoft.com/dotnet/aspnet:6.0` image
    - Sets the working directory within the image to `/app`
    - Exposes port 80 and 443
    - Copies everything from the `/app` directory of the **build** image you created into the app directory of this image
    - Sets the entrypoint of this image to `dotnet` and passes `backend.dll` as an argument

1. Save the Dockerfile, open a command prompt, and go to the directory that holds that file.

    ```bash
    cd mslearn-dotnetmicroservices/backend
    ```

1. Run this command to create the image and tag it with the name **pizzabackend**:

    ```bash
    docker build -t pizzabackend .
    ```

    This runs the commands in the `Dockerfile` in the current directory and applies the tag `pizzabackend` to the resulting image.

    > [!TIP]
    > If you're getting errors from Docker, it might not have been installed correctly. Run the following command to verify: `docker run hello-world`.
    > If you *don't* see "Hello from Docker!" in the output, follow this [Docker installation tutorial](https://dotnet.microsoft.com/learn/aspnet/microservice-tutorial/install-docker).

1. After a lot of output, the image will be built. Entering `docker images` shows you a list of all images on your machine with `pizzabackend` listed.

1. To run the web API service, run the following command to start a new Docker container using the **pizzabackend** image and expose the service on port 5200:

    ```bash
    docker run -it --rm -p 5200:80 --name pizzabackendcontainer pizzabackend
    ```

1. You can browse to `http://localhost:5200/pizzainfo` and see a JSON representation of Contoso Pizza's menu.
