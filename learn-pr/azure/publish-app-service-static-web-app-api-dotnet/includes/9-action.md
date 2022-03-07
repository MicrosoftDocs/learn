You added your API to your web app and they're both running locally. Now it's time to publish your API and your app to Azure Static Web Apps.

When you created the Azure Static Web Apps instance and asked it to watch your **main** branch, a GitHub Action was generated for you. The GitHub Action listens for commits and pull requests to your repository's **main** branch. Then when the GitHub Action detects these changes, it builds and publishes your app.

You may remember when you created the Azure Static Web Apps resource that you provided the folder location for your API project. You provided the default value of _Api_. Azure Static Web Apps built and deployed the Azure Functions app in that folder. However, since you didn't create the HTTP GET API yet, the app didn't work.

## Trigger the GitHub Action

The GitHub Action is ready to build and publish your web app and API once it detects a change to your **main** branch. You could either commit directly or create a pull request to the **main** branch. Both of these will trigger the GitHub Action. Changes that are detected on the **main** branch will trigger the GitHub Action to publish the app at the same URL for your live web site.

## Pre-production environments with preview URLs

Sometimes you want to see your changes in a staging site before publishing to the live web site. Azure Static Web Apps lets you see your changes through pre-production environments that each have its own preview URL. You can create a pre-production environment by creating a pull request against the branch that your GitHub Action is watching. Your live web site won't be affected. Instead, a new version of your app is created in its own pre-production environment. If you go back and check your pull request on GitHub you'll notice that a link to the pre-production version posted in the Conversation tab.

The following table shows how Azure Static Web Apps will publish your app to different URLs. Your app publishes to one URL while a pull request to the same branch publishes to another URL. Azure Static Web Apps provides auto-generated URLs for the production app and pull requests. You can optionally assign a custom domain to the production app.

| Source            | Description       | URL                                                    |
| ----------------- | ----------------- | ------------------------------------------------------ |
| **main** branch   | Example live web site URL | `https://purple-rain-062d03304.azurestaticapps.net/`   |
| Pull Request #5   | Example preview URL       | `https://purple-rain-062d03304-5.<location>.azurestaticapps.net/` |

You're currently working in the **api** branch. You'll make a pull request from your **api** branch to the **main** branch. When you create the pull request against the **main** branch, the GitHub Action publishes the app to a pre-production environment.

Once the workflow has completed building and deploying your app, the GitHub bot adds a comment to your pull request, which contains the URL of the pre-production environment. You can click on this link to see your staged changes.

Next, you'll create a pull request and visit the staged version of your app.
