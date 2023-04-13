You added your API to your web app and they're both running locally. Now it's time to publish your API and your app to Azure Static Web Apps.

When you created the Azure Static Web Apps instance and asked it to watch your **main** branch, a GitHub Action was generated for you. The GitHub Action listens for commits and pull requests to your repository's **main** branch. Then when the GitHub Action detects these changes, it builds and publishes your app.

You may remember when you created the Azure Static Web Apps resource that you provided the folder location for your API. You provided the default value of _api_. However, since you didn't have an API in the _api_ folder at that time, Azure Static Web Apps didn't attempt to publish an API.

Now, everything changes.

## GitHub Action configuration

The folder _.github/workflows_ contains your GitHub Action file. The file contains the settings for the locations of your web app, API, and build artifacts. The locations you chose when you created your Azure Static Web Apps resource are now located in this file, as shown below:

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

Your `api_location` is set to the correct value to point to your API in your _api_ folder.

## Trigger the GitHub Action

The GitHub Action is ready to build and publish your web app and API once it detects a change to your **main** branch. You could either commit directly or create a pull request to the **main** branch. Both of these will trigger the GitHub Action. Changes that are detected on the **main** branch will trigger the GitHub Action to publish the app at the same URL for your live web site.

## Preview URLs

Sometimes you want to see your changes in a staging site before publishing to the live website. Azure Static Web Apps lets you see preview your changes through preview URLs. You can create a preview URL by creating a pull request against the branch that your GitHub Action is watching. Your live web site won't be affected. Instead, a new staging version of your app is created. If you go back and check your pull request on GitHub you'll notice that a link to the staging version posted in the Conversation tab.

The following table shows how Azure Static Web Apps will publish your app to different URLs. Your app publishes to one URL while a pull request to the same branch publishes to another URL.

| Source          | Description       | URL                                                    |
| --------------- | ----------------- | ------------------------------------------------------ |
| **main** branch | Live web site URL | `https://purple-rain-062d03304.azurestaticapps.net/`   |
| Pull Request #5 | Preview URL       | `https://purple-rain-062d03304-5.azurestaticapps.net/` |

You're currently working in the **api** branch. You'll make a pull request from your **api** branch to the **main** branch. When you create the pull request against the **main** branch, the GitHub Action publishes the app to a preview URL.

Once the workflow has completed building and deploying your app, the GitHub bot adds a comment to your pull request, which contains the URL of the pre-production environment. You can click on this link to see your staged changes.

Next, you'll create a pull request and visit the staged version of your app.
