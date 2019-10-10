Visual Studio Code makes it easy to write JavaScript code and run it using Node.js. The Visual Studio Code editor has built-in support for JavaScript and JSON. You can utilize the IntelliSense features of the editor to help you check syntax. IntelliSense also offers code-completion, helping to minimize any syntactic and semantic errors in your applications. You can using the integrated debugging tools to help test and verify your code.

In this unit, you'll learn how to create a JavaScript application using Visual Studio Code. You'll see how to run the application using Node.js from within Visual Studio Code. Finally, you'll learn how to use the debugger to step through your code and examine variables as your code runs.

## Creating a JavaScript application for Node.js

To create a new JavaScript application for Node.js from within Visual Studio Code, perform the following steps:

1. Open a new terminal window. You can do this from the **Terminal** menu. A new termainl window will appear, as shown in the following image:

    ![Screenshot of Visual Studio Code. The user has opened a new terminal window](../media/4-vscode-terminal.png)

2. In the terminal window, create a new folder for your application. Use the `mkdir` command. The following example creates a folder named **appfolder**:

    ```bash
    mkdir appfolder
    ```

3. Move to the application folder, and use the `npm init -y` command to create a new Node.js application:

    ```bash
    cd appfolder
    npm init -y
    ```

    This command creates a new file, named **package.json** in the application folder. This file contains metadata which you use to describe your application to the Node.js runtime.

4. On the **File** menu, click **Open Folder**, and select your application folder.

5. In the **Explorer** window, expand your application folder, and select the **package.json** file. It will open in the editor.

    ![Screenshot of Visual Studio Code. The user has opened the **package.json** file](../media/4-package-json.png)

6. Add a description to the **description** property. You should also replace the text **main.js** in the **main** property with the name of the JavaScript file that will hold your application code.

7. Save the file before continuing.

8. On the **File** menu, click **New File**, and create a new file for your application code. Save the file with the same name as the file that you specified in the **package.json** file. Make sure you give the file a **.js** extension (for JavaScript)

You are now ready to start writing your JavaScript code.

## Enable advanced type checking

In the **Terminal** window, run the following command to install the **@types/node** package:

```bash
npm install @types/node
```

The **node** package contains features that support additional type checking and meaningful error reporting when you are writing JavaScript code. To enable advanced type checking, add the following statement at the top of your application code file:

```javascript
//@ts-check
```

If you want to use ECMAScript 6 or later syntax and features in your JavaScript code, you should also install the **esm** package. In the terminal window, run the following command:

```
npm install esm
```

> [!NOTE]
> ECMAScript 6 adds features such selective `import` statements, and classes, to JavaScript.

## Write your code

Add your JavaScript code to the application code file. As you type, IntelliSense will show suggestions appropriate to the current context. You can click any of the suggestions to complete the phrase.

![Screenshot of the editor Visual Studio Code, showing an Intellisense prompt](../media/4-intellisense.png)

When you write code to call a function, IntelliSense will show the parameters that the function can take.

![Screenshot of the editor Visual Studio Code, showing the parameters for a function call](../media/4-function-params.png)

TBD - ERRORS AND SUGGESTIONS