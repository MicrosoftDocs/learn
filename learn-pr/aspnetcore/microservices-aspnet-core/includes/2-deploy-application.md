In this unit, you'll deploy the eShop app to AKS. You'll also gain an understanding of the microservices architecture used.

## Set up development environment

Run the following command in the command shell. Be patient, as setup can take a few minutes to complete.

```bash
. <(wget -q -O - https://aka.ms/microservices-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command retrieves and runs a setup script from a GitHub repository. The script completes the following steps:

* Clones the eShop project from a GitHub repository.
* Provisions an AKS and Azure Container Registry (ACR) resource.
* Launches the Cloud Shell Editor to view the code.
* Deploys the containers to AKS.
* Displays connection information upon completion

> [!NOTE]
> Non-blocking warnings are expected in the deployment process.

## Review code and architecture

Soon after launching the script, a code editor window will appear. You may investigate the code while the script continues to deploy the containers to AKS.

The following directories contain .NET Core projects, each of which are built to containers and deployed to AKS:

| Project directory | Description |
|-------------------|-------------|
| *src/Aggregators/* | Services to aggregate across multiple microservices for certain cross-service operations. |
| *src/BuildingBlocks/* | These services provide cross-cutting functionality, such as the app's event bus used for inter-service events. |
| *src/Services/* | These projects implement the business logic of the app. Each microservice is autonomous with its own database or other data store. They showcase different software patterns, including Create-Read-Update-Delete (CRUD), Domain Driven Design (DDD), and Command-query Separation (CQRS).
| *src/Web/* | ASP.NET Core apps that implement user interfaces. *WebSPA* is the storefront UI. *WebStatus* is the health check app for monitoring the operational status of the app.

![eShop application architecture](../media/temp/eshop-architecture.png)

As depicted in the diagram, the event bus is used for integrating events across microservices. The implementation that has been deployed in AKS uses RabbitMQ in a container, but a service such as Azure Service Bus would also be appropriate.

## Test deployment

When the app is done deploying to AKS, you will see a message similar to this in the console:

```console
The eShop-Learn application has been deployed.

You can begin exploring these services (when available):
- Centralized logging       : http://13.83.97.100/seq/#/events?autorefresh (See transient failures during startup)
- General application status: http://13.83.97.100/webstatus/ (See overall service status)
- Web SPA application       : http://13.83.97.100/
```

Select the link indicated by the **General application status** link. This health check page shows the status of all the microservices in the deployment.

![Health check page](../media/temp/health-check.png)

When the services are all healthy, you may select the **Web SPA application** link to test the eShop on Containers web app.

![eShop SPA](../media/temp/eshop-spa.png)

Login to the app (the credentials are provided on the login page) and then browse the shop. Add some items to the cart, and then complete the purchase.

## Add the Coupon service

A project for the Coupon service has been provided in *src/Services/Coupon*. 

1. Open *src/Services/Coupon/Coupon.API/Controllers/CouponController.cs*.
1. Replace the comment `/* Add the GetCouponByCodeAsync method */` with the following code:

    ```csharp
    [HttpGet("{code}")]
    [ProducesResponseType((int)HttpStatusCode.NotFound)]
    [ProducesResponseType((int)HttpStatusCode.BadRequest)]
    [ProducesResponseType(typeof(CouponDto), (int)HttpStatusCode.OK)]
    public async Task<ActionResult<CouponDto>> GetCouponByCodeAsync(string code)
    {
        var coupon = await _couponRepository.FindCouponByCodeAsync(code);

        if (coupon is null || coupon.Consumed)
        {
            return NotFound();
        }

        var couponDto = _mapper.Translate(coupon);

        return Ok(couponDto);
    }
    ```

    In the preceding code:

    * %TODO%
    * %TODO%
    * %TODO% 

1. Open *Startup.cs*.
1. Note on line 38 `.AddCustomHealthCheck(Configuration)`. %TODO% Explanation of AddCustomHealthCheck
1. Note on lines 70-82 %TODO% Explanation of /hc and /liveness endpoints
1. Execute the following script:

    ```bash
    ./deploy/k8s/implementation-script.sh
    ```

    The preceding script:

    * Uncomments the coupon field and markup in the SPA.
    * Creates a helm charts for the coupon service (%TODO% explain the following: helm-simple/coupon/Chart.yaml helm-simple/coupon/templates/deployment.yamhelm-simple/coupon/templates/service.yaml helm-simple/coupon/templates/configmap.yaml helm-simple/coupon/templates/ingress.yaml )
    * Adds the coupon service endpoints to the aggregator (see helm-simple/webshoppingagg/templates/configmap.yaml)
    * Adds the coupon HC to the webstatus (see helm-simple/webstatus/templates/configmap.yaml)

1. Open *deploy/k8s/build-to-acr.sh*

    %TODO% explain that we're building the project to ACR in this script
1. Execute the script by running:

    ```bash
    ./deploy/k8s/build-to-acr.sh
    ```

    The containers are published to ACR.
1. Open *deploy/k8s/update-to-aks.sh*

    %TODO% explain that this is installing help charts
1. Execute the script by running:

    ```bash
    ./deploy/k8s/update-to-aks.sh
    ```
1. Observe the services stopping and redploying on the web status.
1. After the app deploys, refresh the page.
1. Add items to the cart.
1. Navigate to the cart and select **Check out**.
1. Add the coupon code **DISC-15**.

## Clean up Azure resources

To de-provision... 

```bash
az group delete --name eshop-learn-rg --yes
```

Also explain how to remove the service principal. Can that be done easily from a script?

