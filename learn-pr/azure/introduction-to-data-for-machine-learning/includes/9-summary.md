We covered a lot of ground. Let’s review some of the key messages.

## What are data?

Data fall into several conceptual categories. The most common are:
* continuous data (numbers),
* categorical data that have no order,
* ordinal data, which can be treated as numbers or ordered categories.

Computers store data as distinct types, and we usually try to match the datatype to the specific kind of data. For example, to store continuous data, floating-point numbers work best, because floating-point numbers allow the storage of fractions. By contrast, categorical data often arrive as strings (text) and must be converted to one-hot vectors for the computer to understand them properly.

## What makes a good dataset?

We learned that a dataset it helpful if it:

* contains relevant information,
* is complete,
* is a good representation of the population (real-world).

If we must deal with incomplete data, we can take steps to make sure that incomplete data doesn't cause big issues. When doing so, we must avoid introduction of new issues, such as changes that would make the data no longer representative, for example.

## Thinking about data

We showed how data visualization can help to build an understanding of what might be useful in a model. Use of different types of graphs, colors, and so on, can be fun and make complex information much more intuitive.

We learned that understanding our data lets us make better decisions about our models. In the final exercise, we improved our model as we explored the count of cabins on the Titanic, and considered how this information was helpful. Yet overall, we found that this could be improved through simplification into nine Deck labels.
