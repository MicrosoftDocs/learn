
In this exercise, you'll protect your webhook payload with a secret, and learn how to validate payloads from GitHub inside an Azure Function.

## Get Key for your Azure Function

1. In the Azure portal, return to your function app that you created from the first exercise in the module.

1. Expand **Functions**.

1. Select the function that you created.

1. In your function's **index.js** JavaScript file, add a reference to the **crypto-js** library at the start of the file, above the `module.exports` statement.

    ```JavaScript
    const Crypto = require('crypto');
    ```

1. Select **Function Keys** from the left-hand menu, select **Click to show** next to the **default** key.

1. Under **Actions**, select **Copy** and save this key for use in the next step.

1. Back in the body of your function, after the `context.log` statement, add the following code. Replace *\<default key\> with the default key that you copied to the clipboard earlier:

    ```JavaScript
    const hmac = Crypto.createHmac("sha1", "<default key>");
    const signature = hmac.update(JSON.stringify(req.body)).digest('hex');
    ```

    This code computes the hash of the key, using the same mechanism as GitHub.

1. Add `sha1=` to the start of the key, so that it matches the format of `x-hub-signature` in the request header. Add the following code to your function.

    ```JavaScript
    const shaSignature = `sha1=${signature}`;
    ```

1. Add the following code to retrieve the GitHub signature from the request header:

    ```JavaScript
    const gitHubSignature = req.headers['x-hub-signature'];
    ```

1. Compare the two strings. If they match, process the request, as follows:

    ```JavaScript
    if (!shaSignature.localeCompare(gitHubSignature)) {
        // Existing code
        if (req.body.pages[0].title) {
            ...
        }
        else {
            ...
        }
    }
    ```

1. If the strings don't match, return an HTTP 401 (Unauthorized) response, with a message telling the sender that the signatures don't match.

    ```JavaScript
    if (!shaSignature.localeCompare(gitHubSignature))
    {
        ...
    }
    else {
        context.res = {
            status: 401,
            body: "Signatures don't match"
        };
    }

    ```

1. Select **Save**.

    The completed function should look like this:

    ```JavaScript
    const Crypto = require('crypto');

    module.exports = async function (context, req) {
        context.log('JavaScript HTTP trigger function processed a request.');

        const hmac = Crypto.createHmac("sha1", "<default key>");
        const signature = hmac.update(JSON.stringify(req.body)).digest('hex');
        const shaSignature =  `sha1=${signature}`;
        const gitHubSignature = req.headers['x-hub-signature'];

        if (!shaSignature.localeCompare(gitHubSignature)) {
            if (req.body.pages[0].title) {
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
        }
        else {
            context.res = {
                status: 401,
                body: "Signatures don't match"
            };
        }
    };
    ```

## Update the webhook secret

1. Switch to your GitHub account in the GitHub portal.

1. Select your repository.

1. Select the **Settings** tab.

1. Select **Webhooks** in the navigation panel.

1. Select the **Edit** button next to your webhook.

1. In the **Secret** text box, enter the default key from your function that you saved earlier in this exercise.

1. At the bottom of the page, select **Update webhook**.

## Test the webhook and the Azure Function

1. On the webhooks page, scroll down to the **Recent Deliveries** section.

1. Select the latest delivery entry by clicking the ellipsis (...) button.

1. Click **Redeliver**, and then select **Yes, redeliver this payload**.

    This action simulates you changing your Wiki page again.

1. In the header, you'll see the `x-hub-signature`. You'll also see that the response code is 200, indicating that the request was processed successfully.

    ```text
    Request URL: https://testwh123456.azurewebsites.net/api/HttpTrigger1?code=aUjXIpqdJ0ZHPQuB0SzFegxGJu0nAXmsQBnmkCpJ6RYxleRaoxJ8cQ%3D%3D
    Request method: POST
    content-type: application/json
    Expect:
    User-Agent: GitHub-Hookshot/16496cb
    X-GitHub-Delivery: ce122460-6aae-11e9-99d4-de6a298a424a
    X-GitHub-Event: gollum
    X-Hub-Signature: sha1=<hash of default key>
    ```

## Test an invalid signature

1. In the GitHub portal, on the webhooks page, scroll up to the **Secret** test box and then select **Edit**.

1. Enter a random string, scroll down, and then select **Update webhook**.

    The key used by the webhook should no longer match that expected by the Azure function.

1. Scroll down to the **Recent Deliveries** section.

1. Select the latest delivery entry by selecting the ellipsis (...) button.

1. Select **Redeliver**, and then **Yes, redeliver this payload**.

1. This time, you'll see that the response code is 401, indicating that the request was not authorized.

1. Select the **Response** tab, and verify that the message "Signatures don't match" appears as the body of the response.
