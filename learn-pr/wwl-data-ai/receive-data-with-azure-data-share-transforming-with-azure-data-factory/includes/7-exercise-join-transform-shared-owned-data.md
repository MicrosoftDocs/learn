## Transform data using mapping data flow

Now that you have successfully copied data into Azure Data Lake Storage, it is time to join and aggregate that data into a data warehouse. 

We will use mapping data flow, Azure Data Factory's visually designed transformation service. Mapping data flows allow users to develop transformation logic code-free and execute them on spark clusters managed by the ADF service.

The data flow created in this step inner joins the 'TripDataCSV' dataset created in the previous section with the 'TripFares.csv' file shared via Azure Data Share. based on four key columns. Then the data gets aggregated based upon column payment_type to calculate the average of certain fields and written in a Azure Synapse Analytics table.

## Add a data flow activity to your pipeline

In the activities pane of the pipeline canvas, open the Move and Transform accordion and drag the Data flow activity onto the canvas.

:::image type="content" source="../media/azure-data-factory-dataflow-move-transform.png" alt-text="Move and Transform":::

In the side pane that opens, select Create new data flow and choose Mapping data flow. 

Click OK.

   :::image type="content" source="../media/azure-data-factory-create-new-dataflow.png" alt-text="Create new DataFlow":::

You'll be directed to the data flow canvas where you will be building your transformation logic. 

In the general tab, name your data flow 'JoinAndAggregateData'.

   :::image type="content" source="../media/azure-data-factory-properties-dataflow.png" alt-text="Properties new DataFlow":::

Configure your trip data csv source

The first thing you want to do is configure your two source transformations. The first source will point to the 'TripDataCSV' DelimitedText dataset. To add a source transformation, click on the Add Source box in the canvas.

   :::image type="content" source="../media/azure-data-factory-add-source-dataflow.png" alt-text="Add Source to Dataflow":::

Name your source 'TripDataCSV' and select the 'TripDataCSV' dataset from the source drop-down. 

Since trip-data.csv exists now, click Open to go to the dataset settings tab.

   :::image type="content" source="../media/azure-data-factory-source-dataflow.png" alt-text="Source Settings of Dataflow":::

Go to tab Schema and click Import schema. 

Select From connection/store to import directly from the file store. 

   :::image type="content" source="../media/azure-data-factory-schema-definition-dataflow-source.png" alt-text="Schema definition source Dataflow":::

If you select From connection/store the columns should appear as following:

   :::image type="content" source="../media/azure-data-factory-schema-source-connection.png" alt-text="Schema definition from Connection":::

Go back to data flow 'JoinAndAggregateData'. 

If your debug cluster has started (indicated by a green circle next to the debug slider), you can get a snapshot of the data in the Data Preview tab. 

Click Refresh to fetch a data preview.

   :::image type="content" source="../media/azure-data-factory-source-schema-map.png" alt-text="Source Settings after Schema Mapping Dataflow":::

When you select the Data Preview tab and click refresh the data will be fetched as long as your debug cluster is green, however Data preview does not write data. 

   :::image type="content" source="../media/azure-data-factory-data-preview-source-dataflow.png" alt-text="Data Preview Fetching Data":::

## Configure your trip fares csv source:

The second source you're adding will point at the csv file 'TripFares.csv' that was shared during the Azure Data Share exercise. 

Under your 'TripDataCSV' source, there will be another Add Source box. 

Click it to add a new source transformation.

   :::image type="content" source="../media/azure-data-factory-add-source-transformation-dataflow.png" alt-text="Add Source Transformation":::

Name this source 'TripFaresCSV'. 

Click New next to the source dataset field to create a new ADLS gen2 dataset.

   :::image type="content" source="../media/azure-data-factory-new-source-transformation.png" alt-text="New Source creation for Transformation":::

Select the Azure Data Lake Storage gen2 tile and click continue.

You may notice many of the connectors in data factory are not supported in mapping data flow. To transform data from one of these sources, ingest it into a supported source using the copy activity.

   :::image type="content" source="../media/azure-data-factory-select-azure-data-lake-storage-gen-2-source-transform.png" alt-text="Select Azure Data Lake Storage Gen 2 for new Source Transformation":::

In the select format pane, select DelimitedText as you are reading from a csv file. Click continue.

   :::image type="content" source="../media/azure-data-factory-delimited-text-selection-dataset-type.png" alt-text="Select Delimited Text":::

Name your dataset 'TripFaresCSV'. 

Select 'ADLSGen2' as your linked service. 

Set the file path to taxidata/TripFares.csv. In the Azure Data Share exercise you have called it TripFares.csv in container 'taxidata'. 

Set First row as header to true as the input data has headers. 

Import the schema From connection/store. 

Click OK when finished.

   :::image type="content" source="../media/azure-data-factory-azure-data-lake-storage-set-properties.png" alt-text="Set properties of File":::

To verify your source is configured correctly, fetch a data preview in the Data Preview tab.

   :::image type="content" source="../media/azure-data-factory-data-preview.png" alt-text="Data Preview of created dataset":::

## Inner join TripDataCSV and TripFaresSQL

To add a new transformation, click the plus icon in the bottom-right corner of 'TripDataCSV'. 

Under Multiple inputs/outputs, select Join.

   :::image type="content" source="../media/azure-data-factory-add-join-transformation.png" alt-text="Add Join Transformation":::

Name your join transformation 'InnerJoinWithTripFares'. 

Select 'TripFaresCSV' from the right stream dropdown. 

Select Inner as the join type. 

Select which columns you wish to match on from each stream via the Join conditions dropdown. 

To add an additional join condition, click on the plus icon next to an existing condition. 

By default, all join conditions are combined with an AND operator which means all conditions must be met for a match. 

We want to match on columns medallion, hack_license, vendor_id, and pickup_datetime

   :::image type="content" source="../media/azure-data-factory-match-columns-join.png" alt-text="Match Columns for Join Transformation":::

Verify you successfully joined 25 columns together with Data Preview.

   :::image type="content" source="../media/azure-data-factory-data-preview-join-transform.png" alt-text="Data Preview for Join Transformation":::

## Aggregate by payment_type

After you complete a join transformation, add an aggregate transformation by clicking the plus icon next to 'InnerJoinWithTripFares. 

Choose Aggregate under Schema modifier and call the Aggregate: ‘AggregateByPaymentType’

   :::image type="content" source="../media/azure-data-factory-aggregate-transformation.png" alt-text="Add Aggregation for Transformation":::

Name your aggregate transformation 'AggregateByPaymentType'. Select payment_type as the group by column.

   :::image type="content" source="../media/azure-data-factory-groupby-column-aggregation.png" alt-text="Group by setting for Aggregation":::

Go to the Aggregates tab. Here, you will specify two aggregations:
    
    * The average fare grouped by payment type
    
    * The total trip distance grouped by payment type
    
Create  the average fare expression. 
    
In the text box labeled Add or select a column, enter 'average_fare'.

   :::image type="content" source="../media/azure-data-factory-aggregate.png" alt-text="Aggregates settings":::

To enter an aggregation expression, click on the marker next to the  the blue box labeled Enter expression.  

   :::image type="content" source="../media/azure-data-factory-aggregation-expression.png" alt-text="Expression builder for Aggregations":::

This will open up the data flow expression builder, a tool used to visually create data flow expressions using input schema, built-in functions and operations, and user-defined parameters. For more information on the capabilities of the expression builder, see the expression builder documentation.

To get the average fare, use the avg() aggregation function to aggregate the total_amount column cast to an integer with toInteger(). In the data flow expression language, this is defined as avg(toInteger(total_amount)). 

Click Save and finish when you are done.

   :::image type="content" source="../media/azure-data-factory-visual-expression-builder.png" alt-text="Visual Expression builder for Aggregations":::

To add an additional aggregation expression, click on the plus icon next to average_fare. 

Select Add column.

   :::image type="content" source="../media/azure-data-factory-add-expression-new-column.png" alt-text="Add a column for another expression":::

In the text box labeled  Add or select a column, enter 'total_trip_distance'. As in the last step, open the expression builder to enter in the expression.

To get the total trip distance, use the sum() aggregation function to aggregate the trip_distance column cast to an integer with toInteger(). 

In the data flow expression language, this is defined as sum(toInteger(trip_distance)).

   :::image type="content" source="../media/azure-data-factory-expression-builder-new-aggregate.png" alt-text="Add expression to new column":::

Click Save and finish.

Test your transformation logic in the Data Preview tab.

  :::image type="content" source="../media/azure-data-factory-data-preview-aggregation.png" alt-text="Data Preview of Aggregation":::


