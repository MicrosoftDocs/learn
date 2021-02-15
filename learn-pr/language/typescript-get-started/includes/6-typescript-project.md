In this exercise, you'll create a new TypeScript project. You'll then confirm that your development environment is set up correctly by running the compiler and verifying that the JavaScript file is generated.

## Set up a new TypeScript project in VS Code

Create a new project workspace in VS Code and initialize the project.

1. Open VS Code.
1. On the Welcome screen, select **Add workspace folder**.

   :::image type="content" source="../media/m01-visual-studio-code-add-workspace-folder-1.png" alt-text="Visual Studio Code Welcome screen with the Add workspace folder highlighted.":::

1. Create a new project folder and then select **Add**.
1. Select the **Explorer** icon.

   :::image type="content" source="../media/m01-visual-studio-code-explorer-icon-2.png" alt-text="Visual Studio Code with the Explorer icon highlighted.":::

1. In the Explorer, select the **New File** icon.

   :::image type="content" source="../media/m01-visual-studio-code-new-file-icon-3.png" alt-text="Visual Studio Code with the New File icon highlighted.":::

1. Type the file name **module01.ts** and press **Enter**. The TypeScript file appears in a new code editor.

   :::image type="content" source="../media/m01-visual-studio-code-new-typescript-file-4.png" alt-text="Visual Studio Code with the new TypeScript file displayed in the code editor.":::

## Generate a tsconfig.json file

The TypeScript compiler applies default behavior when you compile TypeScript source code. But you can modify the TypeScript compiler options by adding a **tsconfig.json** file to the root of your TypeScript project folder. This file defines the TypeScript project settings, such as the compiler options and the files that should be included.

You can use the `init` option of the TypeScript compiler to generate a TSConfig file with default options.

1. In VS Code, open a new terminal window by selecting **Terminal** > **New Terminal**.
1. At the command prompt, enter `tsc --init`.
1. Notice that the new **tsconfig.json** file has been added to the Explorer. (You may need to refresh the Explorer to see the file.)
1. Open the **tsconfig.json** file in the code window. You'll see it has many options, most of which are commented out. Review the description of each enabled option.
1. In the `tsconfig.json` file, locate the target option and change it to `"ES2015"`.
1. Update the **tsconfig.json** file so the compiler saves all JavaScript files to a new folder.
   1. In the Explorer, create a new folder in your project called **build**.
   1. In the **tsconfig.json** file, locate the `outDir` option, remove the comment, and set the parameter to **build**.
1. Save **tsconfig.json**.
1. At the command prompt, enter `tsc`. This reads the 'jsconfig.json` file and resets the options for the project.

> [!TIP]
> To learn more about the **tsconfig.json** file, visit the [TSConfig Reference](https://www.staging-typescript.org/tsconfig?azure-portal=true).

## Compile TypeScript to JavaScript

Let's add some JavaScript code to the TypeScript file and then compile it.

1. Copy and paste the following JavaScript code into the **module01.ts** editor.

   ```javascript
   function addNumbers(x, y) {
     return x + y;
   }
   console.log(addNumbers(3, 6));
   ```

1. Notice that even though you haven't yet compiled the code, VS Code has used its built-in TypeScript support to type check it. As before, there are type errors in the two parameters of the `addNumbers` function.

   :::image type="content" source="../media/m01-visual-studio-code-intellisense-5.png" alt-text="Visual Studio Code editor with Intellisense indicating that there is a type checking error on the first parameter of the addNumbers function.":::

1. Update the TypeScript code to specify a type for each parameter. Replace `x` with `x: number` and `y` with `y: number`.
1. Save the TypeScript file. The TypeScript compiler only works on the saved version of the file.
1. At the Terminal command prompt, enter **tsc module01.ts**. The compiler should run without errors.
1. Notice that a new JavaScript file has been added, but it is not in the **build** folder in the Explorer. (You may need to refresh the Explorer to see the file.) When you run the `tsc` command on a single file, the compiler ignores the `tsconfig.json` file.
1. To load the config file and compile all the .ts files in the folder, run `tsc` without a filename. This should add the .js file to the `build` folder. (Remember to delete the extra .js file in the root folder.)
1. Open the **module01.js** file and then select the **Split Editor Right** icon in the upper right corner of VS Code to open a new editor view. You should now be able to see the .ts and .js files side by side and that they are identical, except that the .js file does not include the new type annotations.
1. At the Terminal command prompt, enter `node .\build\module01.js`. This will run the JavaScript and display the result in the console log.

## Add an HTML file

As a final step, add an HTML file to the project so you can run and test the JavaScript code.

1. In the Explorer, select the **New File** icon.
1. Type the file name **module01.html** and press **Enter**. The HTML file appears in a new code editor.
1. Copy and paste the following HTML into the editor and then save the file.

   ```html
   <!DOCTYPE html>
   <html lang="en" dir="ltr">
   <head>
      <meta charset="UTF-8">
      <title>Test JavaScript</title>
   </head>
   <body>
      <h1>Test JavaScript</h1>
      <p id="date"></p>
      <p>This page calls the script module01.js and is used for testing.</p>
      <script src="./build/module01.js"></script>
   </body>
   </html>
   ```

1. In the Explorer, right-click **module01.html** and select **Open in Default Browser**.
1. Activate the Developer Tools for your browser and you are ready to start coding in TypeScript!

## Exercise solution

You can download the completed Visual Studio Code workspace from the [GitHub code repo](https://github.com/MicrosoftDocs/mslearn-typescript/code/module-01/m01-end). To run the solution, you must first install the following software on your machine:

- Visual Studio Code (or IDE of your choice)
- Node Package Manager (npm)
- TypeScript Compiler (tsc)

For best results, follow the complete instructions for setting up your environment and using the TypeScript compiler in this module. After setting up your environment, you can run any of the Lab setup or solution files in the [Build JavaScript applications by using TypeScript](../../paths/build-javascript-applications-typescript/index.yml) learning path.
