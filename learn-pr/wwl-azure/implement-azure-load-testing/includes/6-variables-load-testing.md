Learn how to pass secrets and environments as parameters to a load test in Azure Load Testing. You can use parameters to change the behavior of a load test without having to edit the Apache JMeter script. For example, to test a web application, specify the endpoint URL as a parameter to reuse your test script across multiple environments. You can also use parameters to avoid having to hard code sensitive information in the JMeter test script.

The Azure Load Testing service supports two types of parameters:

- **Secrets**: Contain sensitive information and are passed securely to the load test engine. For example, secrets provide web service credentials instead of hard-coding them in the test script.

- **Environment variables**: Contain nonsensitive information and are available as environment variables in the load test engine. For example, environment variables make the application endpoint URL configurable.

You can specify parameters in the load test configuration when you create a new test or update an existing test. If you run a load test in your CI/CD workflow, you define parameters in the load test configuration file or in the CI/CD workflow definition.

## Configure load tests with secrets

In this section, you learn how to pass secrets to your load test script in Azure Load Testing. For example, you might use a secret to pass the API key to a web service endpoint that you're load testing. Instead of storing the API key in configuration or hard-coding it in the script, you can save it in a secret store to tightly control access to the secret.

Azure Load Testing enables you to store secrets in Azure Key Vault. Alternatively, when you run your load test in a CI/CD pipeline, you can also use the secret store associated with your CI/CD technology, such as Azure Pipelines or GitHub Actions.

To use secrets with Azure Load Testing, you perform the following steps:

1. Store the secret value in the secret store
2. Pass a reference to the secret into the Apache JMeter test script.
3. Use the secret value in the Apache JMeter test script by using the `GetSecret` custom function.

> [!IMPORTANT]
> You can only use the `GetSecret` custom function when you run your JMeter test script with Azure Load Testing. If you run your test script locally, you need to update your test script and read secret values in a different way.

### Use GitHub secret store to save load test secrets

To use secrets in the CI/CD secret store and pass them to your load test in CI/CD:

1. Add the secret value to GitHub Actions secret store.

    In GitHub, you can use [GitHub repository secrets](https://docs.github.com/actions/security-guides/encrypted-secrets).

    :::image type="content" source="../media/github-new-secret.png" alt-text="Screenshot that shows how to add a GitHub repository secret.":::

2. Pass the secret as an input parameter to the Load Testing task/action in the CI/CD workflow.

    The following YAML snippet shows how to pass the secret to the [Load Testing GitHub action](https://github.com/marketplace/actions/azure-load-testing):

    ```yaml
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
    > The name of the secret input parameter needs to match the name that's used in the Apache JMeter script.

You just specified a secret in the CI/CD secret store and passed a reference to Azure Load Testing. You can now use the secret in the Apache JMeter script.

### Use secrets in Apache JMeter

Next, you update the Apache JMeter script to use the secret that you specified earlier.

You first create a user-defined variable that retrieves the secret value. Then, you can use this variable in your test. For example, to pass an API token in an HTTP request header.

1. Create a user-defined variable in your JMX file, and assign the secret value to it by using the `GetSecret` custom function.

    The `GetSecret(<my-secret-name>)` function takes the secret name as an argument. You use this same name when you configure the load test in a later step.

    You can create the user-defined variable by using the Apache JMeter IDE, as shown in the following image:

    :::image type="content" source="../media/user-defined-variables.png" alt-text="Screenshot that shows how to add user-defined variables to your Apache JMeter script.":::

    Alternatively, you can directly edit the JMX file, as shown in this example code snippet:

    ```xml
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

2. Reference the user-defined variable in the test script.

    You can use the `${}` syntax to reference the variable in the script. In the following example, you use the `udv_appToken` variable to set an HTTP header.

    ```xml
      <HeaderManager guiclass="HeaderPanel" testclass="HeaderManager" testname="HTTP Header Manager" enabled="true">
        <collectionProp name="HeaderManager.headers">
          <elementProp name="" elementType="Header">
            <stringProp name="Header.name">api-key</stringProp>
            <stringProp name="Header.value">${udv_appToken}</stringProp>
          </elementProp>
        </collectionProp>
      </HeaderManager>
    ```

## Configure load tests with environment variables

In this section, you use environment variables to pass parameters to your load test.

1. Update the Apache JMeter script to use the environment variable. For example, to configure the application endpoint hostname.

1. Configure the load test and pass the environment variable to the test script.

### Use environment variables in Apache JMeter

In this section, you update the Apache JMeter script to use environment variables to control the script behavior.

You first define a user-defined variable that reads the environment variable, and then you can use this variable in the test execution. For example, to update the HTTP domain.

1. Create a user-defined variable in your JMX file, and assign the environment variable's value to it by using the `System.getenv` function.

    The `System.getenv("<my-variable-name>")` function takes the environment variable name as an argument. You use this same name when you configure the load test.

    You can create a user-defined variable by using the Apache JMeter IDE, as shown in the following image:

    :::image type="content" source="../media/user-defined-variables-jmeter.png" alt-text="Screenshot that shows how to add user-defined variables for environment variables to your JMeter script.":::

    Alternatively, you can directly edit the JMX file, as shown in this example code snippet:

    ```xml
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

2. Reference the user-defined variable in the test script.

    You can use the `${}` syntax to reference the variable in the script. In the following example, you use the `udv_webapp` variable to configure the application endpoint URL.

    ```xml
    <stringProp name="HTTPSampler.domain">${udv_webapp}</stringProp>
    ```

### Configure environment variables in Azure Load Testing

To pass environment variables to the Apache JMeter script, you can configure the load test in the Azure portal, in the YAML test configuration file, or directly in the CI/CD workflow.

The following YAML snippet shows a GitHub Actions example:

```yaml
- name: 'Azure Load Testing'
  uses: azure/load-testing
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
