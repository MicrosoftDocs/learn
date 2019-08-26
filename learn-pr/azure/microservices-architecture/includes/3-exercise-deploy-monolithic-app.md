Now that we've talked a bit about monolithic and microservices architectures, let's deploy a monolithic application and dive further into how we can evolve it to a microservices architecture.

Fabrikam has currently added the drone service into their existing application.

In this exercise, we'll deploy a monolithic application on Azure App Service and enable Application Insights to get visibility into telemetry and application performance.

## Deploy a monolithic application on Azure App Service

Let's start by deploying the application. First, we'll need to great the Azure resources to host the application.

1. Run this command to deploy the resources needed for this application. This deployment will take a few minutes.

    ```azurecli
    az group deployment create \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --template-uri https://raw.githubusercontent.com/MicrosoftDocs/mslearn-microservices-architecture/master/deployment/azuredeploy.json
    ```

1. Now that we have the resources created, let's deploy the application. First, run this command to pull down the source code from the sample repository.

    ```azurecli
    git clone https://github.com/MicrosoftDocs/mslearn-microservices-architecture.git ~/mslearn-microservices-architecture
    cd ~/mslearn-microservices-architecture/src/before
    ```

1. Run this command to zip up the application code, which we'll use to deploy to the App Service.

    ```bash
    zip -r DroneDelivery-before.zip .
    ```

1. Run this command to set a variable with the name of your App Service.

    ```bash
    APPSERVICENAME="$(az webapp list \
                        --resource-group <rgn>[sandbox resource group]</rgn> \
                        --query '[].name' \
                        --output tsv)"
    ```

1. Run this command to configure the App Service to run a build as part of the deployment.

    ```azurecli
    az webapp config appsettings set \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $APPSERVICENAME \
        --settings SCM_DO_BUILD_DURING_DEPLOYMENT=true
    ```

1. And now, run the following command to deploy the application to App Service. This will take a few minutes to complete.

    ```azurecli
    az webapp deployment source config-zip \
        --resource-group <rgn>[sandbox resource group]</rgn> \
        --name $APPSERVICENAME \
        --src DroneDelivery-before.zip
    ```

1. Once complete, you can confirm the deployment was successful by visiting the web site of your App Service. Run this command to get the URL, and click on it to open the page.

    ```bash
    echo https://$(az webapp config hostname list \
                    --resource-group <rgn>[sandbox resource group]</rgn> \
                    --webapp-name $APPSERVICENAME \
                    --query [].name \
                    --output tsv)

    ![Screenshot of the Drone Delivery web site](../media/3-web-site-before.png)

## Perform load test against application

Now let's test out the performance of the application in it's monolithic architecture.

1. On the home page for your deployed application, click the **Send Requests** button. This simulates the submission of 100 requests through the application.

1. For the first request, you'll see a result of around 8-12 seconds to process 100 messages. If you refresh the page and resubmit if prompted, this may drop by about half, but will still take around five seconds per request.

    ![Screenshot of the Drone Delivery web site after running the performance test](../media/5-performance-test.png)

Fabrikam suspects that the monolithic architecture is preventing heavily utilized services from scaling, leading to the poor performance seen here.
