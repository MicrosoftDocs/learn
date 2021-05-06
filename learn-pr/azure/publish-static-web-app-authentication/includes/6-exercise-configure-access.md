Your shopping list web app needs to secure access to some routes and disable specific authentication providers. In this exercise, you'll update the routing configuration of your web app to achieve that.

In this exercise, you'll complete the following steps:

1. Add rules to the routing configuration to disable some authentication providers.
1. Secure the products list so only authenticated users can access it.
1. Deploy the updated app.
1. Test that the restrictions are effective.

## Disable authentication providers

We'll update the routing configuration of our app to disable Facebook and Google authentication providers.

1. Open the project in Visual Studio Code.

1. Open this file:

    ::: zone pivot="angular"

    ```text
    angular-app/staticwebapp.config.json
    ```

    ::: zone-end

    ::: zone pivot="react"

    ```text
    react-app/staticwebapp.config.json
    ```

    ::: zone-end

    ::: zone pivot="svelte"

    ```text
    svelte-app/staticwebapp.config.json
    ```

    ::: zone-end

    ::: zone pivot="vue"

    ```text
    vue-app/staticwebapp.config.json
    ```

    ::: zone-end

1. At the root of the JSON object, add this routing configuration:

    ```json
    "routes": [
      {
        "route": "/.auth/login/facebook",
        "statusCode": "404"
      },
      {
        "route": "/.auth/login/google",
        "statusCode": "404"
      }
    ]
    ```

    By adding these two routing rules, we prevent our users to access the Facebook and Google authentication providers.

## Secure the product list access

Next we want to secure the product list so that only authenticated are able to access the API. For that we'll add another routing rule in the `staticwebapp.config.json` configuration file.

1. Add this rule at the top of the `routes` array:

    ```json
    {
      "route": "/api/products/*",
      "allowedRoles": ["authenticated"]
    },
    ```

1. Your completed `staticwebapp.config.json` file should look like this:

    ```json
    {
      "routes": [
        {
          "route": "/api/products/*",
          "allowedRoles": ["authenticated"]
        },
        {
          "route": "/.auth/login/facebook",
          "statusCode": "404"
        },
        {
          "route": "/.auth/login/google",
          "statusCode": "404"
        }
      ],
      "navigationFallback": {
        "rewrite": "/index.html",
        "exclude": ["*.{css,scss,js,png,gif,ico,jpg,svg}"]
      }
    }
    ```

## Deploy your changes

Before testing the result of this configuration, we'll redeploy our app.

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Commit All**
1. Enter `Secure access` as the commit message.
1. Press <kbd>Enter</kbd>
1. Open the command palette by pressing <kbd>F1</kbd>
1. Type and select **Git: Push**
1. Press <kbd>Enter</kbd>

After you pushed your changes, wait for the build and deploy process to run. The changes should be visible on your deployed app after that.

## Test the new restrictions

After your app is redeployed, you can test that the new restrictions are effective.

1. In the Visual Studio Code Explorer window, return to the _Static Web Apps_ section and right-click on **my-static-web-app-and-api** and select **Browse Site** to view app in your browser.
1. If you're not logged in, you should see the message **Unauthorized** instead of the products list.
1. Select **Google** in the authentication provider list to log in.
1. You should see a 404 error page like this:

    :::image type="content" source="../media/static-web-apps-404-error-page.png" alt-text="Screenshot of the Static Web Apps 404 error page":::

1. Use the back button of your browser to go back to your app.
1. Select **GitHub** in the authentication provider list to log in.
1. Enter your GitHub credentials if asked, then select **Grant Consent** on the Azure consent page.
1. You're now logged in and should see the products list.

## Next steps

Congratulations, you've implemented a complete authentication workflow in your static web app!
