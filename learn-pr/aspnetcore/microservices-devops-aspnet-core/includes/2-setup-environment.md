In this module, you'll create an initial AKS deployment of the simplified version of *eShopOnContainers* with a public IP address over HTTP. This step requires user input, so watch for the prompt in Azure Cloud Shell.

[!INCLUDE[Azure Cloud Shell instructions](../../includes/use-az-cloud-shell.md)]

## Set up the environment

1. In another browser window, fork the repository <https://github.com/dotnet-architecture/eShop-Learn> to your GitHub account. For instructions on forking, see [Forking Projects](https://guides.github.com/activities/forking/).
1. Run the following command in the command shell:

    ```bash
    . <(wget -q -O - https://aka.ms/microservices-devops-aspnet-core-setup)
    ```

    [!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

To create an AKS cluster with a starter version of eShop-Learn complete the following steps:

1. Go to the module #06 folder - **NOTE - This should be changed to the final module path**

    ```bash
    cd ~/clouddrive/source/module-06-data-services
    ```

1. Run the quickstart script:

    ```bash
    cd deploy/k8s
    ./quickstart.sh --resource-group eshop-learn-rg --location westus
    ```

    You can change the **resource group** and **location** if it suits you better.

When the script finishes, a variation of the following output appears:

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

![Seq home page view, showing typical startup errors.](media/startup-errors-logging.png)

You can also check the general application status at `http://###.###.###.###/webstatus/` until all health icons are green.

![WebStatus home page view, showing all services OK.](media/eshop-learn-webstatus.png)

All the services should be up and running in less than five minutes and then you should be able to browse to the home page and login using the credential in the login page.

![WebSPA home page view.](media/home-page.png)
