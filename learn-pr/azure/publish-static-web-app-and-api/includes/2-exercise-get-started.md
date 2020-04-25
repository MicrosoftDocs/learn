Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you build a web application using your preferred front-end framework from a GitHub repository.

## Create a repository

This article uses a GitHub template repository to make it easy for you to create a new repository. The templates features starter apps built with different front-end frameworks.

- Navigate to the following location to create a new repository
  - https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name your repository **my-first-static-web-app**
- Click the **Create repository from template** button

## Run your app

You just created a GitHub repository named **my-first-static-web-app** in your GitHub account. Next you will clone the code locally to your computer and run it.

1. Start by cloning the GitHub repository to our computer.

   ```bash
   git clone https://github.com/<YOUR_GITHUB_USERNAME_>/my-first-static-web-app
   ```

1. Next, go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   ### [Angular](#tab/angular)

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ### [React](#tab/react)

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ### [Svelte](#tab/svelte)

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ### [Vue](#tab/vue)

   ```bash
   cd vue-app
   ```

   ::: zone-end

1) Now install the application dependencies.

   ```bash
   npm install
   ```

1) Finally, run the front-end client application.

   ::: zone pivot="angular"

   ### [Angular](#tab/angular)

   ```bash
   npm install
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ### [React](#tab/react)

   ```bash
   npm install
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ### [Svelte](#tab/svelte)

   ```bash
   npm install
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ### [Vue](#tab/vue)

   ```bash
   npm install
   npm run serve
   ```

   ::: zone-end

## Run your app

It's time to see your application running locally. Each front-end application runs on a different port.

Select your preferred front-end application and click the link to browse to the application.

::: zone pivot="angular"

### [Angular](#tab/angular)

Browse to <http://localhost:4200>

::: zone-end

::: zone pivot="react"

### [React](#tab/react)

Browse to <http://localhost:3000>

::: zone-end

::: zone pivot="svelte"

### [Svelte](#tab/svelte)

Browse to <http://localhost:5000>

::: zone-end

::: zone pivot="vue"

### [Vue](#tab/vue)

Browse to <http://localhost:8080>

::: zone-end

### Next steps

You built your application and now it is running locally in your browser.

Next, you'll publish your application to Azure Static Web Apps.
