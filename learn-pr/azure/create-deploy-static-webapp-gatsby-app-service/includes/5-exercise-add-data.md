Gatsby's querying capabilities let you build a static site from data gathered from many different sources.

Here, you'll build a query to capture some data from a configuration file and render it into a page.

## Add data to your component

The way you work with data in Gatsby is powerful. Gatsby can query for data from almost anywhere, from your files, from static data and even data from API endpoints and databases. To query for data, we'll use GraphQL.

`gatsby-config.js` is where you store metadata for your site along with configurations of the plugins in a JavaScript object. There's a property in said JavaScript object called `siteMetadata`. This property along with its values gets read into the data graph as part of the build process and gets stored in a node called `site`. You'll see how querying for data works by constructing an `About` component to query for title and description.

Below is a depiction of what the `siteMetadata` property looks like:

```javascript
siteMetadata: {
  title: `Gatsby Default Starter`,
  description: `Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.`,
  author: `@gatsbyjs`,
}
```

We can construct a query given the above, read out the data and have a component render it.

### Start development server

Start the development server by typing the following command at the root of your project:

```bash
gatsby develop
```

You should now have two routes up and running:

- `http://localhost:8000/`, where your app is rendered
- `http://localhost:8000/___graphql`, where the built-in data graph is displayed with GraphQL

### Construct a query

Go to `http://localhost:8000/___graphql` in your browser so you can get help creating the query.

:::image type="content" source="../media/graphql-explorer.png" alt-text="Screenshot showing how to navigate to the Gatsby query." lightbox="../media/graphql-explorer.png":::

In the above image, you can see the Explorer section in the left pane. You can use the Explorer to drill down into our Graph until you find the data you need. In the middle pane you can see how the query is written for you as you perform selections on the left. On the right you see the result of running the query. You can run the query by clicking the *play* button in the middle section.

Return back to the VS Code editor and locate the file `about.js` in the `pages/` directory. Change its content to the following code:

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

Here, you're calling the `graphql` function using the query as an argument and assigning it to the variable `query`. It's important that its called `query` so Gatsby knows to process it and put the result into the component and build time.

During build time Gatsby will input the query result into the component's `data` property as indicated below, where you can reference it from your component's JSX.

Save the file and browse to `http://localhost:8000/about` and you'll see the following:

:::image type="content" source="../media/component-with-data.png" alt-text="Screenshot showing the page component with data.":::

You've added data to your component with a GraphQL query! You also got to use the GraphQL querying tool and Gatsby development server in the process.
