



You've been introduced to the difference between value types and reference types, as well as integral and floating point types.

Suppose your job is to build a new application that retrieves, manipulates, and stores different types of data. Which data types do you use?

In some cases, it is an easy choice. For example, when you need to work with text, then you default to using the `string` data type unless you need to perform a significant amount of concatenation.

But what about working with numeric data? There are 11 different options. How do you choose the right data type?

## Choose the right data type

With so many data types to choose from, what criteria should you use to choose the right data type for the particular situation?

When evaluating your options, you must weigh several important considerations. Often there's no one single correct answer, but some answers are more correct than others.

### Choose the data type that meets the boundary value range requirements of your application

Your choice of a data type can help to set the boundaries for the size of the data you might store in that particular variable. For example, if you know a particular variable should only store a number between 1 and 10,000 otherwise it's outside of the boundaries of what would be expected, you would likely avoid `byte` and `sbyte` since their ranges are too low.

Furthermore, you would likely not need `int`, `long`, `uint`, and `ulong` because they can store more data than is necessary. Likewise, you would probably skip `float`, `double`, and `decimal` if you didn't need fractional values. You might narrow it down to `short` and `ushort`, of which both may be viable. If you're confident that a negative value would have no meaning in your application, you might choose `ushort` (positive unsigned integer, 0 to 65,535). Now, any value assigned to a variable of type `ushort` outside of the boundary of 0 to 65535 would throw an exception, thereby subtly helping you enforce a degree of sanity checking in your application.

### Start with choosing the data type to fit the data (not to optimize performance)

You may be tempted to choose the data type that uses the fewest bits to store data thinking it improves your application's performance. However, some of the best advice related to application performance (that is, how fast your application runs) is to not "prematurely optimize". You should resist the temptation to guess at the parts of your code, including the selection of data types that may impact your application's performance.

Many assume that because a given data type stores less information it must use less of the computer's processor and memory than a data type that stores more information. Instead, you should choose the right fit for your data, then later you can empirically measure the performance of your application using special software that provides factual insights to the parts of your application that negatively impact performance.

### Choose data types based on the input and output data types of library functions used

Suppose you want to work with a span of years between two dates. Since the application is a business application, you might determine that you only need a range from about 1960 to 2200. You might think to try to work with `byte` since it can represent numbers between 0 and 255.

However, when you look at the built-in methods on the `System.TimeSpan` and `System.DateTime` classes, you realize they mostly accept values of type `double` and `int`. If you choose `sbyte`, you'll constantly be casting back and forth between `sbyte` and `double` or `int`. In this case, it might make more sense to choose `int` if you don't need subsecond precision, and `double` if you do need subsecond precision.

### Choose data types based on impact to other systems

Sometimes, you must consider how the information will be consumed by other applications or other systems like a database. For example, SQL Server's type system is different from C#'s type system. As a result, some mapping between the two must happen before you can save data into that database.

If your application's purpose is to interface with a database, then you would likely need to consider how the data is stored and how much data is stored. The choice of a larger data type might impact the amount (and cost) of the physical storage required to store all the data your application will generate.

### When in doubt, stick with the basics

While you've looked at several considerations, as you're getting started, for simplicity's sake you should prefer a subset of basic data types, including:

- `int` for most whole numbers
- `decimal` for numbers representing money
- `bool` for true or false values
- `string` for alphanumeric value

### Choose specialty complex types for special situations

Don't reinvent data types if one or more data type already exists for a given purpose. The following examples identify where a specific .NET data types can be useful:

- `byte`: working with encoded data that comes from other computer systems or using different character sets.
- `double`: working with geometric or scientific purposes. `double` is used frequently when building games involving motion.
- `System.DateTime` for a specific date and time value.
- `System.TimeSpan` for a span of years / months / days / hours / minutes / seconds / milliseconds.

## Recap

There are considerations when choosing data types for your code, and often more than one option. Think through your choices, and unless you have a good reason, try to stick with the basic types like `int`, `decimal`, `string`, and `bool`.
