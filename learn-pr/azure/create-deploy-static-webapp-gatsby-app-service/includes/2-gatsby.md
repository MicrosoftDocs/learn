Static sites have been around since the web's inception, documents with hyperlinks to other documents. At the core of things, what you end up serving the user is just that, HTML, JavaScript, and CSS. Static site generation or SSG is the process in which we create those static assets. We can either create the assets manually, one by one, or use a tool or framework to do so. Much like HTML, JavaScript and CSS have been there since the beginning, so have tools able to generate static assets. So why are we talking about this concept again like it was a new one? There are some major reasons:

- Fast loading websites, our users will come to our site using different Internet speeds. A slow loading website means that our user might leave your site if it takes too long. That's lost business and revenue.
- SEO, search engine optimization. SEO is about getting the search engines to find your site. Web application frameworks use different techniques to *pre render* content and serve said content so that search engine robots can index your site.
- Markdown is popular, most people don't want to author documents in HTML but use some high-level format. A popular format is for the moment Markdown. We need tools that can support converting from Markdown format to HTML.
- Security, when you are making a page static it means we don't have a backend that can be tampered with.
- Things have evolved, we can now carry out numerous things on the client-side that previously was done on the backend.

Modern sites can be massive applications. Our approach to make such sites fast to load is by starting to identify what parts of our app can be static. The parts that can be made static can thereby be served fast. To accomplish this, we have a pre-compilation step.

## Gatsby

Gatsby is a command-line tool. It helps you generate static sites using technologies such as React and GraphQL and different types of data to do so. The input to the command-line tool is your Gatsby project consisting of React components that you author and any assets that you want to add. The output is HTML, CSS and JavaScript and any static assets you might have included like, for example,  image files. Gatsby is built on top of React and React Router and does allow you to mix both dynamic and static parts. So even though it's a tool for primarily producing static sites, it's fully capable of compiling a React project. Thereby Gatsby can replace your normal set-up for producing apps with React, providing you have part of your React app that you want to make static.

Gatsby has a clever system of plugins that can help import data from different types of data sources. The data sources can be as varied as databases to JSON to your local file system. All this imported data can then be paired up with static assets like HTML and CSS to produce the static pages you want to serve to a user. Thanks to the plugin system, more and more different types of data sources can be supported and is being supported as soon as the Gatsby team or the community writes a new plugin.

How does Gatsby do this? In the pre-compilation phase, each plugin *scans* a source. A source can be a file system, a database, or, for example, a set of JSON files. The data is read and added to a data Graph. The Graph is an in-memory tree of nodes that you can query for. Gatsby then let's you query for these nodes when you proceed to author your static pages in your app.

### Technologies used

Gatsby has two core technologies that you need to know to a certain extent. Those technologies are:

- `React.js`, You will use React to create components. You will be creating components to either support the building of pages or to build the pages themselves. Additionally you will also use components to build layouts
- `GraphQL`, GraphQL is a query language used to query for your websites data but also for external data. It's possible to build a Gatsby site without it but it becomes so much easier if you do use it. GraphQL is a query language used for querying APIs. It's able to *negotiate* with the API exactly for what resources and columns it wants from the API. This solves many problems that exist currently with APIs like over-fetching or many round-trips extra to the server.

## Creating and working with a new Gatsby app

Before you are able to work with Gatsby command line tool, there are some prerequisites you need to fulfill. You need to install the below software:

- Git, [Install Git, instructions per OS](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).
- Node.js [Install Node.js](https://nodejs.org/en/download/).
- Gatsby CLI, Once you've installed Node.js you can install the Gatsby CLI with this line `npm install -g gatsby-cli`.

These three commands will get you started working with a new Gatsby app:

- `gatsby new <project name> <optional GitHub URL>`, You use this command to generate a new project. It takes a name as a mandatory argument and optionally a GitHub URL as the second argument. Using the latter argument will create a Gatsby project based on an existing Gatsby project on GitHub.
- `gatsby develop`, this will start up a development server where your project can be accessed. A development server is an HTTP Server able to host your files so you can access them from your browser. You will find your Gatsby app running on address `http://localhost:8000`. It will also start up a GraphQL endpoint, which you can use to author queries that you can later use in your project. You can find the GraphQL endpoint at `http://localhost:8000/___graphql`.
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

One of the most important things to be created in a new Gatsby project is the sub directory `/pages`. Any React component placed in here will be rendered as an actual static page and will be accessible. If you are creating a file `/pages/hello.js` with the following content:

```jsx
import React from 'react';

const HelloPage = () => (<div>Hello</div>)

export default HelloPage;
```

This component creation will lead to a route being created at `/hello`. A route is the trailing part of a URL that defines specifically where to go. Looking at an example URL `http://localhost:8000/products`, the trailing part and route is `/products`.

Back to our component above we can see that it will render the string `Hello` between two `div` tags.



