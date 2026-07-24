Learn how to configure your load test in Azure Load Testing by using YAML. You use the test configuration YAML file to create and run load tests from your GitHub Actions workflow.

> [!NOTE]
> The examples in this unit use version `v0.1` of the load test configuration schema. The schema changes over time, so review the [load test YAML reference](/azure/app-testing/load-testing/reference-test-config-yaml) for the latest information.

## Load test YAML syntax

A load test configuration uses keys that identify the test plan, allocate test engines, and define supporting settings. Required keys provide the minimum information that Azure Load Testing needs to run a test. Optional keys add criteria, parameters, monitoring, networking, and regional distribution.

| Key | Type | Required | Default value | Description |
|--|--|--|--|--|
| `version` | string | Y |  | Load test specification version. The only supported value is `v0.1`. |
| `testId` | string | Y |  | Unique identifier of the load test. The value must be between 2 and 50 characters (`[a-z0-9_-]`). For an existing test, you can get the `testId` from the test details page in the Azure portal. |
| `testName` | string | N |  | **Deprecated**. Unique identifier of the load test. This setting is replaced with `testId`. You can still run existing tests with the `testName` field. |
| `displayName` | string | N |  | Display name of the test. The Azure portal shows this value in the list of tests. If you don't provide a value, Azure Load Testing uses `testId` as the display name. |
| `description` | string | N |  | Short description of the test. The value has a maximum length of 100 characters. |
| `testType` | string | Y |  | Test type. Possible values:<br/><ul><li>`URL`: URL-based load test</li><li>`JMX`: JMeter-based load test</li><li>`Locust`: Locust-based load test</li></ul> |
| `testPlan` | string | Y |  | Reference to the test plan file.<br/><ul><li>If `testType: JMX`: relative path to the JMeter test script.</li><li>If `testType: Locust`: relative path to the Locust test script.</li><li>If `testType: URL`: relative path to the requests JSON file.</li></ul> |
| `engineInstances` | integer | Y |  | Number of parallel test engine instances for running the test plan. |
| `configurationFiles` | array of string | N |  | List of external files required by the test script. For example, JMX fragments, CSV data files, images, or other data files.<br/>Azure Load Testing uploads all files in the same folder as the test script. JMeter and Locust scripts reference external files by file name without path information. |
| `failureCriteria` | object | N |  | List of load test fail criteria. |
| `autoStop` | string or object | N |  | Automatically stop the load test when the error percentage exceeds a value.<br/>Possible values:<br/>- `disable`: don't stop a load test automatically.<br/> |
| `properties` | object | N |  | JMeter user property file or Locust configuration file references. |
| `zipArtifacts` | array of string | N |  | Specifies the list of ZIP artifact files. Files other than the main script and property or configuration files require compression when they exceed 50 MB. Each ZIP file must remain below 50 MB. A test can contain up to 5 ZIP artifacts, with a maximum of 1,000 files and 1 GB of uncompressed data in each artifact. Applies when `testType` is `JMX` or `Locust`. |
| `splitAllCSVs` | boolean | N | False | Split the input CSV files evenly across all test engine instances. |
| `secrets` | object | N |  | List of secrets that the Apache JMeter or Locust script references. |
| `env` | object | N |  | List of environment variables that the Apache JMeter or Locust script references. |
| `certificates` | object | N |  | List of client certificates for authenticating with application endpoints in the JMeter or Locust script. |
| `appComponents` | object | N |  | List of server-side Azure resources and metrics to monitor during the load test. |
| `referenceIdentities` | object | N |  | List of managed identities used to access Key Vault, retrieve Azure Monitor metrics, or authenticate test-engine requests. |
| `subnetId` | string | N |  | Resource ID of the virtual network subnet for testing privately hosted endpoints. This subnet hosts the injected test engine VMs. |
| `publicIPDisabled` | boolean | N |  | Disable the deployment of a public IP address, load balancer, and network security group while testing a private endpoint. |
| `regionalLoadTestConfig` | object | N |  | Distribution of test engine instances across Azure regions. |

The following YAML snippet contains an example load test configuration.

```yaml
version: v0.1
testId: SampleTest
displayName: Sample Test
description: Load test website home page
testPlan: SampleTest.jmx
testType: JMX
engineInstances: 1
subnetId: /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/sample-rg/providers/Microsoft.Network/virtualNetworks/load-testing-vnet/subnets/load-testing
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
referenceIdentities:
  - kind: KeyVault
    type: UserAssigned
    value: /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/sample-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/sample-identity
```

## Configure load parameters

Load parameters control the number of virtual users and how the test distributes their activity over time. Azure Load Testing scales traffic across parallel test engine instances. The available load settings depend on whether you use a URL-based, JMeter-based, or Locust-based test.

| Test type | Number of virtual users | Load pattern |
|--|--|--|
| URL-based (basic) | The load test configuration specifies the target number of virtual users. | A linear pattern uses the ramp-up time and number of virtual users. |
| URL-based (advanced) | The load test configuration specifies the number of test engines and virtual users per instance. | The configuration supports linear, step, and spike patterns. |
| JMeter-based | The load test configuration specifies the number of test engines. The test script specifies the number of virtual users. | The test script defines the load pattern. |
| Locust-based | The load test configuration specifies the number of test engines. The Locust configuration specifies the number of users. | The Locust configuration or test script defines the spawn rate and load behavior. |

### Configure load parameters for JMeter-based tests

For GitHub Actions workflows, you configure the number of engine instances in the YAML test configuration file. You store the configuration file alongside the JMeter test script in the source control repository. The following example uses the `engineInstances` setting to run a load test across 10 parallel test engine instances.

```yaml
version: v0.1
testId: SampleTestCICD
displayName: Sample test from CI/CD
testPlan: SampleTest.jmx
testType: JMX
description: Load test website home page
engineInstances: 10
```

