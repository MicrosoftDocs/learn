In Azure, the [Service Level Agreement](https://azure.microsoft.com/support/legal/sla/) describes Microsoft's commitments for uptime and connectivity. If the SLA for a particular service is 99.9%, you should expect the service to be available 99.9% of the time. Different services have different SLAs.

The Azure SLA also provides for obtaining a service credit if the SLA isn't met, along with specific definitions of *availability* for each service. That aspect of the SLA acts as an enforcement policy.

## Composite SLAs

*Composite SLAs* involve multiple services supporting an application, each with differing levels of availability. For example, consider an App Service web app that writes to Azure SQL Database. At the time of this writing, these Azure services have the following SLAs:

- App Service web apps = 99.95%
- SQL Database = 99.99%

What is the maximum downtime you would expect for this application? If either service fails, the whole application fails. The probability of each service failing is independent, so the composite SLA for this application is 99.95% × 99.99% = 99.94%. That's lower than the individual SLAs, which isn't surprising because an application that relies on multiple services has more potential failure points.

You can improve the composite SLA by creating independent fallback paths. For example, if SQL Database is unavailable, put transactions into a queue to be processed later.

:::image border="false" type="content" source="../media/composite-sla-35720a76.png" alt-text="Diagram showing composite service level agreements.":::

With this design, the application is still available even if it can't connect to the database. However, it fails if the database and the queue both fail at the same time. The expected percentage of time for a simultaneous failure is 0.0001 × 0.001, so the composite SLA for this combined path is:

- Database *or* queue = 1.0 − (0.0001 × 0.001) = 99.99999%

The total composite SLA is:

- Web app *and* (database *or* queue) = 99.95% × 99.99999% = ~99.95%

There are tradeoffs to this approach. The application logic is more complex, you're paying for the queue, and you need to consider data consistency issues.

## SLAs for multiregion deployments

*SLAs for multiregion deployments* involve a high-availability technique to deploy the application in more than one region and use Azure Traffic Manager to fail over if the application fails in one region.

The composite SLA for a multiregion deployment is calculated as follows:

- *N* is the composite SLA for the application deployed in one region.
- *R* is the number of regions where the application is deployed.

The expected chance that the application fails in all regions at the same time is ((1 − N) ^ R). For example, if the single-region SLA is 99.95%:

- The combined SLA for two regions = (1 − (1 − 0.9995) ^ 2) = 99.999975%
- The combined SLA for four regions = (1 − (1 − 0.9995) ^ 4) = 99.999999%

The [SLA for Traffic Manager](https://azure.microsoft.com/support/legal/sla/traffic-manager/v1_0/) is also a factor. Failing over isn't instantaneous in active-passive configurations, which can result in downtime during a failover. For more information, see [Traffic Manager endpoint monitoring and failover](/azure/traffic-manager/traffic-manager-monitoring).
