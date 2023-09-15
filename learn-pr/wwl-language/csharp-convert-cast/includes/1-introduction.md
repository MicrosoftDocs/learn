Suppose you're a software developer on a team working on medical intake form automation. You're tasked with delivery of the application features for collecting the general data entered by a medical technician before the doctor examines the patient. The technician can use the application to record the date and time, patient age, height, weight, pulse, and blood pressure. The application also provides text fields for other information, such as the reason for the visit,
current prescriptions, and other items. You work with a lot of data that is in a mix of data types. For the prototype, you'll build a console application and collect all of the input as `strings`.

Because the input is initially input as a string, you're to change a value from one data type into another in the code occasionally. A simple example is any mathematical operation you want to perform with string data. You would first need to change the value into a numeric data type, like `int`, and then you could manipulate the operation. Alternatively, you may want to format and output a numeric value for a summary report using string interpolation.

You use different techniques to change a data type when necessary. You learn when to use one technique over another, and when a given technique might risk the loss of data.

By the end of this module, you are able to take control of the data in your applications, knowing when to apply the correct technique to change data types as needed.

## Learning objectives

In this module, you'll:

- Use the casting operator to cast a value into a different data type.
- Use conversion methods to convert a value into a different data type.
- Guard against the loss of data when performing a cast or conversion operation.
- Use the `TryParse()` method to safely convert a string into a numeric data type.

## Prerequisites

- Experience using data types like `string`, `int`, `decimal`, `float`, and so on
- Experience using arrays and the `foreach` iteration statement
- Experience using string interpolation to combine variable and literal values for output
- Experience using Visual Studio Code to develop, build, and run C# code
