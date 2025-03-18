When you were first introduced to Power BI, you probably learned how to get data from various sources such as SQL Server databases, Excel files, and even text files. Creating the same or similar semantic model for each report is tedious work. Further, if others also want to develop reports on that exact semantic model, what's your process for sharing?

## Create reusable core assets

Assets can mean semantic models, dataflows, reports, and dashboards, and we most commonly mean semantic models in this module. In our previous example, you spent precious time curating the perfect semantic model, and now you can share and reuse it. Before creating visuals, publish the file to Power BI service and effectively create a *core semantic model*.

Next time someone needs to create a report on that semantic model, they can connect to a Power BI semantic model from Power BI Desktop. If you publish to a shared location, it allows peers to use the same semantic model. A single shared semantic model protects data integrity. This trustworthy semantic model also prevents orphaned semantic models when someone recreates a report without deleting the earlier copies. As an enterprise data analyst, it's your responsibility to be a good data steward to encourage the democratization of data rather than disparate copies of data with questionable quality.

:::image type="content" source="../media/power-bi-connect-semantic-models.png" alt-text="Screenshot showing the Power BI semantic model connection option.":::

## Create specialized semantic models

In our introduction example, we recognized the need to reduce report size and provide targeted reports across regions. To meet these goals, we can create *specialized semantic models*. Consider creating a new semantic model with the specific regional data, instead of limiting regional users access to a single global report.

To create a specialized semantic model, open a new Power BI Desktop instance and connect to the core semantic model. You're now connected live to that semantic model, which doesn't allow any changes to the model, but you can filter and visualize data. Use the **Make changes to the model** option to switch from a live connection to DirectQuery.

:::image type="content" source="../media/dataset-direct-query.png" alt-text="Screenshot of Power BI Desktop notice that DirectQuery connection is required, after selecting the Make changes to the model option.":::

In the following screenshot, there are three tables from the connected semantic model and two new tables added. You can add measures, calculation groups, and more.

:::image type="content" source="../media/composite-dataset.png" alt-text="Screenshot of a model with three tables from one semantic model and two other tables from the newly expanded data source.":::

> [!NOTE]
> You need a data gateway configured to support the DirectQuery model if you want to make changes to the underlying semantic model. For more information, see [What is an on-premises data gateway](/data-integration/gateway/service-gateway-onprem) documentation.

## Power BI Template files

Power BI Template *.pbit* files allow you to save a report to reuse or share for different purposes. These template files are highly customizable, depending on your needs. When you saved a template file, it has all of the same information as if you saved a traditional *.pbix* file.

You can create a standardized report design template. Consider your organization is getting started with Power BI and users are still learning how to interact with reports. As an example, you can create a template with a header for title, description, and location for applicable slicers. You can now save and close the template, and then open the template to start creating your new report. If you have a report that already has your desired format, you can also remove all data sources and save it so only the theme and visual configurations are stored.

You can also use a template as a starting point for future reports or as a *gold copy* to preserve the state before modifying the report. In this scenario, you can create the entire report, then save as a template as an extra copy of the file. While it's not recommended to use a template file for version control, it might be helpful when you're still developing a report or are collaborating on the report and want a backup. Since Power BI templates open as an unsaved file, any changes made wouldn't affect the template file unless you specifically save and overwrite the template file.

> [!NOTE]
> For more information, see the [Create and use report templates in Power BI Desktop](/power-bi/create-reports/desktop-templates) documentation.
