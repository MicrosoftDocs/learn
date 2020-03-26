Tailwind Traders had planned on building a traditional API, but you deftly pointed out that Serverless is perfect for APIs. It can also be done without disturbing their existing codebase. You're already doing so well. You have a long career in online hardware sales in your future.

It's time to deliver on those lofty buzzwords. Now you need to create a new project in Azure Functions that will be the HTTP API for the "Products Manager" application. That means creating the Azure Functions project, complete with all of the endpoints that the Products Manager application is going to need to be able to create, read, update, and delete products.

## Create a new Azure Functions project

1. Open the Command Palette.

1. Type "create new project".

1. Select "Azure Functions: Create New Project".

1. Select the "api" folder

1. When prompted, enter the following values

   | Name          | Value        |
   | ------------- | ------------ |
   | Language      | TypeScript   |
   | Template      | HTTP trigger |
   | Name          | GetProducts  |
   | Authorization | Function     |

The "api" folder in VS Code will now contain a new Azure Functions project along with a new function called "GetProducts".

## Create the Create, Update, and Delete functions

### Create the CreateProduct function

1. Open the Command Palette in VS Code.

1. Type "create function".

1. Select "Azure Functions: Create Function".

1. Select "api".

1. When prompted, enter the following values

   | Name          | Value         |
   | ------------- | ------------- |
   | Template      | HTTP trigger  |
   | Name          | CreateProduct |
   | Authorization | Function      |

### Create the UpdateProduct function

1. Open the Command Palette in VS Code.

1. Type "create function".

1. Select "Azure Functions: Create Function".

1. Select "api".

1. When prompted, enter the following values

   | Name          | Value         |
   | ------------- | ------------- |
   | Template      | HTTP trigger  |
   | Name          | UpdateProduct |
   | Authorization | Function      |

### Create the DeleteProduct function

1. Open the Command Palette in VS Code.

1. Type "create function".

1. Select "Azure Functions: Create Function".

1. Select "api".

1. When prompted, enter the following values

   | Name          | Value         |
   | ------------- | ------------- |
   | Template      | HTTP trigger  |
   | Name          | DeleteProduct |
   | Authorization | Function      |

## Run the project

Azure Functions projects can be run and debugged locally from within VS Code.

1. Open the Command Palette.

1. Type "debug select",

1. Select "Debug: Select and Start Debugging".
   `
1. Select "Attach to Node Functions".

   The Azure Functions project will launch. Notice that the terminal shows you what URL the function is running on.

   :::image type="content" source="../media/functions-in-terminal.png" alt-text="Screenshot of the VS Code integrated terminal showing functions URLs." loc-scope="other"::: <!-- no-loc -->

1. Press <kbd>Cmd/Ctrl</kbd> and click on the "GetProducts" link to open it in a browser.

   :::image type="content" source="../media/get-products-page.png" alt-text="Screenshot of a web browser showing the execution result of the new HTTP function." loc-scope="other"::: <!-- no-loc -->

1. The default function template takes in a name parameter and returns a greeting. To pass in the name parameter, modify the url to pass in a query string parameter called "name"

   ```html
   http://localhost:7071/api/GetProducts?name=John%20Jacob%20Jingleheimer%20Schmidt
   ```

   > [!NOTE]
   > Note that your name may not _actually_ be "John Jacob Jingleheimer Schmidt. Feel free to use your own name if it's different than that.

    :::image type="content" source="../media/hello-message.png" alt-text="Screenshot of a web browser displaying the text "Hello John Jacob Jingleheimer Schmidt"." loc-scope="other"::: <!-- no-loc -->

What a productive 8 minutes! You've got all of the endpoints created and running in Azure Functions. Now, you can sit back and REST - Representational State Transfer Protocol. What is that? I'm glad you asked, because it's going to make your API the envy of applications everywhere. In the next section, we'll talk about why.
