In this exercise, you use [Power BI](/power-bi/fundamentals/power-bi-overview) to create a report displaying captured vehicle anomaly data and pin it to a live dashboard for near-real-time updates. Power BI provides a platform for visualizing and analyzing aggregated data in a near-real-time analytics pipeline built on Azure Event Hubs, Azure Stream Analytics, and Power BI.

1. Open a web browser, navigate to <https://powerbi.microsoft.com/>, and select **Sign in** on the upper right.

    ![The Power BI home page is shown with the Sign in link highlighted.](../media/power-bi-sign-in-2.png "Power BI home page")

2. Enter your Power BI credentials you used when creating the Power BI output for Stream Analytics.

3. After signing in, select **My Workspace** on the left-hand menu.

    ![The My Workspace link is selected on the left-hand menu.](../media/power-bi-my-workspace-link.png "My Workspace")

4. Select the **Datasets + dataflows** tab on top of the workspace. Locate the dataset named **ContosoAutoVehicleAnomalies**, then select the **Create Report** action button to the right of the name. If you do not see the dataset, you may need to wait a few minutes and refresh the page.

    ![The Datasets tab is selected in My Workspace, and the VehicleAnomalies dataset is highlighted.](../media/power-bi-my-workspace.png "Datasets")

    > [!Note]
    > It can take several minutes for the dataset to appear. Periodically, you may need to refresh the page before you see the Datasets tab.

5. You should see a new blank report for VehicleAnomalies with the field list on the far right.

    ![A new blank report is displayed with the field list on the right.](../media/power-bi-blank-report.png "Blank report")

6. Select the **Map** visualization within the Visualizations section on the right.

    ![The Map visualization is highlighted.](../media/power-bi-map-visualizations.png "Visualizations")

7. Drag the **city** field to **Location**, and **aggressivedriving** to **Size**. Adding these values to the visualization places points of different sizes over cities on the map, depending on how many aggressive driving records there are.

    ![The screenshot displays where to drag the fields onto the map settings.](../media/power-bi-map-fields.png "Map settings")

8. Your map should look similar to the following graphic:

    ![The map is shown on the report.](../media/power-bi-map-2.png "Map")

9. Select a blank area on the report to deselect the map. Now select the **Treemap** visualization.

    ![The Treemap visualization is highlighted.](../media/power-bi-treemap-visualizations.png "Visualization")

10. Drag the **enginetemperature** field to **Values**, then drag the **transmission_gear_position** field to **Group**. This will group the engine temperature values by the transmission gear position on the treemap so you can see which gears are associated with the hottest or coolest engine temperatures. The treemap sizes the groups according to the values, with the largest appearing on the upper left and the lowest on the lower right.

    ![Screenshot displaying where to drag the fields onto the treemap settings.](../media/power-bi-treemap-fields.png "Treemap settings")

11. Select the down arrow next to the **enginetemperature** field under **Values**. Select **Average** from the menu to aggregate the values by average instead of the sum.

    ![The Average menu option is highlighted for the enginetemperature value.](../media/power-bi-treemap-average.png "Average engine temperature")

12. Your treemap should look similar to the following graphic:

    ![The treemap is shown on the report.](../media/power-bi-treemap.png "Treemap")

13. Select a blank area on the report to deselect the treemap. Now select the **Area chart** visualization.

    ![The Area chart visualization is highlighted.](../media/power-bi-areachart-visualizations.png "Area chart visualization")

14. Drag the **region** field to **Legend**, the **speed** field to **Values**, and the **timestamp** field to **Axis**. This will display an area chart with different colors indicating the region and the speed at which drivers travel over time within that region.

    ![Screenshot displaying where to drag the fields onto the area chart settings.](../media/power-bi-areachart-fields.png "Area chart settings")

15. Select the down arrow next to the **speed** field under **Values**. Select **Average** from the menu to aggregate the values by average instead of the sum.

    ![The Average menu option is highlighted for the speed value.](../media/power-bi-areachart-average.png "Average speed")

16. Your area chart should look similar to the following graphic:

    ![The area chart on the report.](../media/power-bi-areachart.png "Area chart")

17. Select a blank area on the report to deselect the area chart. Now select the **Multi-row card** visualization.

    ![The multi-card visualization is highlighted.](../media/power-bi-card-visualizations.png "Multi-row card visualization")

18. Drag the **aggressivedriving** field, **enginetempanomaly**, and **oilanomaly** fields to **Fields**.

    ![Screenshot displaying where to drag the fields onto the multi-row card settings.](../media/power-bi-card-fields.png "Multi-row card settings")

19. Select the **Format** tab in the multi-row card settings, then expand **Data labels**. Set the **Text size** to 30. Expand **Category labels** and set the **Text size** to 12.

    ![Screenshot of the format tab.](../media/power-bi-card-format.png "Multi-row card format")

20. Your multi-row card should look similar to the following graphic:

    ![The multi-row card on the report.](../media/power-bi-card.png "Multi-row-card")

21. Select **Save** on the upper right of the page.

    ![The save button is highlighted.](../media/power-bi-save.png "Save")

22. Enter a name, such as "Contoso Auto Vehicle Anomalies," then select **Save**.

    ![Screenshot of the save dialog.](../media/power-bi-save-dialog.png "Save dialog")

23. Now, let's add this report to a dashboard. Select **Pin to a dashboard** at the top of the report. You may have to select the ellipses (...) icon to see the option.

    ![The pin to a dashboard button is highlighted.](../media/power-bi-live.png "Pin to a dashboard")

24. Select **New dashboard**, then enter a name, such as "Contoso Auto Vehicle Anomalies Dashboard." Select **Pin live**. When prompted, select the option to view the dashboard. Otherwise, you can find the dashboard under My Workspace on the left-hand menu.

    ![Screenshot of the pin to dashboard dialog.](../media/power-bi-live-dialog.png "Pin to dashboard dialog")

25. The live dashboard will automatically refresh and update while data is being captured. You can hover over any point on a chart to view information about the item. Select one of the regions in the legend above the average speed chart. All other charts will filter by that region automatically. Select the region again to clear the filter.

    ![The live dashboard view.](../media/power-bi-dashboard.png "Dashboard")
