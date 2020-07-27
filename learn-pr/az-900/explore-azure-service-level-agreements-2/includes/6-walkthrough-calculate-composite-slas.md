In this walkthrough, we will determine availability SLA of Azure services and then calculate application composite SLA-based expected availability.

## Exercise - Calculate Composite SLAs

Our example application consists of these Azure services. We will not go in to deep architectural configuration and considerations, the intention here is to give an high level example.

+ **App service**: To host the application.
+ **Azure AD B2C**: To authenticate user logins and manage profiles.
+ **Application Gateway**: To manage application access, and scaling. 
+ **Azure SQL Database**: To store application data. 

## Task 1: Determine the SLA uptime percentage values for our application

1. In a browser, go to the [SLA summary for Azure services](https://azure.microsoft.com/support/legal/sla/summary?azure-portal=true) page.

2. Locate the **App Service** SLA uptime value, **99.95%**. Click **View full details**, and then expand **SLA details**. Notice the **Monthly uptime percentages** and **Service Credits**.

3. Return to the SLA webpage and locate the **Azure Active Directory B2C** service and determine the SLA uptime value, **99.9%**. 

4. Locate the **Application Gateway** SLA uptime value, **99.95%**. 

5. The Azure SQL database uses Premium tiers but is not configured for Zone Redundant Deployments. Locate the **Azure SQL Database** SLA uptime value, **99.99%**. 

---

> [!NOTE]
> There are different uptime values for different configurations and deployments of Azure SQL Database. It is important you are clear on your required uptime values, when planning and costing your deployment and configuration. Small changes in uptime can have impact on service costs as well as potentially increase complexity in configuration. Some other services that may be of interest on the Azure SLA summary web page would include **Virtual Machines**, **Storage Accounts** and **Cosmos DB**.

---

## Task 2: Calculate the Application Composite SLA percentage uptime

1. If any of the services that comprises our application are not available our application will not be available for users to sign in to and use. As such the total uptime for our application consists of the following:

    **App Service % uptime** X **Azure AD B2C % uptime** X  **Azure Application Gateway % uptime** X **Azure SQL Database % uptime** = **Total % Uptime**

    which in percentage term is as follows:

    **99.95%** X **99.9%** X **99.95%** X **99.99%** = **99.79%**

    This is the SLA-based expected availability of our application with the current services and architecture.

Congratulations! You have determined the SLA-based uptime for each of the services in our sample application and then calculated the composite SLA-based expected availability for the application.


When combining SLAs across different service offerings, the resultant SLA is a called a *Composite SLA*. The resulting composite SLA can provide higher or lower uptime values, depending on your application architecture.

Consider an App Service web app that writes to Azure SQL Database. At the time of this writing, these Azure services have the following SLAs:

- App Service Web Apps is 99.95 percent.
- SQL Database is 99.99 percent.

![Image representing Web app and its SLA uptime value of 99.95 percent and a SQL database and its SLA value of 99.99 percent.](../media/service-level-agreement-comparison-1.png)

**Maximum downtime you would expect for this example application**

In the example above, if either service fails the whole application will fail. In general, the individual probability values for each service are independent. However, the composite SLA value for this application is:

```
99.95 percent × 99.99 percent = approx 99.94 percent
```

This means the combined probability of failure value is lower than the individual SLA values. This isn't surprising, because an application that relies on multiple services has more potential failure points.

Conversely, you can improve the composite SLA by creating independent fallback paths. For example, if **SQL Database** is unavailable, you can put transactions into a **Queue** for processing at a later time.

![Image representing Web app and its SLA uptime value of 99.95 percent and SQL database and its SLA value of 99.99 percent.](../media/service-level-agreement-comparison-2.png)

With the design shown in the image above, the application is still available even if it can't connect to the database. However, it fails if both the SQL Database **and** the Queue fail simultaneously. If the expected percentage of time for a simultaneous failure is `0.0001 × 0.001`, i.e. `(1.0 - 0.9999) x (1.0 - 0.999)`, the composite SLA for this combined path would be:

```
Database *OR* Queue = 1.0 − (0.0001 × 0.001) = 99.99999 percent
```

Therefore, the total composite SLA is:

```
Web app *AND* (Database *OR* Queue) = 99.95 percent × 99.99999 percent = ~ 99.95 percent
```

However, there are tradeoffs to using this approach such as, the application logic is more complex, you are paying for the queue, and there may be data-consistency issues which you need to consider.
