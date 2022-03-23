## Your tasks

In this exercise, you need to: 

* Interact with the app to generate logs.
* Find and view logs from Visual Studio Code.
* Find and view failure reports for 404s on the Azure portal.

## View the app

1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. Right-click on your App Service resource and select **Browser website**.
1. The Express.js web app should display successfully. You can add, edit, and delete properties in the web site. 
1. The data is loaded in memory, if you want to refresh the data, go back to the Azure sidebar, right-click on your App Service and select **Restart**.
1. Spend a few minutes using the website. 
1. Change the URL in the address bar to something like the following, to create a 404 error: `https://YOUR-APP-NAME.azurewebsites.net/1234`.

## From the runtime log files - did your app start successfully?

The App Service keeps logs in the hosting environment, which you can use to resolve runtime issues. 

1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. Find and select your App Service resource and expand its child nodes.
1. Expand the **Logs** section. 
1. Select the file that ends in `_docker.log`. 
1. The last line of the file should display something like: 

    |Log line|
    |--|
    |[DATETIME omitted] INFO  - Container jimb-rentals_1_27887d57 for site jimb-rentals initialized successfully and is ready to serve requests.|

    If your app didn't start up successfully, this would be the first place to look for more information about the errors. 

## From the runtime log files - does your app run successfully?

1. Select the file that ends in `_default_docker.log`.
1. View the last few entries, which should include something like:

    |Log line|
    |--|
    |[DATETIME omitted] express:view lookup "list.html"|
    |[DATETIME omitted] express:view stat "/home/site/wwwroot/views/list.html"|
    |[DATETIME omitted] express:view render "/home/site/wwwroot/views/list.html"|

    These log lines are generated because the `package.json` file's `start` script includes the environment `DEBUG` variable with `express` and `node` included. 

    The debug hosting logs are interesting for a developer new to Azure but not a configuration you want to keep in the production app because your runtime environment could eventually fill up.  

## Were there any failures such as 404 file not found?


1. In Visual Studio Code, use the key combination to open the **Azure** sidebar: <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd>.
1. Right-click your App Service resource, then select **Open in portal**.
1. In the web browser, select **Settings > Application Insights**, then select **View Application Insights data**. This opens your Application Insights resource. 
1. Select **Investigate > Failures**. The graph should display your 404 error. 


:::image type="content" source="../media/azure-application-insights-failures.png" alt-text="Screenshot of web browser showing Azure portal with Application Insights resource listing of web app failures, including 404, file not found.":::



<!--
## Create a 404 alert

1. Still in the web browser for your Application Insights resource, select **Monitoring > Alerts**. 
1. Select **+ Create > Alert rule**. 
1. On the **Create an alert rule** panel, on the **Actions** panel, select **Create action group**. Use the following table to finish creating your action group.

    |Setting|Value|
    |--|--|
    |Basics - Action group name<br>(and display name)|`4xx`|
    |Notifications - Notifications type|**Email/SMS message/Push/Voice**|
    |Notifications - name|`Notify jimb`, replace `jimb` with your email alias. In the **Email/SMS message/Push/Voice** panel, enter at least one of your contact forms.|
1. Don't fill out **Actions** or **Tags** panels.
1. Select **Review + create** button at the bottom of the main panel. 
1. If you are presented with another **Create** button, select it. 
1. On the **Create an alert rule** panel, on the **Condition** panel, select **Add condition**. On the **Select a signal** panel, search for and select `failed requests`.
1. On the **Configure signal logic** panel, use the following table to finish configuring the **Split by dimensions**: 
   
    |Setting|Value|
    |--|--|
    |Dimension name|Result code|
    |Operator|Starts with|
    |Dimension values|`4`|

1. On the **Configure signal logic** panel, use the following table to finish configuring the **Alert logic**: 
   
    |Setting|Value|
    |--|--|
    |Threshold|Static|
    |Operator|Greater than|
    |Aggregation type|Count|
    |Threshold value|`1`|
    |Unit|Count|

    This setting of any 4xx errors triggering an alert isn't realistic for production applications but will help you in this Learn unit. If you continue this web app into a production app for your own purposes, remember to come back and reset this alert logic.

    DO NOT USE THIS SETTING IN PRODUCTION.

1. On the **Configure signal logic** panel, use the following table to finish configuring the **Evaluated based on**: 
   
    |Setting|Value|
    |--|--|
    |Aggregation granularity|1 minute|
    |Frequency of evaulation|Every 1 minute|

    These setting of 1 minute is only so the you don't have to wait too long for the alert to trigger. 

    DO NOT USE THIS SETTING IN PRODUCTION.

1. Once the condition is created, the **Estimated monthly cost** is calculated for you on the **Create an alert rule** panel.
1. 1. On the **Create an alert rule** panel, select the **Details** panel, use the following table to finish configuring the details: 

    |Setting|Value|
    |--|--|
    |Alert rule name|`4xx alert rule`|
    |Alert rule description|`4xx failures`|

    Don't change any other settings.

1. On the **Create an alert rule** panel, select the **Review + create** button at the bottom of the panel.
-->