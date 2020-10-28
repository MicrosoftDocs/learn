In this unit, you run a script to deploy the coupon service and other configuration changes to the existing app. You then verify that the changes were successful. 

## Deploy changes

Run the following script in the command shell to update the existing Azure Kubernetes Service (AKS) cluster with the new configuration:

```bash
./deploy/k8s/update-aks.sh
```

The preceding script uses `helm` commands to:

* Uninstall the *:::no-loc text="WebStatus":::*, *:::no-loc text="WebSPA":::*, and aggregator Helm charts from the AKS deployment.
* Install the reconfigured *:::no-loc text="WebStatus":::* and aggregator Helm charts by using a public container registry.
* Install the new *:::no-loc text="Coupon.API":::* chart and the reconfigured *:::no-loc text="WebSPA":::* chart by using your private Azure Container Registry.

The `helm uninstall` and `helm install` commands used by the script are shown in the command shell with the correct parameters.

## Verify changes

1. Go to the *:::no-loc text="WebStatus":::* page. Observe the status of the changed services.

    > [!NOTE]
    > Notice the unchanged services remain healthy throughout the redeployment of the services you changed.

1. When the services are all healthy, go to the *WebSPA* URL, and follow these steps:
    1. Refresh the browser.
    1. If you're not signed in, select the **LOGIN** link in the upper right (the credentials are provided on the sign-in page).
    1. Add your favorite products to the shopping bag by selecting the images.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**.
    1. Scroll to the **HAVE A DISCOUNT CODE?** field.

        :::image type="content" source="../media/7-update-aks-deployment/discount-code-field.png" alt-text="Shopping basket with the coupon code text box" border="true" lightbox="../media/7-update-aks-deployment/discount-code-field.png":::

    1. Enter the code *:::no-loc text="DISC-15":::* for a 15 USD discount, and select **APPLY**.
    1. Select **PLACE ORDER** to complete the purchase.

Congratulations, you've successfully added the coupon service to the app!
