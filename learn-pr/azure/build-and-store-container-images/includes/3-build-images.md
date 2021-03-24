Suppose your company makes use of container images to manage compute workloads. You use the local Docker tooling to build your container images.

You can now use Azure Container Registry Tasks to build these containers. Container Registry Tasks also allows for DevOps process integration with automated build on source code commit.

Let's automate the creation of a container image using Azure Container Registry Tasks.

## Create a container image with Azure Container Registry Tasks

A standard Dockerfile provides build instructions. Azure Container Registry Tasks enables you to reuse any Dockerfile currently in your environment, including multi-staged builds.

We'll use a new Dockerfile for our example.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

The first step is to create a new file named `Dockerfile`. You can use any text editor to edit the file. We'll use Cloud Shell Editor for this example.

1. Enter the following command into the Cloud Shell window to open the editor.

    ```bash
    code
    ```

1. Copy the following contents into the editor.

    ```bash
    FROM    node:9-alpine
    ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/package.json /
    ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/server.js /
    RUN     npm install
    EXPOSE  80
    CMD     ["node", "server.js"]
    ```

1. Use the key combination <kbd>Ctrl+S</kbd> (<kbd>Cmd+S</kbd> for Mac) to save your changes. Name the file `Dockerfile` when prompted.

    This configuration adds a Node.js application to the `node:9-alpine` image. After that, it configures the container to serve the application on port 80 via the *EXPOSE* instruction.

1. Run the following Azure CLI command to build the container image from the Dockerfile. *$ACR_NAME* is the variable you defined in the preceding unit to hold your container registry name.

    ```azurecli
    az acr build --registry $ACR_NAME --image helloacrtasks:v1 .
    ```

    > [!NOTE]
    > Don't forget the period `.` at the end of the preceding command. It represents the source directory containing the docker file, which in our case is the current directory. Since we didn't specify the name of a file with the `--file` parameter, the command looks for a file called **Dockerfile** in our current directory.

## Verify the image

1. Run the following command in the Cloud Shell to verify that the image has been created and stored in the registry.

    ```azurecli
    az acr repository list --name $ACR_NAME --output table
    ```

    The output from this command should look similar to the following example.

    ```output
    Result
    -------------
    helloacrtasks
    ```

The `helloacrtasks` image is now ready to be used.
