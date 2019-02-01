The following example can help demonstrate how to perform holistic data engineering using the source, ingest, prepare, analyze, and consume approach.

Contoso Health Network recently deployed IoT devices into its Intensive Care Unit (ICU) to be able to capture patient biometric monitoring data in real time.  The hospital intends on processing the streaming data from the IoT devices to help the physicians treat these patients.  Contoso's research center would like to store the biometric data for further analysis in the future.  Their researchers would like to understand further what treatment methods have been used to improve the quality of care and to reduce the likelihood of the patient being readmitted to the hospital through Azure Machine Learning. Contoso's Chief Medical Officer would like a historical view of this data that is visualized.

Contoso's technical architect reviewed the business case and proposed the following technologies:

- **Azure IoT Hub**.  To capture real-time data from the ICU's IoT devices.
- **Azure Streaming Analytics**.  To stream the IoT data, create windows, aggregations, integrate Azure Machine Learning, and to further enrich data.
- **Azure Data Lake Gen2**.  To store the biometric data at speed.
- **Azure Data Factory**.  To perform the extract, load, transform, and load operations from the data lake store into SQL DW.
- **Azure SQL DW**.  To provide data warehousing services to support the Chief Medical Officer's needs.
- **Power BI**.  To create the patient dashboard.  Part of the dashboard will host real-time telemetry regarding the patient's condition while the other visual will display the patient's recent history.  
- **Azure Machine Learning Services** – used to process both the raw and aggregated data to perform patient readmittance predictive analytics.

Contoso's Data Engineer creates a work plan to implement the Extract, Load, Transform, and Load operations.

## Provisioning workflow

1. Provision Azure Data Lake Gen2
2. Provision Azure SQL Data Warehouse
3. Provision Azure IoT Hub
4. Provision Azure Streaming Analytics
5. Provision Azure Machine Learning
6. Provision Azure Data Factory
7. Provision Power BI

## Holistic Workflow

1. Configure Azure IoT Hub to capture data from the ICU IoT devices.
2. Connect Azure IoT Hub to Azure Streaming Analytics.  Configure the windowing functions for the ICU data that will aggregate the data for each window. At the same time, configure the IoT hub to dump the streaming data to the Azure Data Lake using Azure Functions.
3. Configure Azure functions to store the Azure Streaming Analytics aggregates to Azure Data Lake Gen2.
4. Use Azure Data Factory to load data from the Data Lake into Azure SQL Data Warehouse to support the Chief Medical Officer's requirements. Transformations can occur within Azure SQL Data Warehouse once loaded.
5. In parallel, connect Azure Machine Learning Service to the Azure Data Lake Store to perform the Predictive Analytics.
6. Connect Power BI to Streaming Analytics to pull the real-time aggregates for the Patient data and SQL Data Warehouse to pull the historical data to create a combined dashboard.

## Related high-level architecture diagram

The following high-level architecture diagram provides a visualization of the solution.

![High-Level Architecture Diagram](../media/4-high-level-architecture.png)