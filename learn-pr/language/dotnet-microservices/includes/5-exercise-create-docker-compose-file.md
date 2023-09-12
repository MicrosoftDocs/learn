Contoso Pizza has two services that they'd like to group together to build and deploy as a single unit. They've decided that Docker Compose is the tool they'll use.

In this exercise, you'll create a Docker Compose YAML file, then use the Docker Compose utility to both build the Docker container images and run them.

## Create the docker-compose file

1. Use Visual Studio Code to open the **mslearn-dotnetmicroservices** folder you cloned.
1. In the topmost folder (the same folder with README.md), open the file named **docker-compose.yml**. This file will be empty.
1. Add the following code to the **docker-compose.yml** file:

    ```yml
    version: '3.4'

    services: 
    
      frontend:
        image: pizzafrontend
        build:
          context: frontend
          dockerfile: Dockerfile
        environment: 
          - backendUrl=http://backend
        ports:
          - "5902:80"
        depends_on: 
          - backend
      backend:
        image: pizzabackend
        build: 
          context: backend
          dockerfile: Dockerfile
        ports: 
          - "5000:80"

    ```

    This code does several things:

    - First, it creates the frontend website, naming it **pizzafrontend**. The code tells Docker to build it, pointing to the Dockerfile found in the **frontend** folder. Then the code sets an environment variable for the website: `backendUrl=http://backend`. Finally, this code opens a port and declares it depends on the backend service.
    - The backend service gets created next. It's named **pizzabackend**. It's built from the same Dockerfile you created in the previous exercise. The last command specifies which port to open.

1. To build the container images, open a command prompt, navigate to the directory with the **docker-compose.yml** file, and run the following command:

    ```bash
    docker compose build
    ```

1. Then, to start both the website and the web API, run this command:

    ```bash
    docker compose up
    ```

1. After a bit of output, the website and web API will be running. You should get something similar to the following output:

    ```output
    Attaching to docker-aspnet-pizza_backend_1, docker-aspnet-pizza_frontend_1
    ```

1. You can browse to: http://localhost:5902 to see the Contoso Pizza menu.

In this exercise, you learned how to create and write a Docker Compose file, build the services contained within, and run those services.
