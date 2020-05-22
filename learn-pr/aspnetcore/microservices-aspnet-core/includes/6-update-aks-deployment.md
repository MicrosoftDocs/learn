In this unit, you'll run a script to deploy the coupon service and other configuration changes to the existing app. You'll then verify the changes were successful. 

## How the coupon service integrates with other services

%TODO% - What's going on with Orders and Basket. And Identity. Also, think of a better H2 above. :)

## Deploy changes

Run the following script in the command shell to update the existing AKS cluster with the new configuration:

```bash
./deploy/k8s/update-aks.sh
```

The preceding script uses `helm` commands to:

* Uninstall the *WebStatus*, *WebSPA*, and aggregator Helm charts from the AKS deployment.
* Install the reconfigured *WebStatus* and aggregator Helm charts using a public container registry.
* Install the new *Coupon.API* chart and the reconfigured *WebSPA* chart using your private ACR.

## Verify changes

1. Navigate to the *WebStatus* page. Observe the services stopping and redeploying.

1. Once the app is healthy, navigate to the *WebSPA* URL and perform the following steps:
    1. Refresh the browser.
    1. If not signed in, select the **Login** link in the upper right to sign into the app (the credentials are provided on the login page).
    1. Add your favorite products to the shopping bag by clicking on the images.
    1. Select the shopping bag icon in the upper right.
    1. Select **Checkout**. 
    1. Scroll down to the **Have a discount code?** field. 
    1. Enter the code *DISC-15* for a $15 discount and select **Apply**.

        ![The shopping basket showing the discount code field](../media/temp/discount-code-field.png)

    1. Select **Place Order** to complete the purchase.

Congratulations! You've successfully added the coupon service to the app!
