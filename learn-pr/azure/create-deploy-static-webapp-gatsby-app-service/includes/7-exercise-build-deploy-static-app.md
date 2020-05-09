Azure Static Web Apps hosts static applications, like those made with Gatsby, by building the applications static assets and then deploying them to the cloud.

Here, you'll build your app's static assets to see what they look like and host them locally to try them out. Then, you'll push your code to GitHub and create an Azure Static Web Apps instance to host your app on the web.

## Build your site

When it comes to building your site and making it ready for deployment Gatsby does the heavy lifting for us.

Run the following command from your project directory:

```bash
gatsby build
```

This command will create a *production build*. All your files will end up in a sub directory `build/`.

Once the process finishes building, you can go to your `build/` directory and open up the files in a browser. You can explore your build as it would be hosted in the web with `http-server`, a command-line tool that serves up local files over HTTP so you can see them in a browser.  

Now you'll serve up the whole application from a local web server. `cd` your terminal to the `build/` directory and type the following command:

```bash
npx http-server -p 5000
```

Go to the browser on `http://localhost:5000`.

You should now see the following content rendered:

:::image type="content" source="../media/built-site.png" alt-text="Our built app":::

You've built your site and taken it from being a Gatsby app to a set of static pages containing nothing but HTML, CSS, and JavaScript!

Going into your `build/` directory now locate your rendered `about` component at `build/about/index.html`. Because of an optimization process, all whitespace have been removed and the page is represented as one long line. However you should be able to locate the rendered title and description and it should look like this:

```html
// excerpt from about/index.html

<h2>Gatsby Default Starter</h2><div>Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.</div>
```

## Push your code to GitHub

To prepare the app for deployment, we need to take the following steps:

1. Initialize a Git repository
2. Create a GitHub repository and push to the local Git repository to it

### Create a Git repository

In the console, navigate to root of your project, then run the following command to initialize a Git repository and commit all of your files to it:

```bash
git init
```

Next, create a file called `.gitignore` in the root of your project and give it the following content:

```bash
node_modules
build
```

The above configuration will prevent the `build/` and `node_modules` directories from being added to our repository. The `build/` directory changes every time we build, and the `node_modules/` directory is only needed at build time and can be large from all the libraries it contains.

Finally, add the code to the repository index and commit it.

```bash
git add .
git commit -m "adding Gatsby project"
```

### Create a GitHub repo and push the code

1. Go to GitHub and log on. You should now be on a URL like so `https://github.com/<your username>?tab=repositories`

2. Now click the `new` button as indicated below:
   :::image type="content" source="../media/create-github-repo.png" alt-text="Create new GitHub repo":::

3. Name your repository `gatsby-app` and click `Create repository` as indicated below:
   :::image type="content" source="../media/github-naming.png" alt-text="GitHub naming":::

4. Finally, add your GitHub repository as a remote and push. Type the following commands to accomplish that (Replace the `<user>` part with your GitHub user name):

   ```bash
   git remote add origin https://github.com/<user>/gatsby-app.git
   git push -u origin master
   ```

You are now ready to deploy to Azure Static Web Apps!

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

This tutorial uses the Azure sandbox to provide you with a free, temporary Azure subscription you can use to complete the exercise. Before proceeding, make sure you have activated the sandbox at the top of this page.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), making sure you use the same account to sign in as you did to activate the sandbox.
1. In the top bar, search for **Static Web Apps**.
1. Select **Static Web Apps**.
1. Select **New**.

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

1. Click the **Sign-in with GitHub** button and authenticate with GitHub
1. Enter the **Source Control Details**

   | Setting        | Value                                                    |
   | -------------- | -------------------------------------------------------- |
   | _Organization_ | Select the Organization where you created the repository |
   | _Repository_   | **gatsby-app**                              |
   | _Branch_       | **master**                                               |

1. Click the **Next: Build >** button to edit the build configuration

   :::image type="content" source="../media/next-build-button.png" alt-text="Go to build menu":::

### Build

Next, add configuration details specific to your preferred front-end framework.

| Setting                 | Value                |
| ----------------------- | -------------------- |
| _App location_          |  *Leave blank*       |
| _Api location_          |  *Leave blank*       |
| _App artifact location_ | **build**            |

Click the **Review + create** button

:::image type="content" source="../media/review-create-button.png" alt-text="Click review + create":::

### Review + create

Continue to create the application.

1. Click the **Create** button
   :::image type="content" source="../media/create-button.png" alt-text="Click create button":::

1. Once the deployment is complete, click the **Go to resource** button
   :::image type="content" source="../media/go-to-resource-button.png" alt-text="Go to resource":::

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app not yet deployed. The GitHub Action that Azure creates in your repository will run automatically to perform the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below:

:::image type="content" source="../media/static-app-portal.png" alt-text="Browser to see the progress of the GitHub Action":::

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-app-portal-finished.png" alt-text="Azure Static Web Apps overview page":::

:::image type="content" source="../media/published.png" alt-text="Azure Static Web Apps overview page":::

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

You did it! You've deployed your Gatsby app to the cloud.
