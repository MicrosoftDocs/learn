In this unit, you'll add a widget to your dashboard to help visualize your test runs over time.

## Add the widget to the dashboard

1. In your Azure DevOps project, select **Overview**, and then select **Dashboards**.

    > [!NOTE]
    > If you ran the template to create the Azure DevOps project, you won't see the dashboard widgets you set up in previous modules.

1. Select **Add a widget**.
1. In the **Add Widget** pane, search for **Test Results Trend**.
1. Drag **Test Results Trend** to the canvas.
1. Select the **Gear** icon to configure the widget.

    a. Under **Build pipeline**, select your pipeline.

    b. Keep the other default settings.
1. Select **Save**.
1. Select **Done Editing**.

Although the widget displays only one test run, you now have a way to visualize and track test runs over time. Here's an example that shows a few successful test runs.

:::image type="content" source="../media/5-test-results-trend-widget.png" alt-text="A screenshot of Azure DevOps Test Results Trend widget displaying a line trend chart of passing and failing tests.":::

If you begin to see test failures, you can select a point on the graph to navigate directly to that build.
