<!-- See https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

<!-- The titles of exercise units specified in the YAML should be prefixed with "Exercise - " -->

<!-- Keep module prerequisites in mind when writing instructions for readers. Don't spend lots of words on instructions about steps that they should generally already know how to do. Focus on the configuration options and items they need to select. -->

<!-- The CLI is more time- and space-efficient for tasks that are not directly relevant to the module. For example, if your exercise requires creating an App Service web app to host an app, but the module isn't directly about creating App Service instances, strongly consider using the CLI. -->

<!-- If you have sample code, include it with the content. Assume that it will end up in a public git repo for consumption during the exercise (and write your instructions with that assumption, but leave a TODO for the repo name). The Learn team will work with you to get it into the right place.-->

<!-- Exercises should generally make use of the sandbox. See the following:
  - https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-enable-azure-sandbox?branch=master
  - https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-add-embedded-interactivity?branch=master

    The most important things to keep in mind are:
  - Include the proper YAML markup for the unit
  - Don't ask the user to create a resource group; use <rgn>[Sandbox resource group]</rgn> to specify the sandbox resource group name (search the repo for "<rgn>" for examples)
  - Use [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to link to the portal
  - Use the appropriate region includes (search the repo for "azure-sandbox-regions" for examples. There are four includes for different situations - the "friendly" ones are for activities in the portal as opposed to the CLI, and the "first mention" includes are to be used at the first mention of location specification in a module exercise)
  - There's also an include (azure-sandbox-activate.md) that should precede the first interactive directions that require the sandbox to have been activated
-->

<!-- Keep bulleted/numbered lists to seven items max. Break them up into groups with headers if necessary -->



In this Exercise, you'll use the Cloud Shell code editor to create a .NET Core Web API and deploy it to Azure. This Api will then be imported into Azure APIM and a caching policy applied to it.


[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a Web API in Azure Apps Service

Start by creating a new Web API app in Azure Apps Service. You'll use this resource to host a test API, which you'll call from the Logic App later:

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. In the portal, select **Create a resource > Web > API App**.
1. In the **API App** window, enter the following settings, and then click **Create**:

    | Setting | Value |
    | --- | --- |
    | App name | Choose a unique name. Make a note of it, you'll need it later on. |
    | Subscription | *Concierge Subscription* |
    | Resource group | Select *Use existing* and choose *<rgn>Sandbox resource group </rgn>* |
    | App Service plan/Location | Leave default |
    | Application Insights | Disabled |
    | | |

    ![Creating a Web API in the Azure portal](../media/-create-web-api.png)

## Configure git deployment for the API app

We will use the `git` tool to deploy our Web API code. To configure the API app to support `git`:

1. When the API App has been created, select **All resources** and then click the API App.
1. In the **App Service** response, under **Deployment** click **Deployment Center**.

    ![Configure deployment for an API App](../media/3-configure-deployment.png)

1. Click **Local Git** and then click **Continue**.
1. Click **App Service Kudu build server**, click **Continue**, and then click **Finish**.
1. Click **Deployment Credentials** and then click the **User Credentials** tab.
1. In the **Password** and **Confirm Password** textboxes, type **Pa$$w0rd** and then click **Save Credentials**.

## Configure the git command

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

Before you can deploy the Web API, you must configure the **git** tool with your name and email address:

1. In the Cloud Shell on the right, run the following command to set your full name to be recorded in newly created commits.

    ```bash
    git config --global user.name "Your Name"
    ```

1. In the Cloud Shell on the right, run the following command to set your email to be recorded in newly created commits.

    ```bash
    git config --global user.email "Your Email Address"
    ```

## Clone a Web API project

We'll use `git` to clone a Web API project. This Web API includes a frame price calculation method That includes 3 parameters for use with the caching exercise We'll also configure `git` to deploy code to Azure:

1. In the Cloud Shell on the right, to create a Web API project and add the Swagger tool to it, run the following commands:

    <!-- TODO: when the GitHub repo is ready for this module, add its URL to the git clone command here. The sample Web API is in the code folder. -->

    ```bash
    git clone **GitHub Repo URL**
    cd PictureFramingAPI
    ```

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the API App.
1. On the **Overview** response, to the right of the **Git clone URL** field, select **Click to copy**.

    ![Obtain the git clone URL from the portal](../media/3-obtain-git-url.png)

1. In the Cloud Shell, run the following command, pasting in the URL that you copied:

    ```bash
    git remote add production **git URL**
    ```

    This command adds a remote named production for the repository at the URL you gave.

## Deploy the Web API

Now, you can deploy the Web API to Azure:

1. In the Cloud Shell, run the following commands to commit your code:

    ```bash
    git add .
    git commit -m "Version 1 completed"
    ```

1. To deploy the Web API, run the following command, and enter a password. Remember the password you chose,  because you'll need it later.

    ```bash
    git push --set-upstream production master
    ```

## Test the deployed Web API

Now the API is completed and deployed, let's test it. We can do that by submitting a GET request in the browser and also by checking the OpenAPI definition:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the API App.
1. On the **Overview** response, select **Browse**. The browser displays the home response for the API, which is blank.
1. In the **Address** bar, append the URL with **/api/values/6/7/uk**. The browser displays a result.
1. In the **Address** bar, replace **/api/values/6/7** with **/swagger**. The browser displays the Swagger UI.

## Save the OpenAPI definition

1. Locate the file via the link on the swagger interface

1. Copy the contents and save to a new json file.

## Create a new Azure APIM instance

1. This will deploy a lot faster if the cosumption pricing tier is chosen for deployment.

<!--The preview seems to have caching disabled so we are using the standard tier-->

1. This is only available as a preview in the following regions

    -  westus
    -  northcentralus
    -  westeurope
    - northeurope
    -  southeastasia
    -  australiaeast

1. After creation pin this to the dashboard


## Import the API into Azure APIM

![Select your API](../media/chooseapi.png)

1. Select OpenAPI

1. Complete the Wizard and press create


![Complete Wizard](../media/createfomopenapi.png)


1. Add the Web Service URL

![Add website URL](../media/settings.png)

You are now ready to run your managed API  in Test.


1. Run with the following parameters.

1. Height 80

1. Width 100

1. Region Code UK

1. Note the result and run again with the same parameters, the date time will increment as this response is not being cached

This time lets add a policy to control the caching of the  GetQuery Operation.

1. Select the GetQuery operation and choose Inbound Processing

2. Select cache responses and enter a value of 30 to cache the response for 30 seconds.

3. Run in test with the same parameters as before. Note the date time will remain the same until the cache has reached it expiry value.


