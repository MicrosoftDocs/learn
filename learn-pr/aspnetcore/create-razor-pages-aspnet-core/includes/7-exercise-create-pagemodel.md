You've added a product creation page, so it's time to test and run the completed project.

## Compile, deploy, and test the updated project

### Compile the project

Run the following command:

```dotnetcli
dotnet build
```

The preceding command compiles the project with your latest saved changes.

### Redeploy the app to Azure App Service

Run the following command in the command shell:

```azurecli
az webapp up
```

The preceding command updates the web app that was previously deployed to Azure App Service. Be patient, as it may take a few minutes to complete. Once your changes have been deployed, a variation of the following output appears:

```console
You can launch the app at http://webapp<random ID number here>.azurewebsites.net
```

## Tour the app

1. Return to the web app in your browser window.

1. Select the **:::no-loc text="Products Admin":::** link.

    Notice the presence of the new **:::no-loc text="Add Product":::** link:

    :::image type="content" source="../media/8-deploy-test/products-admin-updated.png" alt-text="Screenshot of the updated products administration page." border="true" lightbox="../media/8-deploy-test/products-admin-updated.png":::

1. Select the **:::no-loc text="Add Product":::** link:

    Your new *:::no-loc text="Create":::* page displays:

    :::image type="content" source="../media/8-deploy-test/product-creation-page.png" alt-text="Screenshot of the product creation page." border="true" lightbox="../media/8-deploy-test/product-creation-page.png":::

1. Leave the **:::no-loc text="Name":::** text box empty. Enter `asdf` in the **:::no-loc text="Price":::** text box. Move focus away from the **:::no-loc text="Price":::** text box.

    Client-side validation occurs. A validation message appears next to the text box because the provided value isn't numeric:

    :::image type="content" source="../media/8-deploy-test/product-creation-client-validation.png" alt-text="Screenshot of a client-side validation message on the product creation form." border="true" lightbox="../media/8-deploy-test/product-creation-client-validation.png":::

1. Leave the **:::no-loc text="Name":::** text box empty. Enter `0` in the **:::no-loc text="Price":::** text box. Select the **:::no-loc text="Save":::** button.

    Server-side validation occurs. Validation messages appear next to the text boxes because the provided values are invalid:

    :::image type="content" source="../media/8-deploy-test/product-creation-server-validation.png" alt-text="Screenshot of the product creation form validation messages." border="true" lightbox="../media/8-deploy-test/product-creation-server-validation.png":::

1. Enter any product name in the **:::no-loc text="Name":::** text box. Enter `30` in the **:::no-loc text="Price":::** text box. Select the **:::no-loc text="Save":::** button.

    The form fields passed validation. For that reason:

    * The form data is sent to the web API via an HTTP POST request.
    * You're returned to the products page, which displays the new product in the list.

1. When you're finished testing your app, close the browser.
