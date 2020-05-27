In this unit, you'll run a script to deploy the coupon service and other configuration changes to the existing app. You'll then verify the changes were successful. 

## Deploy changes

Run the following script in the command shell to update the existing AKS cluster with the new configuration:

```bash
./deploy/k8s/update-aks.sh
```

The preceding script uses `helm` commands to:

* Uninstall the *WebStatus*, *WebSPA*, and aggregator Helm charts from the AKS deployment.
* Install the reconfigured *WebStatus* and aggregator Helm charts using a public container registry.
* Install the new *Coupon.API* chart and the reconfigured *WebSPA* chart using your private ACR.

The `helm uninstall` and `helm install` commands used by the script are displayed in the console with the correct parameters.

## Verify changes

1. Navigate to the *WebStatus* page. Observe the status of the changed services.

    > [!NOTE]
    > Notice the unchanged services remain healthy throughout the redeployment of the services you changed.

1. Once the services are all healthy, navigate to the *WebSPA* URL and perform the following steps:
    1. Refresh the browser.
    1. If not signed in, select the **LOGIN** link in the upper right to sign into the app (the credentials are provided on the login page).
    1. Add your favorite products to the shopping bag by selecting the images.
    1. Select the shopping bag icon in the upper right.
    1. Select **CHECKOUT**.
    1. Scroll to the **HAVE A DISCOUNT CODE?** field.

        :::image type="content" source="../media/temp/discount-code-field.png" alt-text="Shopping basket with the coupon code textbox" border="true" lightbox="../media/temp/discount-code-field.png":::

    1. Enter the code *DISC-15* for a $15 USD discount and select **APPLY**.
    1. Select **PLACE ORDER** to complete the purchase.

Congratulations! You've successfully added the coupon service to the app!
