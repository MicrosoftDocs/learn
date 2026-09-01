Learn how to create and manage load tests in your Azure Load Testing resource.

> [!NOTE]
> Azure CLI commands in this unit use the current command syntax at the time of writing. Azure CLI and its extensions update often, so review the [`az load` reference](/cli/azure/load) for the latest information.

## Create an Azure Load Testing resource

First, you create the top-level resource for Azure Load Testing. It provides a centralized place to view and manage test plans, test results, and related artifacts.

You can create a load testing resource by using Azure CLI. The following steps create the resource and display its details.

1. You can sign in to Azure:

    ```azurecli
    az login
    ```

1. You can set parameter values:

    The subsequent commands use these values to create the load testing resource.

    ```bash
    loadTestResource="<load-testing-resource-name>"
    resourceGroup="<resource-group-name>"
    location="East US"
    ```

1. You can create a resource group with the `az group create` command:

    ```bash
    az group create -n $resourceGroup -l $location
    ```

1. You can create an Azure load testing resource with the `az load create` command:

    ```bash
    az load create --name $loadTestResource --resource-group $resourceGroup --location $location
    ```

1. After Azure creates the resource, you can view its details with the `az load show` command:

    ```bash
    az load show --name $loadTestResource --resource-group $resourceGroup
    ```

## Create a load test

The Azure portal provides three options for creating a load test. You can choose an option based on the complexity of the test scenario and the test assets that you already have. This unit focuses on a JMeter script.

- URL-based test.
- JMeter test script (JMX).
- Locust test script.

### Test plan

The test plan contains all files required to run your load test. At a minimum, the test plan should contain one `*.jmx` JMeter script. Azure Load Testing supports one JMX file per load test.

Alongside the test script, you can upload a user property file, configuration files, or input data files, such as CSV files.

1. You can go to the **Test plan**.

1. You can select the required files from your local machine and upload them to Azure.

    :::image type="content" source="../media/test-plan-upload-files.png" alt-text="Screenshot that shows the test plan page for creating a test in the Azure portal, highlighting the upload functionality.":::

    Azure Load Testing stores all files in a single repository. If your test script references configuration or data files, you can remove relative paths from the JMX file.

1. If your test uses CSV input data, you can enable **Split CSV evenly between test engines**.

    By default, Azure Load Testing copies and processes your input files unmodified across all test engine instances. Azure Load Testing enables you to split the CSV input data evenly across all engine instances. If you have multiple CSV files, each file is split evenly.

    For example, if you have a large customer CSV input file and the load test runs on 10 parallel test engines, each instance processes one-tenth of the customers.

    :::image type="content" source="../media/configure-test-split-csv.png" alt-text="Screenshot that shows the checkbox to enable splitting input C S V files when configuring a test in the Azure portal.":::

> [!TIP]
> You can download a file from the **Test plan** tab by selecting the file name in the list. For example, you might download the generated JMeter script for a quick test. You can then modify and upload the script.

### Parameters

You can use parameters to make your test plan configurable instead of hard-coding values in the JMeter script. You can specify key-value pairs in the load test configuration and reference each value in the JMeter script by using its parameter name.

:::image type="content" source="../media/configure-parameters.png" alt-text="Screenshot that shows how to configure parameters when creating a test in the Azure portal.":::

1. You can specify environment variables to pass nonsensitive parameters to your test script.

    For example, you could use an environment variable to pass the target domain name or port number to the test script.

1. You can add references to secrets backed by Azure Key Vault.

    You can use secrets to pass sensitive parameters, such as passwords or authentication tokens, to the test script. You store the secret values in Azure Key Vault. You then add a reference to the secret in the load test configuration and use the parameter name in your script. Azure Load Testing retrieves the secret value from Azure Key Vault.

1. You can add references to client certificates backed by Azure Key Vault.

    If your load testing application endpoints that use certificate-based authentication, you can add the certificates to Azure Key Vault. You can then add a certificate reference to the load test configuration. Azure Load Testing automatically injects the certificates into the web requests in your JMeter script.

1. You can select the managed identity that Azure Load Testing uses to access secrets or certificates in your key vault.

    Selecting the identity doesn't grant access to the key vault. You can grant the identity permission to read the required secrets or certificates. For a key vault that uses Azure RBAC, you can assign the **Key Vault Secrets User** role at the narrowest practical scope.

### Load

The load settings control the number and placement of test engine instances. More instances increase the total load that a JMeter test can generate. You can also connect the engines to a virtual network when the target endpoint isn't publicly accessible.

1. You can specify the number of test engine instances.

    Azure Load Testing automatically scales your load test across all instances. The test engines run the JMeter test script in parallel. The total number of simulated users equals the number of virtual users (threads) that you specify in the JMeter script multiplied by the number of test engine instances.

1. You can configure virtual network connectivity.

    You can connect your load test to an Azure virtual network for load testing privately hosted or on-premises endpoints.

    To connect to a virtual network, you can select **Private** for **Traffic mode**. You can then select the **Virtual network** and **Subnet**.

    :::image type="content" source="../media/configure-test-engine-instances.png" alt-text="Screenshot that shows how to configure the number of test engine instances when creating a test in the Azure portal.":::

### Test criteria

Test criteria define the performance expectations that determine the test result. Client metrics evaluate request behavior, while auto stop settings protect against tests that generate sustained errors. You can configure both types of criteria before running the test.

1. You can specify test failure criteria based on client metrics.

    When a metric surpasses its threshold, Azure Load Testing marks the test as failed. Azure Load Testing currently supports the following client-side metrics for fail criteria:

    - Response time
    - Requests per second
    - Total number of requests
    - Latency
    - Error percentage

    You can specify fail criteria for the entire load test or assign them to specific requests in the JMeter script. For example, you can validate that the home page response time doesn't exceed a specific threshold.

1. You can configure auto stop criteria.

    Azure Load Testing can automatically stop a load test run when the error rate surpasses a given threshold. You can enable or disable this functionality. You can also configure the error rate threshold and time window.

    :::image type="content" source="../media/configure-test-criteria.png" alt-text="Screenshot that shows how to configure test criteria when creating a test in the Azure portal.":::

