Gatsby has a system of plugins that *scans* various data sources and places the resulting data in an in-memory object, the data graph. It does all this at build time. So once you start crafting a new page you can assume the data from that graph is available.

## Tools

The data graph is something you can interact with. Once you start up the development server, the data graph will be available on `http://localhost:8000/___graphql`. This will render the data graph in a tool called GraphiQL.

TODO - add screenshot
![]()

It allows you to do the following:

- Navigate, you can drill down into the data graph and its content by expanding nodes to find just the data you need.
- Construct a query, as you drill down into the graph the query will be written for you but you can also edit the query as you see fit.
- Browse results, you can run the query you construct, this ends up being rendered in the tool. You will know exactly what response a query renders before venturing on to include it in a component.

## Use data in a page component

When you create a page component that wants to use data from the above mentioned graph, there are two things you will do:

1. Define a query, you will write a query in the GraphQL query language that asks for a resource and some columns on that resource. It's a static string you are writing that you are passing to an internal Gatsby function called `graphql()`. Ensure you create a variable `query`. Store the result of calling the `graphql()` function into the mentioned `query` variable. This is by convention, Gatsby will know to process the `query` variable content, fetch the data and insert it into the React component in the same file.
2. Create a component, here you are authoring a React component but you can assume the `data` property is populated with the answer from your query. The shape of the result looks exactly like the query you authored. This is a compelling feature of GraphQL itself. Inside of the rendering section of your component you can now read from the `data` property and layout it's data in the template in a way you find appropriate.

## A plugin example: loading images from files

Data can be almost anything. Gatsby helps you pull in data and place it in its data graph using plugins. The plugin `gatsby-source-filesystem` looks at your file system and populates it's data graph based on that. What it does is that it looks through the file system, on a place we specify and make the results available in the Graph. Let's have look at how this plugin is configured in `gatsby-config.js`:

```javascript
{
  resolve: `gatsby-source-filesystem`,
  options: {
    name: `images`,
    path: `${__dirname}/src/images`,
  },
},
```

The `path` property tells us where this plugin should look for files. In our case, it looks for `__dirname`, which is the current working directory and specifically the sub directory `/images`. At pre-compilation time Gatsby will now look through the `image/` directory and collect information on the files. It will also add that information to Gatsby's in-memory data graph.

So how do we use information on images that we configured via the `gatsby-source-filesystem` plugin? As the plugin *scans* the `images/` directory it collects information such as path, type, size, dimensions, and numerous other interesting information. We can then query for this information from the in-memory data graph and use it to render the image via its path that is stored in the graph. Additionally we can perform various image manipulations on the image before displaying it, like *scaling* for example. The image manipulation functionality is something built into Gatsby and not provided by the plugin. However, the built-in functionality and this plugin really work in tandem to make it a great experience to work with image assets.

Any additional plugins you add to Gatsby follow this pattern:

1. Download the plugins via NPM.
2. Configure the plugin via the `gatsby-config.js` file.

As you can see Gatsby's ability to support various data formats is almost infinite.
