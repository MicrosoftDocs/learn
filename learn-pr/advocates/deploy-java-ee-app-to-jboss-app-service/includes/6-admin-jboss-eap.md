In this unit, we'll outline the JBoss Admin tooling and in the next exercise, access it.

## JBoss EAP Admin Tools (CLI & Web Console)

Azure App Service provides both an administrative graphical user interface and a command-Line Interface.

When you access to Admin Web Console, you'll see the following Screen:

:::image type="content" source="../media/jboss-admin-console2.png" alt-text="Admin Console Top Page":::

## View the application logs

You can view the JBoss application logs by using the Azure CLI:

```azurecli
az webapp log tail --name <your_app_name> -g <resource_group_name>
```

In the next exercise, you'll learn how to access to the JBoss Admin Tools and get the log stream from your running application.
