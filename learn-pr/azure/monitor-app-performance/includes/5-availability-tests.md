After you've deployed your web app or website, you can set up recurring tests to monitor availability and responsiveness. Application Insights sends web requests to your application at regular intervals from points around the world. It can alert you if your application isn't responding or responds too slowly.

You can set up availability tests for any HTTP or HTTPS endpoint that's accessible from the public internet. You don't have to make any changes to the website you're testing. In fact, it doesn't even have to be a site that you own. You can test the availability of a REST API that your service depends on.

You can create up to 100 availability tests per Application Insights resource, and there are three types of availability tests:

* [URL ping test (classic)](/azure/azure-monitor/app/monitor-web-app-availability): You can create this test through the portal to validate whether an endpoint is responding and measure performance associated with that response. You can also set custom success criteria coupled with more advanced features, like parsing dependent requests and allowing for retries.
* [Standard test (Preview)](/azure/azure-monitor/app/availability-standard-tests): This single request test is similar to the URL ping test. It includes SSL certificate validity, proactive lifetime check, HTTP request verb (for example `GET`, `HEAD`, or `POST`), custom headers, and custom data associated with your HTTP request.
* [Custom TrackAvailability test](/azure/azure-monitor/app/availability-azure-functions): If you decide to create a custom application to run availability tests, you can use the [TrackAvailability()](/dotnet/api/microsoft.applicationinsights.telemetryclient.trackavailability) method to send the results to Application Insights.

> [!NOTE]
> **Multi-step test** is a fourth type of availability test, however that is only available through Visual Studio 2019. **Custom TrackAvailability test** is the long term supported solution for multi request or authentication test scenarios.

> [!IMPORTANT]
> The **URL ping test** relies on the DNS infrastructure of the public internet to resolve the domain names of the tested endpoints. If you're using private DNS, you must ensure that the public domain name servers can resolve every domain name of your test. When that's not possible, you can use custom **TrackAvailability tests** instead.

Visit the [troubleshooting](/azure/azure-monitor/app/troubleshoot-availability) article for guidance on diagnosing availability issues.
