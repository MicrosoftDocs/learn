One of the iron laws of data science is know as the "[curse of dimensionality](https://wikipedia.org/wiki/Curse_of_dimensionality)": as the number of considered features (dimensions) of a space increases, the number of data configurations grows exponentially. Thus the number of observations (data points) needed to account for these configurations must also increase. This fact of life has huge ramifications for the time, computational effort, and memory required. As a result, it is often desirable to reduce the number of dimensions we work with.

The challenge is determining which features we can remove from our analysis.

Not all features are created equal. Certain features may impede our analysis, or simply not be overly important. We need to identify the features to exclude, but obviously we can only take this so far. At a certain point reducing dimensions will also reduce the accuracy of a classifier and our analysis.

## Our scenario

We have a collection of foods and their nutrients. We'd like to group them together so we can see similar items. Our traditional categorization of dairy or vegetables aren't descriptive enouth, and can be a little misleading. For example, not all fruits are created equal - an avocado is rather different from a apple. We'd like to group our foods together based on their composition.

As we begin our analysis, our initial challenge is trying to determine what makes a food item a food item? What components are most important? It's a real struggle to try to determine what components we should focus on.

## Learning objectives

In this module, you will:

- 

## Prerequisites

