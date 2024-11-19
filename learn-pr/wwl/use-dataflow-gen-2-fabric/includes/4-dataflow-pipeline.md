---
ms.custom:
  - build-2023
---
Dataflows Gen2 provide an excellent option for data transformations in Microsoft Fabric. The combination of dataflows and pipelines is useful when you need to perform additional operations on the transformed data.

Data pipelines are a common concept in data engineering and offer a wide variety of activities to orchestrate. Some common activities include:

- Copy data
- Incorporate Dataflow
- Add Notebook
- Get metadata
- Execute a script or stored procedure

Pipelines provide a visual way to complete activities in a specific order. You can use a dataflow for data ingestion, transformation, and landing into a Fabric data store. Then incorporate the dataflow into a pipeline to orchestrate extra activities, like execute scripts or stored procedures after the dataflow has completed.

Pipelines can also be scheduled or activated by a trigger to run your dataflow. By using a pipeline to run your dataflow, you can have the data refreshed when you need it instead of having to manually run the dataflow. When you're dealing with enterprise or frequently changing data, automation allows you to focus on other responsibilities.

:::image type="content" source="../media/dataflow-schedule-pipeline.png" alt-text="Screenshot of the pipeline schedule window for a dataflow.":::
