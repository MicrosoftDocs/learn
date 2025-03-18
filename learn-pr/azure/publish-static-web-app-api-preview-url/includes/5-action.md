You added your API to your web app and they're both running locally. Now it's time to publish your API and your app to Azure Static Web Apps.

When you created the Azure Static Web Apps instance and asked it to watch your **main** branch, a GitHub Action was generated for you. The GitHub Action listens for changes to your repository's **main** branch, and when it detects a commit or a pull request to **main**, it builds and publishes your app.

You might remember when you created the Azure Static Web Apps resource that you provided the folder location for your API. You provided the default value of *api*. However, since you didn't have an API in the *api* folder at that time, Azure Static Web Apps didn't attempt to publish an API.

Now, everything changes.

## GitHub Action configuration

The folder *.github/workflows* contains your GitHub Action file. The file contains the settings for the locations of your web app, API, and build artifacts. The locations you chose when you created your Azure Static Web Apps resource are now located in this file, as shown here:

::: zone pivot="angular"

```yml
app_location: 'angular-app' # App source code path
api_location: 'api' # Api source code path - optional
output_location: 'dist/angular-app' # Built app content directory - optional
```

::: zone-end

::: zone pivot="react"

```yml
app_location: 'react-app' # App source code path
api_location: 'api' # Api source code path - optional
output_location: 'build' # Built app content directory - optional
```

::: zone-end

::: zone pivot="svelte"

```yml
app_location: 'svelte-app' # App source code path
api_location: 'api' # Api source code path - optional
output_location: 'public' # Built app content directory - optional
```

::: zone-end

::: zone pivot="vue"

```yml
app_location: 'vue-app' # App source code path
api_location: 'api' # Api source code path - optional
output_location: 'dist' # Built app content directory - optional
```

::: zone-end

Your `api_location` is set to the correct value to point to your API in your *api* folder.

## Trigger the GitHub Action

The GitHub Action is ready to build and publish your web app and API once it detects a change to your **main** branch. To trigger the GitHub Action, you could either commit directly or create a pull request to the **main** branch.  Changes that are detected on the **main** branch trigger the GitHub Action to publish the app at the same URL for your live web site.

## Preview URLs

Sometimes you want to see your changes in a staging site before publishing to the live website. Azure Static Web Apps lets you see a preview of your changes through preview URLs. You can create a preview URL by creating a pull request against the branch that your GitHub Action is watching. Your live web site isn't affected. Instead, a new staging version of your app is created. If you go back and check your pull request on GitHub, you should see a link to the staging version posted in the Conversation tab.

The following table shows how Azure Static Web Apps publishes your app to different URLs. Your app publishes to one URL while a pull request to the same branch publishes to another URL.

| Source          | Description       | URL                                                    |
| --------------- | ----------------- | ------------------------------------------------------ |
| **main** branch | Live web site URL | `https://purple-rain-062d03304.azurestaticapps.net/`   |
| Pull Request #5 | Preview URL       | `https://purple-rain-062d03304-5.azurestaticapps.net/` |

You're currently working in the **api** branch. Make a pull request from your **api** branch to the **main** branch. When you create the pull request against the **main** branch, the GitHub Action publishes the app to a preview URL.

Once the workflow completes building and deploying your app, the GitHub bot adds a comment to your pull request that contains the URL of the preproduction environment. You can select this link to see your staged changes.

Next, you create a pull request and visit the staged version of your app.
