Static sites have been around since the web's inception, documents with hyperlinks to other documents. At the core of things, what you end up serving the user is just that, HTML, JavaScript, and CSS. Static site generation or SSG is the process in which we create those static assets. We can either create the assets manually, one by one, or use a tool or framework to do so. Much like HTML, JavaScript and CSS have been there since the beginning, so have tools able to generate static assets. So why are we talking about this concept again like it was a new one? There are three major reasons:

- Fast loading websites, our users will come to our site using different Internet speeds. A slow loading website means that our user might leave your site if it takes too long. That's lost business and revenue.
- SEO, search engine optimization. SEO is about getting the search engines to find your site. Web application frameworks use different techniques to *pre render* content and serve said content so that search engine robots can index your site.

- Markdown is popular, most people don't want to author documents in HTML but use some high-level format. A very popular format is for the moment Markdown. We need tools that can support converting from Markdown format to HTML.

Modern sites can be massive applications. Our approach to make such sites fast to load is by starting to identify what parts of our app can be static. The parts that can be made static can thereby be served fast. To accomplish this, we have a pre-compilation step.

In this step, we can mix static data with calls to databases and produce static HTML and CSS. How does Gatsby do this? It relies on a number of plugins. Each plugin *scans* a source. A source can be a file system, a database, or, for example,  a set of JSON files. The data is read and added to a data Graph. The Graph is an in-memory tree of nodes that you can query for. Gatsby then let's you query for these nodes when you proceed to author your static pages in your app.

We have now hopefully made parts of our app fast by having created the static pages. Our dynamic parts still need to be dynamic but hopefully we've made part of our site a lot faster.

## Gatsby

Gatsby is a tool for static site generation. It makes it possible mix all kinds of data to help create static assets.

### Technologies used

Gatsby has two core technologies that you need to know to a certain extent. Those technologies are:

- `React.js`, You will use React to create components. You will be creating components to either support the building of pages or to build the pages themselves. Additionally you will also use components to build layouts
- `GraphQL`, GraphQL is a query language used to query for your websites data but also for external data. It is possible to build a Gatsby site without it but it becomes so much easier if you do use it.

### Set up

You will need the following to be able to work with Gatsby:

- `Node.js`, Gatsby works in part by using Node.js and the Web framework Express so you will need to install Node.js
- `Git`, For many of the commands in the Gatsby CLI you will need Git and Git commands, for example when scaffolding a new site based on a GutHub template
- `Gatsby-cli`, you will use the CLI to scaffold a new site, build a static site, run a development server and more. 

### Commands

- `gatsby new <project name> <optional GitHub URL>`, You use this command to generate a new project. It takes a name as a mandatory argument and optionally a GitHub URL as the second argument. Using the latter argument will create a Gatsby project based on an existing Gatsby project on GitHub.
- `gatsby develop`, this will start up a development server where your project can be accessed. A development server is a HTTP Server able to host your files so you can access them from your browser. You will find your Gatsby app running on address `http://localhost:8000`. It will also start up a GraphQL endpoint, which you can use to author queries that you can later use in your project. You can find the GraphQL endpoint at `http://localhost:8000/___graphql`.
- `gatsby build`, this will create a static representation of your app. All the resulting HTML, JavaScript and, CSS will end up in the sub directory `public`.

## Project anatomy

A scaffolded Gatsby project consists of some parts that you need to understand to work with Gatsby effectively and efficiently.

- `/pages`, any React component placed in this directory will become a route and a page. Pages are described in more detail below.
- `gatsby-config.js`, is a configuration file. Part of the configuration will be used to set up and configure plugins and part of it is global data that you can render on your pages
- `gatsby-node.js`, a file used to implement life-cycle methods of the Gatsby API. In here you can do things such as sourcing files, add/update nodes to the Gatsby graph and even bring in data from the outside that should be part of the website.
nodes to
- Styles, Gatsby let's you apply styles in many ways, everything from imported CSS, SASS, LESS to CSS Modules
- `/components` here you should place React components meant as helper components like header, layout and more.

### Pages

The resulting scaffolded Gatsby project will contain a few files. One of the most important things to be created is the sub directory `/pages`. Any React component placed in here will be rendered as an actual static page and will be accessible. If you are creating a file `/pages/hello.js` with the following content:

```jsx
import React from 'react';

const HelloPage = () => (<div>Hello</div>)

export default HelloPage;
```

This component creation will lead to a route being created at `/hello`. A route is the trailing part of a URL that defines specifically where to go. Looking at an example URL `http://localhost:8000/products`, the trailing part and route is `/products`.

Back to our component above we can see that it will render the string `Hello` between two `div` tags.

### Pages with Data

In the last section we introduced a simple page that we built using a React component. We used the static data `Hello` and rendered that. Gatsby can do a lot more than that. Gatsby has a system of plugins that *scans* various data sources and places the resulting data in an in-memory object, the data graph. It does all this at build time. So once you start crafting a new page you can assume the data from that graph is available.

When you create a page component that wants to use data from the above mentioned graph there are two things you will do:

1. Define a query, you will write a query in the GraphQL query language that asks for a resource and some columns on that resource. It's a static string you are writing that you are passing to an internal Gatsby function called `graphql()`. Gatsby ensures at build time that the asked for data is fetched and passed to your component as a property called `data`.
2. Create a component, here you are authoring a React component but you can assume the `data` property is populated with the answer from your query. The shape of the result looks exactly like the query you authored. This a really compelling feature of GraphQL itself. Inside of the rendering section of your component you can now read from the `data` property and layout it's data in the template in a way you find appropriate.

### Page with data - image files

Data can be almost anything. Gatsby helps you pull in data and place it in its data graph using a plugins. The plugin `gatsby-source-filesystem` looks at your file system and populates it's data graph based on that. What it does is that it looks through the file system, on a place we specify and make the results available in the Graph. Let's have look at how this plugin is configured in `gatsby-config.js`:

```javascript
{
  resolve: `gatsby-source-filesystem`,
  options: {
    name: `images`,
    path: `${__dirname}/src/images`,
  },
},
```

The `path` property tells us where this plugin should look for files. In our case, it looks for `__dirname`, which is the current work directory and specifically the sub directory `/images`. Ensure our app is running and let's now go to `http://localhost:8000/___graphql`
