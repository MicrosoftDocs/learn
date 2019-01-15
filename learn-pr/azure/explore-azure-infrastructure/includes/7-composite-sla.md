When combining SLAs across different service offerings, the resultant SLA is a called a *Composite SLA*. The resulting composite SLA can provide higher or lower uptime values, depending on your application architecture.

## Calculating downtime 

Consider an App Service web app that writes to Azure SQL Database. These Azure services currently have the following SLAs:

![Image representing Web app and its SLA uptime value of 99.95 percent and a SQL database and its SLA value of 99.99 percent.](../media/7-sla-compositesla1.png)

In this example, if either service fails the whole application will fail. In general, the individual probability values for each service are independent. However, the composite SLA value for this application is: 

`99.95 percent × 99.99 percent = 99.94 percent`

This means the **combined probability of failure** is higher than the individual SLA values. This isn't surprising, because an application that relies on multiple services has more potential failure points.

Conversely, you can improve the composite SLA by creating independent fallback paths. For example, if SQL Database is unavailable, you can put transactions into a queue for processing at a later time.

![Image representing Web app and its SLA uptime value of 99.95% and SQL database and its SLA value of 99.99%.](../media/7-sla-compositesla2.png)

With this design, the application is still available even if it can't connect to the database. However, it fails if both the database _and_ the queue fail simultaneously. 

If the expected percentage of time for a simultaneous failure is **0.0001 × 0.001**, the composite SLA for this combined path of a database _or_ queue would be:

`1.0 − (0.0001 × 0.001) = 99.99999 percent`

Therefore, if we add the queue to our web app, the total composite SLA is:

`99.95 percent × 99.99999 percent = ~99.95 percent`

Notice we've improved our SLA behavior. However, there are trade-offs to using this approach: the application logic is more complicated, you are paying more to add the queue support, and there may be data-consistency issues you'll have to deal with due to retry behavior.
