In this tutorial, you used the Azure Functions Core Tools to get started developing functions from the command line. You created a local functions project and the simple-interest function with nothing but the Core Tools and a text editor and ran the function locally to test it. After using the Azure CLI to create a function app in Azure, you used the Core Tools to publish your function and interact with it in Azure.

[!include[](../../../includes/azure-sandbox-cleanup.md)]

## What's next?

Now that you can create projects and functions with the Core Tools, what's next?

- Install the [Core Tools](/azure/azure-functions/functions-run-local#install-the-azure-functions-core-tools) and [Azure CLI](/cli/azure/install-azure-cli) on your own computer.
- Try creating functions projects using different languages to see the differences between them. Sample the different trigger templates and examine the generated code to see how to use them.
- Run `func` without any commands to view the Core Tools usage guide and learn about its other features. What do `func settings` and `func azure functionapp logstream` do?
- Use `func init` to initialize a functions project folder as a Git repository and track changes to your code, then upload it to GitHub and share it.
- Create automated tests that use `func start` to run on any computer.
- Have a look at local functions development with [Visual Studio](/azure/azure-functions/functions-develop-vs) and [Visual Studio Code](/azure/azure-functions/functions-develop-vs-code), including support for interactive debugging.
