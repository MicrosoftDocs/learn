In Azure Stream Analytics, a job is a _unit of execution_. A Stream Analytics job pipeline consists of three parts:

1. An **Input** which provides the source of the data stream.
2. A **Transformation Query** which performs an option on the input such as an aggregation of the data.
3. An **Output** which identifies the destination of the transformed data.

The Stream Analytics pipeline provides a transformed data flow going from input to output as shown in the following diagram.

![Screenshot of Stream Analytics pipeline](../media/2-stream-analytics-pipeline.png)