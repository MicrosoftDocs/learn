Machine learning models are as strong as the data they are trained on. Often it is important to derive features from existing raw data that better represent the nature of the data and thus help improve the predictive power of the machine learning algorithms. This process of generating new predictive features from existing raw data is commonly referred to as **feature engineering**.

## Feature engineering

There are many valid approaches to feature engineering and some of the most popular ones, categorized by data type, are as follows:

- Aggregation (count, sum, average, mean, median, and the like)
- Part-of (year of date, month of date, week of date, and the like)
- Binning (grouping entities into bins and then applying aggregations)
- Flagging (boolean conditions resulting in True of False)
- Frequency-based (calculating the frequencies of the levels of one or more categorical variables)
- Embedding (transforming one or more categorical or text features into a new set of features, possibly with a different cardinality)
- Deriving by example

Feature engineering is not limited to the above list and can involve domain knowledge-based approaches for deriving features. 

Let’s work with an example to understand the process of feature engineering. In our example, we are working with a system that gives us weather data on an hourly basis, and we have a column in the data that is `hour of day`. The `hour of day` column is of type integer and it can assume any integer value in the range `[0, 23]`. 

The question is, how best to represent this data to a machine learning algorithm that can learn its cyclical nature? One approach is to engineer a set of new features that transforms the `hour of day` column using sine and cosine functions. These derived features are plotted in the figure below for the range `[0, 24]`:

![Engineered Features](../media/02-01-03-engineered-features.jpg)

The cosine function provides symmetrically equal weights to corresponding AM and PM hours, and the sine function provides symmetrically opposite weights to corresponding AM and PM hours. Both functions capture the cyclical nature of `hour of day`.