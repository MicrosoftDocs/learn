Once your server is configured to receive payloads, it will listen for any payload sent to the endpoint you configured. For security reasons, you might want to limit requests to those coming from GitHub. There are a few ways to go about this. For example, you could opt to whitelist requests from GitHub's IP address. An easier method is to set up a secret token and validate the request using this token.

In the example scenario, your IT Department's management are happy with the webhook triggered Azure Function that you've created. All of the information regarding updates to the Technology wiki are being parsed by the Function app and sent to the business, each time the *Gollum* event is triggered. The management has asked how secure the information passed from GitHub is. They've asked you to find a way to secure the information, and verify it's GitHub that is sending updates.

In this unit, you'll learn how to secure your webhook payload with a secret and validate payloads from GitHub.

## Webhook secrets

Setting a webhook secret allows you to ensure that POST requests sent to the payload URL are from GitHub. When you set a secret, you'll receive the `X-Hub-Signature` header in the webhook POST request.

In GitHub, you can set the *secret* field by going to the repository where you have setup your webhook, and then editing the webhook. Use the following procedure

1. Navigate to the repository where you're setting up your webhook.

2. Enter some text into the **Secret** textbox. Use a string that can't easily be guessed.

3. Click **Update Webhook**.

## Validating payloads from GitHub

When your secret token is set, GitHub uses it to create a hash signature for each payload. This hash signature is passed along with each request in the headers as `X-Hub-Signature`.

When your function receives a request, you need to compute the hash using your secret, and ensure that it matches the hash in the request header. GitHub uses an HMAC SHA1 hex digest to compute the hash, so you must calculate your hash in this same way, using the key of your secret and your payload body. The hash signature starts with the text `sha1=`.