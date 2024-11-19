In this exercise, you extend the application code by exporting functions and creating API endpoints for the web app to perform vector and GPT searches. You also set up a Docker container for local deployment, preparing your app for Azure Kubernetes Service in the next unit.

## Extend the application code

1. Open the **load-and-vectorize-data.js** located in the **06-guided-project/node.js** directory

1. Navigate to the `TODO` comment at the end of the file

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

1. Create a file named "Dockerfile" in the project directory **06-guided-project/node.js**

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

1. Build the Docker Image using the command `docker build -t vector-search-app:1.0.0 `

    This command uses the Dockerfile to build a Docker image of your application. The image name is `vector-search-app`.

1. Verify the image was build using the command `docker images`

    You should see your newly created image in the list. Once the image is built, you can run it as a container.

1. Run the container using the command: 

    `docker run -p 3000:80 vector-search-app:1.0.0`

    In this command, 3000 represents the host port you exposed earlier, and 80 represents the container port. The container port is the port inside the container where the application is running and listening for incoming traffic.

1. Access the app by navigating to `http://localhost:3000` in your web browser.

You successfully built, tagged, and pushed your Docker image to the Azure Container Registry. Now you're ready to deploy your image to Azure Kubernetes Service in the next exercise. Great work!