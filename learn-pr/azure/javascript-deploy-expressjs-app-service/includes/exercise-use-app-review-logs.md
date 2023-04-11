Now that the sample application is deployed, you'll use it to generate log files. Use the failure report to understand how to debug a 404 error.

In this exercise, you'll:

* Interact with the app to generate logs.
* Find and view logs from Visual Studio Code.
* Find and view failure reports for 404 errors in the Azure portal.

## View the app

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **Resources** section, expand the sandbox subscription, then right-click your Azure App Service resource and select **Browse website**.
1. The Express.js web app should appear. You can add, edit, and delete properties on the website.
1. The data is loaded in memory. If you want to refresh the data, go back to the **Azure** pane on the left, right-click your App Service resource in the **Resources** section, right-click your App Service resource, and select **Restart**.
1. Spend a few minutes using the website.
1. To create a 404 error, change the URL in the address bar to something like `https://YOUR-APP-NAME.azurewebsites.net/1234`.

## From the runtime log files: Did your app start successfully?

The App Service keeps logs in the hosting environment, which you can use to resolve runtime issues.

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **Resources > App Services** node, find and select your App Service resource and expand its child nodes.
1. Expand the **Logs** section.
1. Select the file that ends in `_docker.log`.
1. The last line of the file should display something like this example:

    |Log line|
    |--|
    |[DATETIME omitted] INFO  - Container jimb-rentals_1_27887d57 for site jimb-rentals initialized successfully and is ready to serve requests.|

    If your app didn't start up successfully, look here first for more information about the errors.

## From the runtime log files: Does your app run successfully?

1. Select the file that ends in `_default_docker.log`.
1. View the last few entries, which should include something like this example:

    |Log line|
    |--|
    |[DATETIME omitted] express:view lookup "list.html"|
    |[DATETIME omitted] express:view stat "/home/site/wwwroot/views/list.html"|
    |[DATETIME omitted] express:view render "/home/site/wwwroot/views/list.html"|

    These log lines are generated because the `package.json` file's `start` script includes the environment `DEBUG` variable with `express` and `node` included.

    The debug hosting logs are interesting for a developer new to Azure. They aren't a configuration you want to keep in the production app, because your runtime environment could eventually fill up.

## Were there any failures, such as "404 - File not found"?

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **Resources > App Services** node, right-click your App Service resource, and then select **Open in portal**.
1. In the web browser, select **Settings** > **Application Insights**, then select **View Application Insights data**. This action opens your Azure Application Insights resource.
1. Select **Investigate** > **Failures**. The graph should display your 404 error.

    :::image type="content" source="../media/azure-application-insights-failures.png" alt-text="Screenshot of web browser that shows the Azure portal with the Application Insights resource list of web app failures that includes 404 - File not found." lightbox="../media/azure-application-insights-failures.png":::


    If the graph doesn't show errors, wait a couple of minutes and select **Refresh** to try again.
<!--

## Create a 404 alert

1. Still in the web browser for your Application Insights resource, select **Monitoring** > **Alerts**. 
1. Select **+ Create** > **Alert rule**. 
1. On the **Create an alert rule** pane, on the **Actions** pane, select **Create action group**. Use the following table to finish creating your action group.

    |Setting|Value|
    |--|--|
    |Basics - Action group name<br>(and display name)|`4xx`|
    |Notifications - Notifications type|**Email/SMS message/Push/Voice**|
    |Notifications - name|`Notify jimb`, replace `jimb` with your email alias. In the **Email/SMS message/Push/Voice** pane, enter at least one of your contact forms.|
1. Don't fill out **Actions** or **Tags** panes.
1. Select the **Review + create** button at the bottom of the main pane. 
1. If another **Create** button appears, select it. 
1. On the **Create an alert rule** pane, on the **Condition** pane, select **Add condition**. On the **Select a signal** pane, search for and select `failed requests`.
1. On the **Configure signal logic** pane, use the following table to finish configuring **Split by dimensions**: 
   
    |Setting|Value|
    |--|--|
    |Dimension name|Result code|
    |Operator|Starts with|
    |Dimension values|`4`|

1. On the **Configure signal logic** pane, use the following table to finish configuring **Alert logic**: 
   
    |Setting|Value|
    |--|--|
    |Threshold|Static|
    |Operator|Greater than|
    |Aggregation type|Count|
    |Threshold value|`1`|
    |Unit|Count|

    This setting of any 4xx errors triggering an alert isn't realistic for production applications but will help you in this Learn unit. If you continue this web app into a production app for your own purposes, remember to come back and reset this alert logic.

    *Do not use this setting in production.*

1. On the **Configure signal logic** pane, use the following table to finish configuring **Evaluated based on**: 
   
    |Setting|Value|
    |--|--|
    |Aggregation granularity|1 minute|
    |Frequency of evaluation|Every 1 minute|

    The setting of 1 minute is so that you don't have to wait too long for the alert to trigger. 

    *Do not use this setting in production.*

1. After the condition is created, **Estimated monthly cost** is calculated for you on the **Create an alert rule** pane.
1. On the **Create an alert rule** pane, select the **Details** pane. Use the following table to finish configuring the details: 

    |Setting|Value|
    |--|--|
    |Alert rule name|`4xx alert rule`|
    |Alert rule description|`4xx failures`|

    Don't change any other settings.

1. On the **Create an alert rule** pane, select the **Review + create** button at the bottom.

-->

## Check your work

You've used your Azure resources to understand your app's current state and failures. In this exercise:

* You found your startup and runtime logs from Visual Studio Code.
* You found your failures in the Azure portal for "404 - File not found" errors.
