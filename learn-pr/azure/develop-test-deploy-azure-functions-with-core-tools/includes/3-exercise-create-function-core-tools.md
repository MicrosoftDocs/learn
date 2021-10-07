Azure Functions Core Tools enable you to develop functions locally on your own computer by creating the files and folders necessary for a functions project and by providing a Functions host that runs locally from the root directory of your project.

You've decided to start your work locally with Azure Functions by developing a function that computes simple interest. Eventually you'll work your way up to more complex functions that work together and call other services and databases, but using Core Tools to build a function that performs a basic loan calculation is a good start. You also want to try running your function on your own computer before publishing it to Azure. You can do all of this from Azure Cloud Shell using Core Tools.

The Azure Cloud Shell comes with Core Tools, Azure CLI, and an editor you can use to write code. Make sure to activate the sandbox above before proceeding.

## Create a local Azure Functions project

In this exercise, you'll use Cloud Shell to develop your function.

1. In the Cloud Shell on the right, create a new directory called `loan-wizard` and open that directory.

    ```bash
    mkdir ~/loan-wizard
    cd ~/loan-wizard
    ```

1. Run `func init` to initialize the `loan-wizard` directory as a functions project folder.

    ```bash
    func init
    ```

1. When prompted to select a worker runtime, enter **2** (for **node**).

1. When prompted to select a language, enter **1** (for **JavaScript**).

    The output will list the files being written to disk. You'll see **host.json** and **local.settings.json**, as well as a few other files:
    - **package.json** is a JavaScript-specific file that keeps track of any packages you install and use within your code.
    - **.gitignore** and **extensions.json** are configuration files that can be used by the Git version control tool and Visual Studio Code, respectively, but you can ignore them for now.

## Create an HTTP-triggered function

Let's create our function!

1. In Cloud Shell, run `func new` to start the function creation wizard.

    ```bash
    func new
    ```

    Remember, you are running `func new` in the `loan-wizard` project folder you just created, which is important.

1. When prompted to select a template, enter **8** (for **HTTP trigger**).

1. When prompted to provide a function name for HTTP trigger, enter **simple-interest**.

1. Open the Cloud Shell editor by running the following command.

    ```bash
    code .
    ```

    ![Screenshot showing the simple-interest folder with the function.json file open in Cloud Shell code editor.](../media/3-functions-project-view.png)

    The wizard has created a new folder in our functions project called **simple-interest**, and created two files **index.js** and **function.json**, both with default content. Take a moment now to explore the project files using the editor. The screenshot above shows the expanded folder with the **function.json** file open in the editor.
   
## Implement the simple-interest function

The default function implementation that Core Tools created for us in **index.js** looks for an input called `name` in the query string or the body of the inbound HTTP request and returns the string `Hello, [name]`. This is a good illustration of how to use an HTTP trigger, but we want to replace that code with code that calculates simple interest from three input parameters.

1. In the editor's **FILES** pane, expand the `simple-interest` folder, and select `index.js` to open the file in the editor.

1. Replace the full contents of `index.js` with the following code:

    ```javascript
    module.exports = async function(context, req) {
      // Try to grab principal, rate, and term from the query string and
      // parse them as numbers
      const principal = parseFloat(req.query.principal);
      const rate = parseFloat(req.query.rate);
      const term = parseFloat(req.query.term);

      if ([principal, rate, term].some(isNaN)) {
        // If any empty or non-numeric values, return a 400 response with an
        // error message
        context.res = {
          status: 400,
          body: "Please supply principal, rate and term in the query string"
        };
      } else {
        // Otherwise set the response body to the product of the three values
        context.res = { body: principal * rate * term };
      }
    };
    ```

    This script looks for parameters named `principal`, `rate`, and `term` in the query string of the HTTP request, and returns the result of the simple interest calculation (principal * rate * term).

1. Save the file by pressing <kbd>Ctrl+S</kbd>, and close the editor by pressing <kbd>Ctrl+Q</kbd>.

## Run the function locally

To run our new function locally and try it out, we'll use `func start` to start the Function Runtime.

1. Run `func start` to start the local Functions host. As with `func new`, Cloud Shell should still be in the `loan-wizard` directory.

    ```bash
    func start
    ```

    Near the end of the output, you'll see a message that lists `Functions: simple-interest:` is available as a GET or POST HTTP request `http://localhost:7071/api/simple-interest`. 
    
    > [!NOTE]
    > If you see an error message, press <kbd>Ctrl+C</kbd> to stop the host, and make sure that the contents of your index.js file are the same as the sample above.

    This localhost URL is not published to the web, it's only accessible from tools running in your Cloud Shell session. 
    
    We're going to use a command line tool, `curl`, to interact with our function. To do that, we need to restart the Functions host as a background process so we can use the command line while it's running. If you were using Core Tools from your own computer, you probably wouldn't need to restart the host--you could use `curl` from a second terminal window, and the output produced by Core Tools would appear in real time in the first terminal window. In Cloud Shell, we are limited to a single terminal, so this technique is necessary for this tutorial.

1. Press <kbd>Ctrl+C</kbd> to stop the Functions host. The Cloud Shell should respond **Application is shutting down**.

1. Run the following command to start the Functions host silently in the background.

    ```bash
    func start &> ~/output.txt &
    ```

    You can ignore the output of this command. The Functions host is now running exactly as before, but its output is being sent to the file `~/output.txt`, and we can continue to use the command line while it's running.

1. Run the following command to send an HTTP GET request to our locally running function.

    ```bash
    curl "http://localhost:7071/api/simple-interest" -w "\n"
    ```

    The output, `Please supply principal, rate and term in the query string`, indicates that our function was successfully invoked and is able to return a response to us, but we aren't calling it as intended. We need to provide the parameters as part of the HTTP request.

1. Invoke the function again, this time providing a value for the each of the query string parameters.

    ```bash
    curl "http://localhost:7071/api/simple-interest?principal=5000&rate=.035&term=36" -w "\n"
    ```

    This time, the output is `6300`. Our function is working as expected!

1. Stop the background Functions host by running the `pkill` utility.

    ```bash
    pkill func
    ```

    Press <kbd>Enter</kbd> a second time to see the confirmation that the host has stopped:  `[1]+  Done func start &> ~/output.txt`.

1. Enter the following command to view the output log in the editor.

    ```bash
    code ~/output.txt
    ```

    The top 9 lines or so of the file will be the same as when you ran `func start` the first time. After that, you'll see a set of log entries, each starting with a timestamp for each time you called the function with `curl`, looking like this.

    ```output
    Executing HTTP request: {
      "requestId": "91a3875c-d0f1-4290-a3a6-f9c3afed4c7a",
      "method": "GET",
      "uri": "/api/simple-interest"
    }
    Executing 'Functions.simple-interest' (Reason='This function was programmatically called via the host APIs.',Id=556934d5-2643-493f-aa2a-7b5abb3eda8e)
    Executed 'Functions.simple-interest' (Succeeded, Id=556934d5-2643-493f-aa2a-7b5abb3eda8e)
    Executed HTTP request: {
      "requestId": "91a3875c-d0f1-4290-a3a6-f9c3afed4c7a",
      "method": "GET",
      "uri": "/api/simple-interest",
      "identities": [
        {
          "type": "WebJobsAuthLevel",
          "level": "Admin"
        }
      ],
      "status": 200,
      "duration": 793
    }
    ```

1. Close the editor by pressing <kbd>Ctrl+Q</kbd>.
