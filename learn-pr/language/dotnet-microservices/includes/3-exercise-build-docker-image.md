In this exercise, you create a microservice endpoint and containerize it by using the .NET SDK and Docker.

> [!NOTE]
> You can complete this exercise in an instance of GitHub Codespaces that has [Docker](https://www.docker.com/products/docker-desktop) and the [.NET SDK](https://dotnet.microsoft.com/download) preinstalled. When you use these tools and techniques in your own development environment, make sure that you have these prerequisites installed.

## Open the development environment

You can choose to use a GitHub codespace that hosts the exercise, or complete the exercise locally in Visual Studio Code.

To use a **codespace**, create a preconfigured GitHub Codespace with [this Codespace creation link](https://codespaces.new/MicrosoftDocs/mslearn-dotnet-cloudnative?devcontainer_path=.devcontainer%2Fdotnet-docker%2Fdevcontainer.json).

GitHub takes several minutes to create and configure the codespace. When the process completes, you see the code files for the exercise. The code used for the remainder of this module is in the **/dotnet-docker** directory.

To use **Visual Studio Code**, clone the [https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative) repository to your local machine. Then:

1. Install any [system requirements](https://code.visualstudio.com/docs/devcontainers/containers) to run Dev Container in Visual Studio Code.
1. Make sure Docker is running. 
1. In a new Visual Studio Code window open the folder of the cloned repository
1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
1. Search: **>Dev Containers: Rebuild and Reopen in Container**
1. Select **eShopLite - dotnet-docker** from the drop-down. Visual Studio Code creates your development container locally.

## Use .NET publish to create the Products back-end image

The latest .NET 8 release improves support for containerization. You can use the `dotnet publish` command to create a Docker image for your microservices. The command creates a rootless container image that runs services under an `app` account. Running rootless containers is great for security and performance. The command knows how to pick the best base image by checking the settings in the project file.

1. To create the images for all the **:::no-loc text="eShopLite":::** services, go to the **TERMINAL** tab and run this command:

    ```bash
    cd ./dotnet-docker 
  	dotnet publish /p:PublishProfile=DefaultContainer
  	```

    You see output like the following messages:

    ```console
    DataEntities -> /workspaces/mslearn-dotnet-cloudnative/dotnet-docker/DataEntities/bin/Release/net8.0/publish/
    Products -> /workspaces/mslearn-dotnet-cloudnative/dotnet-docker/Products/bin/Release/net8.0/Products.dll
    Products -> /workspaces/mslearn-dotnet-cloudnative/dotnet-docker/Products/bin/Release/net8.0/publish/
    Store -> /workspaces/mslearn-dotnet-cloudnative/dotnet-docker/Store/bin/Release/net8.0/Store.dll
    Store -> /workspaces/mslearn-dotnet-cloudnative/dotnet-docker/Store/bin/Release/net8.0/publish/
    Building image 'store' with tags 'latest' on top of base image 'mcr.microsoft.com/dotnet/aspnet:8.0'.
    Building image 'products' with tags 'latest' on top of base image 'mcr.microsoft.com/dotnet/aspnet:8.0'.
    Pushed image 'store:latest' to local registry via 'docker'.
    Pushed image 'products:latest' to local registry via 'docker'.
    ```

    The command reads the solution file, determined it contains three projects, built them, and created images for the store and products projects. The images are named after the projects and published into the local docker registry.

1. Check the images are available in docker:

    ```bash
    docker images
    ```
    
    You see output like the following messages:

    ```console
    REPOSITORY                          TAG       IMAGE ID       CREATED              SIZE
    products                            latest    63614e340088   About a minute ago   293MB
    store                               latest    e9458c3abdb1   About a minute ago   218MB
    ```

## Use a Dockerfile to create the Products back-end image

If you want more control of how the images are built, you can use a Dockerfile to create an image for the Products web service. 

1. In the **EXPLORER** pane, create a file named **Dockerfile** in **./dotnet-docker/Products**. The file is empty.

1. Enter the following code:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
  
    WORKDIR /DataEntities
    COPY "DataEntities/DataEntities.csproj" .
    RUN dotnet restore
    COPY "DataEntities" .
    RUN dotnet publish -c release -o /app
    ```

    After completing the following steps, this code will set up the DataEntities library in the Products docker image:

    - Pull the `mcr.microsoft.com/dotnet/sdk:8.0` image and name the image `build`.
    - Set the working directory within the image to `/DataEntities`.
    - Copy the file named **DataEntities.csproj** found locally to the `/DataEntities` directory that you created.
    - Call `dotnet restore` on the project.
    - Copy everything in the local **DataEntities** directory to the image.
    - Call `dotnet publish` on the project.

1. Directly below the last line, enter this code:

    ```dockerfile
  	WORKDIR /src
  	COPY Products/Products.csproj .
  	RUN dotnet restore
  	COPY Products .
  	RUN dotnet publish -c release -o /app
  	```
	
    This code does the following steps sequentially when invoked:
    
      - Set the working directory within the image to `/src`.
      - Copy the file named **Products.csproj** found locally to the `/src` directory that you created.
      - Call `dotnet restore` on the project.
      - Copy everything in the local **Products** directory to the image.
      - Call `dotnet publish` on the project.

1. Directly below the last line, enter this code:

    ```dockerfile
  	FROM mcr.microsoft.com/dotnet/aspnet:8.0
  	WORKDIR /app
  	EXPOSE 80
  	EXPOSE 443
  	COPY --from=build /app .
  	ENTRYPOINT ["dotnet", "Products.dll"]
  	```

  	This code does the following steps sequentially when invoked:
  
      - Pull the `mcr.microsoft.com/dotnet/aspnet:8.0` image.
      - Set the working directory within the image to `/app`.
      - Expose port 80 and 443.
      - Copy everything from the **app** directory of the **build** image you created into the **app** directory of this image.
      - Set the entry point of this image to `dotnet` and pass `Products.dll` as an argument.

## Create the Docker image

Having completed the Dockerfile, the next step is to use it to create a Docker image:

1. To create the image for the Products back-end service, go to the **TERMINAL** tab and run this command:

    ```bash
    cd ./dotnet-docker 
  	docker build -t productsbackend:latest -f Products/Dockerfile .
  	```

  	This runs the commands in **Dockerfile** in the current directory and applies the tag **productsbackend:latest** to the resulting image.

1. After much output, the image will be built. Entering `docker images` shows you a list of all images in your codespace including **productsbackend**. The other image is the one for the codespace itself.

    You see output like the following messages:

    ```console
    REPOSITORY                          TAG       IMAGE ID       CREATED              SIZE
    products                            latest    63614e340088   10 minutes ago       293MB
    store                               latest    e9458c3abdb1   10 minutes ago       218MB
    productsbackend                     latest   190783f7e06f    About a minute ago   293MB
    ```

Think about the difference between using `dotnet publish` and having to manually create the **Dockerfiles** for each microservice in your apps.

## Run the container and test the service

Now you can use the image to run and host the Products service.

1. To create and run a container from the new **products** image and expose the service on port 32001, run this command:

    ```bash
    docker run -it --rm -p 32001:8080  products
    ```

    Or if you'd like to run the image you created using the Dockerfile, run:

    ```bash
    docker run -it --rm -p 32001:8080 productsbackend
    ```

1. To test the service, switch to the **PORTS** tab then, to the right of the local address for the **Back End** port, select the globe icon. The browser opens a new tab at that address.

    :::image type="content" source="../media/connect-backend.png" alt-text="Screenshot showing how to connect to the backend products service."  lightbox="../media/connect-backend.png":::

1. To query some products, append the address with **/api/product** and then press <kbd>Enter</kbd>. You should see some product information listed in JSON format.

    ```json
    [
        {
            "id": 1,
            "name": "Solar Powered Flashlight",
            "description": "A fantastic product for outdoor enthusiasts",
            "price": 19.99,
            "imageUrl": "product1.png"
        },
        {
            "id": 2,
            "name": "Hiking Poles",
            "description": "Ideal for camping and hiking trips",
            "price": 24.99,
            "imageUrl": "product2.png"
        },
        {
            "id": 3,
            "name": "Outdoor Rain Jacket",
            "description": "This product will keep you warm and dry in all weathers",
            "price": 49.99,
            "imageUrl": "product3.png"
        },
        ...
    ]       
    ```
