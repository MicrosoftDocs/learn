In this unit, you look at how to view a live app log stream, and how live log streams can help during Web app development. 

## What is live log streaming?

Live log streaming is an easy and efficient way to view live logs for troubleshooting purposes. Live log streaming provides a quick view of all the messages sent to the app logs in the file system, without having to go through the process of locating and opening the logs. To use live logging, you connect to the live log service from the command line, and you can then see text being written to the app's logs in real time.

### What logs can be streamed?

The log streaming service adds a redirect from the file system logs, so that you see the same information that is saved to the log files. So, if you enable verbose logging for ASP.NET Windows apps, for example, the live log stream shows all your logged messages.

:::image type="content" source="../media/4-live-log-stream.png" alt-text="Screenshot of Azure portal live log stream pane showing output from the asp logs container." border="false":::

### Typical scenarios for using live logging

Live logging is a useful tool for initial debugging. Real time log messages give you immediate feedback for code or server issues. You can then make a change, redeploy your app, and instantly see the results.

The live log stream connects to a single app instance, so it's not useful if you have a multi-instance app. Live logging is also of limited use as you scale up your apps. In these scenarios, it's better to ensure that messages are saved to log files that can be opened and studied offline.

## How to use live log streaming

You can enable live log streaming from the command line, in a Cloud Shell session directly from the Azure portal. There are two options: **Azure CLI** or **curl** commands.

### Azure CLI

To open the log stream, run the following command.

```azcli
az webapp log tail --name <app name> --resource-group <resource group name>
```

To stop viewing live logs, press <kbd>Ctrl+C</kbd>.

### Curl

To use Curl, you need *FTPS credentials*. There are two types of FTPS credentials:

- **Application scope**. Azure automatically creates a username/password pair when you deploy a Web app, and each of your apps has their own separate set of credentials.

- **User scope**. You can create your own credentials for use with any Web app. You can manage these credentials in the Azure portal, *as long as you already have at least one Web app*, or by using Azure CLI commands.

### Azure portal UI

To view and copy these details from the Azure portal, in the **App Service** menu, under **Deployment**, select **Deployment Center**, and then select the **FTPS credentials**. tab.

:::image type="content" source="../media/4-deployment-credentials.png" alt-text="Screenshot of the App Service Deployment Center pane showing FTPS credentials tab." border="false":::

## Reset user-level credentials

To create a new set of user-level credentials, run the following command in the Cloud Shell.

```azcli
az webapp deployment user set --user-name <name-of-user-to create> --password <new-password>
```

> [!NOTE]
> Usernames must be globally unique across all of Azure, not just within your own subscription or directory.

After you have created a set of credentials, run the following command to open the log stream. You're then prompted for the password.

```azcli
curl -u {username} https://{sitename}.scm.azurewebsites.net/api/logstream
```

To close an active log stream session, press <kbd>Ctrl+C</kbd>.
