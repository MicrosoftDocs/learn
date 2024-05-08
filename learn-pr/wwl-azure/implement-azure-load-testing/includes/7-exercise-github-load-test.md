You can automate a load test in Azure Load Testing by creating a CI/CD pipeline. In this exercise you learn how to configure GitHub Actions to invoke an existing test in Azure load testing. This exercise shows how you can continuously validate your application performance and stability under load.

In this exercise you will:

- Configure service authentication to allow GitHub Actions to connect to your Azure load testing resource.
- Add load test input files to your repository, such as the JMeter test script and the load test YAML configuration.
- Update the GitHub Actions workflow to invoke Azure Load Testing.

## Prerequisites

### Azure

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

### GitHub

- A GitHub account. If you don't have a GitHub account, you can [create one for free](https://github.com/).
- A GitHub repository to store the load test input files and create a GitHub Actions workflow. To create one, see [Creating a new repository](https://docs.github.com/github/creating-cloning-and-archiving-repositories/creating-a-new-repository).

## Exercise 1

### Create an Azure Load Testing Resource  

#### Task 1: Create an Azure Load Testing resource using CLI

First, you create the top-level resource for Azure Load Testing. It provides a centralized place to view and manage test plans, test results, and related artifacts.

1. Sign into Azure:

    ```azurecli
    az login
    ```

1. Set parameter values:

    The following values are used in subsequent commands to create the load testing resource.

    ```azurecli
    loadTestResource="<load-testing-resource-name>"
    resourceGroup="<resource-group-name>"
    location="East US"
    ```

1. Create an Azure load testing resource with the `azure load create` command:

    ```azurecli
    az load create --name $loadTestResource --resource-group $resourceGroup --location $location
    ```

1. After the resource is created, you can view the details with the `azure load show` command:

    ```azurecli
    az load show --name $loadTestResource --resource-group $resourceGroup
    ```

---

## Configure Service authentication

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

1. Create a service principal and assign the `Load Test Contributor` role - the scope is limited to the load testing resource.

    ```azurecli
    az ad sp create-for-rbac --name "my-load-test-cicd" --role "Load Test Contributor" \
        --scopes $loadtest \
        --json-auth
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

1. In [GitHub](https://github.com), browse to your repository.

1. Select **Settings** > **Secrets & variables** > **Actions**.

1. Select **New repository secret**, enter the secret information, and then select **Add secret** to create a new secret.

    | Field      | Value                                                                                 |
    | ---------- | ------------------------------------------------------------------------------------- |
    | **Name**   | *AZURE_CREDENTIALS*                                                                   |
    | **Secret** | Paste the JSON output from the service principal creation command you copied earlier. |

You can now access your Azure subscription and load testing resource from your GitHub Actions workflow by using the stored credentials.

## Add load test files to your repository

To run a load test with Azure Load Testing in a CI/CD workflow, you need to add all load test input files in your repository including:

- Load test configuration YAML file.
- Test plan file.
  - For JMeter-based tests, add a JMeter test script (`JMX` file).
- JMeter user properties files
- Input data files that your test plan uses. For example, CSV data files.

1. Commit all input files to your source control repository.

### Update the GitHub Actions workflow

Update your GitHub Actions workflow to run a load test for your Azure load testing resource.

1. In [GitHub](https://github.com), browse to your repository.

1. Edit your GitHub Actions workflow or [create a new workflow](https://docs.github.com/actions/quickstart) in your GitHub repository.

1. Use the `actions/checkout` action to check out the repository with the load test input files.

    ```yml
        - name: Checkout
          uses: actions/checkout@v3
    ```

1. Use the `azure/login` action to authenticate with Azure by using the stored credentials.

    Paste the following YAML contents in your workflow definition:

    ```yml
        - name: Login to Azure
          uses: azure/login@v1
          continue-on-error: false
          with:
            creds: ${{ secrets.AZURE_CREDENTIALS }}
    ```

1. Use the `azure/load-testing` action to run the load test.

    Specify the load test configuration file you exported earlier in the `loadTestConfigFile` property.

    Replace the *`<load-testing-resource>`* and *`<load-testing-resource-group>`* text placeholders with the name of your Azure load testing resource and the resource group.

    ```yml
        - name: 'Azure Load Testing'
          uses: azure/load-testing@v1
          with:
            loadTestConfigFile: 'config.yaml'
            loadTestResource: <load-testing-resource>
            resourceGroup: <load-testing-resource-group>
    ```

    Optionally, you can pass parameters or secrets to the load test by using the `env` or `secrets` property.

1. Use the `actions/upload-artifact` action to publish the test results as artifacts in your GitHub Actions workflow run.

    ```yml
        - uses: actions/upload-artifact@v2
          with:
            name: loadTestResults
            path: ${{ github.workspace }}/loadTest
    ```

## View load test results

When you run a load test from your CI/CD pipeline, you can view the summary results directly in the CI/CD output log. If you published the test results as a pipeline artifact, you can also download a CSV file for further reporting.

:::image type="content" source="../media/github-actions-workflow-completed.png" alt-text="Screenshot that shows the workflow logging information.":::
