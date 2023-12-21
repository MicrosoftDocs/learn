In this exercise, you create a microservice endpoint and containerize it by using Docker.

> [!NOTE]
> You can complete this exercise in an instance of GitHub Codespaces that has [Docker](https://www.docker.com/products/docker-desktop) and the [.NET SDK](https://dotnet.microsoft.com/download) preinstalled. When you use these tools and techniques in your own development environment, make sure that you have these prerequisites installed.

## Open the development environment

You can choose to use a GitHub codespace that hosts the exercise, or complete the exercise locally in Visual Studio Code.

To use a **codespace** create a pre-configured GitHub Codespace with [this Codespace creation link](https://codespaces.new/MicrosoftDocs/mslearn-dotnet-cloudnative?devcontainer_path=.devcontainer%2Fdotnet-docker%2Fdevcontainer.json).

GitHub takes several minutes to create and configure the codespace. When it's finished, you see the code files for the exercise. The code that's used for the remainder of this module is in the **/dotnet-docker** directory.

To use **Visual Studio Code**, fork the [https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative) repository to your own GitHub account. Then:

1. Make sure Docker is running. In a new Visual Studio Code window, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
1. Search for and select **Dev Containers: Clone Repository in Container Volume**.
1. Select your forked repository. Visual Studio Code creates your development container locally.

## Edit the Dockerfile to configure the Products back end

You can use a Dockerfile to containerize the Products web service.

1. Wait for the setup is complete.
2. In the **EXPLORER** pane, open the file named **dotnet-docker/Products/Dockerfile**. The file will be empty.

3. Enter the following code:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

    WORKDIR /DataEntities
    COPY "DataEntities/DataEntities.csproj" .
    RUN dotnet restore
    COPY "DataEntities" .
    RUN dotnet publish -c release -o /app
    ```

    This code sets up the DataEntities library in the Products Docker image by completing these steps:

    - Pulls the *mcr.microsoft.com/dotnet/sdk:8.0* image and names the image *build*.
    - Sets the working directory within the image to */DataEntities*.
    - Copies the local file named *DataEntities.csproj* to the */DataEntities* directory that you created.
    - Calls `dotnet restore` on the project.
    - Copies everything in the local *DataEntities* directory to the image.
    - Calls `dotnet publish` on the project.

4. Directly below the last line, enter this code:

    ```dockerfile
    WORKDIR /src
    COPY Products/Products.csproj .
    RUN dotnet restore
    COPY Products .
    RUN dotnet publish -c release -o /app
    ```

    This code performs the following steps sequentially when invoked:

    - Sets the working directory within the image to */src*.
    - Copies the local file named *Products.csproj* to the */src* directory that you created.
    - Calls `dotnet restore` on the project.
    - Copies everything in the local *Products* directory to the image.
    - Calls `dotnet publish` on the project.

5. Directly below the last line, enter this code:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/aspnet:8.0
    WORKDIR /app
    EXPOSE 80
    EXPOSE 443
    COPY --from=build /app .
    ENTRYPOINT ["dotnet", "Products.dll"]
    ```

    This code performs the following steps sequentially when invoked:

    - Pulls the *mcr.microsoft.com/dotnet/aspnet:8.0* image.
    - Sets the working directory within the image to */app*.
    - Exposes port 80 and port 443.
    - Copies everything from the *app* directory of the *build* image that you created to the *app* directory of this image.
    - Sets the entrypoint of this image to `dotnet` and passes `Products.dll` as an argument.

## Create the Docker image

The next step is to use it to create a Docker image.

1. In a new terminal, run this command to go to the code root:

    ```cli
    cd dotnet-docker
    ```

1. To create the image for the Products back-end service, select the **Terminal** tab and run this command:

    ```bash
    docker build -t productsbackend:latest -f Products/Dockerfile .
    ```

    This code runs the commands that are in *Dockerfile* in the current directory and applies the tag `productsbackend` to the image.

1. After much output, the image is built. Enter `docker images` to see a list of all images in your codespace, including *productsbackend*. The other image is for the codespace itself.

## Run the container and test the service

Now you can use the image to run and host the Products service.

1. To create and run a container from the new *productsbackend* image and expose the service on port 5200, run this command:

    ```bash
    docker run -it --rm -p 32001:8080 --name productsbackendcontainer productsbackend
    ```

1. To test the service, select the **Ports** tab. Then, to the right of the local address for the **Back End** port, select the globe icon. The browser opens a new tab at that address.

   :::image type="content" source="../media/connect-backend.png" alt-text="Screenshot that shows how to connect to the back-end products service.":::

1. To query some products, append the address with `/api/product`, and then select Enter. You should see some product information listed in JSON format.
