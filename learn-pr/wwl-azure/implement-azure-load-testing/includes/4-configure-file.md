Learn how to configure your load test in Azure Load Testing by using YAML. You use the test configuration YAML file to create and run load tests from your GitHub Actions workflow.

## Load test YAML syntax

A load test configuration uses the following keys:

| Key                         | Type             | Required | Default value | Description                                                                                                                                                                                                                                                                                                                                                      |
| --------------------------- | ---------------- | -------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `version`                   | string           | Y        |               | Load test specification version. The only supported value is `v0.1`.                                                                                                                                                                                                                                                                                             |
| `testId`                    | string           | Y        |               | Unique identifier of the load test. The value must be between 2 and 50 characters ([a-z0-9_-]). For an existing test, you can get the `testId` from the test details page in the Azure portal.                                                                                                                                                                   |
| `testName`                  | string           | N        |               | **Deprecated**. Unique identifier of the load test. This setting is replaced with `testId`. You can still run existing tests with the `testName` field.                                                                                                                                                                                                          |
| `displayName`               | string           | N        |               | Display name of the test. This value is shown in the list of tests in the Azure portal. If not provided, `testId` is used as the display name.                                                                                                                                                                                                                   |
| `description`               | string           | N        |               | Short description of the test. The value has a maximum length of 100 characters.                                                                                                                                                                                                                                                                                 |
| `testType`                  | string           | Y        |               | Test type. Possible values:<br/><ul><li>`URL`: URL-based load test</li><li>`JMX`: JMeter-based load test</li></ul>                                                                                                                                                                                                                                               |
| `testPlan`                  | string           | Y        |               | Reference to the test plan file.<br/><ul><li>If `testType: JMX`: relative path to the JMeter test script.</li><li>If `testType: URL`: relative path to the requests JSON file.</li></ul>                                                                                                                                                                         |
| `engineInstances`           | integer          | Y        |               | Number of parallel test engine instances for running the test plan.                                                                                                                                                                                                                                                                                              |
| `configurationFiles`        | array of string  | N        |               | List of external files, required by the test script. For example, CSV data files, images, or any other data file.<br/>Azure Load Testing uploads all files in the same folder as the test script. In the JMeter script, only refer to external files using the file name, and remove any file path information.                                                  |
| `failureCriteria`           | object           | N        |               | List of load test fail criteria.                                                                                                                                                                                                                                                                                                                                 |
| `autoStop`                  | string or object | N        |               | Automatically stop the load test when the error percentage exceeds a value.<br/>Possible values:<br/>- `disable`: don't stop a load test automatically.<br/>                                                                                                                                                                                                     |
| `properties`                | object           | N        |               | JMeter user property file references.                                                                                                                                                                                                                                                                                                                            |
| `zipArtifacts`              | array of string  | N        |               | Specifies the list of zip artifact files. For files other than JMeter scripts and user properties, if the file size exceeds 50 MB, compress them into a ZIP file. Ensure that the ZIP file remains below 50 MB in size. Only 5 ZIP artifacts are allowed with a maximum of 1,000 files in each and uncompressed size of 1 GB. Only applies when `testType: JMX`. |
| `splitAllCSVs`              | boolean          | N        | False         | Split the input CSV files evenly across all test engine instances.                                                                                                                                                                                                                                                                                               |
| `secrets`                   | object           | N        |               | List of secrets that the Apache JMeter script references.                                                                                                                                                                                                                                                                                                        |
| `env`                       | object           | N        |               | List of environment variables that the Apache JMeter script references.                                                                                                                                                                                                                                                                                          |
| `certificates`              | object           | N        |               | List of client certificates for authenticating with application endpoints in the JMeter script.                                                                                                                                                                                                                                                                  |
| `keyVaultReferenceIdentity` | string           | N        |               | Resource ID of the user-assigned managed identity for accessing the secrets from your Azure Key Vault. If you use a system-managed identity, this information isn't needed. Make sure to grant this user-assigned identity access to your Azure key vault.                                                                                                       |
| `subnetId`                  | string           | N        |               | Resource ID of the virtual network subnet for testing privately hosted endpoints. This subnet hosts the injected test engine VMs.                                                                                                                                                                                                                                |
| `publicIPDisabled`          | boolean          | N        |               | Disable the deployment of a public IP address, load balancer, and network security group while testing a private endpoint.                                                                                                                                                                                                                                       |

The following YAML snippet contains an example load test configuration.

```yaml
version: v0.1
testId: SampleTest
displayName: Sample Test
description: Load test website home page
testPlan: SampleTest.jmx
testType: JMX
engineInstances: 1
subnetId: /subscriptions/abcdef01-2345-6789-0abc-def012345678/resourceGroups/sample-rg/providers/Microsoft.Network/virtualNetworks/load-testing-vnet/subnets/load-testing
configurationFiles:
  - 'sampledata.csv'
zipArtifacts:
   - bigdata.zip
splitAllCSVs: True
failureCriteria:
  - avg(response_time_ms) > 300
  - percentage(error) > 50
  - GetCustomerDetails: avg(latency) >200
autoStop:
  errorPercentage: 80
  timeWindow: 60
secrets:
  - name: my-secret
    value: https://akv-contoso.vault.azure.net/secrets/MySecret/abc1234567890def12345
keyVaultReferenceIdentity: /subscriptions/abcdef01-2345-6789-0abc-def012345678/resourceGroups/sample-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/sample-identity
```

## Configure load parameters

To simulate user traffic for your application, you can configure the load pattern and the number of virtual users you want to simulate load for. Azure Load Testing can scale out the number of virtual users that simulate traffic to your application by running the load test across many parallel test engine instances. The load pattern determines how the load is distributed over the duration of the load test. Examples of load patterns are **linear**, **stepped**, or **spike load**.

Depending on the type of load test, URL-based, or JMeter-based, you have different options to configure the target load and the load pattern. The following table lists the differences between the two test types.

| Test type            | Number of virtual users                                                                                                    | Load pattern                                                                |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| URL-based (basic)    | Specify the target number of virtual users in the load test configuration.                                                 | Linear load pattern, based on the ramp-up time and number of virtual users. |
| URL-based (advanced) | Specify the number of test engines and the number of virtual users per instance in the load test configuration.            | Configure the load pattern (linear, step, spike).                           |
| JMeter-based         | Specify the number of test engines in the load test configuration. Specify the number of virtual users in the test script. | Configure the load pattern in the test script.                              |

### Configure load parameters for JMeter-based tests

For GitHub Action workflows, you configure the number of engine instances in the YAML test configuration file. You store the load test configuration file alongside the JMeter test script file in the source control repository.

The following example configures a load test that runs across 10 parallel test engine instances.

Configure the number of test engine instances in the `engineInstances` setting.

```yaml
    version: v0.1
    testId: SampleTestCICD
    displayName: Sample test from CI/CD
    testPlan: SampleTest.jmx
    description: Load test website home page
    engineInstances: 10
```
