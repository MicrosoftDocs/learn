Data preparation is a broad term that encompasses the beginning stages of getting the data to the point at which it's ready for modeling. This step is the responsibility of both the data engineer and the data scientist. The data engineer does most of the data preparation by making the data accessible, clean, and ready for the data scientist to work with. However, most data scientists still perform additional data cleansing.

Let's focus on the portion of this process that pertains to the data scientist.

Using the example from the previous page, we know that your company has stores that sell products such as clothing, cleaning supplies, and groceries. Management has noticed that they are selling out of brooms before the end of the month, and they want to know how many brooms they should stock so they don't sell out.

The following table displays sales data from your company. 

| SaleID | ItemID | ItemName | ItemPrice | TotalPrice | Timestamp|
| ------ | ------ | -------- | --------- | ---------- | -------- |
| 1739283 | 1435 | Broom | 14.99 | 20.98 | 10-02-2009 13:20:22 |
| 1739283 | 1923 | Bleach | 5.99 | 20.98 | 10-02-2009 13:20:22 |
| 1739101 | 1435 | Broom | 14.99 | 24.72 | 10-02-2009 20:45:38 |
| 1739101 | 1981 | Ground beef | 6.74 | 24.72 | 10-02-2009 20:45:38 |
| 1739101 | 1722 | Bananas | Null | 24.72 | 10-02-2009 20:45:38 |

Let's note some things about the data:

- The first two rows are referring to the same sale. Therefore, you know that this person bought a broom and bleach together.
- The last three rows are from a customer who bought a broom, ground beef, and bananas in the evening.

## Clean the data

Generally, the kinds of cleansing a data scientist will do involves null or absent values. Data that has been prepped by a data engineer won't have much cleansing left. Note that there are other names for this process.

In the previous table, you can see there is one null value for the ItemPrice for bananas. It's likely that in a large data frame, where there is one null value there are others. Therefore, to find (or *extract*) the missing ItemPrice of that item you could subtract the sum of the other ItemPrices from the TotalPrice of the same customer sale. 

## Expose the data with EDA

The Exploratory Data Analysis (EDA) part of the process is crucial because of the information unveiled during this step. EDA allows for the investigation of what is happening in the data that is not obvious at a glance. Sometimes it's possible to uncover patterns within the data, build questions about the data, and reject or accept the original hypotheses about the data.

As you can see in the data from your company, you don't have a lot of features; this is not unusual. So, for your company's EDA you might want to look at the TotalPrice distribution, where ItemName is 'broom' to show patterns in people's spending when they're buying a broom. You might also want to look at the broom sales over time to see if there is a trend or seasonality to the data. These are just a few of many things you could do to understand the data.

## Summary

Although most data preparation is outside the data scientist's role, it's still imperative to understand the transformations that can be done to data. Data cleansing and EDA are vital to the modeling process, so it should never be overlooked.