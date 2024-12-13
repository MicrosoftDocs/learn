As a side effect of data's influence on machine learning, models trained only on small amounts of data rarely perform well in the real world. This behavior happens because small amounts of data don't usually serve as good real-world representations. For example, four randomly selected people on Earth wouldn't reliably represent the average person. By contrast, if we selected 1,000,000,000 people, our data would probably become representative.

However, other factors also have importance. We need large, representative data samples that:

- Have zero errors.
- Contain all key information.

We cover these concerns here, before we move to a practical exercise involving our Titanic dataset.

## 'Representative' - What does that mean?

Statisticians rely on two key concepts, _populations_ and _samples_, to decide if available data resources actually help their analysis and study.

We focus on a population. In other words, every conceivable data-point. For our Titanic scenario, we want to know which factors led to survival for everyone on board. This includes stowaways not listed on the official records. As a second example, to investigate the relationship between personality traits and likelihood of a ship sinking, our population would cover every ship captain who ever lived.

A sample refers to the data available to us, as a subset of the total population. For our Titanic dataset, this sample covers only the people listed on the official passenger list. For our second example, the sample might cover every ship captain we can convince to take a personality test at our local marina.

We need to think about whether the sample accurately represents the population. For our Titanic example, our sample is so large that it probably serves as a good representation of the population. By contrast, conversations with only ship captains at our local marina probably don't give us a good cross-section of the sailors we would find across the globe. Data from our local marina might build a model that works well for local captains, but it doesn't really help us understand captains from other countries/regions.

## What is a data error?

The term _data error_ refers to incorrect data. Enough data errors can skew a model so that it consistently makes incorrect predictions. It's simple: if you put bad data in, you get bad predictions.

Errors in data are a fact of life, and we can group them in two categories, measurement errors and data entry errors.

The term _measurement errors_ refers to data with low-quality measurements at the data-collection phase. These errors are often subtle and difficult or impossible to eliminate.

The term _data entry errors_ refers to accurately collected data, but then incorrectly or inaccurately placed into a spreadsheet or data-management resource. Sometimes, we can spot data entry errors more easily than we can spot measurement errors. For example, we might measure someone as 1.8 meters tall, but miss the decimal place and write 18 meters. We can easily see the error because a tree-sized person is unrealistic.

## What is complete data?

A complete dataset has no missing data. Missing data has two types. This data shows the height and weight of Dylan, Reece, and Tom:

|Name| Height (m) | Weight (kg)|
|---|---|---|
|Dylan|1.8|75|
|Reece| |82|

The data is incomplete because of a missing sample: Tom. Additionally, the data for Reece doesn't show the height of Reece.

Ideally, we always work with complete data, but we don't always have complete data available to us. For incomplete data, we can do one of the following:

- Choose a model that can work with incomplete data.
- Remove samples (rows) that have incomplete data and work with the remaining data.
- Artificially add values as reasonable substitutes for the missing data.

Most times, picking a model that can handle missing data works best, although this isn't always possible. Removal of incomplete data is the easiest approach, and it usually works. However, we must be careful that removal of data doesn't cause a sample to misrepresent the population. Artificially adding data is usually a method of last resort.

In the next unit, we'll work with our Titanic dataset to identify and patch up incomplete data.
