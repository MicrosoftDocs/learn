Azure Functions Core Tools lets you develop functions locally on your own computer by:

- Creating the files and folders necessary for a functions project.
- Providing a Functions host that runs locally from the root directory of your project.

You decide to start your work locally with Azure Functions by developing a function that computes simple interest. Eventually, you can create more complex functions that work together and call other services and databases. Using Core Tools to build a function that carries out a basic loan calculation is a good start. You also want to try running your function on your own computer before publishing it to Azure. You can do it all from Azure Cloud Shell using Core Tools.

The Azure Cloud Shell comes with Core Tools, Azure CLI, and an editor you can use to write code. Make sure to select **Activate sandbox** above before you proceed.

## Create a local Azure Functions project

In this exercise, use Cloud Shell to develop your first JavaScript function using Core Tools. Cloud Shell already has the correct versions of both Core Tools and Node.js installed. 

1. From the root folder, run `func init` to create a functions project in a new `loan-wizard` folder.

    ```bash
    func init loan-wizard
    ```

1. When prompted to select a worker runtime, enter **3** for **node**.

1. When prompted to select a language, enter **1** for **javascript**.

    The output lists the files being written to disk, including these files:
    - *host.json* supports app-level configuration for both the runtime instance and specific trigger and binding types.
    - *local.settings.json* sets local-only behaviors and application settings (local environment variables).
    - *package.json* is a JavaScript-specific file that keeps track of any packages you install and use within your code.
    - *.gitignore* and *extensions.json* are configuration files used by the Git version control tool and Visual Studio Code, respectively. You can ignore them for now.

## Create an HTTP-triggered function

It's time to create your function!

1. In Cloud Shell, navigate to the new `loan-wizard` directory.

    ```bash
    cd ~/loan-wizard
    ```

1. Run `func new` to start the function creation wizard.

    ```bash
    func new
    ```

1. When prompted to select a template, enter **7** for **HTTP trigger**.

1. When prompted to provide a function name for HTTP trigger, enter `simple-interest`.

1. Run the following command to open the Cloud Shell editor.

    ```bash
    code .
    ```

    :::image type="content" source="../media/3-functions-project-view.png" alt-text="Screenshot showing the simple-interest folder with the function.json file open in Cloud Shell code editor.":::

    The wizard creates a new file in the functions project under `src/functions` called **simple-interest.js**, which has default template content. This code supports the Node.js v4 programming model for Azure Functions. Take a moment now to explore the project files using the editor. The screenshot shows the expanded folder with *simple-interest.js* open in the editor.

## Implement the simple-interest function

The default function implementation that Core Tools created for us in *simple-interest.js* looks for an input called `name` in the query string or the body of the inbound HTTP request and returns the string `Hello, [name]`. It's a good illustration of how to use an HTTP trigger, but you want to replace that code with code that calculates simple interest from three input parameters.

1. In the editor's **FILES** pane, expand the *src* > *functions* folder and select *simple-interest.js* to open the file in the editor.

1. Replace the full contents of *simple-interest.js* with the following code:

    ```javascript
    const { app } = require('@azure/functions');
    
    app.http('simple-interest', {
        methods: ['GET','POST'],
        authLevel: 'anonymous',
        handler: async (request, context) => {
            const principal = parseFloat(request.query.get('principal'));
            const rate = parseFloat(request.query.get('rate'));
            const term = parseFloat(request.query.get('term'));
    
          if ([principal, rate, term].some(isNaN)) {
            // If any empty or non-numeric values, return a 400 response with an
            // error message
            return {
              status: 400,
              body: "Please supply principal, rate and term in the query string"
            };
          } else {
            // Otherwise set the response body to the product of the three values
            return { body: principal * rate * term };
          }
        }
    });
    ```

    This script looks for parameters named `principal`, `rate`, and `term` in the query string of the HTTP request. It then returns the result of the simple interest calculation (`principal * rate * term`).

1. Save the file by pressing **Ctrl**+**S**, and close the editor by pressing **Ctrl**+**Q**.

## Run the function in Cloud Shell

To run your new function locally to try it out, use `func start` to start the Functions runtime (*func.exe*) in a background process so that you can use the command line while it's running. Then, use a command-line tool, `curl`, to interact with the function.

If you're using Core Tools from your own computer, you can just use `curl` from a second terminal window or a web browser. The output produced by Core Tools appears in real time in the first terminal window. In Cloud Shell, you're limited to a single terminal, so you need to run Core Tools (func.exe) in a background process.

1. Run the following command to start the Functions host silently in the background.

    ```bash
    func start &> ~/output.txt &
    ```

    As with `func new`, Cloud Shell should still be in the `loan-wizard` directory.

    The Functions host is now writing its output to the file *~/output.txt*. You can continue to use the command line while it's running.

    Use the `ps` command to verify that the `func` process is running.

1. Enter the following command to view the output log.

    ```bash
    code ~/output.txt
    ```

    In the output, you see a message that lists `Functions: simple-interest:` is available as both a GET and a POST HTTP request `http://localhost:7071/api/simple-interest`.

    > [!NOTE]
    > If you see an error message, select **Ctrl**+**C** to stop the host. Make sure that the contents of your code file are the same as the sample.

    This localhost URL isn't published to the web, it's only accessible from tools running in your Cloud Shell session.

1. Close the editor by selecting **Ctrl**+**Q**.

1. Run the following command to send an HTTP GET request to your locally running function.

    ```bash
    curl "http://localhost:7071/api/simple-interest" -w "\n"
    ```

    The output, `Please supply principal, rate and term in the query string`, indicates that our function was successfully invoked and can return a response, but you're not calling it as intended. You need to provide the parameters as part of the HTTP request.

1. Invoke the function again. This time, provide a value for each of the query string parameters.

    ```bash
    curl "http://localhost:7071/api/simple-interest?principal=5000&rate=.035&term=36" -w "\n"
    ```

    This time, the output is `6300`. Your function is working as expected!

1. Enter the following command to again view the output log.

    ```bash
    code ~/output.txt
    ```

    After the startup log entries you see appended a timestamped set of log entries for each time you called the function with `curl`:

    ```output
    [2024-02-20T06:25:56.700Z] Executing 'Functions.simple-interest' (Reason='This function was programmatically called via the host APIs.', Id=5daf20c3-f204-41bb-a5b9-021acaf17c04)
    [2024-02-20T06:25:56.893Z] Executed 'Functions.simple-interest' (Succeeded, Id=5daf20c3-f204-41bb-a5b9-021acaf17c04, Duration=228ms)

    ```

1. Close the editor by selecting **Ctrl**+**Q**.
