You added your API to your web app and they're both running locally. Now it's time to publish your API and your app to Azure Static Web Apps.

When you created the Azure Static Web App resource, it generated a GitHub Action for you. The GitHub Action listens for commits and pull requests to your repository's **master** branch. Then when the GitHub Action detects these changes, it builds and publishes your app.

You may remember when you created the Azure Static Web App resource that you provided the folder location for your API. You provided the default value of _api_. However, since you didn't have an API in the _api_ folder, Azure Static Web Apps didn't attempt to publish an API.

Now, everything changes.

## How GitHub Actions knows where your code is

The folder _.github/workflows_ contains tour GitHub Action file. The file contains the settings for the locations of your web app, API, and build artifacts. The locations you chose when you created your Azure Static Web Apps resource are now located in this file, as shown below:

::: zone pivot="angular"

```yml
app_location: '/' # App source code path
api_location: 'api' # Api source code path - optional
app_artifact_location: 'dist/angular-app' # Built app content directory - optional
```

::: zone-end

::: zone pivot="react"

```yml
app_location: '/' # App source code path
api_location: 'api' # Api source code path - optional
app_artifact_location: 'build' # Built app content directory - optional
```

::: zone-end

::: zone pivot="svelte"

```yml
app_location: '/' # App source code path
api_location: 'api' # Api source code path - optional
app_artifact_location: 'public' # Built app content directory - optional
```

::: zone-end

::: zone pivot="vue"

```yml
app_location: '/' # App source code path
api_location: 'api' # Api source code path - optional
app_artifact_location: 'dist' # Built app content directory - optional
```

::: zone-end

Your `api_location` is set to the correct value to point to your API in your _api_ folder.

## Trigger the GitHub Action

The GitHub Action is ready to build and publish your web app and API once it detects a change to your **master** branch. You could either commit directly or create a pull request to the **master** branch. Both of these will trigger the GitHub Action. Changes that are detected on the **master** branch will trigger the GitHub Action to publish the app at the same URL for your live web site.

## Preview URLs

Sometimes you want to see your changes in the browser before publishing to the live web site. Azure Static Web Apps lets you see preview your changes through preview URLs. You can create a preview URL by creating a pull request against the branch that your GitHub Action is watching. Your live web site won't be affected. Instead, a new URL will be created for previewing your web app from your pull request.

The following table shows how Azure Static Web Apps will publish your app to different URLs. Your app publishes to one URL while a pull request to the same branch publishes to another URL.

| Source            | Description       | URL                                                    |
| ----------------- | ----------------- | ------------------------------------------------------ |
| **master** branch | Live web site URL | https://purple-rain-062d03304.staticsitescanary.net/   |
| Pull Request #5   | Preview URL       | https://purple-rain-062d03304-5.staticsitescanary.net/ |

You're currently working in the **api** branch/ The **api** branch is connected to the Azure Static Web Apps resource. A common procedure is to make a pull request from your **api** branch to the branch the **master** branch. When you create the pull request against the **master** branch, the GitHub Action publishes the app to a preview URL.

Next, you'll create a pull request and visit the preview URL that your GitHub Action will create.
