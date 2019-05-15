In this exercise, you'll update your Azure Function to parse information from the GitHub webhook payload, and display the results.

## Update the Function App to parse information from the GitHub webhook


1. Expand **Functions**.

1. Select the function that you created.

1. Click **View files**, and then click **index.js**.

1. Update the index.js file by editing the code in the main window for the function. Replace the `if...else` statement in the function body with the following code.

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

1. Click **Save**.

## Trigger your Azure Function with a Gollum event

1. Return to your GitHub account.

1. Select your repository.

1. Select the **Settings** tab.

1. Click **Webhooks** in the navigation panel.

1. Click the **Edit** button next to your webhook.

1. Scroll down to the **Recent Deliveries** section.

1. Select the latest delivery entry by clicking the ellipsis button (...).

1. Click **Redeliver**.

1. In the message box, click **Yes, redeliver this payload**. This action simulates you changing your Wiki page again.

1. Verify that the webhook is now processed successfully.

1. Click the **Response** tab. You'll see how the webhook, has triggered your Azure function, and parsed the information that you added to the function at the start of the exercise. The body of the response should look like:

    ```text
    Page is Home, Action is edited, Event Type is gollum
    ```