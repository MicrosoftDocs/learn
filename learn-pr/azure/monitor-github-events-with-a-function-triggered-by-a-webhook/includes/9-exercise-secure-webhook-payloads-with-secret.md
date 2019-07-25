
In this exercise, you'll protect your webhook payload with a secret, and learn how to validate payloads from GitHub inside an Azure Function.

## Get Key for your Azure Function

1. In the Azure portal, return to your function app that you created from the first exercise in the module.

1. Expand **Functions**.

1. Select the function that you created.

1. Click **Manage**.

1. In the **Function Keys** section, click **Click to show** next to the **default** key. It should look like:

1. Under **Actions**, click **Copy**.

1. Select you function again, and in the **index.js** JavaScript file, add a reference to the **crypto-js** library at the start of the file, above the `module.exports` statement.

    ```JavaScript
    var Crypto = require('crypto');
    ```

1. In the body of the function, after the `context.log` statement, add the following code. Replace *\<default key\> with the default key that you copied to the clipboard earlier:

    ```JavaScript
    var hmac = Crypto.createHmac("sha1", "ciCDNcluUthgW5DwCxVx8/FTR6QBSL2/K6svSDYkgvZcng/qbdp/5A==");
    var signature = hmac.update(JSON.stringify(req.body)).digest('hex');
    ```

    This code computes the hash of the key, using the same mechanism as GitHub.

1. Add `sha1=` to the start of the key, so that it matches the format of `X-Hub-Signature` in the request header. Add the following code to your function.

    ```JavaScript
    var signature =  "sha1=" + signature;
    ```

1. Add the following code to retrieve the GitHub signature from the request header: 

    ```JavaScript
    var gitHubSignature = req.headers['X-Hub-Signature'];
    ```

1. Compare the two strings. If they match, process the request, as follows:

    ```JavaScript
    if (!signature.localeCompare(gitHubSignature)) {
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
    if (signature.localeCompare(gitHubSignature) == 0)
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

1. Click **Save**.

    The completed function should look like this:

    ```JavaScript
    var Crypto = require('crypto');

    module.exports = async function (context, req) {
        context.log('JavaScript HTTP trigger function processed a request.');

        var hmac = Crypto.createHmac("sha1", "<default key>");
        var signature = hmac.update(JSON.stringify(req.body)).digest('hex');
        var signature =  "sha1=" + signature;
        var gitHubSignature = req.headers['x-hub-signature'];

        if (!signature.localeCompare(gitHubSignature)) {
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

1. Click **Webhooks** in the navigation panel.

1. Click the **Edit** button next to your webhook.

1. In the **Secret** text box, enter the default key from your function.

1. At the bottom of the page, click **Update webhook**.

## Test the webhook and the Azure Function

1. On the webhooks page, scroll down to the **Recent Deliveries** section.

1. Select the latest delivery entry by clicking the ellipsis (...) button.

1. Click **Redeliver**, and then click **Yes, redeliver this payload**. 

    This action simulates you changing your Wiki page again.

1. In the header, you'll see the `X-Hub-Signature`. You'll also see that the response code is 200, indicating that the request was processed successfully.

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

1. In the GitHub portal, on the webhooks page, scroll up to the **Secret** test box and then click **Edit**.

1. Enter a random string, scroll down, and then click **Update webhook**.

    The key used by the webhook should no longer match that expected by the Azure function.

1. Scroll down to the **Recent Deliveries** section.

1. Select the latest delivery entry by clicking the ellipsis (...) button.

1. Click **Redeliver**, and then click **Yes, redeliver this payload**.

1. This time, you'll see that the response code is 401, indicating that the request was not authorized.

1. Click the **Response** tab, and verify that the message "Signatures don't match" appears as the body of the response.
