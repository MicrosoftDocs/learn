In this exercise, you'll create a new project in Azure Functions that will be the HTTP API for the Product Management application. You'll learn how to create a new HTTP Trigger function, run the function locally and set breakpoints. Finally, you'll wire the function up to the database you created in the previous exercise.

## Create a new Azure Functions project

1. Press F1 to open the Command Palette.

1. Type "create new project".

1. Select "Azure Functions: Create New Project".

1. Select the "api" folder

When prompted, enter the following values

| Name          | Value        |
| ------------- | ------------ |
| Language      | TypeScript   |
| Template      | HTTP trigger |
| Name          | GetProducts  |
| Authorization | Function     |

The "api" folder in VS Code will now contain a new Azure Functions project.

## Run the project

Azure Functions projects can be run and debugged locally from within VS Code.

1. Press F1 to open the Command Palette.

1. Type "debug",

1. Select "Debug: Select and Start Debugging".

1. Select "Attach to Node Functions".

The Azure Functions project will launch. Notice that the terminal shows you what URL the function is running on. Press Cmd/Ctrl and click on the link to open it in a browser.

![A web browser showing the execution result of the new HTTP function](../media/get-products-page.png)

1. The default function template takes in a name parameter and returns a greeting. To pass in the name parameter, modify the url to pass in a query string parameter called "name"

   ```html
   http://localhost:7071/api/GetProducts?name=YourName
   ```

   ![The browser displaying the text "Hello Burke"](../media/hello-message.png)

## Debug the GetProducts function in VS Code

1. Return to the `index.ts` file in VS Code. Click in the left-hand gutter next to line number 7.

   ![VS Code with a square around a breakpoint set on line 7](../media/set-breakpoint.png)

   This will set a breakpoint in the code. You can hit this breakpoint by executing the function from the browser.

1. Return to the browser where the greeting message was returned. Press refresh on the page. VS Code will break on line 7.

1. Press F5 to continue the program execution and see the greeting in the browser. Remove the breakpoint in the editor by clicking on the red dot next to line 7.

1. Click on the "disconnect" button to end the debugging session and terminate the Azure Functions process.

![VS Code debug bar with the disconnect debugger icon outlined with a red square](../media/terminate-debug-process.png)

You have now created the GetProducts API endpoint. In the next section, you'll learn how to modify your function's configuration so that they conform to a REST API standard.
