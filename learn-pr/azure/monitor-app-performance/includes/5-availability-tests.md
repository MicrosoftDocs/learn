After you deploy your web app or website, you can set up recurring tests to monitor availability and responsiveness. Application Insights sends web requests to your application at regular intervals from points around the world. It can alert you if your application isn't responding or responds too slowly. You can create up to 100 availability tests per Application Insights resource.

Availability tests don't require any changes to the website you're testing and work for any HTTP or HTTPS endpoint that's accessible from the public internet. You can also test the availability of a REST API that your service depends on.

You can create up to 100 availability tests per Application Insights resource, and there are three types of availability tests:

* **Standard test:** This is a type of availability test that checks the availability of a website by sending a single request, similar to the deprecated URL ping test. In addition to validating whether an endpoint is responding and measuring the performance, Standard tests also include TLS/SSL certificate validity, proactive lifetime check, HTTP request verb (for example, `GET`,`HEAD`, and `POST`), custom headers, and custom data associated with your HTTP request.

* **Custom TrackAvailability test:** If you decide to create a custom application to run availability tests, you can use the [TrackAvailability()](/dotnet/api/microsoft.applicationinsights.telemetryclient.trackavailability) method to send the results to Application Insights.

* [URL ping test (classic)](/azure/azure-monitor/app/monitor-web-app-availability): You can create this test through the portal to validate whether an endpoint is responding and measure performance associated with that response. You can also set custom success criteria coupled with more advanced features, like parsing dependent requests and allowing for retries.

> [!IMPORTANT]
> **URL ping tests:** On September 30, 2026, URL ping tests in Application Insights will be retired. Existing URL ping tests will be removed from your resources. Review the [pricing](https://azure.microsoft.com/pricing/details/monitor) for standard tests and [transition](https://aka.ms/availabilitytestmigration) to using them before September 30, 2026 to ensure you can continue to run single-step availability tests in your Application Insights resources.
