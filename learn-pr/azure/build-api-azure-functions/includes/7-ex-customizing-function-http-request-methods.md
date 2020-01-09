As you're building out the API for the Product Manager application, you'll need to specify different HTTP request methods for your endpoints depending on what that endpoint does. In this exercise, you'll learn how to modify which HTTP request methods your Azure Functions respond to. You'll also learn how to compose and execute HTTP requests from the command line using the built-in tools on your operating system.

## Modify the methods for the GetProducts function

1. Open the `api/GetProducts/function.json` file.

1. Find the line that contains the property "methods"

1. Modify that line by adding "put" to the "methods" array.

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["get", "post", "put"]
       },
       {
         "type": "http",
         "direction": "out",
         "name": "res"
       }
     ],
     "scriptFile": "../dist/GetProducts/index.js"
   }
   ```

1. Start the project by pressing F5.

1. Open a new Bash or Powershell instance from VS Code by pressing <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>

1. Select "api"

1. Type the following command to perform a GET request to the "GetProducts" function

   ::: zone pivot="windows"

   invoke-webrequest http://localhost:7071/api/GetProducts

   ::: zone-end

   ::: zone pivot="linux"

   curl http://localhost:7071/api/GetProducts

   ::: zone-end
