Gatsby has a system of plugins that *scans* various data sources and places the resulting data in an in-memory object, the data graph. It does all this at build time, so when you're crafting a new page you can assume the data from that graph is available.

## Tools

The data graph is something you can interact with. Once you start up the development server, the data graph will be available on `http://localhost:8000/___graphql`. This will render the data graph in a tool called GraphQL.

GraphQL allows you to do the following:

- **Navigate**: Drill down into the data graph and its content by expanding nodes to find just the data you need.
- **Construct queries**: As you drill down into the graph, the tool will craft a query for you. You can also edit the query text as you see fit to see the results.
- **Browse results**: Run the query you construct to see it rendered in the tool. You'll know exactly what response a query renders before venturing on to include it in a component.

## Use data in a page component

When you create a page component that wants to use data from the above mentioned graph, there are three things you'll do:

1. **Define a query**. Craft a query in the GraphQL query language that asks for a resource and some columns on that resource.
1. **Write the code to Execute the query**. In your page's `.js` file, call the `graphql()` function with your query as an input and store the result in a variable named `query`. Here's an example:

    ```javascript
    export const query = graphql ("query {} ");
    ```

    Naming the variable `query` is an important convention: Gatsby will automatically process the `query` variable, fetch the data and insert it into the React component in the same file.
1. **Create a parameterized component that uses the data**. Create a React component with a `data` parameter. When you build the application, `data` will be populated with the answer from your query. The shape of the result looks exactly like the query you authored. Inside of the rendering section of your component you can now read from the `data` property and layout its data in the template in a way you find appropriate.

## A plugin example: Loading images from files

Data can be almost anything. Gatsby helps you pull in data and place it in its data graph using plugins. The plugin `gatsby-source-filesystem` looks at your file system and populates its data graph based on that. What it does is that it looks through the file system, on a place we specify and makes the results available in the Graph. Let's have look at how this plugin is configured in `gatsby-config.js`:

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

So how do we use information on images that we configured via the `gatsby-source-filesystem` plugin? As the plugin *scans* the `images/` directory it collects information such as path, type, size, and dimensions. We can then query for this information from the in-memory data graph and use it to render the image via its path that is stored in the graph. Additionally, we can perform various image manipulations on the image before displaying it, like *scaling* for example. The image manipulation functionality is something built into Gatsby and not provided by the plugin. However, the built-in functionality and this plugin work in tandem to make it a great experience to work with image assets.

Any additional plugins you add to Gatsby should follow this pattern:

1. Download the plugins via npm.
2. Configure the plugin via the `gatsby-config.js` file.
