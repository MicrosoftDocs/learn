Good Bicep code is _self-documenting_. This means that it uses clear naming and a good structure, so that when a colleague reads your code they can quickly understand what's happening - and if they need to make a change, they can be confident they are modifying the right places. However, there are some situations where you need to add extra documentation to your Bicep files. Also, once your template is deployed and resources have been created in Azure, it's important that anyone who looks at your Azure environment understands what each resource is and what it's for. In this unit, you'll learn how to add comments to your Bicep files, and how to use resource tags to add metadata to your Azure resources. These features provide insights into what your code does, the logic that was used to write the code, and the purpose of your Azure resources.

## Add comments to your code

Bicep enables you to add _comments_ to your code. Comments are human-readable text. They help you to document your Bicep code, but they're ignored when the file is deployed to Azure.

Bicep supports two types of comments:

- **Single-line comments** start with a `//` character sequence, and continue to the end of the line, like this:
  ::: code language="bicep" source="code/4-comments.bicep" range="1-8" highlight="5" :::
- **Multi-line comments** use the `/*` and `*/` character sequences to surround your comment, and can span multiple lines, like this:
  ::: code language="bicep" source="code/4-comments.bicep" range="10-13" :::

> [!TIP]
> Avoid using comments for obvious and clear parts of your code. Focus on documenting unique logic and complex expressions. Having too many comments actually reduces your code's readability!

You can also use Bicep comments to add a structured multi-line block at the beginning of each file. Think of it as a _manifest_. Your team could agree that each template and module should have a manifest, and what it contains.

```bicep
/*
  SYNOPSIS: Module for provisioning Azure SQL server and database.
  DESCRIPTION: This modules provisions an Azure SQL server and a database, and configures the server to accept connections from within Azure.
  VERSION: 1.0.0
  OWNER TEAM: Website
*/
```

### Add comments to parameter files

Parameter files enable you to create a file to specify a set of parameters for your deployment. The parameters that you specify in parameter files also often need to be documented, and it's a good practice to add comments to parameter files when you work with parameter values that aren't immediately clear to someone reading the file. For example, your website's Bicep template might include a parameter for the URL to access your product stock API, so your website can display whether your toys are in stock in your warehouse. The URLs to access the stock API for each environment aren't easy to understand, so they're a good candidate for a comment:

::: code language="json" source="code/5-parameters.jsonc" highlight="6" :::

> [!TIP]
> When you work with parameter files and other JSON files that include comments, you usually need to use the `.jsonc` file extension instead of `.json`. This helps Visual Studio Code and other tools understand that comments are allowed.

## Apply resource tags

Comments in your Bicep file don't appear anywhere in your deployed resources - they are just there to help you document your Bicep files. However, there are many situations where you need to track information about your deployed Azure resources, including:

- Allocating your Azure costs to specific cost centers.
- Understanding how the data contained in databases and storage accounts should be classified and protected.
- Recording the name of the team or person who is responsible for management of the resource.
- Tracking the name of the environment the resource relates to, like production or development.

Resource _tags_ enable you to store important metadata about resources. You define resource tags in your Bicep code, and Azure stores the information with the resource when it's deployed:

::: code language="bicep" source="code/4-tags.bicep" range="5-21" highlight="4-9" :::

You can query a resource's tags using tools like Azure PowerShell and the Azure CLI, and you can see tags on the Azure portal:

:::image type="content" source="../media/4-tags-portal.png" alt-text="Screenshot of the Azure Portal for a storage account, showing the location of tags." border="true":::
