## Create a container image using Azure Container Registry Tasks

You use a Dockerfile to provide build instructions. Azure Container Registry Tasks enables you to reuse any Dockerfile currently in your environment, including multi-staged builds. For this example, you create a new Dockerfile that builds a Node.js application.

1. Open the Cloud Shell editor and create a new file named *Dockerfile* using the `code` command.

    ```azurecli-interactive
    code Dockerfile
    ```

2. Paste the following Dockerfile contents into the file.

    This Dockerfile uses the `node:9-alpine` image as its base image. It then adds the Node.js application files to the image and installs the application dependencies. Finally, it configures the container to serve the application on port 80 via the *EXPOSE* instruction.

    ```azurecli-interactive
    FROM    node:9-alpine
    ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/package.json /
    ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/server.js /
    RUN     npm install
    EXPOSE  80
    CMD     ["node", "server.js"]
    ```

3. Save the file and close the editor.
4. Build the container image from the Dockerfile using the `az acr build` command.

    > [!NOTE]
    > Make sure you add the period (`.`) to the end of the command. It represents the source directory containing the Dockerfile. Because we didn't specify the name of the file using the `--file` parameter, the command looks for a file called **Dockerfile** in our current directory.

    ```azurecli-interactive
    az acr build --registry $ACR_NAME --image helloacrtasks:v1 .
    ```

5. Verify that the image has been created and stored in the registry using the `az acr repository list` command.

    ```azurecli-interactive
    az acr repository list --name $ACR_NAME --output table
    ```

    Your output should look similar to the following example output:

    ```output
    Result
    -------------
    helloacrtasks
    ```
