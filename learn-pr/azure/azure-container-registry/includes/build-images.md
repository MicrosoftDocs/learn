Create a file named `Dockerfile` with the following contents.

```console
FROM    node:9-alpine
RUN     mkdir /src
ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/package.json /src
ADD     https://raw.githubusercontent.com/Azure-Samples/acr-build-helloworld-node/master/server.js /src
RUN     cd /src && npm install
EXPOSE  80
CMD     ["node", "/src/server.js"]
```

Run the following command to build the container image from the Dockerfile.

```azurecli
az acr build --registry $ACR_NAME --image helloacrbuild:v1 .
```

When done, run the following command to verify that the image has been created and stored in the registry.

```azurecli
az acr repository list --name $ACR_NAME --output table
```