The columns in a dataset may not provide enough information to answer a question we have about our data. This is where derived data is useful. A derived column is a new column added to a dataset, based on the existing data. There are many ways you can create a derived column, and they offer the flexibility to enhance your dataset for more detailed analysis. The data type of the derived field can be a number, date, or string.  

You can use a calculation to create a derived column, which can be summarized. If you want to calculate the total value of a sales order line, you multiply the quantity field by the sales price field, to generate the total value as a new column. Then you use an aggregate function to summarize each value in the derived column to return the total value of all order lines.

A derived column can be based on a condition. For example, if you want to report weekend sales compared to weekday sales, you could create a new field based on the date. If the weekday value of the date was Monday through Friday, then the value in the derived column would be Weekday. Otherwise, the value would be Weekend.

Values with a column can also be altered to make the data consistent and easier to analyze.

In this video, you'll see how a new column is added to a dataset using the current data. Then you'll learn how to add summary data by aggregating the values in the new column:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4TYJ9]
