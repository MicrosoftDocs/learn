In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that will automatically build and publish your application.

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), making sure you use the same account to sign in as you did to activate the sandbox.
1. Click **Create a Resource**
1. Search for **Static Web Apps**
1. Click **Static Web Apps (Preview)**
1. Click **Create**

### Basics

Next, configure your new app and link it to your GitHub repository.

1. Enter the **Project Details**

   | Setting          | Value                                    |
   | ---------------- | ---------------------------------------- |
   | _Subscription_   | **Concierge subscription**               |
   | _Resource Group_ | <rgn>[Sandbox resource group name]</rgn> |

1. Enter the **Static Web Apps details**

   | Setting  | Value                                                                         |
   | -------- | ----------------------------------------------------------------------------- |
   | _Name_   | Name your app. Valid characters are `a-z` (case insensitive), `0-9`, and `_`. |
   | _Region_ | Select the region closest to you                                              |
   | _SKU_    | **Free**                                                                      |

1. Click the **Sign-in with GitHub** button and authenticate with GitHub
1. Enter the **Source Control Details**

   | Setting        | Value                                                    |
   | -------------- | -------------------------------------------------------- |
   | _Organization_ | Select the Organization where you created the repository |
   | _Repository_   | **my-static-blazor-app**                                    |
   | _Branch_       | **main**                                                 |

1. From **Build Presets**, select Blazor and confirm the options are correct for your project.

   | Setting                 | Value       |
   | ----------------------- | ----------- |
   | _App location_          | **/Client** |
   | _Api location_          | **/Api**    |
   | _App artifact location_ | **wwwroot** |

   Click the **Review + create** button. This will bring you to the page where you can review the resource before you create it.

   :::image type="content" source="../media/review-create-button.png" alt-text="Review + create button":::

### Review + create

Continue to create the application.

1. Click the **Create** button

   :::image type="content" source="../media/create-button.png" alt-text="Create button":::

1. Once the deployment is complete, click the **Go to resource** button

   :::image type="content" source="../media/go-to-resource-button.png" alt-text="Go to resource button":::

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app isn't yet deployed. The GitHub Action that Azure creates in your repository will run automatically to trigger the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below to navigate to the Actions page of your GitHub repository:

:::image type="content" source="../media/goto-action.png" alt-text="Browse to see the progress of the GitHub Actions workflow":::

Once you're there:

1. Click **Azure Static Web Apps CI/CD**
1. Click the commit titled **Azure Static Web Apps added workflow for file for CI/CD**
1. Click the **Build and Deploy Job** link

From here, you can observe the progress of your app as it builds.

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-web-apps-resource-overview.png" alt-text="Azure Static Web Apps overview page":::

Your app's now globally available, but it's still stuck at **Loading data ...** because there's no data or API yet. You'll add the API for your web app in the next section.

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

## Next steps

Your app is missing an API for its shopping list. Next, you'll explore how to add an Azure Functions API to your app that will publish to Azure alongside the static assets.
