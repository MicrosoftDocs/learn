Data preparation falls into the role of both the data engineer and the data scientist. It is a broad term that encompasses the beginning stages of getting the data to the point at which the data is ready for modeling. The data engineer does most of the data preparation by making the data  accessible and clean for the data scientist to work with. However, most data scientists still need to do large amount of data cleansing.

Let's focus on the portion of this process that pertains to the data scientist.

Let's recall the example from the previous page.

Your company has stores that sell products such as clothing, cleaning supplies, and groceries. Management noticed that they were selling out of brooms before the month ended. Management wants to know how many brooms they should stock so they do not sell out before the month is over.

You Company's Sample Data

| SaleID | ItemID | ItemName | ItemPrice | TotalPrice | Timestamp|
| ------ | ------ | -------- | --------- | ---------- | -------- |
| 1739283 | 1435 | Broom | 14.99 | 20.98 | 10-02-2009 13:20:22 |
| 1739283 | 1923 | Bleach | 5.99 | 20.98 | 10-02-2009 13:20:22 |
| 1739101 | 1435 | Broom | 14.99 | 24.72 | 10-02-2009 20:45:38 |
| 1739101 | 1981 | Ground Beef | 6.74 | 24.72 | 10-02-2009 20:45:38 |
| 1739101 | 1722 | Bananas | Null | 24.72 | 10-02-2009 20:45:38 |

Let's note some things about the data:

- The first two rows are referring to the same sale. Therefore, you know that this person bought a broom and bleach together.
- The last three rows are from someone who bought a broom, ground beef and bananas on that same day in the evening.

## Data cleansing

Generally, the kinds of cleansing a data scientist do involve null or absent values. Data that has been prepped by a data engineer won't have much cleansing left. Note that there are other names for this process.

In the example, you can see there is one null value in the place of the ItemPrice for the bananas. It is likely that in a large data frame if there is one null value, there are others. Therefore, to fix this issue, you could subtract the sum of the ItemPrice from the same sale from the TotalPrice to find the price of that Item. 

## Exploratory Data Analysis (EDA)

This part of the process is crucial because of the information unveiled during EDA. Exploratory data analysis allows for the investigation of what is happening in the data that is not obvious at a glance. Sometimes it is possible to uncover patterns within the data, build questions regarding the data as well as reject or accept our original hypotheses about the data.

As you can see in the data from your company, you don't have a lot of features which is not unusual. So, for the EDA, you may want to look at the distribution of the TotalPrice where ItemName is 'broom' to show patterns in people's spending when they're buying a broom. You may also want to look at the broom sales over time to see if there is a trend or seasonality to the data. These are just a couple of the many things you could do to understand the data.

## Summary

Although most of the data preparation is outside of the role of the data scientist, it is still imperative to understand the transformations done to the data. Data cleansing and EDA are vital to the modeling process so it should never be overlooked.