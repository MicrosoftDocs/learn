The Azure Functions Core Tools let you develop and run functions on your local computer from the command line.

You've decided you want to try building your first function, a simple interest calculator, by developing it locally on your own computer and not in the Azure portal's functions editor. You're not sure if you want to use a development environment like Visual Studio or Visual Studio Code, both of which can be extended to support Azure Functions directly. Ultimately, you decide to use the Core Tools from the command line and a basic text editor.

In this module, you'll learn how to use the Core Tools to create and run functions locally. Let's learn more about Core Tools before we use them in the exercise in the next unit, which walks you through these concepts using the Azure Cloud Shell.

## What are the Azure Functions Core Tools?

The Azure Functions Core Tools are a set of command-line tools that you can use to develop and test Azure Functions on your local computer.

The Core Tools feature different kinds of functions-related capabilities, but their primary purpose is to:

1. Generate the files and folders you need to develop functions on your local computer.

1. Run your functions locally so you can test and debug them.

1. Publish your functions to Azure.

The Core Tools are packaged as a single command-line utility named `func`. If you run `func` from the command line without any other commands, it will display version information and a usage guide. You don't need to read it now, but here's what it looks like:

:::image type="content" source="../media/2-func-help-output.png" alt-text="A portion of the help text output by func." loc-scope="other":::

The Core Tools are standalone utilities, not an extension of a larger integrated development environment or tool. You can accomplish the above tasks with nothing but the command line and the Core Tools. Use any text editor you like to write code and modify a configuration. In practice, you'll also need the Azure CLI or Azure PowerShell to sign in to Azure and carry out other management tasks.

Other Functions development tools, such as the Functions-related features in Visual Studio and the Azure Functions extension for Visual Studio Code, are built on top of Core Tools.

### Core Tools versions

You may see references to two different versions of the Core Tools as you move through learn content: versions **1.x** and **2.x**. We recommend using the newest available revision of version 2.x, as it offers the best support for most scenarios, and it can be installed on Windows, macOS, and Linux computers.

We'll discuss and use version 2.x throughout this tutorial, but you won't install anything on your own computer. This tutorial uses the in-browser Cloud Shell environment, and Core Tools are already installed, along with the Azure CLI and a code editor.

### Local development vs. Azure portal development

The Azure portal has a powerful functions editor experience. In most cases, it doesn't support modifying functions that you develop locally. Once you start using a local development workflow based on Core Tools, you can't use the Azure portal to make changes to your functions.

## Create functions locally

So, let's take a closer look at how to create functions with Core Tools and run them locally. We'll look at how to publish to Azure later on in this tutorial.

Here are some fundamental concepts about functions.

### Function apps and functions projects

Every function published to Azure belongs to a *function app*, which is a collection of one or more functions that Azure publishes together into the same environment. All of the functions in a function app share a common set of configuration values. Build them all for the same language runtime. A function app is an Azure resource that can be configured and managed independently.

When you develop functions locally, you work within a *functions project*. The project is a folder that contains the code and configuration files that define your functions. A functions project on your computer is equivalent to a function app in Azure, and can contain multiple functions that use the same language runtime.

To start developing locally on your computer, you need to create a functions project folder that's organized correctly. Every new function you add to the project requires additional code and a configuration. They must be complete and correctly structured, or your functions won't run.

If you wanted to, you could become familiar with the names, contents, and structure of the files you need in a functions project folder and create them yourself. Doing so would be time-consuming and error-prone.

With the Azure Functions Core Tools, you'll never need to create them yourself. You can use Core Tools to generate function projects and functions from scratch.

### Create a new functions project with `func init`

To create a new functions project, run `func init` on the command line.

:::image type="content" source="../media/2-func-init-output.png" alt-text="Output from func init creating a JavaScript function project." loc-scope="other":::

`func init` will ask you which language runtime you'd like to use for the app and tailor the project folder's contents appropriately.

When you create a new functions project, the files included in the project folder depend on the language runtime you select. Regardless of the runtime you choose, the two most critical project files are always present:

- **host.json** stores runtime configuration values, such as logging options, for the function app. The settings stored in this file are used both when running functions locally and in Azure.
- **local.settings.json** stores configuration values that only apply to the function app when it's run locally with the Core Tools. This file contains two kinds of settings:
  - Local runtime settings: Used to configure the local functions runtime itself.
  - Custom application settings: You add and configure them based on your app's needs. All the functions in the app can access and use them.

Functions projects that `func init` generates don't have any functions in them. Let's find out how to add one.

### Create a new function with `func new`

Each individual function in a project requires code and a configuration to define its behavior. Running `func new` in a functions project folder will create a new function and all the files you need to get started developing.

:::image type="content" source="../media/2-func-new-output.png" alt-text="Output from func new creating a JavaScript function." loc-scope="other":::

After asking you which kind of function trigger you want to use and what you'd like to name your function, `func new` will generate a complete, publish-ready starter implementation in your function project's chosen language. The starter code illustrates how to use the type of trigger you selected and is there to help you get started quickly: just replace the body of the function with your own implementation, and you're ready to build, run, test, and publish.

In the next part of this tutorial, we'll use `func new` to create an HTTP-triggered function and modify the starter implementation to perform a simple interest calculation.

## Run functions locally

Functions aren't programs that can be run on their own: they must be hosted. The function host is what powers everything outside of your function code: it loads the configuration, listens for triggers and HTTP requests, starts the worker process for the language your functions are written in, writes log output, and more. In Azure, function apps run the function host automatically when they start.

You can use the Core Tools to run your own instance of the functions host and try out your functions locally before you publish them. By running your functions before publishing them, you can make sure your configuration and code loads correctly and test out your functions by making real HTTP calls to them without the need for Azure resources.

To start the functions host locally, run `func start` from a functions project folder. At the end of the output, the Core Tools will display local URLs you can use to call each of your functions. While the host is running, you can use any tools or libraries that make HTTP calls, like `curl`, to interact with your functions. The Core Tools will write any log output produced by the host to the terminal in real time.

:::image type="content" source="../media/2-func-start-output.png" alt-text="func start output showing a function invocation URL." loc-scope="other":::
