In this unit, you'll run a script to deploy the *Coupon.API* microservice and other configuration changes to the existing app. You'll then verify the changes were successful. 

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

1. After the app deploys, navigate to the *WebSPA* URL and perform the following steps:
    1. Add items to the cart.
    1. Navigate to the cart and select **Check out**.
    1. Add the coupon code *DISC-15*.
    1. Select **Apply**. 

%TODO% (Cam or Scott) - Screenshot of cart with coupon box
