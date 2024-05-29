The Azure Functions Core Tools let you develop and run functions on your local computer from the command line.

You want to build your first function, a simple interest calculator, locally on your own computer and not in the Azure portal's functions editor. You're not sure if you want to use a development environment like Visual Studio or Visual Studio Code, both of which can be extended to support Azure Functions directly. Ultimately, you decide to use the Core Tools from the command line and a basic text editor.

In this unit, you learn how to use the Core Tools to create and run functions locally. Let's learn more about Core Tools before we use them in the exercise in the next unit, which walks you through these concepts using the Azure Cloud Shell.

## What is Azure Functions Core Tools?

Azure Functions Core Tools is a standalone runtime along with a set of command-line tools that you can use to develop, run, and deploy function code from your local computer. 

Core Tools supports several functions-related capabilities, including:

- Generate the files and folders you need to develop functions locally.
- Provide a local runtime so you can test and debug functions on your computer.
- Publish your functions to Azure.
 
Using Core Tools, you can accomplish these tasks from the command line. Use any text editor you like to write code and modify configuration. You also need the Azure CLI or Azure PowerShell to sign in to Azure, create Azure resources, and deploy project files.

Core Tools is packaged as a single command-line utility named `func`. If you run `func` from the command line without any other commands, it displays version information and a usage guide. You don't need to read it now, but here's what it looks like:

:::image type="content" source="../media/2-func-help-output.png" alt-text="A portion of the help text output by func." loc-scope="other":::

Both Visual Studio and Visual Studio Code use Core Tools to provide an integrated local debugging experience. 

Here are some fundamental concepts about functions.

### Function apps and functions projects

When you develop functions locally, you work within a *functions project*. The project is a folder that contains the code and configuration files that define your functions. This code project is deployed to a *function app* resource in Azure. In a function app instance, all of the functions share a common set of configuration values and resources. 

Each function app targets a specific language stack, and each stack has its own language-specific project requirements. Fortunately,  you never need to create functions project manually yourself. You can use Core Tools to generate function projects and functions from scratch in your desired language.

### Core Tools versions

Because Core Tools include the Azure Functions runtime, the major version of the Core Tools you use must always match the major version of the Functions runtime in Azure. Currently, version 4.x is the recommended version of the Functions runtime, and the only version that supports all languages. While this tutorial discusses and uses Core Tools version 4.x, you don't need to install anything on your own computer. In this tutorial, you instead use Core Tools in an Azure Cloud Shell environment in your browser. Cloud Shell already has the correct versions of Core Tools, Azure CLI, and Node.js, along with a code editor already installed.

### Local development vs. Azure portal development

While the Azure portal does provide a built-in editor for your function code, you can only use it for specific language stacks. You also can't use the portal to edit functions that you develop locally and deploy to Azure. When you start using any local development workflow, you can't use the Azure portal to make changes to your function code. 

Core Tools supports local development for all language stacks supported by Azure Functions. 

## Create functions locally

Here's a closer look at how to create functions with Core Tools and run them locally. Learn how to publish to Azure later on in this tutorial.

### Create a new functions project with `func init`

To create a new functions project, run `func init` on the command line.

:::image type="content" source="../media/2-func-init-output.png" alt-text="Output from func init creating a JavaScript function project." loc-scope="other":::

`func init` asks you which language runtime to use for the app. It tailors the project folder's contents appropriately.

When you create a new functions project, the files included in the project folder depend on the language runtime that you select. Regardless of which runtime you choose, the two most critical project files are always present:

- *host.json* stores runtime configuration values, such as logging options, for the function app. The settings stored in this file are used both when you run functions locally and in Azure.
- *local.settings.json* stores configuration values that only apply to the function app when it runs locally with the Core Tools. This file contains two kinds of settings:
  - Local runtime settings: Used to configure the local functions runtime itself.
  - Custom application settings: You add and configure them based on your app's needs. All the functions in the app can access and use them.

Functions projects that `func init` generates don't have any functions in them. In the next section, find out how to add one.

### Create a new function with `func new`

Each individual function in a project requires code and a configuration to define its behavior. Running `func new` in a functions project folder creates a new function and all the files you need to start developing.

:::image type="content" source="../media/2-func-new-output.png" alt-text="Output from func new creating a JavaScript function." loc-scope="other":::

After asking you which kind of function trigger you want to use and what you'd like to name your function, `func new` generates a complete, publish-ready starter implementation in your function project's chosen language. The starter code illustrates how to use the type of trigger you selected and is there to help you get started quickly. Replace the body of the function with your own implementation, and you're ready to build, run, test, and publish.

In the next part of this tutorial, you use `func new` to create an HTTP-triggered function and modify the starter implementation to perform a simple interest calculation.

## Run functions locally

Functions aren't programs that can be run on their own. They must be hosted. The Azure Functions host is what powers everything outside of your function code: it loads the configuration, listens for triggers and HTTP requests, starts the worker process for the language your functions are written in, writes log output, and more. In Azure, function apps run the host automatically when they start.

You can use the Core Tools to run your own instance of the Azure Functions host and try out your functions locally before you publish them. By running your functions before publishing them, you can make sure your configuration and code loads correctly and test out your functions by making real HTTP calls to them without the need for Azure resources.

To start the functions host locally, run `func start` from a functions project folder. At the end of the output, the Core Tools display local URLs you can use to call each of your functions. While the host is running, you can use any tools or libraries that make HTTP calls, like `curl`, to interact with your functions. The Core Tools write any log output produced by the host to the terminal in real time.

:::image type="content" source="../media/2-func-start-output.png" alt-text="func start output showing a function invocation URL." loc-scope="other":::
