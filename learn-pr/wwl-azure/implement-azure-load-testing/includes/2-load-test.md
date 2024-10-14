Azure Load Testing is a service provided by Microsoft Azure that allows developers and testers to generate high-scale loads to identify performance bottlenecks in applications and automate regression testing. It's designed to help optimize the performance, scalability, and capacity of applications by simulating real-world loads.

## Azure Load Testing components

Azure load testing consists of the following components:

- **Load testing resource**
- **Test**
- **Test Run**
- **Test engine**
- **App component**

:::image type="content" source="../media/load-testing.png" alt-text="Diagram illustrating the process of load testing.":::

### Load testing resource

The Azure load testing resource is the top-level resource for your load-testing activities. This resource provides a centralized place to view and manage load tests, test results, and related artifacts.

When you create a load test resource, you specify its location, which determines the location of the test engines.

To run a load test for your application, you add a test to your load testing resource.

### Test

A test describes the load test configuration settings for running a load test. You add a test to an existing Azure load testing resource.

A test contains the following configuration settings for running the load test:

- **Test plan**: the steps to invoke the application endpoint. You can define the test plan in either of two ways:

  - Upload a JMeter test script.
  - Specify the list of URL endpoints to test.

- **Load test parameters**: Environment variables, secrets, and certificates.
- **Load configuration**: Specify the number of test engines in the load test configuration. Specify the number of virtual users in the test script.
- **Test criteria**: Define failure criteria to specify the performance expectations in the test and configure auto-stop settings for the test.
- **Monitoring settings**: Configure the list of Azure app components and resource metrics to monitor.

When you start a test, Azure Load Testing deploys the JMeter test script, related files, and configuration to the test engine instances. The test engine instances then initiate the JMeter test script to simulate the application load.

Each time you start a test, Azure Load Testing creates a **test run** and attaches it to the test.

### Test run

A test run represents one execution of a load test. When you run a test, the test run contains a copy of the configuration settings from the associated test.

After the test run completes, you can view and analyze the load test results in the Azure Load Testing dashboard. You can also download the test logs and export the test results file.

> [!IMPORTANT]
> When you update a test, the existing test runs don't automatically inherit the new settings from the test. The new settings are only used by new test runs when you run the *test*. If you rerun an existing *test run*, the original settings of the test run are used.

### Test engine

A test engine is computing infrastructure, managed by Microsoft that runs the Apache JMeter test script. The test engine instances run the JMeter script in parallel. You can scale out your load test by configuring the number of test engine instances. Azure Load Testing can scale out the number of virtual users that simulate traffic to your application by running the load test across many parallel test engine instances. The load pattern determines how the load is distributed over the duration of the load test.

Examples of load patterns:

- linear
- stepped
- spike

### App component

When you run a load test for an Azure-hosted application, you can monitor resource metrics for the different Azure application components (server-side metrics). While the load test runs, and after completion of the test, you can monitor and analyze the resource metrics in the Azure Load Testing dashboard.

When you create or update a load test, you can configure the list of app components that Azure Load Testing will monitor. You can modify the list of default resource metrics for each app component.

Now that you understand the key concepts and components of Azure Load Testing, lets learn how to create and manage an Azure Load Testing resource.
