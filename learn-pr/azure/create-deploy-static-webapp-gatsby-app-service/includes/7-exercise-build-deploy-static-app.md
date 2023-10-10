Azure Static Web Apps hosts static applications, like those made with Gatsby, by building the applications static assets and then deploying them to the cloud.

Here, you'll build your app's static assets to see what they look like and host them locally to try them out. Then, you'll push your code to GitHub and create an Azure Static Web Apps instance to host your app on the web.

## Build your site

When it comes to building your site and making it ready for deployment Gatsby does the heavy lifting for us.

Run the following command from your project directory:

```bash
gatsby build
```

This command will create a *production build*. All your files will end up in a sub-directory `public/`.

Once the process finishes building, you can go to your `public/` directory and open up the files in a browser. You can explore your build as it would be hosted in the web with `http-server`, a command-line tool that serves up local files over HTTP so you can see them in a browser.  

Now you'll host the whole application from a local web server. `cd` in your terminal to the `public/` directory and type the following command:

```bash
npx http-server -p 5000
```

Browse to `http://localhost:5000`.

You should now see the following content rendered:

:::image type="content" source="../media/welcome-page-gatsby.png" alt-text="Screenshot showing your built app.":::

You've built your site and taken it from being a Gatsby app to a set of static pages containing nothing but HTML, CSS, and JavaScript!

From VS Code, navigate into your `public/` directory, locate your rendered `about` component at `public/about/index.html`. Because of the optimization process, all whitespace has been removed and the page is represented as one long line. However, you should be able to locate the rendered title and description and it should look like this:

```html
// excerpt from about/index.html

<h2>Gatsby Default Starter</h2><div>Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.</div>
```

## Push your code to GitHub

To prepare the app for deployment, we need to take the following steps:

1. Initialize a Git repository.
2. Create a GitHub repository and push the local Git repository to it.

### Add the About page

In the terminal, navigate to the root of your project, then add the code to the repository index and commit it.

```bash
git add .
git commit -m "adding About page to site"
```

### Create a GitHub repo and push the code

1. Go to GitHub and log in.

1. Navigate to the repositories page.

   :::image type="content" source="../media/repositories.png" alt-text="Screenshot of the repository button in GitHub.":::

1. Now click the **new** button as indicated below:

   :::image type="content" source="../media/create-github-repo.png" alt-text="Screenshot of the create a new GitHub repo button.":::

1. Name your repository **gatsby-app** and click create repository as indicated below:

   :::image type="content" source="../media/github-naming.png" alt-text="Screenshot showing how to name GitHub repository.":::

1. Finally, add your GitHub repository as a remote and push. Type the following commands to accomplish that (Replace the `<user>` part with your GitHub user name):

   ```bash
   git remote add origin https://github.com/<user>/gatsby-app.git
   git push -u origin master
   ```

You're now ready to deploy to Azure Static Web Apps!

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), making sure you use the same account to sign in as you did to activate the sandbox.
1. In the top bar, search for **Static Web Apps**.
1. Select **Static Web Apps**.
1. Select **Create**.

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
   | _Region_ | Select Region closest to you                                                  |
   | _SKU_    | **Free**                                                                      |

1. If prompted, click the **Sign-in with GitHub** button and authenticate with GitHub
1. Enter the **Deployment Details**

   | Setting        | Value                                                    |
   | -------------- | -------------------------------------------------------- |
   | _Organization_ | Select the Organization where you created the repository |
   | _Repository_   | **gatsby-app**                              |
   | _Branch_       | **main or master**          |

   > [!NOTE]
   > If you don't see any repositories, you may need to authorize Azure Static Web Apps on GitHub. Then browse to your GitHub repository and go to **Settings > Applications > Authorized OAuth Apps**, select **Azure Static Web Apps**, and then select **Grant**. For organization repositories, you must be an owner of the organization to grant the permissions.

1. Use the **Build Details** drop down list to select **Gatsby** to populate the build information.

    | Setting                 | Value                |
    | ----------------------- | -------------------- |
    | _App location_          |  *Leave default*     |
    | _Api location_          |  *Leave default*     |
    | _Output location_ | **public**           |

1. Click the **Review + create** button

   :::image type="content" source="../media/review-create-button.png" alt-text="Screenshot showing the review and create button.":::

### Review + create

Continue to create the application.

1. Click the **Create** button

   :::image type="content" source="../media/create-button.png" alt-text="Screenshot showing the click create button.":::

1. Once the deployment is complete, click the **Go to resource** button

   :::image type="content" source="../media/go-to-resource-button.png" alt-text="Screenshot showing the Go to resource button.":::

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app is not yet deployed. The GitHub Action that Azure creates in your repository will run automatically to perform the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below:

:::image type="content" source="../media/static-app-portal.png" alt-text="Screenshot showing how to browse to see the progress of the GitHub Action." lightbox="../media/static-app-portal.png":::

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-app-portal-finished.png" alt-text="Screenshot that shows the Azure portal with a link to the URL for the app." lightbox="../media/static-app-portal-finished.png":::

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

Congratulations! You've deployed your first Gatsby app to the cloud using Azure Static Web Apps.
