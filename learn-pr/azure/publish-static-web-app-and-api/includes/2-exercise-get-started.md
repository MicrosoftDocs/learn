Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you'll build a web application using your preferred front-end framework from a GitHub repository.

## Create a repository

This article uses a GitHub template repository. Template repositories make it easy for you to create a new repository. The template contains starter apps. Each starter app is built with a different front-end framework.

1. Navigate to the [create from template page](https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate) for the template repository. If you get a 404 Page Not Found error, sign in to GitHub and try again.
1. Name your repository **my-first-static-web-app**
1. Check the box **Include all branches**
1. Click the **Create repository from template** button

## Run your app

You just created a GitHub repository named **my-first-static-web-app** in your GitHub account. Next you'll clone the code locally to your computer and run it.

1. Start by cloning the GitHub repository to our computer.

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/my-first-static-web-app
   ```

1. Next, go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Now install the application dependencies.

   ```bash
   npm install
   ```

1. Finally, run the front-end client application.

   ::: zone pivot="angular"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   npm run serve
   ```

   ::: zone-end

## Browse to your app

It's time to see your application running locally. Each front-end application runs on a different port.

Select your preferred front-end application and click the link to browse to the application.

::: zone pivot="angular"

Browse to <http://localhost:4200>

:::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="Browsing to your Angular app":::

::: zone-end

::: zone pivot="react"

Browse to <http://localhost:3000>

:::image type="content" source="../media/my-shopping-list-app-react.png" alt-text="Browsing to your React app":::

::: zone-end

::: zone pivot="svelte"

Browse to <http://localhost:5000>

:::image type="content" source="../media/my-shopping-list-app-svelte.png" alt-text="Browsing to your Svelte app":::

::: zone-end

::: zone pivot="vue"

Browse to <http://localhost:8080>

:::image type="content" source="../media/my-shopping-list-app-vue.png" alt-text="Browsing to your Vue app":::

::: zone-end

### Next steps

You built your application and now it's running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.
