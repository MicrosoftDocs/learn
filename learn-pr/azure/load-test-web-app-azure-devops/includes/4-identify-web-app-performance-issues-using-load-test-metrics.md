Now that you have some results from your first set of performance tests, the next step is to evaluate these results, and then identify possible changes you might make to the **Contoso Costume Rentals** app, as well as additional testing that might provide more guidance to help with your next steps.

## What data is provided after a successful test run?

When you click on a completed test, you get a new results pane. This pane provides two chart areas; the first labeled **Details**, shows a set of key results from the test, and the second labeled **Web App Usage**, initially shows information on your app's CPU and memory consumption.

### Details

The **Details** chart shows the most important metrics from the performance test, presented in several sections.

![Chart showing an overview of the performance test results.](../media/4-results-overview.png)

This example shows:

- **Requests**: The number and proportion of **Successful** and **Failed** requests.

- **Messages**: Information on how the test was run; you can click in this list to get more details.

- **Performance under load**: Three metrics:

  - **Average response time (sec)**. This number, **7.12** seconds in the example, is the average time taken to respond to a successful request. This is a fairly high number, and many enterprises aim for under 5 seconds. Even a wait of 1 or 2 seconds can irritate users and so, when also taking potential network latencies into account, a typical response time target may be around 500 ms maximum. Response time is a measure of how quickly your app responds to requests and whether app performance decreases as more load is placed on it, perhaps because a back-end database is at full capacity or there are no more available CPU cycles for processing and delivering media files.

  - **User load**. This is the average number of virtual users that were concurrently accessing the site during the test period; in the example, **20 users** were configured in the test, and the server was always able to meet this number of users. When testing your app, you need to determine a realistic load to test against, and you might also run a series of tests where you incrementally increase the user load in order to find the point at which the server can longer support this number of users at the same time. you should check whether the maximum users you specified in the test configuration was reached in the test - if not, your app may not be able to scale.

  - **Requests/second**. This number, **2.17** in the example, is the average number of requests processed per second, and in this example as the response time increased, the number of processed requests decreased.

  The numbers shown on the chart are the average over the test period; if you move your mouse over the chart, you get the details of how these metrics changed during test period.

> [!IMPORTANT] 
> Remember that when using the Azure portal you are testing _one URL_, so you should repeat the test and specify other pages especially if functions such as database queries are only initiated from specific pages.

### Failed Requests

The **Requests** area of the chart shows the number of requests that failed, because the app did not respond quickly enough, perhaps due to server load, or because there were other issues such as poor network connectivity. You may also get failed requests if your app uses **throttling** under load, ignoring new requests until current requests are processed.

To get more details about failures, click in the **Requests** area to open the **Request Details** pane; in this example, the host closed the connection 36 times.

![Table shown after clicking in the Requests area of the overview chart.](../media/4-request-failure-details.png)

### Web App Usage

The **Web App Usage** area initially shows **CPU Time** and **Memory working set** over the previous hour, so if you are looking at test results more than an hour after completion, this graph may be empty. However, if you click on this chart, you get a new view over a longer time span, and the option to add other metrics to the chart, such as number of particular HTTP responses or server errors over time,

## What real-world questions do these results help to answer?

So you've now got some results, but how do these metrics help you with your Web app development and deployment?

- **Will my app be able to scale up from dev to production?** If the test results show that your app is already slowing down as more user requests are made, you may need to return to your design, or look at the provisioning more resources.
- **What is the current number of concurrent users that my app can support?** If your initial test results show that that there is decrease is response times as the test reaches the maximum number of users that you specified, then you should repeat the test adding users until you see an effect on performance; at this point, you are reaching a user limit.
- **How long is the typical wait time for a user to see my app in their browser?** Within the parameters you've set for the test, the average response time represents a fair approximation of wait time.
- **Does my app get quicker over time?** If the test results show an improvement in performance over the testing period, your app may be benefitting from caching; you should look at your app's functionality to see if this is due to client-side or server-side cache, and how you could exploit caching as you develop and scale up your app deployment.
- **Does my app get slower over time?** If the test results show a reduction in performance over the testing period, your app may be hitting issues such as CPU bottlenecks or network throttling; you should think about how your app works, and then do further tests to see if you can identify the specific issue.
- **Are there pages or functions that are particularly slow?** By repeating your tests with different URLs, you may be able to identify specific issues; the more configurable testing available with Azure DevOps will help here, and you'll at these tests in the next unit.

Some of these questions that cannot easily be answered using the testing you've done so far. In the next unit, you'll look at how you can use Azure DevOps for more configurable testing.

