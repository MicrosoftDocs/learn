You can automate a load test in Azure Load Testing by creating a CI/CD pipeline. In this exercise you learn how to configure GitHub Actions to invoke an existing test in Azure load testing. You generate a load against a sample web application that you deploy to Azure App Service. This exercise shows how you can continuously validate your application performance and stability under load.

In this exercise you will:

- Deploy a Node.js web API to Azure App Service.
- Create an Azure Load Testing resource.
- Configure service authentication to allow GitHub Actions to connect to your Azure load testing resource.
- Create a load test with load testing YAML config file.
- Update the GitHub Actions workflow to invoke a test run.

## Prerequisites

### Azure

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

### GitHub

- A GitHub account. If you don't have a GitHub account, you can [create one for free](https://github.com/).
- A GitHub repository to store the load test input files and create a GitHub Actions workflow. To create one, see [Creating a new repository](https://docs.github.com/github/creating-cloning-and-archiving-repositories/creating-a-new-repository).

## Task 1: Deploy a Node.js web API to Azure App Service

The sample application consists of a Node.js web API, which interacts with a NoSQL database. You deploy the web API to Azure App Service web apps and use Azure Cosmos DB as the database.

1. Open Windows PowerShell, sign in to Azure, and set the subscription:

   ```azurecli
   az login
   az account set --subscription <your-Azure-Subscription-ID>
   ```

1. Clone the sample application's source repo:

   ```powershell
   git clone https://github.com/Azure-Samples/nodejs-appsvc-cosmosdb-bottleneck.git
   ```

   The sample application is a Node.js app that consists of an Azure App Service web component and an Azure Cosmos DB database. The repo includes a PowerShell script that deploys the sample app to your Azure subscription. It also has an Apache JMeter script that you'll use in later steps.

1. Go to the Node.js app's directory and deploy the sample app by using this PowerShell script:

   ```powershell
   cd nodejs-appsvc-cosmosdb-bottleneck
   .\deploymentscript.ps1
   ```

   > [!TIP]
   > You can install PowerShell on [Linux/WSL](/powershell/scripting/install/installing-powershell-on-linux) or [macOS](/powershell/scripting/install/installing-powershell-on-macos).
   >
   > After you install it, you can run the previous command as `pwsh ./deploymentscript.ps1`.

1. At the prompt, provide:

   - Your Azure subscription ID.
   - A unique name for your web app.
   - A location. By default, the location is `eastus`. You can get region codes by running the [Get-AzLocation](/powershell/module/az.resources/get-azlocation) command.

   > [!IMPORTANT]
   > For your web app's name, use only lowercase letters and numbers. Don't use spaces or special characters.

1. After deployment finishes, go to the running sample application by opening `https://<yourappname>.azurewebsites.net` in a browser window.

Now that you have the sample application deployed and running, you can create an Azure load testing resource and a load test.

## Task 2: Create an Azure Load Testing resource

First, you create the top-level resource for Azure Load Testing. It provides a centralized place to view and manage test plans, test results, and related artifacts.

Follow these steps to create an Azure load testing resource and a load test by using the Azure CLI:

1. Open a terminal window and enter the following command to sign in to your Azure subscription.

    ```azurecli
    az login
    ```

1. Go to the sample application directory.

   ```azurecli
   cd nodejs-appsvc-cosmosdb-bottleneck
   ```

1. Create an Azure load testing resource with the [`az load create`](/cli/azure/load) command.

    Replace the `<your-app-name>` text placeholder with the name of your web app. Replace the `<load-testing-resource-name>` text placeholder with the name of the load testing resource.

    ```azurecli
    # This script requires the following Azure CLI extensions:
    # - load
    
    $resourceGroup = "<your-app-name>-rg"
    $loadTestResource = "my-loadtest"
    $resourceGroup = "loadtestwebappeastus-rg"
    $location = "East US"
    
    az load create --name $loadTestResource --resource-group $resourceGroup --location $location
    ```

1. After the resource is created, you can view the details with the `azure load show` command:

    ```azurecli
    az load show --name $loadTestResource --resource-group $resourceGroup
    ```

## Task 3: Configure Service authentication

To run a load test from GitHub Actions workflow, you need to grant permission to the GitHub workflow to access your load testing resource using a service principal.

To access your Azure Load Testing resource from the GitHub Actions workflow, you first create a Microsoft Entra service principal. This service principal represents your GitHub Actions workflow in Microsoft Entra ID.

Next, you grant permissions to the service principal to create and run a load test with your Azure Load Testing resource.

### Create a service principal

Create a service principal in the Azure subscription and assign the Load Test Contributor role so that your GitHub Actions workflow has access to your Azure load testing resource to run load tests.

1. Create a service principal and assign the `Load Test Contributor` role:

      ```azurecli
      # Get the resource ID for the load testing resource - replace the text place holders.
      az resource show -g <resource-group-name> -n <load-testing-resource-name> \ 
          --resource-type "Microsoft.LoadTestService/loadtests" \
          --query "id" -o tsv
      ```

    The output is a JSON object that represents the service principal. You use this information to authenticate with Azure in the GitHub Actions workflow.

    ```json
    {
    "clientId": "<GUID>",
    "clientSecret": "<secret>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    (...)
    }
    ```

    > [!NOTE]
    > You might get a `--sdk-auth` deprecation warning when you run this command if you are running an older version of the Azure CLI locally.

1. Copy the output JSON object to the clipboard.

    In the next step, you store the service principal information as a GitHub secret.

### Store Azure credentials in GitHub Actions

Create a GitHub Actions secret to securely store the service principal information. You use this secret in your workflow definition to connect to authenticate with Azure and access your Azure load testing resource.

To create a GitHub Actions secret:

1. In [GitHub](https://github.com), browse to your repository where the sample application is.

1. Select **Settings** > **Secrets & variables** > **Actions**.

1. Select **New repository secret**, enter the secret information, and then select **Add secret** to create a new secret.

    | Field      | Value                                                                                 |
    | ---------- | ------------------------------------------------------------------------------------- |
    | **Name**   | *AZURE_CREDENTIALS*                                                                   |
    | **Secret** | Paste the JSON output from the service principal creation command you copied earlier. |

You can now access your Azure subscription and load testing resource from your GitHub Actions workflow by using the stored credentials.

## Task 4: Update the load test YAML file

1. Open the SampleApp.jmx file in your repository. Notice how the `Sampleapp.yaml` load test configuration file references the `SampleApp.jmx` JMeter test script.

1. Notice how the `SampleApp.jmx` JMeter test script uses the `${}` syntax to reference the web app variable in the script: ${udv_webapp}

1. Update the `SampleApp.yaml` to include the following configurations. Notice that you pass in the sample application that you deployed earlier as a variable to the load test. Replace the `<your-app-name>` text placeholder with the name of your web app.

    ```yaml
    displayName: Sample Test
    testPlan: SampleApp.jmx
    description: Load test the sample app
    engineInstances: 1
    testId: sample-app-test
    testType: JMX
    splitAllCSVs: False
    failureCriteria: []
    env:
    - name: webapp
      value: <your-app-name>.azurewebsites.net
    autoStop:
      errorPercentage: 90
      timeWindow: 60
    ```

## Task 5: Update the GitHub Actions workflow and invoke a test run

Update your GitHub Actions workflow to run a load test for your Azure load testing resource.

1. In your repository navigate to .github\workflows and select workflow.yml

1. Note that the following actions are in the file under the job LoadTest:
    - the `actions/checkout` action to check out the repository with the load test input files.
    - the `azure/login` action to authenticate with Azure by using the stored credentials.
    - the `azure/load-testing` action to run the load test.
    - the `actions/upload-artifact` action to publish the test results as artifacts in your GitHub Actions workflow run.
1. Push a commit to main to trigger the workflow.
1. Go to the Actions tab in your GitHub repository to see the workflow run.

## Task 6: View load test results

When you run a load test from your CI/CD pipeline, you can view the summary results directly in the CI/CD output log. If you published the test results as a pipeline artifact, you can also download a CSV file for further reporting.

:::image type="content" source="../media/github-actions-workflow-completed.png" alt-text="Screenshot that shows the workflow logging information.":::
