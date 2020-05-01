Now you will learn to create a Gatsby application.

## Create and run a Gatsby site

All Gatsby projects are created by the Gatsby CLI. The CLI is able to help you with scaffolding a new Gatsby project, host it and also build the final product, which is a static set of files that you can deploy into any static host you wish.

### Create a Gatsby app

Let' create a Gatsby app by typing the following command in the terminal:

```bash
gatsby new <your app name>
```

This will create a Gatsby project, a set of directories and files that you can extend and configure.

### Run Gatsby

To start developing with Gatsby, ensure you are in the correct directory. If you named your project , hello-gatsby` then ensure you changed directory to `hello-gatsby` before continuing.

Now run the following command:

```bash
gatsby develop
```

You should see the following output in the terminal:

```output
You can now view gatsby-starter-default in the browser.
  http://localhost:8000.
View GraphiQL, an in-browser IDE, to explore your site's data and schema
  http://localhost:8000/___graphql
```

Now open up a browser and go to url `http://localhost:8000`.

:::image type="content" source="../media/gatsby-browser.png" alt-text="Gatsby app":::

If you see the above, you successfully created your first Gatsby app. Congrats!

## Add a page component

For this exercise we will learn to create a component that we can navigate to, a so called *page component*. We will continue to use the app we created in the last exercise.

Find the `pages/` directory and create a file and name it `about.js`. Give the file the following content:

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

The code above creates a so-called *presentation* component that is only able to show data. Components in React are created either by a class inheriting from `React.Component` or by simple functions, like the above. A component can be as simple as a function returning a piece of JSX, which the above does.

The `React.Fragment` element is used as there needs to be root element in every component. You can add any valid HTML element as a root element. To avoid polluting your DOM with extra elements, you are encouraged to use the `React.Fragment` component.

There's a `Link` component used above. That's a component from the underlying React Router library that will ultimately render as an anchor tag `a`. We can use that component to navigate from this page back the root of our app, note how we set the `to` attribute yo `/`.

Once you pasted in the code above and saved it in the file `about.js` the development server will recompile. If you now visit, `http://localhost:8000/about` you should see the following content rendered:

:::image type="content" source="../media/gatsby-page-component.png" alt-text="Page component":::

Congrats, you managed to add a page component, written in React, to your app. Additionally you've learned that any component placed under `/pages` directory can be navigated to.
