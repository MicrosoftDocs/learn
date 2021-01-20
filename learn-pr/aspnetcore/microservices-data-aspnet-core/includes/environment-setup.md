In this unit, you'll use a script to deploy the existing *:::no-loc text="eShopOnContainers":::* app to AKS.

[!INCLUDE[Azure Cloud Shell instructions](../../includes/use-az-cloud-shell.md)]

## Run deployment script

Run the following command in the command shell. Be patient, as setup can take several minutes to complete. Continue reading while the script runs.

```bash
. <(wget -q -O - https://aka.ms/microservices-data-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

1. Installs the required version of the .NET Core SDK.
1. Clones the *:::no-loc text="eShopOnContainers":::* app from a GitHub repository.
1. Provisions AKS and Azure Container Registry (ACR) resources.
1. Launches the Cloud Shell editor to view the code.
1. Deploys the containers to a fully managed Kubernetes service in Azure, known as AKS.
1. Displays connection information upon completion.

[!INCLUDE[Instructions for restoring the default Cloud Shell configuration](../../includes/microservices/revert-cloud-shell-configuration.md)]

1. Go to the module #06 folder

    ```bash
    cd ~/clouddrive/source/module-06-data-services
    ```

1. Start VS Code online, so it's easier for you to look at the scripts or code

    ```bash
    code .
    ```

1. Run the quickstart script:

    ```bash
    cd deploy/k8s
    ./quickstart.sh --resource-group eshop-learn-rg --location westus
    ```

    You can change the **resource group** and **location** if it suits you better.

When the script finishes you should see something like this:

```txt
Helm charts deployed
NAME                            NAMESPACE       REVISION        UPDATED                                 STATUS         CHART                    APP VERSION
eshoplearn-backgroundtasks      default         1               2020-06-10 17:14:34.2354515 +0100 BST   deployed       backgroundtasks-0.1.0    1.0.0
eshoplearn-basket               default         1               2020-06-10 17:14:36.5080041 +0100 BST   deployed       basket-0.1.0             1.0.0
eshoplearn-basketdata           default         1               2020-06-10 17:14:38.4985338 +0100 BST   deployed       basketdata-0.1.0         1.0.0
eshoplearn-catalog              default         1               2020-06-10 17:14:40.6579297 +0100 BST   deployed       catalog-0.1.0            1.0.0
eshoplearn-coupon               default         1               2020-06-10 17:14:42.5984986 +0100 BST   deployed       coupon-0.1.0             1.0.0
eshoplearn-identity             default         1               2020-06-10 17:14:44.8502929 +0100 BST   deployed       identity-0.1.0           1.0.0
eshoplearn-nosqldata            default         1               2020-06-10 17:14:47.0955346 +0100 BST   deployed       nosqldata-0.1.0          1.0.0
eshoplearn-ordering             default         1               2020-06-10 17:14:49.0495894 +0100 BST   deployed       ordering-0.1.0           1.0.0
eshoplearn-payment              default         1               2020-06-10 17:14:51.336031 +0100 BST    deployed       payment-0.1.0            1.0.0
eshoplearn-rabbitmq             default         1               2020-06-10 17:14:53.3890533 +0100 BST   deployed       rabbitmq-0.1.0           1.0.0
eshoplearn-seq                  default         1               2020-06-10 17:14:55.1297461 +0100 BST   deployed       seq-0.1.0                1.0.0
eshoplearn-signalr              default         1               2020-06-10 17:14:57.2937766 +0100 BST   deployed       signalr-0.1.0            1.0.0
eshoplearn-sqldata              default         1               2020-06-10 17:14:59.5705215 +0100 BST   deployed       sqldata-0.1.0            1.0.0
eshoplearn-webshoppingagg       default         1               2020-06-10 17:15:01.7092263 +0100 BST   deployed       webshoppingagg-0.1.0     1.0.0
eshoplearn-webspa               default         1               2020-06-10 17:15:03.9433526 +0100 BST   deployed       webspa-0.1.0             1.0.0
eshoplearn-webstatus            default         1               2020-06-10 17:15:06.0316249 +0100 BST   deployed       webstatus-0.1.0          1.0.0

Pod status
NAME                               READY   STATUS              RESTARTS   AGE
backgroundtasks-78946c4f64-qgf8f   0/1     Running             0          33s
basket-774d6b4b87-w9pj9            0/1     ContainerCreating   0          31s
basketdata-569c8f68bb-wfdtl        1/1     Running             0          29s
catalog-6f59798c7-lw64l            0/1     ContainerCreating   0          27s
coupon-5bd6c5fff5-pr6xb            0/1     ContainerCreating   0          25s
identity-768c455966-6qj8d          0/1     ContainerCreating   0          22s
nosqldata-7c94c9d6d7-d9x6c         0/1     ContainerCreating   0          20s
ordering-6f9f6b8d6c-zdppc          0/1     ContainerCreating   0          18s
payment-69f857769-flsf2            0/1     ContainerCreating   0          16s
rabbitmq-7ddff8b55c-t9kfm          0/1     ContainerCreating   0          14s
seq-55b68898d4-zb9gt               0/1     ContainerCreating   0          12s
signalr-dfc475758-7kn2j            0/1     ContainerCreating   0          10s
sqldata-6895f76b7-5hglj            0/1     ContainerCreating   0          8s
webshoppingagg-645d7b6b9-82pft     0/1     ContainerCreating   0          5s
webspa-7bddd848cc-w5kc7            0/1     ContainerCreating   0          3s
webstatus-596dd7b945-2qql2         0/1     ContainerCreating   0          1s

The eShop-Learn application has been deployed to "http://51.124.84.102" (IP: 51.124.84.102).

You can begin exploring these services (when ready):
- Centralized logging       : http://51.124.84.102/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://51.124.84.102/webstatus/ (See overall service status)
- Web SPA application       : http://51.124.84.102/
```

> **NOTE**:
>
> If you miss the above screen because the session timed out or any other reason, you can get all the relevant information with this command: \
> `cat ~/clouddrive/source/deploy-application-results.txt`

A little while after the `seq` container becomes ready (1/1) you should be able to check the centralized logs at `http://###.###.###.###/seq/#/events?autorefresh` where you'll see all the transient errors that occur during the application startup, until they stop and all services are up and running.

:::image type="content" source="../media/startup-errors-logging.png" alt-text="Seq home page view, showing typical startup errors." lightbox="../media/startup-errors-logging.png" border="true":::

You can also check the general application status at `http://###.###.###.###/webstatus/` until all health icons are green.

:::image type="content" source="../media/eshop-learn-webstatus.png" alt-text="WebStatus home page view, showing all services OK." lightbox="../media/eshop-learn-webstatus.png" border="true":::

All the services should be up and running in less than five minutes and then you should be able to browse to the home page and login using the credential in the login page.

:::image type="content" source="../media/home-page.png" alt-text="WebSPA home page view." lightbox="../media/home-page.png" border="true":::

## Discount Coupon features

- The user can apply a discount coupon code during the checkout (**DISC-##**, where ## is the discount amount to the order total. For $5, $10, $15, $20, $25, and $30).
- The coupon service must confirm that the coupon is available and return the discount amount (REST API).
- The ordering microservice will request validation for the coupon, during the order process (Asynchronous messaging).
- Upon validation, the coupon will be assigned to the order and won't be available for any other order. However the coupon can be initially "used" by more than one order, until it's actually "consumed" during the order process.
- If the coupon validation is rejected for another order it'll be cancelled.
- If an order is cancelled because of payment rejection (will happen if the order total exceeds $100, configurable), the assigned coupon, if there was one, should be released for any other order to use.

The discount coupon feature adds the following element to the checkout view:

:::image type="content" source="../media/discount-coupon-feature.png" alt-text="WebSPA checkout page view, highlighting the discount coupon input." lightbox="../media/discount-coupon-feature.png" border="true":::
