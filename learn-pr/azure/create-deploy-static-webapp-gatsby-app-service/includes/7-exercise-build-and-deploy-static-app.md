Azure Static Web Apps hosts static applications, like those made with Gatsby, by building the applications static assets and then deploying them to the cloud.

Here, you'll build your app's static assets to see what they look like and host them locally to try them out. Then, you'll push your code to GitHub and create an Azure Static Web Apps instance to host your app on the web.

## Activate the Azure sandbox

The first step is to connect to an Azure sandbox. You can create the Azure Static Web Apps resources from here.

1. Start by **activating the Azure sandbox above**.
1. Once the sandbox is activated, [sign into the Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
   - Make sure you use the same account to sign in as you did to activate the sandbox.

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

:::image type="content" source="../media/gatsby-built-site.png" alt-text="Our built app":::

You've built your site and taken it from being a Gatsby app to a set of static pages containing nothing but HTML, CSS, and JavaScript!

Going into your `build/` directory now locate your rendered `about` component at `build/about/index.html`. Because of an optimization process, all whitespace have been removed and the page is represented as one long line. However you should be able to locate the rendered title and description and it should look like this:

```html
// excerpt from about/index.html

<h2>Gatsby Default Starter</h2><div>Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.</div>
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

### Create a GitHub repo and push the code

1. Go to GitHub and log on. You should now be on a URL like so `https://github.com/<your username>?tab=repositories`

2. Now click the `new` button as indicated below:
:::image type="content" source="../media/gatsby-create-gh-repo.png" alt-text="Create new GitHub repo":::

3. Name your repository `gatsby-app` and click `Create repository` as indicated below:
:::image type="content" source="../media/gatsby-gh-naming.png" alt-text="GitHub naming":::

4. Finally, add your GitHub repository as a remote and push. Type the following commands to accomplish that (Replace the `<user>` part with your GitHub user name):

```bash
git remote add origin https://github.com/<user>/gatsby-app.git
git push -u origin master
```

You are now ready to deploy to Azure Static Web Apps!

## Create a Static Web App

Now that you've created your GitHub repository, you can create a Static Web Apps instance from the Azure portal.

1. In the top bar, search for **Static Web Apps**
1. Select **Static Web Apps**
1. Select **New**

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

### Build

Next, add configuration details specific to your preferred front-end framework.

| Setting                 | Value                |
| ----------------------- | -------------------- |
| _App location_          |  *Leave blank*       |
| _Api location_          |  *Leave blank*       |
| _App artifact location_ | **build**            |

Click the **Review + create** button

### Review + create

Continue to create the application.

1. Click the **Create** button
1. Once the deployment is complete, click the **Go to resource** button

### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app not yet deployed. The GitHub Action that Azure creates in your repository will run automatically to perform the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below:

:::image type="content" source="../media/static-app-portal.png" alt-text="Browser to see the progress of the GitHub Action":::

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/static-app-portal-finsihed.png" alt-text="Azure Static Web Apps overview page":::


:::image type="content" source="../media/gatsby-published.png" alt-text="Azure Static Web Apps overview page":::

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

You did it! You've deployed your Gatsby app to the cloud.
