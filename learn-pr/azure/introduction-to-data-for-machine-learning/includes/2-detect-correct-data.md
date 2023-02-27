The fact that data shapes machine learning gives machine learning its predictive power. As a side effect, models trained only on small amounts of data rarely perform well in the real world, because small amounts of data don't usually serve as good real-world representations. For example, four randomly-selected people, chosen from anywhere on Earth, would not represent the average person on Earth very well. By contrast, if we selected 1 billion people, our data would probably become quite representative.

However, other factors also have importance. We need large, representative data samples that

- Have zero errors
- Contain all key information

We'll cover these topics here, before we move to a practical exercise involving our Titanic dataset.

## 'Representative' - What does that mean?

Statisticians rely on two key concepts: _populations_ and _samples_, to decide if available data resources will actually help their analysis and study.

We'll focus on a population - in other words, every conceivable data-point. For our Titanic scenario, we want to know which factors led to survival for everyone on board — including stowaways not listed on the official records. As a second example, to investigate the relationship between personality traits and likelihood of a ship sinking, our population would cover every ship captain who has ever lived.

A sample refers to the data available to us, as a subset of the total population. For our Titanic dataset, this sample will cover only the people listed on the official passenger list. For our second example, the sample might cover every ship captain we can convince to take a personality test at our local marina.

We need to think about whether the sample accurately represents the population. For our Titanic example, our sample is so large that it probably serves as a very good representation of the population. By contrast, for our second example, conversations only with ship captains at our local marina probably won't give us a good cross-section of the sailors we would find across the globe. Data from our local marina might build a model that works well for local captains, but won't really help us understand captains from other countries/regions.

## What is a data error?

The term 'data errors' refers to incorrect data. Enough data errors can skew a model that it consistently makes incorrect predictions. It's really simple: if you put bad data in, you’ll get bad predictions out.

Errors in data are a fact of life, and we can group them in two categories:

The term 'measurement errors' refers to data with low-quality measurements at the data-collection phase. These errors are often subtle and difficult or impossible to eliminate.

The term 'data entry errors' refers to correctly-collected data incorrectly or inaccurately placed into a spreadsheet or data-management resource incorrectly. Sometimes, we can spot data entry errors more easily than we can spot measurement errors. For example, we might measure someone as 1.8 meters tall, but miss the decimal place and write 18 meters. We can easily see the error because a tree-sized person is unrealistic.

## What is complete data?

A complete dataset has no missing data. Missing data has two types. This data shows the height and weight of Dylan, Reece, and Tom:

|Name| Height (m) |	Weight (kg)|
|---|---|---|
|Dylan|1.8|75|
|Reece| |82|

The data is incomplete because of a missing sample: Tom. Additionally, the data for Reece does not show the height of Reece.

Ideally, we always work with complete data, but this does not always happen. For incomplete data, we can:

- Choose a model that can work with incomplete data, or
- Remove samples (rows) that have incomplete data, and work with the remaining data, or
- Artificially add values as reasonable substitutes for the missing data

Most times, picking a model that can handle missing data is best, although we can't always do this. Removal of incomplete data is the easiest approach, and it usually works, although we must be careful that removal of data doesn't cause a sample to misrepresent the population. Adding data in artificially is usually a method of last resort.

In the next unit, we'll work with our Titanic dataset, identifying and patching up incomplete data.