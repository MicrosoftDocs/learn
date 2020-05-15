# Exercise - Update the AKS deployment

In this unit, you'll run a script to deploy the **Coupon.API** microservice and other configuration changes to the existing app. You'll then verify the changes were successful. 

## Deploy changes

Run the following script in the command shell to update the existing AKS cluster with the new configuration:

```bash
./deploy/k8s/update-aks.sh
```

The preceding script:

* Uninstalls and reinstalls the WebStatus, WebSPA, and aggregator Helm charts.
* Installs...  **%TODO%** -- Nish, we don't quite understand what's going on in update-aks.sh. Miguel has two comments, `# Install reconfigured charts` and `# Install charts for new and updated applications`, but the loop for the two tasks looks to do exactly the same thing. Why are there two loops with two sets of charts?   

## Verify changes

1. Navigate to the WebStatus page. Observe the services stopping and redeploying.

1. After the app deploys, navigate to the WebSPA URL and perform the following steps:
    1. Add items to the cart.
    1. Navigate to the cart and select **Check out**.
    1. Add the coupon code *DISC-15*.
    1. Select **Apply**. 

%TODO% (Cam or Scott) - Screenshot of cart with coupon box
