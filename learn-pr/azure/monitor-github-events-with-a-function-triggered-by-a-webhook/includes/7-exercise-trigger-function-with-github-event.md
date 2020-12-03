In this exercise, you'll update your function to parse information from the GitHub webhook payload, and display the results.

## Update our function to parse the webhook payload


1. In the Azure portal, navigate to the function app that you created earlier.

1. Select **Functions** and select the function that you created.

1. Select **Code + Test** on the far right of the portal UI, and then select **index.js**.

1. Update the index.js file by editing the code in the main window for the function. Replace the current `if...else` statement in the function body with the following code.

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
        }
    }
    ```

    This code retrieves the event type from the request header, and the title and action fields from the message body. This information indicates that page has changed, and whether it has been edited or newly created. The code constructs a response that summarizes the action.

1. Select **Save**.

## Trigger your Azure Function with a Gollum event

1. Return to your GitHub account.

1. Select the repository you are using for this module.

1. Select the **Settings** tab.

1. Select **Webhooks** in the navigation panel.

1. Select the **Edit** button next to your webhook.

1. Scroll down to the **Recent Deliveries** section.

1. Select the latest delivery entry by clicking the ellipsis button (...).

1. Select **Redeliver**.

1. In the message box that appears, select **Yes, redeliver this payload**. This action simulates you changing your Wiki page again.

1. Select the **Response** tab. You'll see how the webhook, has triggered your function, which then parsed the information and sent back a response similar to the following text:

    ```text
    Page is Home, Action is edited, Event Type is gollum
    ```
