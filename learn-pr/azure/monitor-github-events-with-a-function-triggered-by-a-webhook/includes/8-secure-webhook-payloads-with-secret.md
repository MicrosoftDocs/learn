After your function is configured to receive payloads, it will listen for any payload sent to the endpoint you configured. For security reasons, you might want to limit requests to those coming from GitHub. There are a few ways to go about this. For example, you could opt to approve requests from GitHub's IP address. An easier method is to set up a secret token and validate the request using this token.

In the example scenario, your IT Department's management are happy with the webhook triggered function that you've created in an Azure Functions app. All of the information regarding updates to the company wiki are being parsed by that function and sent to the business, each time the *Gollum* event is triggered. The management has asked how secure is the information passed from GitHub. They've asked you to find a way to secure the information, and verify it's GitHub that is sending updates.

In this unit, you'll learn how to secure your webhook payload with a secret and validate payloads from GitHub.

## Webhook secrets

Setting a webhook secret allows you to ensure that POST requests sent to the payload URL are from GitHub. When you set a secret, you'll receive the `x-hub-signature` header in the webhook POST request.

In GitHub, you can set the *secret* field by going to the repository where you have set up your webhook, and then editing the webhook. We'll show you how to do that for our example in the next exercise.

## Validate payloads from GitHub

When your secret token is set, GitHub uses it to create a hash signature for each payload. This hash signature is passed along with each request in the headers as `x-hub-signature`.

When your function receives a request, you need to compute the hash using your secret, and ensure that it matches the hash in the request header. GitHub uses an HMAC SHA1 hex digest to compute the hash, so you must calculate your hash in this same way, using the key of your secret and your payload body. The hash signature starts with the text `sha1=`.