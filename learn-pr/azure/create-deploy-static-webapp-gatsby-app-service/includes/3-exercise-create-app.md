In this unit, you'll create a new Gatsby application and add a single page to it.

## Install Gatsby

Run the following command in a terminal to install Gatsby globally to your system:

```console
npm install -g gatsby-cli
```

## Create and run a Gatsby site

All Gatsby projects are created by the Gatsby CLI. The CLI is able to help you with scaffolding a new Gatsby project, host it and also build the final product, which is a static set of files that you can deploy into any static host you wish.

### Create a Gatsby app

Now, create a new Gatsby app by typing the following command in the terminal:

```bash
gatsby new myApp
```

`gatsby new` creates a new Gatsby application, to which you can start adding content pages.

### Run Gatsby

To start developing with Gatsby, you need to navigate to the project directory before starting the development server.

Run the following commands to move to your project folder and start the server:

```bash
cd myApp
gatsby develop
```

You should see the following output in the terminal:

```output
You can now view gatsby-starter-default in the browser.
  http://localhost:8000.
View GraphQL, an in-browser IDE, to explore your site's data and schema
  http://localhost:8000/___graphql
```

Now open up a browser and navigate to `http://localhost:8000`.

:::image type="content" source="../media/welcome-page-gatsby.png" alt-text="Screenshot of the Gatsby app.":::

If you see the above, you successfully created your first Gatsby app. Congrats!

## Add a page component

Now you'll create a component that you can navigate to in the browser: a **page component**.

1. Open the "myApp" project folder in Visual Studio Code. Find the `pages/` directory.

   :::image type="content" source="../media/add-page-component.png" alt-text="Screenshot of the pages folder in VS Code.":::

1. Create a file and name it **about.js**. Give the file the following content:

   ```jsx
   import React from 'react';
   import { Link } from 'gatsby';
   
   export default () => (
     <React.Fragment>
       <div>About page</div>
       <Link to="/">Back to home</Link>
     </React.Fragment>
   )
   ```

The code above creates a *presentation component* that is only able to show data. This component simply renders the text "About page" and a link that points to the root of the application.

Once you've pasted in the code and saved it in the file `about.js`, the development server will recompile the application automatically. If you now visit `http://localhost:8000/about` you should see the following content rendered:

:::image type="content" source="../media/page-component.png" alt-text="Screenshot showing the loaded page component.":::

You've got your first page! Now you can see how any component placed in the `/pages` directory can be navigated to.
