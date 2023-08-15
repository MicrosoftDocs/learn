
After you've deployed your web app or website to any server, you can set up tests to monitor its availability and responsiveness.

It's helpful to check if your application is still running and gives a healthy response.

Some applications have specific Health endpoints that an automated process can check. The Health endpoint can be an HTTP status or a complex computation that uses and consumes crucial parts of your application.

For example, you can create a Health endpoint that queries the database. This way, you can check that your application is still accessible, but also the database connection is verified.

You can create your framework to create availability tests (ping test) or use a platform that can do it for you.

Azure has the functionality to develop Availability tests. You can use these tests in the pipeline and as release gates.

In Azure, you can set up availability tests for any HTTP or HTTPS endpoint accessible from the public internet.

You don't have to add anything to the website you're testing. It doesn't even have to be your site: you could try a REST API service you depend on.

There are two types of availability tests:

 -  URL ping test: a simple test that you can create in the Azure portal. You can check the URL and check the response and status code of the response.
 -  Multi-step web test: Several HTTP calls that are executed in sequence.

For more information, see also:

 -  [Creating an Application Insights Web Test and Alert Programmatically](https://azure.microsoft.com/blog/creating-a-web-test-alert-programmatically-with-application-insights/).
 -  [Monitor the availability of any website](/azure/application-insights/app-insights-monitor-web-app-availability).
