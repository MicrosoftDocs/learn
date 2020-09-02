It's always refreshing to see something in action, and with functions, we can do this very quickly. Let's do a little exercise together: using only 10 clicks, you'll be able to execute your very first function in the Azure portal!

## Objective

Use the Learn Live Sandbox to create a function that says "hello" in
response to an HTTP GET request.

## Instructions

> [!IMPORTANT]
> Activate the Azure Sandbox to execute the lab instructions in a free subscription and open [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)

### 1. Create a Function App

Create a new function app in the sandbox environment - the quickest way to do so is to click on "Create a resource" and search for "Function app".

> [!TIP]
> For this demonstration, make sure you don't create a Linux server. Linux servers do not allow for the function editing within the portal.

Use the following credentials:
- Function App Name: Use a globally unique name (e.g., your initials + "functiontest" + a numeric value)
- Publish: Code
- Runtime stack: Node.js
- Version: 12
- Region: Central US
- Click "Review + create"
- Click "Create" - Wait for creations to complete and "Go to resource" when done

Think of the Function app as a workspace that contains our functions.

### 2. Add a Function

Let's add a function you can call via a URL

- In the menu on the left select "Functions"
- Click "+Add" in the top menu to add a new function
- From the list of templates select "HTTP Trigger"
- Click "Create Function"

Wait for the function to be created. This should only take some seconds.

To see the source code of the function, select "Code + Test" in the left menu. In our case, this is JavaScript, but we could have picked other languages, like C#. We can modify the source code directly in the browser, but for now, let's execute the function.

### 3. Execute the Function

We can run the function in the editor or get its URL because we chose to create something that is callable over HTTP.

- In the top menu, click "Get function URL"
- Click "Copy" to get the URL into the clipboard.
- Open a new browser tab and paste the URL - Notice how the URL starts with the function name we specified earlier.
- Notice the output it has generated.
- Add "&name=YOUR_NAME" to the URL and hit enter.
- Watch it output "Hello YOUR_NAME"

### 4. Modify the function

- Switch back to the editor
- Change the line that contains "Hello " to "Welcome to Learn Live, dear "
- Click "Save"
- Switch back to the tab with the function URL and refresh
- The output will be "Welcome to Microsoft Learn, dear YOUR_NAME"
