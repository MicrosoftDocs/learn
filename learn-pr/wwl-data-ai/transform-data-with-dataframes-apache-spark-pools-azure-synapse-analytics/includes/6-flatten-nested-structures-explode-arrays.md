A common use case for using Apache Spark pools in Azure Synapse Analytics is for transforming complex data structures using DataFrames. It can help for the following reasons:

- Complex data types are increasingly common and represent a challenge for data engineers because analyzing nested schema and data arrays often include time-consuming and complex SQL queries. 
- It can be difficult to rename or cast the nested column data type. 
- Performance issues arise when working with deeply nested objects. Data Engineers need to understand how to efficiently process complex data types and make them easily accessible to everyone. In the following example, Apache Spark for Azure Synapse is used to read and transform objects into a flat structure through data frames. 
- Apache Synapse SQL serverless is used to query such objects directly and return those results as a regular table.
- With Azure Synapse Apache Spark pools, it's easy to transform nested structures into columns and array elements into multiple rows. 

In the example, the following steps show the techniques involved to deal with complex data types by creating multiple DataFrames to achieve the desired result.

![Flatten Nested Structures Steps ](../media/steps-flatten-nested-structure-transform.png)

### Step 1: Define a function for flattening
We create a function that will flatten the nested schema. 

### Step 2:  Flatten nested schema
We will define the function you create to flatten the nested schema from one DataFrame into a new DataFrame.

### Step 3: Explode Arrays
Here you will transform the data array from the DataFrame created in step 2 into a new DataFrame.

### Step 4: Flatten child nested Schema
Finally, you use the transformed DataFrame created in step 3 and load the cleansed data into a destination DataFrame to complete the work.