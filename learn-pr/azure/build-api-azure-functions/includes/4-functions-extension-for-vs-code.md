Azure Functions is uniquely suited for building HTTP APIs. Here's why...

1. The delopment cycle is faster

   Standing up an API in Azure Functions is fast, because you don't have to worry about creating and managing a web server or any of the code that goes into exposing endpoints to the web.

2. It saves you money

   Serverless means you only pay when your function is executed. APIs that are used by actual users vary in execution because it's hard to accurately predict human behavior. Ask anyone with children.

3. Scaling is simplified

   Azure Functions scales up as much as necessary to accomodate load. This is ideal for an HTTP API that might see "burstable" traffic; that is, traffic that experiences suddent and sharp increases and decreases.

## Azure Functions in VS Code

When you install Azure extensions for VS Code, such as the Azure Functions extension and the Azure Cosmos DB extension, an Azure icon will appear in the ActivityBar. The ActivityBar is the bar that runs vertically along the side of your editor. Clicking on that icon will open the Azure Explorer view in the SideBar.

Inside this new Azure Explorer view, each extension that you have installed will show up as a section.

![VS Code with the Azure item in the ActivityBar outlined as well as an outline around the Azure explorer view](../media/activitybar-azure.png)

> [!TIP]
> You can filter the subscriptions that you see in these extensions by opening the Command Palette (F1) and selecting "Azure: Select Subscriptions"

If you have completed previous Learn modules, you will be familiar with using the CLI to create Azure Function projects, run them locally, publish them to Azure, ect.

The Azure Functions extension for VS Code wraps the Azure Functions CLI. This means that virtually anything you can do on the CLI can be done visually from within VS Code. That increases initial productivity because you can immediately see what you are doing.

All Azure Functions extension actions can be accessed two ways - either from the Azure Functions explorer item header icons, or from the Command Palette. The Command Palette contains every command available in VS Code. You can open the Command Palette by pressing <kbd>F1</kbd>.

![VS Code with the Azure item in the ActivityBar outlined as well as an outline around the Azure explorer view](../media/activitybar-azure.png)

> [!TIP]
> You can also summon the Command Palette by pressing <kbd>Cmd</kbd>/<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>. Some find this easier, paticularly if you don't have function keys or if those function keys are mapped to, well, other functions.
