In this unit, we discuss the JBoss Admin tooling

## JBoss EAP Admin Tools (CLI & Web Console)

Azure App Service provides both an administrative graphical user interface and a command-Line Interface.

If you access to Admin Web Console, you can see like following Screen:

:::image type="content" source="../media/jboss-admin-console2.png" alt-text="Admin Console Top Page":::

## View application logs

You can view logs by using Azure CLI. Run the following CLI command and replace <your_app_name> with the name of your App Service:

```azurecli
az webapp log tail --name <your_app_name> -g <resource_group_name>
```

In the next exercise, you'll learn how to access to the JBoss Admin Tools and get the log stream from running application.
