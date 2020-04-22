## 2- Exercise - Get started

Azure Static Web Apps publishes websites to a production environment by building apps from a GitHub repository. In this exercise, you build a web application using your preferred front-end framework from a GitHub repository.

## Create a repository

This article uses a GitHub template repository to make it easy for you to create a new repository. The templates features starter apps built with different front-end frameworks.

- Navigate to the following location to create a new repository
  - https://github.com/MicrosoftDocs/mslearn-staticwebapp/generate
- Name your repository **my-first-static-web-app**
- Click the **Create repository from template** button

## Run your app

```bash
git clone https://github.com/<YOUR-GITHUB-ORG>/my-first-static-web-app
```

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

## See your app locally

Browse to the app

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
