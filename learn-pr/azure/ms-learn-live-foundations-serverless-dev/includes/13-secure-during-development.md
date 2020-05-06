## 💻 Exercise - Prevent unauthorized access during development

The requirements for productive environments are beyond the scope of this course. But what about the development environment?

While you’re working on your project, you might want to push preview versions up into the cloud. Other members of your team will want to begin integrating the APIs you made.
This will make your work available to anyone knowing the URL of the API!
It would be just a matter of time until a malicious attacker tries to break in and steal data.
You can make it harder for attackers by using Functions’ authorization level setting.

> [!IMPORTANT]
> Authorization keys are NOT SUPPORTED for local development. Even if a function’s auth level is set, the local environment will ignore it!

## Objective

- Prevent unauthorized access during development using authorization levels

## Instructions

- In Visual Studio Code, locate the `CreateProduct` function and open its function.json file
- Change the "authLevel" property from "anonymous" to "function"
- Repeat for the `UpdateProduct` function

With this change in place, the functions will return an HTTP code 400 (bad request) if there is no query parameter called "code" present in the URL containing an access key. This is however only effective for deployed function applications that run on Azure. 
