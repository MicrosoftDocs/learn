

You’ve analyzed the data and made predictions. Your next step is to help business decision makers understand your findings. In this scenario, you’ll use Power BI for data visualization.

This step requires a Power BI online service workspace. You’ll use the workspace in conjunction with your Power BI Desktop application.

## Connect to Power BI online service

First, add a new workspace to your existing Power BI online service for this scenario. You’ll use an Azure Synapse linked service to connect to your Power BI online service and new workspace. You can view and edit Power BI datasets and reports within Azure Synapse Studio and create new reports. When ready, you can share those reports from your Power BI online service.

To connect your Synapse Studio workspace to your new Power BI service workspace, follow these steps:

1. Select **Visualize** on the Azure Synapse Analytics home page.
1. Complete the form and select **Create**.

:::image type="content" source="../media/visualize-button-cropped.png" alt-text="Screenshot of Synapse Studio workspace screen showing the Visualize button that connects to your new Power B I service workspace." lightbox="../media/visualize-button.png":::

After you connect the two workspaces, you can interact with datasets and reports in the Power BI online workspace from Azure Synapse Analytics. You’re ready to get your data and reports into the Power BI workspace so they can be used by Synapse Analytics to complete the scenario.

## Display results in a data visualization

To help decision makers compare vendor ratings, make sure your ratings are viewable in a Power BI data visualization. Create reports in Power BI Desktop based on the Azure Synapse dataset and save them to your Power BI online service before you can share them. Follow these steps:

1. Open Power BI Desktop.
1. Select **Get data** to connect to the dedicated SQL pool in Synapse Analytics. Select your new table and use filters and charting in Power BI to fine-tune the view.
1. Save your new report in the Power BI workspace that you’ve linked to Azure Synapse Studio. Any future saved changes will be written back to the online Power BI workspace. Your reports and datasets are viewable in Azure Synapse Studio.
1. Publish and share your reports from the Power BI workspace as you normally would.
1. Assign permissions to the decision makers that need to see the vendor ratings.

## Summary

Azure Synapse Studio enhances productivity by enabling you to create Power BI reports and visualizations without leaving Synapse. In the fictitious business scenario, you’ve ingested data from multiple sources, applied analytics and machine learning for a scored dataset, and visualized it with Power BI.
