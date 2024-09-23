Now that you're familiar with the key features of Visual Studio Code, let's see how Visual Studio Code works—what capabilities you get out of the box and what you can add through the Extensions Marketplace.

Visual Studio Code has a lightweight footprint. Out-of-the-box, Visual Studio Code provides:

- UI with the Editor, Explorer, Search, Debugger, Source Control, Terminal, and Extensions features.
- Support for several languages including HTML, CSS, JavaScript, and TypeScript.
- Integration with Git for source control.
- Integration with Node.js for running and debugging JavaScript.

For some developers, all that is needed is this initial install to get started on their web application projects. But most developers want to add more tools and support for other languages by installing extensions.

## What are extensions?

Extensions are code packages that plug into the Visual Studio Code UI and add support for features such as:

- Themes to change the look-and-feel of the UI color scheme or the style of file icons displayed in the Explorer.
- Productivity tools such as Linters or code beautifiers.
- Other programming languages, such as C++, Python, and hundreds more.
- Debugging support.

You can add what you need to Visual Studio Code quickly and leave out what you don't need.

### Where do you get the extensions?

You can search for, download, and install extensions from the Extensions Marketplace within Visual Studio Code, which integrates with the [Visual Studio Marketplace](https://marketplace.visualstudio.com/vscode?azure-portal=true). For example, you can search by categories such as formatters, programming languages, or themes. The following screenshot displays a few of the many extensions available in the "formatters" category. When you find an extension you want to add, select <kbd>Install</kbd>.

:::image type="content" source="../media/3-extensions-marketplace-prettier.png" alt-text="Screenshot of Visual Studio Code with the Extensions Marketplace view displayed and the Prettier extension in view.":::

### Who built the extensions?

Microsoft publishes many popular extensions, including C/C++, Python, and Docker. Third-parties such as individuals or companies like Red Hat also create and publish extensions for the Marketplace. Most extensions are free. However, some providers charge a fee to download and use their extensions. The publisher is listed below the extension name.

:::image type="content" source="../media/3-marketplace-python.png" alt-text="Screenshot of Visual Studio Code with the Extensions Marketplace view displayed and the Python extension published by Microsoft in view.":::

## Scenario

Now, let's apply this knowledge about how Visual Studio Code works and see how we might set up Visual Studio Code in our scenario.

Recall that in the first part of the scenario, you want to build a website for a local restaurant. To accomplish this, you decide to build a Node.js application.

Here's what you do:

1. First, you [download and install the Visual Studio Code version](https://code.visualstudio.com/Download?azure-portal=true) appropriate for your computer's platform (Windows, macOS, or Linux).

1. Next, you launch Visual Studio Code and using the built-in terminal, you install a Node.js package that helps you scaffold a basic Node.js application. Scaffolding creates several files needed to run a Node.js application.

1. Using the editor workspace, you edit these files. The IntelliSense built into the editor assists you as you write and edit code by providing hints for code completion. This feature helps you save time and ensure your code's syntax is correct.

1. As you work, you can check your files into GitHub using the built-in Source Control view or by issuing Git commands from the integrated terminal. By integrating with GitHub, you can maintain versions of your work that help you better manage changes to your code over time.

1. Now that you're getting comfortable with Visual Studio Code, you decide to install a Visual Studio Code extension that can add to your productivity by making your code's format easier to read. You search for and install the [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) extension.

1. When you're ready, you can test your application and see how it looks by using the built-in debugger.

After you launch the restaurant's website, you can continue using Visual Studio Code for the other projects you're working on for the restaurant.

To prepare for developing the inventory application, you download and install the [Microsoft C/C++ extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools) and the Microsoft Visual C++ (MSVC) compiler toolset. This setup enables you to run and debug C++ code on your computer.

To configure Visual Studio Code for performing data analytics for the restaurant, you download and install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python), which also contains the [Jupyter extension](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter). If you don't already have Python installed on your computer, you also need to download and install a Python interpreter.

After you install a few extensions, a compiler, and an interpreter, Visual Studio Code is set up so that you can develop several different applications. Furthermore, you kept your code editor lightweight by adding only those features you need.
