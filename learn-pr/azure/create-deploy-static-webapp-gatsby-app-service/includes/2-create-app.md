Static websites have been around since the web's inception. At their essence, static web sites are made up of HTML, CSS and JavaScript, which are served to the user. A Static Site Generator (SSG) is a tool that can take higher level tools and generate these static assets.

Gatsby is one such tool that we can use to create a static website. It uses React as a UI layer and GraphQL as a query language to access data available within the site. 

Gatsby is built on top of React and React Router, which allows you to mix both dynamic and static parts. So even though it's a tool for primarily producing static sites, it's fully capable of compiling a React project. Thereby Gatsby can replace your normal set-up for producing apps with React, providing you have part of your React app that you want to make static.

Gatsby has a clever system of plugins that can help import data from different types of data sources. The data sources can be as varied as databases to JSON to your local file system. All this imported data can then be paired up with static assets like HTML and CSS to produce the static pages you want to serve to a user. Thanks to the plugin system, more and more different types of data sources can be supported and is being supported as soon as the Gatsby team or the community writes a new plugin.

How does Gatsby do this? In the pre-compilation phase, each plugin *scans* a source. A source can be a file system, a database, or, for example, a set of JSON files. The data is read and added to a data Graph. The Graph is an in-memory tree of nodes that you can query for. Gatsby then let's you query for these nodes when you proceed to author your static pages in your app.

## Installing and using Gatsby

Gatsby is available via the `gatsby-cli` JavaScript package. You have two ways you can use it:

- **Global install**, run  `npm install gatsby-cli -g`, this will install the executable `gatsby` on your machine. You can now use Gatsby like so, `gatsby <command>`.
- **Use npx**, `npx` is a tool that makes it possible to run executable files without first installing them on your machine. If you use this way of installing you need to prefix your calls to Gatsby like so `npx gatsby <command>`.

These three commands will get you started working with a new Gatsby app:

- `gatsby new <project name> <optional GitHub URL>`: Use this command to generate a new project. It takes a name as a mandatory argument and optionally a GitHub URL as the second argument. Using the latter argument will create a Gatsby project based on an existing Gatsby project on GitHub.
- `gatsby develop`: Start a development server where your project can be accessed. A development server is an HTTP server able to host your files so you can access them from your browser. You will find your Gatsby app running on address `http://localhost:8000`. It will also start an instance of GraphiQL, which is a graphical development tool you can use to explore the data available to your app and build queries. You can use GraphiQL by browsing to `http://localhost:8000/___graphql`.
- `gatsby build`: Create a deployable static representation of your app. All the resulting HTML, JavaScript, and CSS will end up in the sub directory `public`.

## Project anatomy

A scaffolded Gatsby project consists of some parts that you need to understand to work with Gatsby effectively and efficiently.

- `/pages`: React components placed in this directory will become routes and a pages. Pages are described in more detail below.
- `gatsby-config.js`: A configuration file. Part of the configuration will be used to set up and configure plugins and part of it is global data that you can render on your pages.
- `gatsby-node.js`: A file used to implement life-cycle methods of the Gatsby API. In here you can do things such as sourcing files, add/update nodes to the Gatsby graph and even bring in data from the outside that should be part of the website.
- `/styles`: Gatsby lets you apply styles in many ways, everything from imported CSS, SASS, and LESS to CSS Modules.
- `/components`: For React components meant as helper components like header, layout and more.
