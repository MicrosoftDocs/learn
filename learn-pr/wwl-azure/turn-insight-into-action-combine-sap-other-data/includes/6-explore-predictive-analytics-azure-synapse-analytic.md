

After you run the pipeline to transform data and join records, your dedicated SQL pool database table contains one record per vendor. The records include historical transactions and QA reports. You're ready to start performing analytics in Azure Synapse Studio.

Many organizations want to make sure they are working with quality data before spending time and money on machine learning. One way to check quality is with T-SQL queries to generate reports that you visualize with Power BI. Check to see if you can get reliable answers to questions like these before you move forward with predictive analytics:

- How many total vendors do we have for each part?
- What is the average time to fulfill an order?
- Which vendors fulfill orders fastest? Which are slowest?
- Which vendors achieve the highest quality ratings? The lowest?
- Which vendors have the highest quality and the shortest delivery time?

## SQL machine learning

At this point, you've validated the accuracy of your historical data. You're ready to predict which vendors have the highest likelihood of delivering high quality parts in the shortest possible time.

Machine learning requires data inputs, a data model that helps you achieve your results, and outputs, also known as a score. Your vendor analysis, for example, would output a score for each vendor.

To run your analysis, tap machine learning capabilities in Azure Synapse Analytics. T-SQL includes a [PREDICT T-SQL](/sql/t-sql/queries/predict-transact-sql) function to generate prediction values for data inputs in near real time. Use it with the combined data the pipeline extracted into your dedicated SQL pool.

The PREDICT function uses the native C++ extension capabilities in SQL machine learning. This methodology offers the fastest possible processing speed for forecasting and prediction workloads. It supports models created in [Open Neural Network Exchange (ONNX)](https://onnx.ai/get-started.html) format and other model creation methods. ONNX is an online community that enables data scientists and others to create and share machine learning models.

Imagine you've already created an ONNX model in Azure Machine Learning to support your business scenario. Your data scientist has used your combined data to train the ONNX model and output a dataset. Next step is to use native scoring on that dataset with T-SQL PREDICT.

Native scoring simplifies the scoring process by eliminating the need to call the R or Python interpreter. To use native scoring, call the PREDICT T-SQL function from your SQL script interface and pass the following required inputs:

- A compatible model based on a supported model and algorithm.
- A T-SQL query executed on your joined QA and vendor purchase data.

The function returns predictions based on the input data along with columns of source data in a new table. In your scenario, the machine learning function scores each vendor, which you can use as a vendor rating.

## Azure AI and machine learning

If your team has experience creating models in Azure Machine Learning, you can alternatively create and train a model in Azure Machine Learning studio. You can then run the model on your data in Synapse Studio. Connect to the machine learning service as a linked service in Azure Synapse Service: This approach requires a previously configured machine learning workspace.

## Scoring outputs for Power BI

Output your scoring results into a table in your SQL pool. The table will include columns based on the pre-scored data. You'll see vendor and part number, plus a new column with the vendor score, or rating. This table is what Power BI will use to create a data visualization.

## Summary

Azure Synapse Studio helps simplify analytics by enabling you to use T-SQL queries on data in your dedicated SQL pool. Synapse Studio also provides transformed data in a format ready for Power BI.
