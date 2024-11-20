Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

Now you can pull and run the `hello-world:v1 container` image from your container registry by using [docker run](https://docs.docker.com/engine/reference/commandline/run/):

```azurecli
docker run <login-server>/hello-world:v1

```

For example:

```azurecli
docker run newregistryapl.azurecr.io/hello-world:v1
```
