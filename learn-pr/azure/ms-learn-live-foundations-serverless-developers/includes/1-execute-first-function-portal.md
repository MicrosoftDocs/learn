It's always refreshing to see something in action, and with functions, we can do this very quickly. Let's do a little exercise together: using only 10 clicks, you'll be able to execute your very first function in the Azure portal!

## Objective

Use the Learn Live Sandbox to create a function that says "hello" in response to an HTTP GET request.

## Instructions

> [!IMPORTANT]
> Activate the Azure Sandbox to execute the lab instructions in a free subscription and open [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

### Create a Function App

To create a new Function App in the sandbox environment:

1. Select **Create a resource**, search for and select *Function App.* The **Create Function App** pane appears.

    > [!TIP]
    > For this demonstration, make sure you don't create a Linux server. Linux servers do not allow for the function editing within the portal.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project Details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown list, select the GUID of your sandbox resource group |
    | **Instance Details** |
    | Function App name | Use a globally unique name (for example, your initials + *functiontest* + a numeric value) |
    | Publish | Code |
    | Runtime stack | Node.js |
    | Version | 12 LTS |
    | Region | Central US |

1. Select **Review + create**, and then select **Create**.

1. When deployment is complete, select **Go to resource**. The **Function App** pane appears showing aspects of the Function App you just created. Think of the Function App as a workspace that contains our functions.

### Add a function

Let's add a function you can call via a URL.

1. In the left menu pane, under **Functions**, select **Functions**. The **Functions** pane appears for your Function App.

1. On the top menu bar, select **+Add** to add a new function. The **Add function** pane appears.

1. Under **Select a template**, select **HTTP trigger**.

1. Select **Add**.

    Wait for the function to be created. This should only take some seconds. The **HttpTrigger1** pane appears.

1. To see the source code of the function, select **Code + Test** in the left menu pane. In our case, this is JavaScript, but we could have picked other languages, like C#. We can modify the source code directly in the browser, but for now, let's execute the function. The **Code + Test** pane appears.

### Run the function

We can run the function in the editor or get its URL because we chose to create something that is callable over HTTP.

1. In the top menu bar, select **Get function URL**. The **Get function URL** dialog box appears.

1. In the **URL** field, select the *Copy to clipboard* icon.

1. Open a new browser tab and paste the URL. Notice how the URL starts with the function name we specified earlier. Notice the output it has generated.

1. Add "&name=YOUR_NAME" to the end of the URL, and press <kbd>Enter</kbd>. "Hello YOUR_NAME" appears as output.

### Modify the function

To modify the function:

1. Switch back to the editor on the **Code + Test** pane.

1. Change the line that contains "Hello " to "Welcome to Learn Live, dear ".

1. Select **Save**.

1. Switch back to the tab with the function URL, and refresh the browser. The output now shows *Welcome to Microsoft Learn, dear YOUR_NAME"*
