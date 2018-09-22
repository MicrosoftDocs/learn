Suppose your company makes use of container images to manage compute workloads. You use the local Docker tooling to build your container images.

You can now use Azure Container Registry Tasks to build these containers. Container Registry Tasks also allows for DevOps process integration with automated build on source code commit.

Let's automate the creation of a container image using Azure Container Registry Tasks.

## Create a container image with Azure Container Registry Tasks

A standard Dockerfile to provides build instructions. Azure Container Registry Tasks allows you to reuse any Dockerfile currently in your environment, including multi-staged builds.

We'll use a new Dockerfile for our example.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

The first step is to create a new file named `Dockerfile`. You can use any text editor to edit the file. We'll use Cloud Shell Editor for this example. Enter the following command into the Cloud Shell window to open the editor.

```bash
code
```

Copy the following contents to your new Dockerfile. Make sure to save the file.

```bash
FROM    node:9-alpine
ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/package.json /
ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/server.js /
RUN     npm install
EXPOSE  80
CMD     ["node", "server.js"]
```

Use the key combination <kbd>Ctrl+S</kbd> to save. Name the file `Dockerfile` when prompted.

This configuration adds a Node.js application to the `node:9-alpine` image. After that, it configures the container to serve the application on port 80 via the *EXPOSE* instruction.

Now run the Azure CLI command `az acr build` to build the container image from the Dockerfile.

```azurecli
az acr build --registry <acrName> --image helloacrtasks:v1 .
```

You'll see the image being built and pushed to your Container Registry as you run the command.

## Verify the image

Run the following command to verify that the image has been created and stored in the registry.

```azurecli
az acr repository list --name <acrName> --output table
```

The output should look similar to the following:

```console
Result
-------------
helloacrtasks
```

The `helloacrbuild` image is now ready to be used.
