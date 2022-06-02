Now that Application Insights is configured, you can use the service to monitor what's happening in your application.

In this unit, you'll view the following items:

 -  The Application Map
 -  Performance data
 -  Failures
 -  Metrics
 -  Live Metrics
 -  Availability
 -  Logs

To analyze monitoring data, do the following procedure.

1.  In your browser, navigate to the Azure portal and your resource group.
2.  Select the **Application Insights** resource in the resource group. On the overview page you'll see data about ***Failed requests, Server response time, Server requests,** and **Availability.***
3.  Select **Application map** to display information about the applications running in your Spring Cloud Service and their dependencies.
4.  Select the **api-gateway** service to display details about the application, such as *slowest requests* and *failed dependencies*.
5.  Select **Investigate performance** to display information data on performance.
6.  Mouse over the graph to select a specific time period.
7.  Select your Application Insights resource to navigate back to the **Application map** and the **api-gateway** service.
8.  Select **Live Metrics** to view live metrics of your application. You'll see the real-time performance of your application and the logs and traces coming through.
9.  Select **Availability**, and then **Add Standard (preview) test**, to configure an availability test for your application.
10. All the following information and select **Create**:
    
    
     -  **\[Test name\]**: Name for your test.
     -  **\[URL\]**: Fill out the URL to your api-gateway.
     -  Select default settings for the remainder of the configuration.

11. Select the ellipses next to the newly created availability test, and select the **Open Rules (Alerts)** page.
    
    > [!NOTE]
    > Alerts for the test will be enabled. Your application will be pinged for availability from five test locations, every 5 minutes.
    
    > [!NOTE]
    > Select the alert rule for your availability test. By default there are no action groups associated with this alert rule. You won't be configuring them in this unit, but you can send email or SMS notifications to individuals or groups.

12. Navigate to the **Application Insights** resource.
13. Select **Failures** to view information for failures in your applications.
14. You can select **response codes, exception types,** or **failed dependencies** for information on failures.
15. Select **Performance** to view operations performance data for your applications.
16. Select **Logs**, to view logged data.
17. Select **Queries**, then **Performance**.
18. Open **Operations performance** to load the query.
19. Select **Run** to view the query results.
