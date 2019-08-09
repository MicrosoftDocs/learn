Creating features is often an instrumental part of the process in the modeling procedure. Feature engineering allows you to extract a new feature from the original data using different methods. This technique can help you improve your model results and help you see patterns in the data that may not have been visible with the original dataset. An example of feature engineering from a datetime column is creating a separate feature based on the time of the day to add attention to it.

Your company's sales data table includes the following sales information.

| SaleID | ItemID | ItemName | ItemPrice | TotalPrice | Timestamp|
| ------ | ------ | -------- | --------- | ---------- | -------- |
| 1739283 | 1435 | Broom | 14.99 | 20.98 | 10-02-2009 13:20:22 |
| 1739283 | 1923 | Bleach | 5.99 | 20.98 | 10-02-2009 13:20:22 |
| 1739101 | 1435 | Broom | 14.99 | 24.72 | 10-02-2009 20:45:38 |
| 1739101 | 1981 | Ground beef | 6.74 | 24.72 | 10-02-2009 20:45:38 |
| 1739101 | 1722 | Bananas | Null | 24.72 | 10-02-2009 20:45:38 |

## Extracting Y

It can be the case where there is a dataset, where what you're trying to predict is not already a feature of the data. This does not always happen, but when it does, feature engineering is required to move forward in the modeling process.

You notice that you're not provided with the number of sales that month, so you are forced to extract that feature. This is a relatively easy task; you first create a column with all ones in it, then use a sum aggregation of the data by each month. This feature engineering will give you a new dataset.

## Extract for other features

Often the most useful features in the data are ones created from data you have. There are a variety of ways to create columns from numerical data. Common features involve different aggregations of the data.

Your company's data makes up a pretty bland dataset. It almost feels like there isn't much you can do with the data, but this is where feature engineering becomes useful. Since the data has a few different numerical columns, you could consider taking the aggregation of SaleID by the average ItemPrice.

## Perform feature engineering with datetime data

Timestamps allow for unique types of feature engineering that are extremely useful. This is because a dataset that is structured around time often operates differently than other datasets. The first technique is moving the average, which enables you to see the patterns over any length of time and improve model performance. (You can also use other moving aggregations.) The second technique is differencing, which enables you to find the differences in values over time.

In the example, the moving average could be extremely useful in the model. It may be helpful to look at the moving average TotalPrice on a month-to-month basis. This will help you identify a trend in the data.

## Summary

Feature engineering is an overlooked process that can strongly benefit the model if done correctly. If the data provided does not already have the graph's Y column, it's imperative to use feature engineering to extract it. Aside from that, much of vital data comes from feature extraction, especially in data formulated around dates.