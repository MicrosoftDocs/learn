## JBoss EAP Admin Tools (CLI & Web Console)

In order to manage or monitor the  JBoss EAP Application Server, sometimes you may want to access to the server and you want to confirm or configure the Server. In order to do it, Azure App Service provide both Graphical User Interface and Command Line Interface. 

For example, if you access to Admin Web Console, you can see like follwoing Screen.

![Admin Console Top Page](../media/jboss-admin-console2.png)


## Azure App Service Log stream

You can see (or "tail") the logs from the running App Service. Any calls to console.log in the site code are displayed in the terminal.

Run the following command to start logging, replacing <your_app_name> with the name of your App Service:

```azurecli
az webapp log tail --name <your_app_name>
```

In the next exercise, you will learn how to access to the JBoss Admin Tools and get the log stream from running application.