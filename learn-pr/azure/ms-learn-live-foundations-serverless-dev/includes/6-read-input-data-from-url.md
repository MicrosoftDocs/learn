## 💻 Exercise - Use the context object to read input data from the URL route

The context object can be used for writing logs, reading data and setting outputs.

## Objective

Process input data from the URL path using the context object.

## Instructions

To access the product ID, provided as part of the URL path, we can use the `context` object.
It contains a property called `bindingData` where we can access our route information.

1. Using Visual Studio Code, navigate to the folder `GetProduct`
1. Open the file `index.ts`
1. The ID of the product to be read is part of the URL and can be accessed as `productId` - this matches the placeholder you added to function.json.

Add the following code:

`const productId = req.params.productId;`

You can change the output of the function to return the product ID and verify everything works by building the project and navigating to the URL using your browser.
