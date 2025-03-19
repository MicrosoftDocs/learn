In this exercise, you'll update your function to parse information from the GitHub webhook payload, and display the results.

## Update your function to parse the webhook payload

1. In the Azure portal, go to the Function App that you created earlier.

1. On the **Function App** pane, in the left menu pane, under **Functions**, select **Functions**. The **Functions** pane appears for your *Function App*.

1. Select the HttpTrigger1 you created. The **HtttpTrigger1** pane appears for your *Function*.

1. In the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane for your *Function* appears.

1. In the path above the code, from the dropdown list, select **index.js**. The JavaScript for your trigger appears.

1. Update the code by replacing the last three lines of code in the function body with the following code.

    ```JavaScript
    if (req.body.pages[0].title){
        context.res = {
            body: "Page is " + req.body.pages[0].title + ", Action is " + req.body.pages[0].action + ", Event Type is " + req.headers['x-github-event']
        };
    }
    else {
        context.res = {
            status: 400,
            body: ("Invalid payload for Wiki event")
        };
    }
    ```

    This code retrieves the event type from the request header, and the title and action fields from the message body. This information indicates that page has changed, and whether it has been edited or newly created. The code then constructs a response that summarizes the action. Here's what the JavaScript should look like:

    ```JavaScript
    module.exports = async function (context, req) {
        context.log('JavaScript HTTP trigger function processed a request.');

        const name = (req.query.name || (req.body && req.body.name));
        const responseMessage = name
            ? "Hello, " + name + ". This HTTP triggered function executed successfully."
            : "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.";

        if (req.body.pages[0].title){
            context.res = {
                body: "Page is " + req.body.pages[0].title + ", Action is " + req.body.pages[0].action + ", Event Type is " + req.headers['x-github-event']
            };
         }
         else {
            context.res = {
                status: 400,
                body: ("Invalid payload for Wiki event")
            };
        }
    }
    ```

1. In the top menu bar, select **Save**.

## Trigger your Azure Function with a Gollum event

1. Return to your GitHub account.

1. Select the repository you're using for this module.

1. In the top menu bar, select **Settings**. The **Settings** pane appears.

1. In the sidebar, select **Webhooks**. The **Webhooks** pane appears.

1. Select **Edit** for your webhook. The **Webhooks/Manage webhook** pane appears.

1. Select the **Recent Deliveries** tab.

1. Select the latest (top) delivery entry by selecting its ellipsis button (**...**).

1. Select **Redeliver**.

1. In the **Redeliver payload?** dialog box that appears, select **Yes, redeliver this payload**. This action simulates you changing your Wiki page again.

1. Select the latest (top) delivery entry (*redelivery*) by selecting its ellipsis button (**...**).

1. Select the **Response** tab. You'll see how the webhook has triggered your function, which then parsed the information, and sent a response similar to the following text:

    ```text
    Page is Home, Action is edited, Event Type is gollum
    ```
