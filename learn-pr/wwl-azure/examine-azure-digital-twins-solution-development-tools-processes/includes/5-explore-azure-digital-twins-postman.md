The Azure Digital Twins APIs are organized in two sections, one for managing the Azure Digital Twins instance (control plane) and the other for managing the elements contained within the instance (data plane).

:::image type="content" source="../media/m11-l03-adt-rest-api-reference-c858f7f2.png" alt-text="Screenshot that shows the Azure Digital Twins APIs for the Azure Digital Twins control plan and data plane.":::


## Azure Digital Twins API reference documentation

In addition to a basic description of the control plane and data plane APIs, the reference documentation provides detailed information describing headers, responses, security, and examples for each API.

The control plane APIs (used to manage your Azure Digital Twins instance) include the following categories:

 -  Check Name Availability.
 -  Digital Twins Instance.
 -  Endpoints.
 -  Operations.
 -  Private Endpoints.

The data plane APIs (used to manage the elements within your Azure Digital Twins instance) include the following categories:

 -  Event Routes.
 -  Models.
 -  Query.
 -  Twins.

You can find the Azure Digital Twins REST API reference documentation at the following location: [Azure Digital Twins REST API reference](/rest/api/azure-digitaltwins/)

## Examine the REST APIs with Postman

Postman is a REST testing tool that provides key HTTP request functionalities in a desktop and plugin-based GUI. You can use Postman to craft HTTP requests and submit them to the Azure Digital Twins REST APIs.

> [!NOTE]
> You must configure the Postman REST client to interact with the Azure Digital Twins APIs before you can test the APIs. This configuration involves the following steps: Use Azure CLI to get a bearer token that you will use to make API requests in Postman; Set up a Postman collection and configure the Postman REST client to use your bearer token to authenticate.

> [!NOTE]
> If you need to download the Postman app, navigate to [www.getpostman.com/apps](http://www.getpostman.com/apps) and follow the prompts to download the app.

### Get bearer token

Postman uses a bearer token to authorize requests against the Azure Digital Twins APIs. You will apply the token when configuring Postman.

The following example uses the Azure CLI to obtain a token.

1.  Open a command prompt that you can use for Azure CLI commands (a local command prompt window is used here but you could also use the Azure Cloud Shell)
2.  Use the `az login` command and verify that you are logged into Azure with the appropriate credentials (same account that you used to create your Azure Digital Twins instance)
3.  Use the `az account get-access-token` command, passing in the resource ID for the Azure Digital Twins service endpoint (you specify a static value of 0b07f429-9f4b-4714-9392-cc5e8e80c8b0), to get a bearer token with access to the Azure Digital Twins service:
    
    ```
    az account get-access-token --resource 0b07f429-9f4b-4714-9392-cc5e8e80c8b0
    
    ```

    :::image type="content" source="../media/m11-l03-adt-postman-get-bearer-token-26342a1e.png" alt-text="Screenshot that shows using an Azure CLI command to obtain a bearer token that can be used to assess the Azure Digital Twins APIs.":::


> [!IMPORTANT]
> The bearer token is valid for at least five minutes and a maximum of 60 minutes. If you run out of time allotted for the current token, you can repeat the steps in this section to get a new one. You may need to refresh your token when evaluating the Azure Digital Twins APIs in Postman.

### Configure a request collection

Requests in Postman are saved in collections (groups of requests). When you create a collection to group your requests, you can apply common settings to many requests at once. This feature can greatly simplify authorization if you plan to create more than one request against the Azure Digital Twins APIs, as you only have to configure authentication once for the entire collection.

When working with Azure Digital Twins, you can get started by importing a pre-built collection of all the Azure Digital Twins requests. You may want to use this approach if you're exploring the APIs and want to quickly set up a project with request examples.

### Import collection of Azure Digital Twins APIs

A quick way to get started with Azure Digital Twins in Postman is to import a pre-built collection of requests for the Azure Digital Twins APIs. The first step in importing the API set is to download a collection. You can choose between pre-built collections for either the data plane or control plane.

> [!NOTE]
> The remainder of this section focuses on importing a data plane collection.

#### Download the collection file

There are currently two Azure Digital Twins data plane collections available for you to choose from:

 -  Azure Digital Twins Postman Collection: This collection provides a simple getting started experience for Azure Digital Twins in Postman. The requests include sample data, so you can run them with minimal edits required. Choose this collection if you want a digestible set of key API requests containing sample information.
    
     -  To find the collection, navigate to the repo link [https://github.com/microsoft/azure-digital-twins-postman-samples](https://github.com/microsoft/azure-digital-twins-postman-samples) and open the file named postman\_collection.json.
 -  Azure Digital Twins data plane Swagger: This repo contains the complete Swagger file for the Azure Digital Twins API set, which can be downloaded and imported to Postman as a collection. This file will provide a comprehensive set of every API request, but with empty data bodies rather than sample data. Choose this collection if you want to have access to every API call and fill in all the data yourself.
    
     -  To find the collection, navigate to the repo link [https://github.com/Azure/azure-rest-api-specs/tree/master/specification/digitaltwins/data-plane/Microsoft.DigitalTwins](https://github.com/Azure/azure-rest-api-specs/tree/master/specification/digitaltwins/data-plane/Microsoft.DigitalTwins) and choose the folder for the latest spec version. From here, open the file called digitaltwins.json.

Use the following steps to download a collection to your computer, which enables you to import it into Postman.

1.  Use the links in the previous paragraph to open the collection file in GitHub in your browser.
2.  On the GitHub project page, select the Raw button to open the raw text of the file.
3.  Copy the text from the window, and paste it into a new file on your machine.
4.  Save the file with a .json extension (the file name can be whatever you want, as long as you can remember it to find the file later).

#### Import the collection

Next, import the collection into Postman.

1.  From the main Postman window, select the Import button.
2.  In the Import window that follows, select Upload Files and navigate to the collection file on your machine that you created earlier. Select Open.
3.  Select the Import button to confirm.

The newly imported collection can now be seen from your main Postman view, in the Collections tab.

#### Configure authorization for the collection

Next, edit the collection you've created to configure some access details. Highlight the collection you've created and select the View more actions icon to pull up a menu. Select Edit.

Follow these steps to add a bearer token to the collection for authorization. Use the token value that you gathered in the Get bearer token section. You will be authorized for all API requests in your collection.

1.  In the edit dialog for your collection, make sure you're on the Authorization tab.
2.  Set the Type to OAuth 2.0, paste your access token into the Access Token box, and select Save.

When working with a data plane collection, you can help the collection connect easily to your Azure Digital Twins resources by setting some variables provided with the collections. When many requests in a collection require the same value (like the host name of your Azure Digital Twins instance), you can store the value in a variable that applies to every request in the collection. Both of the downloadable collections for Azure Digital Twins come with pre-created variables that you can set at the collection level.

1.  Still in the edit dialog for your collection, move to the Variables tab.
2.  Use your instance's host name from the Prerequisites section to set the CURRENT VALUE field of the relevant variable. Select Save.
3.  If your collection has other variables, fill and save those values as well.

When you're finished with these steps, you're done configuring the collection. You can close the editing tab for the collection if you want.

### Explore requests in Postman

You can explore the requests inside the Azure Digital Twins API collection by expanding the collection and viewing the pre-created requests (sorted by category of operation).

Different requests require different information about your instance and its data. To see all the information required to craft a particular request, look up the request details in the Azure Digital Twins REST API reference documentation.

You can edit the details of a request in the Postman collection using these steps:

1.  Select it from the list to pull up its editable details.
2.  Fill in values for the variables listed in the Params tab under Path Variables.
3.  Provide any necessary Headers or Body details in the respective tabs.

Once all the required details are provided, you can run the request with the Send button.
