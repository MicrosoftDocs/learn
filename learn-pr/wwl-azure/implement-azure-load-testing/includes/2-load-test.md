Azure Load Testing enables developers and testers to generate high-scale loads that identify performance bottlenecks and support automated regression testing. The service helps you optimize application performance, scalability, and capacity by simulating real-world loads.

## Azure Load Testing components

Azure Load Testing organizes load-testing activities into resources, tests, test runs, test engines, and app components. Each component controls a different part of test configuration, execution, or analysis. The following list introduces the components that you use throughout a load test.

- **Load testing resource**
- **Test**
- **Test run**
- **Test engine**
- **App component**

### Load testing resource

The Azure load testing resource is the top-level resource for your load-testing activities. This resource provides a centralized place to view and manage load tests, test results, and related artifacts.

When you create a load test resource, you specify its location, which determines the location of the test engines.

To run a load test for your application, you add a test to your load testing resource.

### Test

A test describes the load test configuration settings for running a load test. You add a test to an existing Azure load testing resource.

A test contains the following configuration settings for running the load test:

- **Test plan:** Defines the steps that invoke the application endpoint. You can define the test plan in three ways:
    - You can upload a JMeter test script.
    - You can upload a Locust test script.
    - You can specify a list of URL endpoints to test.

- **Load test parameters:** Include environment variables, secrets, and certificates.
- **Load configuration:** Specifies the number of test engines in the load test configuration and the number of virtual users in the test script.
- **Test criteria:** Define the performance expectations and auto stop settings for the test.
- **Monitoring settings:** Identify the Azure app components and resource metrics to monitor.

When you start a test, Azure Load Testing deploys the test script, related files, and configuration to the test engine instances. The test engine instances then run the test plan to simulate the application load.

Each time you start a test, Azure Load Testing creates a **test run** and attaches it to the test.

### Test run

A test run represents one execution of a load test. When you run a test, the test run contains a copy of the configuration settings from the associated test.

After the test run completes, you can view and analyze the load test results in the Azure Load Testing dashboard. You can also download the test logs and export the test results file.

> [!IMPORTANT]
> When you update a test, existing test runs keep their original settings. New test runs use the updated test settings. If you rerun an existing *test run*, Azure Load Testing uses that run's original settings.

### Test engine

A test engine is Microsoft-managed compute infrastructure that runs an Apache JMeter or Locust test plan. Test engine instances run the test plan in parallel. You can scale the number of virtual users that simulate traffic by configuring multiple parallel test engine instances. The load pattern determines how Azure Load Testing distributes the load over the test duration.

Examples of load patterns:

- Linear.
- Stepped.
- Spike.

### App component

When you run a load test for an Azure-hosted application, you can monitor resource metrics for the different Azure application components (server-side metrics). While the load test runs and after it completes, you can monitor and analyze the resource metrics in the Azure Load Testing dashboard.

When you create or update a load test, you can configure the list of app components that Azure Load Testing monitors. You can modify the list of default resource metrics for each app component.

Learn more about which [Azure resource types Azure Load Testing supports](/azure/app-testing/load-testing/resource-supported-azure-resource-types).
