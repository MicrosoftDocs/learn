This unit focuses on how you know your app is working correctly. 

## View the app

1. In Visual Studio Code, in the Azure sidebar, right-click on your App Service and select **Browser website**.
1. The Express.js web app should display successfully. You can add, edit, and delete properties in the web site. 
1. The data is loaded in memory, if you want to refresh the data, go back to the Azure sidebar, right-click on your App Service and select **Restart**.
1. Spend a few minutes using the website.

## View App Service logs

The App Service keeps logs in the hosting environment for you to review when an issue comes up. 

1. In Visual Studio Code, select the Azure sidebar, then select App Service. 
1. Find and select your web app and expand its child nodes.
1. Expand the **Logs** section. 
1. Select one of the files which ends in `_docker.log`. 
1. The last line of the file should display something like: 

    ```console
    [DATETIME ommited] INFO  - Container jimb-rentals_1_27887d57 for site jimb-rentals initialized successfully and is ready to serve requests.
    ``` 

    If your app didn't start up successfully, this would be the first place to look. 

1. Select one of the files which ends in `default_docker.log`.
1. View the last few entries, which should include something like:

    ```console
    [DATETIME ommited] express:view lookup "list.html"
    [DATETIME ommited] express:view stat "/home/site/wwwroot/views/list.html"
    [DATETIME ommited] express:view render "/home/site/wwwroot/views/list.html"
    ```

    This are the Express.js logs, generated because the `package.json` file's `start` script includes the environment `DEBUG` variable with express and node included. 

    Its interesting for a developer new to Azure but not a configuration you want to keep in the product app because your runtime environment could eventually fill up.  

## View cloud-based Application Insights logs

When you created the App Service, you included Application Insights. 

## Application insights logs