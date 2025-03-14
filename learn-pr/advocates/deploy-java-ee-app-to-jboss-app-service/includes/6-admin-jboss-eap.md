This unit shows you how the JBoss administration tools appear on the screen and how to view the application logs. You execute these steps in the next unit.

## JBoss EAP administration tools - CLI and web console

Azure App Service provides both an administrative UI and a command line interface. When you open the admin web console, you see the following screen:

:::image type="content" source="../media/jboss-admin-console-home-page.png" alt-text="Screenshot of the main page of the admin console." lightbox="../media/jboss-admin-console-home-page.png":::

## Application logs

You can view the JBoss application logs by using the following command:

```azurecli
az webapp log tail
    --resource-group <resource-group-name>
    --name <your-app-name>
```

In the next exercise, you learn how to access the JBoss administration tools and get the log stream from your running application.

## Unit summary

You've seen the steps to examine the server logs. In the next section, you execute the steps to see the logs in your application.
