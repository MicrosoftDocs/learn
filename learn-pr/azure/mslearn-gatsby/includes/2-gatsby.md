Static sites is what the web has been about since it's inception. At the core of things, what you end up serving the user is just that, HTML, JavaScript and CSS. Static site generation or SSG is the process in which we create those static assets. We can either create the assets manually, one by one, or use a tool or framework to do so. Much like HTML, JavaScript and CSS have been there since the beginning, so have tools able to generate static assets. So why are we talking about this concept again like it was a new one? There are three major reasons:

- Fast loading websites, our users will come to our site using different Internet speeds. A slow loading website means that our user might leave your site if it takes too long. That's lost business and revenue.
- SEO, search engine optimization. This is about getting the search engines to find your site. Web application frameworks use different techniques to pre render content and serve that so the search engine robot can index your site. This is continuously evolving to be faster and better.
- Markdown is very popular, most people don't want to author documents in HTML but use some high-level format. A very popular format is for the moment Markdown. We need tools that can support converting from Markdown format to HTML.

Modern sites can be massive applications. Our approach to make such sites fast to load is by starting to identify what parts of our app can be static. The parts that can be made static can thereby be served fast. To accomplish this we have a pre-compilation step. In this step we can mix static data with calls to databases and produce static HTML and CSS. Our dynamic parts still need to be dynamic but hopefully we've made part of our site a lot faster. To help with this pre-compilation process, with different types of content we can use Gatsby.

## Gatsby

Gatsby is a tool for static site generation. It makes it possible mix all kinds of data to help create static assets.

### Technologies used

Gatsby has two core technologies that you need to know to a certain extent. Those are:

- `React.js`, You will use React to create components. You will be creating components to either support the building of pages or to build the pages themselves. Additionally you will also use components to build layouts
- `GraphQL`, GraphQL is a query language used to query for your websites data but also for external data. It is possible to build a Gatsby site without it but it becomes so much easier if you do use it.

### Set up

You will need the following to be able to work with Gatsby:

- `Node.js`, Gatsby works in part by using Node.js and Express so you will need to install Node.js
- `Git`, For many of the commands in the Gatsby cli you will need Git and Git commands, for example when scaffolding a new site based on a GutHub template
- `Gatsby-cli`, you will use the cli to scaffold a new site, build a static site, run a development server and more. You install with the following command `npm install -g gatsby-cli`

TODO links

### Commands

- `gatsby new <project name> <optional GitHub URL>`, You use this command to generate a new project. It takes a name as a mandatory argument and optionally a GitHub URL as the second argument. Using the latter argument will create a Gatsby project based on an existing Gatsby project on GitHub
- `gatsby develop`, this will start up a development server where your project can be accessed. The default value is `http://localhost:8000`. It will also start up a GraphQL endpoint which you can use to author queries that you can later use in your project. You can find the GraphQL endpoint at `http://localhost:8000/___graphql`.
- `gatsby build`, this will create a static representation of your app. All the resulting HTML, JavaScript and CSS will end up in the sub directory `public`

## Project anatomy

The scaffolded Gatsby project consist of some parts that you need to understand to work with Gatsby effectively and efficiently.

- `/pages`, this is a directory. Any React component placed in here will become a route and a page
- `gatsby-config.js`, this is a configuration file. Part of the configuration will be used to set up and configure plugins and part of it is global data that you can render on your pages
- `gatsby-node.js`, this a file used to implement life-cycle methods of the Gatsby API. In here you can do things such as sourcing files, add/update nodes to the Gatsby graph and even bring in data from the outside that should be part of the website.
nodes to
- Styles, Gatsby is pretty open on how to work with styles, everything from imported CSS, SASS, LESS to CSS Modules
- `/components` here you should place React components meant as helper components like header, layout and more.

### Pages

The resulting scaffolded Gatsby project will contain a few files. One of the most important things to be created is the sub directory `/pages`. Any React component placed in here will be rendered as an actual static page and will be accessible. If you were to create a file `/pages/hello.js` withe following content:

```jsx
import React from 'react';

const HelloPage = () => (<div>Hello</div>)

export default HelloPage;
```

This will lead to a route being created at `/hello` and it will render the component content, in this case the string `Hello` between two div tags.

### Pages with Data

When creating a page you can do so in the following way:

1. Define a query fetching data from the Gatsby Graph
2. Create a component that renders the mentioned query

For this query we will use data stored in `gatsby-config.js`. Opening this file up we can see that the first piece of information available is this:

```js
  siteMetadata: {
    title: `Gatsby Default Starter`,
    description: `Kick off your next, great Gatsby project with this default starter. This barebones starter ships with the main Gatsby configuration files you might need.`,
    author: `@gatsbyjs`,
  }
```

Gatsby have added this data as part of Graph that you can query, using GraphQL, let's query for it !

Ensure your project is running by first typing `http://localhost:8000`

The easiest way to find out what query to write is to go to the GraphQL endpoint at `http://localhost:8000/___graphql`.

There you will find a view like this:

TODO GraphQL view iamge

As you expand the node you want to your left you will see how the query is constructed on your right

TODO GraphQL constructed query

Copy the query and put it in a statement like this:

```jsx
export const query = graphql `
  query {
    site {
      siteMetadata {
        title
      }
    }
  }
`
```

Next we need a way to render the results. We create a React component for that like so:

```jsx
export default ({ data }) => (<div>{data.site.siteMetadata.title}</div>)
```

Note how the `data` input parameters is populated by Gatsby ad how we in our rendering section just need to focus on frilling down in our data to find the data we need `data.site.siteMetadata.title`.

The full code for `hello.js` should look like so:

```jsx
import React from 'react';
import { graphql } from 'gatsby';

export default ({ data }) => (<div>{data.site.siteMetadata.title}</div>)

export const query = graphql `
  query {
    site {
      siteMetadata {
        title
      }
    }
  }
`
```

Now let's go to our browser and the URL `http://localhost:8000/hello`. You should see the `hello.js` rendered as HTML with the `title` property from `gatsby.config.js` file.

![Component with data](todo)

### Page with data - image files

Data can be almost anything. So far you've seen how we can pull in data from the file `gatsby-config`. However pulls in a lot more that you can query for. A thing that helps with that is the plugin `gatsby-source-filesystem`. What it does is that it looks through the file system, on a place we specify and make the results available in Gatsby data Graph. Let's have look at how this plugin is configured in `gatsby-config.js`:

```javascript
{
  resolve: `gatsby-source-filesystem`,
  options: {
    name: `images`,
    path: `${__dirname}/src/images`,
  },
},
```

The `path` property tells us where this plugin should look for files. In our case it looks for `${__dirname}/src/images` which is the current work directory and specifically the sub directory `/images`. Ensure our app is running and let's now go to `http://localhost:8000/___graphql`
