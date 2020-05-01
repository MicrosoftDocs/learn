Now it's time for you to learn how to build your app so it's ready to be deployed anywhere. You will also deploy your app to a Cloud service.

## Build your site

When it comes to building your site and making it ready for deployment Gatsby does the heavy lifting for us. All you need to do is to call the following command:

```bash
gatsby build
```

This command will create a so called *production build*. All your files will end up in a sub directory `build/`.

Once the process finish building, you can now go to your `build/` directory and open up the files in browser. You can see how the *production-build* renders by, for example,  using a great tool like
`http-server`. `http-server` is a command-line tool that serves up your files on a specific port so you can see them in a Browser.  

You can run the tool by placing yourself in `build/` directory and type the following command:

```bash
npx http-server -p 5000
```

Go to the browser on `http://localhost:5000`.

You should now see the following content rendered:

:::image type="content" source="../media/gatsby-built-site.png" alt-text="Our built app":::

Congrats, you managed to build your site and you took it from being a Gatsby app to an app containing nothing but HTML, CSS, and JavaScript!

Going into your `build/` directory now locate your rendered `about` component at `build/about/index.html`. Because of an optimization process, all whitespace have been removed and the page is represented as one long line. However you should be able to locate the rendered title and description and it should look like this:

```html
// excerpt from about/index.html

<h2>Gatsby Default Starter</h2><div>Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.</div>
```

## Push your app to a Git repository

To prepare the app for deploy, we will need to take the following steps:

1. Create a Git repository
2. Create a GitHub repository and push to the local Git repository to it

### Create a Git repository

In the console, navigate to root of your project, then run the following commands to initialize a Git repository and commit all of your files to it:"

```bash
git init
```

Create a file .gitignore and give it the following content:

```bash
node_modules
build
```

The above content will ensure that once we commit all our files it will exclude the `build/` and `node_modules` directories. The `build/` directory is something that changes every time we build and the `node_modules/` directory is something that's only need at build time and can be large from all the libraries it contains.

Next step is to add our code under Gits revision control. We do that with first with the following command:

```bash
git add .
```

This will add our files to Gits staging area.

Next, we need to commit so the files go from the staging area to becoming a commit we can push to GitHub. You accomplish that with:

```bash
git commit -m "adding Gatsby project"
```

Above we are giving our commit a commit message with the `-m` flag. Adjust the message to fit your scenario.

### Create a GitHub repo and push the code

1. Go to GitHub and log on. You should now be on a URL like so `https://github.com/<your username>?tab=repositories`

2. Now click the `new` button as indicated below:
:::image type="content" source="../media/gatsby-create-gh-repo.png" alt-text="Create new GitHub repo":::

3. Now give your repository a suitable name and click `Create repository` as indicated below:
:::image type="content" source="../media/gatsby-gh-naming.png" alt-text="GitHub naming":::

4. Next you, you need to create a connection between your local Git repo and your GitHub repo. You also need to push your Git repo code to GitHub. Type the following commands to accomplish that (Replace the `<user>` part with your GitHub user name):

```bash
git remote add origin https://github.com/<user>/gatsby-app.git
git push -u origin master
```

Congratulations, you are now ready to deploy!

In this exercise, you'll create an Azure Static Web Apps instance including a GitHub Action that will automatically build and publish your application.

## Activate the Azure sandbox

The first step is to connect to an Azure sandbox. You can create the Azure Static Web Apps resources from here.

1. Start by **activating the Azure sandbox above**.
1. Once the sandbox is activated, [sign into the Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
    - Make sure you use the same account to sign in as you did to activate the sandbox.

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
   | _Repository_   | **my-first-static-web-app**                              |
   | _Branch_       | **master**                                               |

1. Click the **Next: Build >** button to edit the build configuration

### Build

Next, add configuration details specific to your preferred front-end framework.

| Setting                 | Value                |
| ----------------------- | -------------------- |
| _App location_          |                      |
| _Api location_          |                      |
| _App artifact location_ | **build**            |

Click the **Review + create** button

### Review + create

Continue to create the application.

1. Click the **Create** button
1. Once the deployment is complete, click the **Go to resource** button


### Review the GitHub Action

At this stage, your Static Web Apps instance is created in Azure, but your app not yet deployed. The GitHub Action that Azure creates in your repository will run automatically to perform the first build and deployment of your app, but it takes a couple minutes to finish.

You can check the status of your build and deploy action by clicking the link shown below:

:::image type="content" source="../media/goto-action.png" alt-text="Browser to see the progress of the GitHub Action":::

### View website

Once your GitHub Action finishes building and publishing your web app, you can browse to see your running app.

Click on the _URL_ link in the Azure portal to visit your app in the browser.

:::image type="content" source="../media/gatsby-published.png" alt-text="Azure Static Web Apps overview page":::

Your app's now globally available, but it's still stuck at **Loading data ...** because there is no data or API yet. You'll add the API for your web app in the next section.

Congratulations! You've deployed your first app to Azure Static Web Apps!

> [!NOTE]
> Don't worry if you see a web page that says the app hasn't been built and deployed yet. Try refreshing the browser in a minute. The GitHub Action runs automatically when the Azure Static Web Apps is created. So if you see the splash page, the app is still being deployed.

You did it! You've managed to deploy a static app to the Cloud.
