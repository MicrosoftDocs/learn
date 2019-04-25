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
Companies that use Azure API Management to host API can modify their behavior, without rewriting code, by using policies.

Suppose you have planned to implement caching for the Board Pricing API. You want to add the API to API Management and write the necessary policies.

In this exercise, you'll import an API into Azure API Management and add a caching policy to it.

[!include[](../../../includes/azure-sandbox-activate.md)]

[!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

## Create a Web API in Azure Apps Service

Start by creating a new Web API app in Azure Apps Service. You'll use this resource to host the Board Pricing API:

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. In the portal, select **Create a resource > Web > API App**.
1. In the **API App** window, enter the following settings, and then click **Create**:

    | Setting | Value |
    | --- | --- |
    | App name | Choose a unique name. Make a note of it, you'll need it later on. |
    | Subscription | *Concierge Subscription* |
    | Resource group | Select *Use existing* and choose *<rgn>Sandbox resource group</rgn>* |
    | App Service plan/Location | Leave default |
    | Application Insights | Disabled |
    | | |

    ![Creating a Web API in the Azure portal](../media/5-create-api-azure-portal.png)

## Configure git deployment for the API app

We will use the `git` tool to deploy our Web API code. This relies on the Kudu build server. To configure the API app to support Kudu:

1. When the API App has been created, select **All resources** and then click the API App.
1. In the **App Service** resource, under **Deployment** click **Deployment Center**.
1. Click **Local Git** and then click **Continue**.
1. Click **App Service build service**, click **Continue**, and then click **Finish**.
1. Click **Deployment Credentials** and then click the **User Credentials** tab.
1. In the **Password** and **Confirm Password** text boxes, type **Pa$$w0rd** and then click **Save Credentials**.

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
    cd BoardGamingapi
    ```

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the API App.
1. On the **Overview** response, to the right of the **Git clone URL** field, select **Click to copy**.

    ![Obtain the git clone URL from the portal](../media/5-get-git-deployment-url.png)

1. In the Cloud Shell, run the following command, pasting in the URL that you copied:

    ```bash
    git remote add production **git URL**
    ```

    This command adds a remote named production for the repository at the URL you gave.

## Deploy the Web API

Now, you can deploy the Web API to Azure:

1. To deploy the Web API, run the following command, and enter the password you set for git deployment:

    ```bash
    git push --set-upstream production master
    ```

## Test the deployed Web API

Now the API is completed and deployed, let's test it. We can do that by submitting a GET request in the browser and also by checking the OpenAPI definition:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the API App.
1. On the **Overview** response, select **Browse**. The browser displays the home response for the API, which is blank.
1. In the **Address** bar, append the URL with **/api/values/6/7/uk/chess**. The browser displays a result in JSON format. Notice that the result includes the server time.
1. In the **Address** bar, replace **/api/values/6/7/uk/chess** with **/swagger**. The browser displays the Swagger UI. Keep this browser tab open for later.

## Create a new Azure API Management instance

Now that we have a functional API, let's set up API Management:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Create a resource > Web > API Management**.
1. In the **API Management service** window, enter the following settings, and then click **Create**:

    | Setting | Value |
    | --- | --- |
    | Name | Choose a unique name. Make a note of it, you'll need it later on. |
    | Subscription | *Concierge Subscription* |
    | Resource group | Select *Use existing* and choose *<rgn>Sandbox resource group</rgn>* |
    | Location | Choose from West Europe or Southeast Asia | <!-- These are the only two locations supported by both the sandbox and the consumption tier -->
    | Organization | BoardGames |
    | Administrator email | Enter your own email address or use the default |
    | Pricing tier | Consumption |
    | | |

## Add the API in API Management

Before you can apply a policy, you must add the API to the API Management instance

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All Resources** and then click the management service you just created.
1. Under **API Management**, click **APIs**, and then click **OpenAPI**.

    ![Adding an API](../media/5-add-api-to-management.png)

1. Switch to the browser tab that displays the Swagger interface for the API, and then click the link to the **swagger.json** file.
1. Copy all the text in the address bar.
1. In the **Create from OpenAPI specification** window, place the cursor in the **OpenAPI specification** textbox, and then press CTRL-V.
1. Click **Create**. Azure adds the API to the management instance.

    ![Adding an API](../media/5-complete-api-add.png)

## Test the API in API Management

The API is now added to the management instance. Let's test the API before any policy is applied:

1. Click the **Test** tab and then click the **GET** operation.
1. Use the following values for template parameters and then click **Send**:

    | Name | Value |
    | --- | --- |
    | Height | 6 |
    | Width | 7 |
    | ShippingCode | UK |
    | Game | Chess |
    | | |

    ![Test the API in API Management](../media/5-test-api-in-apim.png)

1. Examine the results. Note the precise time that is included in the response.
1. Click the **Send** button to resend the request. Notice the the time in the response has changed.

## Add a caching policy

Now we can enable the cache by adding elements to the policy:

1. Click the **Design** tab and then click the **GET** operation.
1. In the **Inbound processing** section, click **+Add policy**.

    ![Adding a policy](../media/5-add-policy.png)

1. Click **Cache responses**.
1. In the **Duration in seconds** box, type **600**, and then click **Save**.
1. In the **Inbound processing** section, click **</>**. The portal displays the policy XML editor.
1. Notice that a **&lt;cache-lookup&gt;** tag has been added to the **&lt;inbound&gt;** section, and a **&lt;cache-store&gt;** tag has been added to the **&lt;outbound&gt;** section.

    ![Policy editor with caching elements](../media/5-policy-editor-with-caching-elements.png)

1. Click **Save**.

## Test the cache

We'll run the same test on the API in API Management and observe the results of the cache:

1. Click the **Test** tab and then click the **GET** operation.
1. Use the following values for template parameters and then click **Send**:

    | Name | Value |
    | --- | --- |
    | Height | 6 |
    | Width | 7 |
    | ShippingCode | UK |
    | Game | Chess |
    | | |

    ![Test the API in API Management](../media/5-test-api-in-apim.png)

1. Examine the results. Note the precise time that is included in the response.
1. Click the **Send** button to resend the request. Notice the the time in the response has not changed. This is because the cached response has been served.
