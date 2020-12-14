In the preceding exercise, we deployed an app using a basic Azure Resource Manager template. The template was inflexible in that everything was hard-coded. In particular, to change the name of the workflow or the location to which the app was deployed, you would have to edit the template itself. In scenarios where you are doing multiple deployments in a scripted environment, editing the template by hand becomes cumbersome. A better approach is to supply values as parameters to customize resource deployment. 

## Update our template to use template parameters

1. Make a copy of the basic template we used in the preceding exercise with the following `cp` command.

    ```azurecli
    cp basic-template.json template-with-params.json
    ```

1. To edit the template, open it in the built-in editor with the following `code` command.

    ```azurecli
    code template-with-params.json
    ```

    The first thing we'll do is add parameters so we can easily customize the name of our app and the location where it is run.

1. Replace the `parameters` section of the template with the following code to add two new parameters, `logicAppName` and `location` as shown in the following snippet. 

    [!code-json[](../code/basic-template-with-params/template.json?range=4-18)]

    Both parameters are strings. We don't supply a default value for the `logicAppName` parameter, which means supply one at deployment time. In contrast, the `location` is optional since we supply a default valuer.

    The default value for the `location` parameter is the location of the resource group into which the app is being deployed. We get that value by referencing the *location* property from the resource group returned by the `resourceGroup()` template function. Expressions start and end with brackets: `[` and `]`, respectively. The value of the expression is evaluated when the template is deployed. An expression can return a string, integer, boolean, array, or object. The maximum number of parameters you can define in a template is 256. 
    Now that we've defined our two new parameters, let's use them in the template by replacing hard-coded values with references to the new parameters.

1. Replace the `name` and `location` fields in the resources section of the template to use our new parameters as shown in the following snippet.

    [!code-json[](../code/basic-template-with-params/template.json?range=24-25)]

1. Replace the `outputs` section at the bottom of the template with the following code. We are updating the value of the `logicAppUrl` template variable to also use the `logicAppName` parameter as shown in the following snippet.

    [!code-json[](../code/basic-template-with-params/template.json?range=60-65)]

1. Save all changes to **template-with-params.json**.


## Deploy our logic app using the parameterized template

There are two ways to supply parameters to our template during deployment using the`--parameters` flag in the `az deployment group create` command. We can pass in a URI of a remote parameters file, or the name of a local file. Let's use a local file.

### Create a parameters JSON file

1. Create a new file called `params.json` in the built-in code editor with the following command.

    ```azurecli
    code params.json
    ```

1. Paste the following JSON into **params.json** and save your changes.
    [!code-json[](../code/basic-template-with-params/params.json?range=1-5)]

### Validate our template

1. From the Cloud Shell, run `az deployment group validate` to validate the template.

    ```azurecli
    az deployment group validate \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-file template-with-params.json \
    --parameters @params.json
    ```

    The `--template-file` argument points to the local template. The template's filename is **template-with-params.json**. 

    You see a large JSON block as output, which tells you that the template passed validation.

    Azure Resource Manager fills in the template parameters and checks whether the template would successfully run in your subscription.

    If validation failed, you would see a detailed description of the failure in the output.

## Deploy template with parameters from a local file
 
1. Run the following command in the Cloud Shell to deploy the logic app with the name of the app taken from the **params.json** file. The `location` parameter is not set in the params.json file, so the default is used.

    ```azurecli
    az deployment group create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-file template-with-params.json \
    --parameters @params.json
    ```

    Deployment will take a few seconds and you can watch the progress in the Cloud Shell command line. When deployment is finished, you should see `provisioningState` in the JSON result with the value `Succeeded`.

1. To see the app in action, find the **logicAppUrl** value in the JSON result. Select the URL and paste it into a new browser window. The page will display the *Hello Logic Apps Template!* message.


## Deploy template with parameters from the command line

Instead of editing a parameters file every time we want to deploy from the command line, we can supply the parameters in a JSON string on the command line.

1. Run the following command in the Cloud Shell to deploy the logic app with the name of the app and its location fed in as a JSON string on the command line.

    ```azurecli
    az deployment group create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-file template-with-params.json \
    --parameters '{ "logicAppName": {"value":"MyLogicApp2"}, "location": {"value":"East US"}}'
    ```
    
    Deployment will take a few seconds and you can watch the progress in the Cloud Shell command line. When deployment is finished, you should see `provisioningState` in the JSON result with the value `Succeeded`.

1. To see the app in action, find the **logicAppUrl** value in the JSON result. Select the URL and paste it into a new browser window. The page will display the *Hello Logic Apps Template!* message.

1. Run the following command to list all Logic Apps workflows we've deployed so far.

    ```azurecli
    az resource list \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --resource-type Microsoft.Logic/workflows \
    --query [*].[name,location] --output tsv
    ```

    This command will list the three Logic Apps workflows we've deployed so far, all from a template.

## Update the app action in the Azure Resource Manager template

Let's now turn our attention to making our app do a little more than just sending back a static message to us. We'll keep the app as an HTTP-triggered workflow and it will still return an HTTP response. But let's pass in some values with the request, and have the app do a calculation for us. We'll do a simple area calculation. Assuming the inputs we pass in are height and width of a rectangle, we'll return the area. We'll then deploy the new app and see it in action.

1. Open **template-with-params.json** in the built-in editor by running the following command in the Cloud Shell. 

    ```azurecli
    code template-with-params.json
    ```

1. Replace the `relativePath` field to the **inputs** section of our HTTP request trigger as shown in the following snippet. 

    [!code-json[](../code/basic-template-with-params/template.json?range=36-40)]

    The `relativePath` entry specifies the parameters that we want our HTTP endpoint URL to accept. In this case, we define two parameters, *width* and *height*. We'll use the values of these parameters to calculate an area and return the result. 

1. Update the body of the Response action with the following line.

    [!code-json[](../code/basic-template-with-params/template.json?range=49-49)]

    Our updated response does the following:

    - Prints out the name of the logic app. It makes a call to the `workflow()` function to return information about the workflow, and from that we reference the name property.
    - It returns the product (`mul()` function) of the integer equivalents (`int()` conversion function) of the height and width string values of the URL parameters.

1. Save all changes to **template-with-params.json**.

1. Validate our template after these changes with the `az deployment group validate` command in the Cloud Shell. We set the name of the app in this instance to *CalculateArea* using an inline parameter. 

    ```azurecli
    az deployment group validate \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-file template-with-params.json \
    --parameters '{ "logicAppName": {"value":"CalculateArea"}}'
    ```

1. Run the following command to deploy our changes to a logic app named **CalculateArea**. We will omit a value for the `location` parameter and just use the default.

    ```azurecli
    az deployment group create \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --template-file template-with-params.json \
    --parameters '{ "logicAppName": {"value":"CalculateArea"}}'
    ```

    Deployment will take a few seconds and you can watch the progress in the Cloud Shell command line. When deployment is finished, you should see `provisioningState` in the JSON result with the value `Succeeded`.

1. To see the app in action, find the **logicAppUrl** value in the JSON result. Select the URL and paste it into a new browser window.

1. Update the URL in the browser, changing `/triggers/manual/paths/invoke?api` to `/triggers/manual/paths/invoke/{width}/{height}?api`, where **{width}** and **{height}** are integer values for the width and height of the area we want to calculate. For example, `/triggers/manual/paths/invoke/6/7?api`. The response from the app will list the name of the workflow and the calculated area, as shown in the following screenshot.

    :::image type="content" source="../media/calculate-area-response.png" alt-text="Web browser displaying response from our app called calculate area." loc-scope="other"::: <!-- no-loc -->

1. Run the following command to list all Logic Apps workflows we've deployed so far. 

    ```azurecli
    az resource list \
    --resource-group <rgn>[sandbox resource group name]</rgn> \
    --resource-type Microsoft.Logic/workflows \
    --query [*].[name,location] --output tsv
    ```

In this exercise, we introduced more flexibility to our template with parameters. We supplied those parameters on the command line and using a local file. We also updated the action that our simple workflow executes, by directly changing the `body` of the response we send back.

You can download the parameters and template files from GitHub with the following `curl` commands in the Cloud Shell.

  ```azurecli
    curl https://github.com/MicrosoftDocs/mslearn-logic-apps-and-arm-templates/blob/master/calculate-area/params.json > params-final.json
    curl https://github.com/MicrosoftDocs/mslearn-logic-apps-and-arm-templates/blob/master/calculate-area/template.json > template-with-params-final.json
  ```
