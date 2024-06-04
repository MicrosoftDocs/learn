Data is just another word for collected information. Volumes and masses of available information are huge, spanning many different information types.

We can categorize data in many ways. To operate in the machine learning space, we must understand both the type, and digital storage systems, of the data available to us.

## Continuous, ordinal, and categorical data

For data operations, we sometimes need awareness of what exactly the data represents. This awareness can help us choose the right machine learning model. It can also help us organize our data in specific, helpful ways.

_Continuous data_ refers to numerical information that can increase or decrease by any amount. For example, you can add 1 millimeter to 1 meter, and calculate a sum as 1.001 meters.

_Categorical data_ refers to data that doesn’t fall on a continuous spectrum. In our scenario, the data categorizes the people on the Titanic as “crew” or “passengers.” Categorical data can’t be stored as numbers in a clearly obvious way.

_Ordinal data_ refers to categorical data that have a defined order, and can therefore support storage as numerical values. For example, we can define values of **big**, **medium**, and **small** as ordinal data because we can numerically rank them: big > medium > small. By contrast, the values **apple**, **orange** and **coconut** are categorical because we can't rank them. Ordinal data can also refer to numbers that can increase or decrease, but only by set amounts. For example, the number of people boarding a boat is guaranteed to be a whole number: no one can half board.

_IDs_ refer to a special type of categorical data where each sample has its own unique ID. For example, in our dataset, each person on the Titanic has a given ID value, even if that person has the same name as someone else. Identity values help us navigate in a dataset, but our data analysis doesn't directly involve those values.

## Datatypes

A computer must store and process all the data we use for machine learning. While we can write almost any data on a piece of paper with a pencil, computers store information as series of 0's and 1's. This places restrictions on the way we use information.

**Datatype** refers to the type of data that a computer store. Datatypes generally have these categories:

* integers: counting numbers: for example, **2**
* floating-point numbers: numbers with decimal places: for example, **2.43**
* strings: letters and words
* booleans: true and false
* None, void, or null: not data, but rather the _**absence**_ of data

The exact terms and implementation for these concepts vary from language to language, but they all operate in similar ways across all computer languages.

Sometimes, two different datatypes offer equivalent functionality. For example, computers can handle true/false values as Booleans (true or false), strings (‘y’, or ‘n’), integers (0 or 1) or even floating-point numbers (0.0 or 1.0).

## Derived datatypes

As we use technology, we encounter many more basic, 'primitive' datatypes beyond the above list. Computers can store dates, images, 3D models, and so on. We refer to these as **derived datatypes**. We start with one or more primitive datatypes to construct a derived datatype.

Often, in machine learning, it helps to convert derived types into simpler representations. For example, we can store a defined date value (for example, **1st January, 2017**) as an integer or floating point number: **20170101**. Integer or floating point numbers make the calculations behind our models easier.

## Too many choices?

Knowing the kind of data you have available can help you choose the right datatype.

The correct datatype can depend on the package you use to run your models, although generally, packages are permissive. Generally:

* To work with continuous data, floating point numbers become the best choice.
* Ordinal data typically encodes with integer values.
* Categorical data involving only two categories can usually encode as Boolean or integer data. Working with three or more categories can become a little more complicated. Don't worry - the next lesson will cover this topic!

In the next exercise, we'll practice data visualization, to better understand the data itself. As we do so, carefully note the datatypes involved, and try to identify the continuous, ordinal, or categorical datatypes.