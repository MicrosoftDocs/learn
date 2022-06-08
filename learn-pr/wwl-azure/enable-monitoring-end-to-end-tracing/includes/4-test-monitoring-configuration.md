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
2.  Select the **Application Insights** resource in the resource group. On the overview page you'll see data about **Failed requests, Server response time, Server requests,** and **Availability*.***
3.  From **Investigate** section, select **Application map** to display information on the applications running in your Spring Cloud Service and their dependencies.
4.  Select the **api-gateway** service to display details about the application, such as **slowest requests** and **failed dependencies**.
5.  Select **Investigate performance** to display information data on performance.
6.  Mouse over the graph to select a specific time period.
7.  Navigate back to the **Application map** page.
8.  In the navigation menu, in the **Investigate** section, select **Live Metrics**, to display live metrics of your app. The metrics include near real time performance and logs and traces. In the navigation menu, in the **Investigate** section, select **Availability.**
9.  Select **Availability**, and then + **Standard (preview) test**, to configure an availability test for your application.
10. All the following information and select **Create**:
    
    
     -  **\[Test name\]**: Name for your test.
     -  **\[URL\]**: Fill out the URL to your api-gateway.
     -  Select default settings for the remainder of the configuration.

11. Select the **`...`** next to the newly created availability test, and select the **Open Rules (Alerts)** page.
    
    > [!NOTE]
    > Alerts for the test will be enabled. Your application will be pinged for availability from five test locations, every 5 minutes.
    
    Select the alert rule for your availability test. By default there are no action groups associated with this alert rule. You won't be configuring them in this unit, but you can send email or SMS notifications to individuals or groups.

12. Navigate to the **Application Insights** resource.
13. In the navigation menu, in the **Investigate** section, select **Failures** to review information about failures of your apps. You can select any of the response codes, exception types, or failed dependencies display additional information about each of these types of failures.
14. In the navigation menu, in the **Investigate** section, select **Performance** to display performance data about your app's operations. The performance data matches the information you reviewed earlier.
15. In the navigation menu, in the **Monitoring** section, select **Logs** to display log data. You can use Kusto Query Language (KQL) queries to search and analyze the log data.
16. Select **Queries**, then **Performance**.<br>
17. Open **Operations performance** to load the query.
18. Select **Run** to view the query results.
