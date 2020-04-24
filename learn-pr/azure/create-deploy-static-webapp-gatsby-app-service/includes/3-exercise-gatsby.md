In this exercise you will learn the following:

- Scaffold a new Gatsby app
- Add a page component
- Construct a data query
- Build a Gatsby site that is ready to be deployed to a host

## Exercise - create and run a Gatsby site

Install the following software:

- Git, [Install Git, instructions per OS](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Node.js [Install Node.js](https://nodejs.org/en/download/)
- Gatsby CLI, Once you've installed Node.js you can install the Gatsby CLI with this line `npm install -g gatsby-cli`

### Create a Gatsby app

Let' create a Gatsby app by typing the following in the terminal

```bash
gatsby new hello-gatsby
```

`hello-gatsby` is the name of the project and can be anything you want it to be.

### Run Gatsby

To start developing with Gatsby, ensure you are in the correct directory. If you named your project `hello-gatsby` then ensure you did a `cd hello-gatsby` before continuing.

Now run the following command:

```bash
gatsby develop
```

This command will start up a development server with so called *hot-reloading*. This concept means that any changes done to the code, even addition of files will be picked up by Gatsby and lead to a recompilation.

You should see the following output in the terminal:

![Gatsby develop](../media/gatsby-develop.png)

Now open up a browser and go to url `http://localhost:8000`.

![](../media/gatsby-browser.png)

If you see the above, you successfully created your first Gatsby app. Congrats!

## Exercise - add a page component

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

When you save the file `about.js` the development server will recompile. If you know visit ,http://localhost:8000/about` you should see the following content rendered:

![Page component](../media/gatsby-page-component.png)

Congrats, you managed to add a page component, written in React, to your app. Additionally you've learned that any component placed under `/pages` directory can be navigated to.

## Exercise - add data to our component

Now that we've managed to create our component `about.js` let's make it more exciting by adding data to it. The way you work with data in Gatsby is powerful. Gatsby can query for data from almost anywhere, from your files, from static data and even data from API endpoints and databases. To query for data, we'll use GraphQL. The reason we can query for data from so many diverse data sources is because Gatsby has a big data Graph where all the data is placed. Gatsby scans the app for data in many places with the help of plugins. The process of finding data and placing it in a Graph is called *sourcing*. Data can also be transformed from one format to another before being placed in the Graph.

In this exercise, we will query for data from the `gatsby-config.js` file. Technically we will be querying the data Graph but the data originated from `gatsby-config.js`. There is a section in `gatsby-config.js` called `siteMetadata` looking like this:

```javascript
siteMetadata: {
  title: `Gatsby Default Starter`,
  description: `Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.`,
  author: `@gatsbyjs`,
}
```

We can construct a query given the above, read out the data and, have our `about.js` component render it. 

The first thing we want to do is to go to `http://localhost:8000/___graphql` so we can get help creating our query.

![Query](../media/gatsby-query.png)

In the `Explorer` to the left, we are able to expand our Graph until we find the data we need. In the  middle section, we can see how our query is written for us as we do selection on the left. On the right, we see the result of running our query. We run our query by clicking the *play* button in the middle section.

We make a note of our constructed query:

```bash
site {
  siteMetadata {
    author,
    description,
    title
  }
}
```

Let's now open up our `about.js` file and change it to the following code:

```jsx
import React from 'react';
import { Link, graphql } from 'gatsby';

export default ({ data }) => (
  <React.Fragment>
    <h2>{data.site.siteMetadata.title}</h2>
    <div>{data.site.siteMetadata.description}</div>
    <Link to="/">Back to home</Link>
  </React.Fragment>
)

export const query = graphql `
  query {
    site {
      siteMetadata {
        author,
        description,
        title
      }
    }
  }
`
```

We have taken our constructed query and called the fragment function `graphql` using our query as an argument:

```javascript
export const query = graphql `
  query {
    site {
      siteMetadata {
        author,
        description,
        title
      }
    }
  }
`
```

Then we have relied on Gatsby to input the result of the query as input parameter to our component with the following code:

```jsx
export default ({ data }) => (
```

Finally we are rendering out the data in the rendering section of our component, like so:

```jsx
<h2>{data.site.siteMetadata.title}</h2>
<div>{data.site.siteMetadata.description}</div>
```

If you go to the URL `http://localhost:8000/about`, you should see the following:

![Page component with data](../media/gatsby-component-with-data.png)

Congrats, you've managed to add data to your component and you've learned some basic GraphQL querying in the process, using our GraphQL visual tool called *GraphiQL*.

## Exercise - build our site

The last step we want to take in this series of exercises is to learn how to build a static site that we can deploy to a host. Gatsby does the heavy lifting for us. All you need to do is to call the following command:

```bash
gatsby build
```

This command will create a so called *production build*. All your files will end up in a sub directory `build/`.

Once the process finish building, you can now go to your `build/` directory and open up the files in browser. I usually use a great tool like `http-server` to do so. You can install it using this command:

```bash
npm install http-server -g
```

To run it first ensure, you are standing in the `/build` directory. Then type:
type:

```bash
http-server -p 5000
```

Go to the browser on `http://localhost:5000`.

You should now see the following content rendered:

![Our built app](../media/gatsby-built-site.png)

Congrats, you managed to build your site and you took it from being a Gatsby app to an app containing nothing but HTML, CSS, and JavaScript!
