Your shopping list web app needs to secure access to some routes and disable specific authentication providers. In this exercise, you'll update the routing configuration of your web app to achieve that.

In this exercise, you'll complete the following steps:

1. Add rules to the routing configuration to disable some authentication providers.
1. Secure the products list so only authenticated users can access it.
1. Deploy the updated app.
1. Test that the restrictions are effective.

## Disable authentication providers

We'll update the routing configuration of our app to disable Facebook and Google authentication providers.

::: zone pivot="angular"


::: zone-end

::: zone pivot="react"


::: zone-end

::: zone pivot="svelte"


::: zone-end

::: zone pivot="vue"



::: zone-end

## Secure the product list access


## Deploy your changes

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Commit All**
1. Enter `Add authentication` as the commit message.
1. Press <kbd>Enter</kbd>
1. Open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Push**
1. Press <kbd>Enter</kbd>

After you pushed your changes, wait a few minutes for the build and deploy process to run. The changes should be visible on your deployed app after that.

## Test the new restrictions


## Next steps

