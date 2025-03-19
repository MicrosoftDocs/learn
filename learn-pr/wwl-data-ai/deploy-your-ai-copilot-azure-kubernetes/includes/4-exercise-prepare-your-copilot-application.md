Previously in this learning path, you implemented AI vector search functionality within your MongoDB project. Now this project is extended to include a web application interface. In this exercise, you’ll add code to expose key functions and create endpoints, enabling external interactions with the application. You’ll also create a Dockerfile to containerize your app, then run the Docker image locally to verify everything is working as expected. By the end of this exercise, you create a web application ready for deployment, complete with accessible endpoints, and containerized for easy distribution.

> [!IMPORTANT]
> You need your own Azure subscription to run this exercise, and you might incur charges. If you don't already have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?icid=azurefreeaccount) before you begin.

## Prepare your coding environment

Before you begin developing and deploying your application, you need to set up your local coding environment if you haven't already. Follow the steps to ensure you have the necessary tools installed and configured.

> [!NOTE]
> If you've already cloned the repository and created the Azure resources, then you only need to copy and paste the **.env** file from **04-vector-search/.env** to **05-deploy-with-aks/node.js**. Then right-click on the **05-deploy-with-aks** folder and select **Open in integrated Terminal** and run `npm install`. Now you're ready to begin!

1. Open Visual Studio Code

1. Install Node.js

    Node.js is required to run and manage JavaScript dependencies for the application you're deploying. You can [download the latest version of Node here](https://nodejs.org/en/download/prebuilt-installer). You can verify the installation by opening the terminal in Visual Studio Code and running the command `node -v`

1. Install the Azure CLI 

    You can [install the Azure CLI by following the instructions on this page](/cli/azure/install-azure-cli-windows?tabs=azure-cli#install-or-update). You can verify the installation by opening the terminal in Visual Studio Code and running the command `az -v`

1. Install [Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)

1. Install the **Docker** extension for Visual Studio Code.

    You can find the extension by navigating to **View** > **Extensions** and enter "Docker" in the search bar.

1. Clone the following repository in Visual Studio Code:

    `https://github.com/MicrosoftLearning/mslearn-cosmosdb-mongodb-vcore`

    Once the repository is cloned, navigate to the project directory **05-deploy-with-aks**.

1. Right-click on the **05-deploy-with-aks** folder and select **Open in integrated Terminal**.

1. Install project dependencies

    In the terminal, run the following command inside the project directory: `npm install`

1. Create Azure resources by running the following commands in the terminal:

    ```bash
    az login
    ./create-azure-resources.ps1
    ```

## Extend the application code

1. Open the **load-and-vectorize-data.js** located in the **05-deploy-with-aks/node.js** directory.

1. Navigate to the `TODO` comment at the end of the file.

    ```js 
    // TODO: Export functions
    ```

1. Replace the comment and export the module functions by adding the following code:

    ```js
    module.exports = { getOptions, processOption, doGPTSearch, doVectorSearch };
    ```

    This line exposes the functions so that they can be used in other parts of the app.

1. Open the **app.js** file

    Notice the **load-and-vectorize-data** import near the top of the file

    ```js
    const data = require('./load-and-vectorize-data');
    ```

    You can access the functions you exported using the constant `data`.

1. Navigate to the comment `// TODO: Extend the application code`

1. Replace the comment and add the following code to the application:

    ```js
    app.get('/getOptions', (req, res) => {
        const options = data.getOptions();
        res.json(options);
    });
    
    app.get('/doVectorSearch', (req, res) => {
        const query = req.query.q;
        const result = data.doVectorSearch(query);
        res.json(result);
    });
    
    app.get('/doGPTSearch', (req, res) => {
        const query = req.query.q;
        const result = data.doGPTSearch(query);
        res.json(result);
    });
    ```

    This code creates several endpoints the web app can interact with and performs the vector search operations as needed.

## Create a local deployment

In this task, you create a Docker image for your application and run your project locally before you create a deployment in the next unit. Let's get started!

1. Create a file named "Dockerfile" in the project directory **05-deploy-with-aks/node.js**

    The Dockerfile defines how your application is containerized. The Dockerfile has no file extension.

1. Open the Dockerfile in Visual Studio Code and add the following contents:
   
    ```
    # Use Node.js runtime as the base image
    FROM node:latest
      
    # Set the working directory inside the container
    WORKDIR /app
      
    # Copy package.json and package-lock.json (if available)
    COPY package*.json ./
      
    # Install dependencies
    RUN npm install
      
    # Copy the rest of the application files
    COPY . /app
      
    # Expose the port that the app runs on
    EXPOSE 3000
      
    # Command to start the application
    CMD ["node", "app.js"]
    ```

1. Save the file.

1. Build the Docker Image using the command `docker build -t vector-search-app:1.0.0`.

    This command uses the Dockerfile to build a Docker image of your application. The image name is `vector-search-app`.

1. Verify the image was build using the command `docker images`

    You should see your newly created image in the list. Once the image is built, you can run it as a container.

1. Run the container using the command: 

    `docker run -p 3000:80 vector-search-app:1.0.0`

    In this command, 3000 represents the host port you exposed earlier, and 80 represents the container port. The container port is the port inside the container where the application is running and listening for incoming traffic.

1. Access the app by navigating to `http://localhost:3000` in your web browser.

You successfully built, tagged, and pushed your Docker image to the Azure Container Registry. Now you're ready to deploy your image to Azure Kubernetes Service in the next exercise. Great work!