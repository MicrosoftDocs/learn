In this unit, you build and host the new and updated container images in Azure Container Registry. You then deploy the coupon service and other configuration changes to the existing :::no-loc text="eShopOnContainers"::: app, and verify that the changes are successful.

## Container images in Azure Container Registry

You host container images for microservices solutions in container registries. Often, a public container registry like Docker Hub is sufficient. Private container registries, such as Azure Container Registry, are more appropriate for enterprise scenarios. Only your team and services have access to your private container registry. All the container images used to deploy the :::no-loc text="eShopOnContainers"::: app to Azure Kubernetes Service (AKS) are from one of the Container Registry endpoints.

The following diagram shows the relationships among Docker container images, container registries such as Container Registry, and AKS or other Kubernetes deployments.

:::image type="content" source="../media/6-add-coupon-service/acr-aks.png" alt-text="A container image is created by a developer, sent to Container Registry, and retrieved by AKS" border="false" lightbox="../media/6-add-coupon-service/acr-aks.png":::

1. The developer sends the container image to Container Registry.
1. The developer sends Kubernetes YAML configuration files to AKS. The configuration specifies which container images are required.
1. AKS retrieves the images from Container Registry, and uses the images to build and run the containers.

Because you don't have permissions to make changes to Microsoft's container registry, you host the coupon service container image and the modified *:::no-loc text="WebSPA":::* app container image on your private container registry. The `helm install` command specifies which container registry to use when you install the Helm charts to AKS.

## Build the coupon service

Run the following script in the terminal to build the coupon service and *:::no-loc text="WebSPA":::* app container images and host them in Container Registry:

```bash
./build-to-acr.sh
```

The preceding script builds the container images in Container Registry by using the `az acr build` command, with the provided *:::no-loc text="Dockerfile":::* files for the *:::no-loc text="Coupon.API":::* and *:::no-loc text="WebSPA":::* projects.

The solution doesn't build in your development container, but in the cloud when the container image is sent to Container Registry. In the terminal, you can see the `az acr build` command the script uses, with the correct parameters. The command looks similar to the following example:

```azurecli
az acr build --registry eshoplearn \
     --image eshoplearn.azurecr.io/coupon.api:linux-net6-coupon \
     --file src/Services/Coupon/Coupon.API/Dockerfile \
     .
```

In the preceding example:

- The `--registry` parameter specifies the name of the container registry to use.
- The `--image` parameter specifies the name and tag of the image, in the format `<repo url>/<name>:<tag>`.
- The `--file` parameter specifies the relative path of the *:::no-loc text="Dockerfile":::*.
- The final parameter, which is positional and not indicated by a command-line flag, specifies the location of the local source code directory. In this case, the script uses the directory where it's currently running, indicated by `.`.

The terminal also shows the build output.

## Deploy changes to AKS

When the build finishes, run the following script in the terminal to update the existing Azure Kubernetes Service (AKS) cluster with the new configuration:

```bash
./update-aks.sh
```

The preceding script uses `helm` commands to:

- Uninstall the *:::no-loc text="WebStatus":::*, *:::no-loc text="WebSPA":::*, and aggregator Helm charts from the AKS deployment.
- Install the reconfigured *:::no-loc text="WebStatus":::* and aggregator Helm charts by using a public container registry.
- Install the new *:::no-loc text="Coupon.API":::* chart and the reconfigured *:::no-loc text="WebSPA":::* chart by using your private container registry.

The script shows the `helm uninstall` and `helm install` commands in the terminal with the correct parameters.

## Verify changes

After the updated app installs and is online, verify that the changes were successful.

1. Go to the *:::no-loc text="WebStatus":::* page, and observe the status of the changed services. Notice that the unchanged services remain healthy throughout the redeployment of the new and changed services.

1. When the services are all healthy, go to the *WebSPA* URL, and follow these steps:
   1. Refresh the browser.
   1. If you're not signed in, select the **LOGIN** link at upper right and use the credentials provided on the sign-in page.
   1. Add your favorite products to the shopping bag by selecting the images.
   1. Select the shopping bag icon in the upper right.
   1. Select **CHECKOUT**.
   1. Scroll to the **HAVE A DISCOUNT CODE?** field.

      :::image type="content" source="../media/7-update-aks-deployment/discount-code-field.png" alt-text="Screenshot of the shopping basket with the coupon code text box." lightbox="../media/7-update-aks-deployment/discount-code-field.png":::

   1. Enter the code *:::no-loc text="DISC-15":::* for a 15 USD discount, and select **APPLY**.
   1. Select **PLACE ORDER** to complete the purchase.

Congratulations! You successfully added the coupon service to the :::no-loc text="eShopOnContainers"::: app.
