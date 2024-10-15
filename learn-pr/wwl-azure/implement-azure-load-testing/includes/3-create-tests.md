Learn how to create and manage load tests in your Azure Load Testing resource.

## Create an Azure Load Testing resource

First, you create the top-level resource for Azure Load Testing. It provides a centralized place to view and manage test plans, test results, and related artifacts.

To create a load testing resource using CLI:

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

## Create a load test

There are two options to create a load test in the Azure portal:

- URL-based test
- JMeter test script (JMX)

:::image type="content" source="../media/create-test-dropdown.png" alt-text="Screenshot that shows the options to create a new test in the Azure portal.":::

In this unit, we focus on creating a test using a JMeter script.

### Components of a test plan

#### Test plan

The test plan contains all files that are needed for running your load test. At a minimum, the test plan should contain one `*.jmx` JMeter script. Azure Load Testing only supports one JMX file per load test.

Alongside the test script, you can upload a user property file, configuration files, or input data files, such as CSV files.

1. Go to the **Test plan**.

2. Select all files from your local machine, and upload them to Azure.

    :::image type="content" source="../media/test-plan-upload-files.png" alt-text="Screenshot that shows the test plan page for creating a test in the Azure portal, highlighting the upload functionality.":::

    Azure Load Testing stores all files in a single repository. If your test script references configuration or data files, make sure to remove any relative path names in the JMX file.

3. If your test uses CSV input data, you can choose to enable **Split CSV evenly between test engines**.

    By default, Azure Load Testing copies and processes your input files unmodified across all test engine instances. Azure Load Testing enables you to split the CSV input data evenly across all engine instances. If you have multiple CSV files, each file is split evenly.

    For example, if you have a large customer CSV input file, and the load test runs on 10 parallel test engines, then each instance processes 1/10th of the customers.

    :::image type="content" source="../media/configure-test-split-csv.png" alt-text="Screenshot that shows the checkbox to enable splitting input C S V files when configuring a test in the Azure portal.":::

> [!TIP]
> You can download a file from the **Test plan** tab by selecting the file name in the list. For example, you might download the generated JMeter script for a quick test, modify it, and then upload the file again.

#### Parameters

You can use parameters to make your test plan configurable instead of hard-coding values in the JMeter script. Specify key-value pairs in the load test configuration, and reference the value in the JMeter script by using the parameter name.

:::image type="content" source="../media/configure-parameters.png" alt-text="Screenshot that shows how to configure parameters when creating a test in the Azure portal.":::

1. Specify environment variables to pass nonsensitive parameters to your test script.

    For example, you could use an environment variable to pass the target domain name or port number to the test script.

2. Add references to secrets, backed by Azure Key Vault.

    Use secrets to pass sensitive parameters, such as passwords or authentication tokens, to the test script. You store the secret values in your Azure key vault, and add a reference to the key in the load test configuration. You can then reference the key in your script by using the parameter name. Azure Load Testing then retrieves the key value from Azure Key Vault.

3. Add references to client certificates, backed by Azure Key Vault.

    If you are load testing application endpoints that use certificate-based authentication, you can add the certificates to your Azure key vault, and add a reference to the certificate in the load test configuration. Azure Load Testing automatically injects the certificates in the web requests in your JMeter script.

4. Select the managed identity that is used for accessing your key vault for secrets or certificates.

#### Load

1. Specify the number of test engine instances.

    Azure Load Testing automatically scales your load test across all instances. The JMeter test script is run in parallel across all instances. The total number of simulated users equals the number of virtual users (threads) you specify in the JMeter script, multiplied by the number of test engine instances.

2. Configure virtual network connectivity.

    You can connect your load test to an Azure virtual network for load testing privately hosted or on-premises endpoints.

    To connect to a virtual network, select the *Private* **Traffic mode**, and then select the **Virtual network** and **Subnet**.

    :::image type="content" source="../media/configure-test-engine-instances.png" alt-text="Screenshot that shows how to configure the number of test engine instances when creating a test in the Azure portal.":::

#### Test criteria

1. Specify test failure criteria based on client metrics.

    When the load test surpasses the threshold for a metric, the load test gets the failed status. Azure Load Testing currently supports the following client-side metrics for fail criteria:

    - Response time
    - Requests per second
    - Total number of requests
    - Latency
    - Error percentage

    You can specify fail criteria for the entire load test, or assign them to specific requests in the JMeter script. For example, to validate that the home page response time doesn't exceed a specific response time.

2. Configure auto stop criteria.

    Azure Load Testing can automatically stop a load test run when the error rate surpasses a given threshold. You can enable or disable this functionality, and configure the specific error rate threshold and time window.

    :::image type="content" source="../media/configure-test-criteria.png" alt-text="Screenshot that shows how to configure test criteria when creating a test in the Azure portal.":::
