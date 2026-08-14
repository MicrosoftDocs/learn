Learn how to pass secrets and environment variables as parameters to a load test in Azure Load Testing. You can use parameters to change the behavior of a load test without having to edit the Apache JMeter or Locust script. For example, you can specify the endpoint URL as a parameter to reuse your test script across multiple environments. You can also use parameters to avoid hard-coding sensitive information in the test script.

> [!NOTE]
> The examples in this unit use current Azure Load Testing parameter features and supported major versions of the GitHub actions at the time of writing. The service and actions update often, so review the [parameter documentation](/azure/app-testing/load-testing/how-to-parameterize-load-tests) and action repositories for the latest information.

The Azure Load Testing service supports two types of parameters:

- **Secrets:** Contain sensitive information that Azure Load Testing passes securely to the test engine. For example, secrets provide web service credentials instead of hard-coded values in the test script.

- **Environment variables:** Contain nonsensitive information that the test engine exposes to the test script. For example, environment variables make the application endpoint URL configurable.

You can specify parameters in the load test configuration when you create a new test or update an existing test. If you run a load test in your CI/CD workflow, you define parameters in the load test configuration file or in the CI/CD workflow definition.

## Authenticate the GitHub Actions workflow

The Azure Load Testing action requires an authenticated Azure session. For a GitHub-hosted runner, you can configure a federated identity credential and assign the identity the **Load Test Contributor** role at the Azure Load Testing resource scope.

The workflow uses OpenID Connect with `id-token: write` permission and repository secrets for the client, tenant, and subscription identifiers. The following example establishes the Azure session without storing a client secret.

```yaml
on: [push]

permissions:
  id-token: write
  contents: read

jobs:
  load-test:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v7

      - name: Sign in to Azure
        uses: azure/login@v3
        with:
          client-id: '${{ secrets.AZURE_CLIENT_ID }}'
          tenant-id: '${{ secrets.AZURE_TENANT_ID }}'
          subscription-id: '${{ secrets.AZURE_SUBSCRIPTION_ID }}'
```

## Configure load tests with secrets

Secrets keep API keys, passwords, and other sensitive values out of your test scripts. Azure Load Testing can retrieve values from Azure Key Vault or receive them from a CI/CD secret store. The following process passes a stored secret to a JMeter or Locust script.

1. You can store the secret value in Azure Key Vault or your CI/CD secret store.
1. You can pass a reference to the secret into the test script.
1. For JMeter-based tests, you can retrieve the secret with the `GetSecret` custom function. For Locust-based tests, you can read the secret from an environment variable.

> [!IMPORTANT]
> You can only use the `GetSecret` custom function when you run your JMeter test script with Azure Load Testing. If you run your test script locally, you need to update your test script and read secret values in a different way.

### Use GitHub secret store to save load test secrets

GitHub repository secrets provide encrypted storage for values that a workflow uses. The following steps pass a repository secret to Azure Load Testing without placing its value in source control.

1. You can add the secret value to the GitHub repository secrets.

    In GitHub, you can use [GitHub repository secrets](https://docs.github.com/actions/security-guides/encrypted-secrets).

    :::image type="content" source="../media/github-new-secret.png" alt-text="Screenshot that shows how to add a GitHub repository secret.":::

1. You can pass the secret as an input parameter to the Azure Load Testing action in the CI/CD workflow.

    The following YAML snippet shows how to pass the secret to the [Load Testing GitHub action](https://github.com/marketplace/actions/azure-load-testing):

    ```yaml
    # Code fragment - focus on passing a repository secret.
    - name: 'Azure Load Testing'
      uses: azure/load-testing@v1
      with:
        loadtestConfigFile: 'SampleApp.yaml'
        loadtestResource: 'MyTest'
        resourceGroup: 'loadtests-rg'
        secrets: |
          [
            {
            "name": "appToken",
            "value": "${{ secrets.MY_SECRET }}"
            }
          ]
    ```

    > [!IMPORTANT]
    > The secret input parameter name must match the name in the JMeter or Locust script.

  After you specify a secret in the CI/CD secret store, Azure Load Testing passes its value to the JMeter or Locust script.

### Use secrets in Apache JMeter

Next, you update the Apache JMeter script to use the secret that you specified earlier.

You first create a user-defined variable that retrieves the secret value. Then, you can use this variable in your test. For example, to pass an API token in an HTTP request header.

1. You can create a user-defined variable in your JMX file and assign the secret value to it by using the `GetSecret` custom function.

    The `GetSecret(<my-secret-name>)` function takes the secret name as an argument. You use this same name when you configure the load test in a later step.

    You can create the user-defined variable by using the Apache JMeter IDE, as shown in the following image:

    :::image type="content" source="../media/user-defined-variables.png" alt-text="Screenshot that shows how to add user-defined variables to your Apache JMeter script.":::

    Alternatively, you can directly edit the JMX file, as shown in this example code snippet:

    ```xml
    <!-- Code fragment - focus on retrieving a secret. -->
    <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
      <collectionProp name="Arguments.arguments">
        <elementProp name="appToken" elementType="Argument">
          <stringProp name="Argument.name">udv_appToken</stringProp>
          <stringProp name="Argument.value">${__GetSecret(appToken)}</stringProp>
          <stringProp name="Argument.desc">Value for x-secret header </stringProp>
          <stringProp name="Argument.metadata">=</stringProp>
        </elementProp>
      </collectionProp>
    </Arguments>
    ```

1. You can reference the user-defined variable in the test script.

    You can use the `${}` syntax to reference the variable in the script. In the following example, you use the `udv_appToken` variable to set an HTTP header.

    ```xml
      <!-- Code fragment - focus on adding the secret to a request header. -->
      <HeaderManager guiclass="HeaderPanel" testclass="HeaderManager" testname="HTTP Header Manager" enabled="true">
        <collectionProp name="HeaderManager.headers">
          <elementProp name="" elementType="Header">
            <stringProp name="Header.name">api-key</stringProp>
            <stringProp name="Header.value">${udv_appToken}</stringProp>
          </elementProp>
        </collectionProp>
      </HeaderManager>
    ```

### Use secrets in Locust

Azure Load Testing exposes a secret passed from the GitHub Actions secret store as an environment variable on the Locust test engine. You can retrieve the value by using the same name that you specified in the action input. The following fragment retrieves the `appToken` value.

```python
# Code fragment - focus on reading the secret.
import os

app_token = os.getenv("appToken")
```

## Configure load tests with environment variables

In this section, you use environment variables to pass nonsensitive parameters to your load test. JMeter and Locust scripts access the values through their respective environment APIs.

1. You can update the Apache JMeter script to use the environment variable. For example, you can configure the application endpoint hostname.

1. You can configure the load test and pass the environment variable to the test script.

### Use environment variables in Apache JMeter

In this section, you update the Apache JMeter script to use environment variables to control the script behavior.

You first define a user-defined variable that reads the environment variable, and then you can use this variable in the test execution. For example, to update the HTTP domain.

1. You can create a user-defined variable in your JMX file and assign the environment variable's value to it by using the `System.getenv` function.

    The `System.getenv("<my-variable-name>")` function takes the environment variable name as an argument. You use this same name when you configure the load test.

    You can create a user-defined variable by using the Apache JMeter IDE, as shown in the following image:

    :::image type="content" source="../media/user-defined-variables-jmeter.png" alt-text="Screenshot that shows how to add user-defined variables for environment variables to your JMeter script.":::

    Alternatively, you can directly edit the JMX file, as shown in this example code snippet:

    ```xml
    <!-- Code fragment - focus on reading an environment variable. -->
    <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
      <collectionProp name="Arguments.arguments">
        <elementProp name="appToken" elementType="Argument">
          <stringProp name="Argument.name">udv_webapp</stringProp>
          <stringProp name="Argument.value">${__BeanShell( System.getenv("webapp") )}</stringProp>
          <stringProp name="Argument.desc">Web app URL</stringProp>
          <stringProp name="Argument.metadata">=</stringProp>
        </elementProp>
      </collectionProp>
    </Arguments>
    ```

1. You can reference the user-defined variable in the test script.

    You can use the `${}` syntax to reference the variable in the script. In the following example, you use the `udv_webapp` variable to configure the application endpoint URL.

    ```xml
    <!-- Code fragment - focus on using the environment variable. -->
    <stringProp name="HTTPSampler.domain">${udv_webapp}</stringProp>
    ```

### Use environment variables in Locust

A Locust script can read environment variables by using Python's `os.getenv` function. The variable name must match the name in the load test configuration or GitHub Actions input. The following fragment reads the `webapp` endpoint value.

```python
# Code fragment - focus on reading an environment variable.
import os

web_app = os.getenv("webapp")
```

### Configure environment variables in Azure Load Testing

To pass environment variables to a JMeter or Locust script, you can configure the load test in the Azure portal, in the YAML test configuration file, or directly in the CI/CD workflow.

The following YAML snippet shows a GitHub Actions example:

```yaml
# Code fragment - focus on passing an environment variable.
- name: 'Azure Load Testing'
  uses: azure/load-testing@v1
  with:
    loadtestConfigFile: 'SampleApp.yaml'
    loadtestResource: 'MyTest'
    resourceGroup: 'loadtests-rg'
    env: |
      [
        {
        "name": "webapp",
        "value": "myapplication.contoso.com"
        }
      ]
```

