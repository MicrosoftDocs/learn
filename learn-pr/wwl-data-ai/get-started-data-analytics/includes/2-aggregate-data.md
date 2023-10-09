Aggregate functions are used to return a summary value from your dataset, and are a fundamental component of data analysis. These functions help us answer specific questions about our business, such as how many customers visited the Tokyo store last Tuesday, or  the average spend of each online customer in December.

The following functions are commonly used in data analysis:

- **Count** - A good starting point before you begin more in-depth analysis is to use the count function to return the number of records in your dataset. The count function can be applied to any dataset, regardless of the type of data it contains, as the calculation is done on the number of rows. 

- **Count distinct** - A distinct count can be applied to return the number of unique values within a column, and is useful for categorical data.

- **Sum** - A common function that summarizes the total values within a field. It's used to return values such as total sales or revenue.

- **Average** - The average function calculates the sum of a field, divided by the number of records. For example, to discover the average customer spend, the average function would run a sum calculation against the spend of all customers, then divide it by the number of customers in the table.

- **Minimum** - A function that is used to return the lowest value in a field.

- **Maximum** - The opposite of the minimum function, this function returns the highest value in a field.

The type of function used depends on the data in the column being aggregated. Temperature values in a column wouldn't work with a summary aggregation, but would be ideal for minimum, maximum, or average. In a sales order table, the total column might be summarized, or you could use the minimum, maximum, or average functions.

In this video, you'll see how aggregate functions can be applied to data to return summarized results:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4U38n]
