Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

Now you can pull and run the `hello-world:v1 container` image from your container registry by using [docker run](https://docs.docker.com/engine/reference/commandline/run/):

```azurecli
docker runs <login-server>/hello-world:v1

```

For example:

```azurecli
docker run newregistryapl.azurecr.io/hello-world:v1
```

The output should resemble graphic seen here.

:::image type="content" source="../media/image-run-registry-output-f1bffcda.png" alt-text="Displays a screenshot of the output for running docker.":::
