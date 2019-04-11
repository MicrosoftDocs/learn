In the previous module, you set up a dashboard so that you can monitor pull requests and visualize the health of your builds.

Here, you'll add a widget to the dashboard to monitor the tests.

Talk track:

* Cool, we have a passing unit test that's run in the pipeline whenever changes are made.
* Alice maybe shows Andy and then they both show Amita.
* Amita: That's certainly cool! I bet that will certainly help us all. But is there a way I can just see a brief overview of test results over time?
* Alice: Yes. Azure DevOps lets you set up dashboards that you can add widgets to. Dashboards can help the team and other teams see things like build health and tests result trends over time.

TODO: Knowledge needed: 
  * What is the Marketplace? 
  * Mention that many add-ons are free, but some still require an evaluation or license key?

## Add a widget to the dashboard

1. From Azure DevOps, select **Overview** and then **Dashboards**.
1. Click **Add a widget**.
1. From the **Add Widget** pane, search for **Test Results Trend**.
1. Drag **Test Results Trend** to the canvas.
1. Click the gear icon to configure the widget.
    1. Under **Build pipeline**, select your pipeline.
    1. Keep all other settings at their default.
1. Click **Save**.
1. Click **Done Editing**.

Although the widget shows only one test run, you now have a way to visualize and track test runs over time.

![](../media/5-test-results-trend-widget.png)

If you begin to see test failures, you can click on a point in the graph to navigate directly to that build.