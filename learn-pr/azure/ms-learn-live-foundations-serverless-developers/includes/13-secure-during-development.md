The requirements for production environments are beyond the scope of this course. But what about the development environment?

While you're working on your project, you might want to push preview versions up into the cloud. Other members of your team will want to begin integrating the APIs you made. However, this makes your work available to anyone knowing the URL of the API! It would be just a matter of time until a malicious hacker tries to break in and steal data. You can make it harder for hackers by using Azure Functions' authorization level setting.

> [!IMPORTANT]
> The local development environment doesn't support authorization. Even if a function's authorization level is set, the local environment will ignore it!

## Objective

- Prevent unauthorized access during development using authorization levels.

## Instructions

To prevent unauthorized access during development using authorization levels:

1. In Visual Studio Code, locate the `CreateProduct` function, and open its function.json file.

1. Change the *authLevel* property from *anonymous* to *function*.

1. Repeat these steps for the `UpdateProduct` function.

With this change in place, the functions will return an HTTP code 400 (bad request) if there is no query parameter called *code* present in the URL containing an access key. This is only effective for deployed function applications that run on Azure.
