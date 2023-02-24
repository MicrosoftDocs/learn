There's more to building applications than the C# language itself. You'll also need the .NET Runtime, which hosts and manages your code as it executes on the end user's computer. You'll also rely on a collection of functionalities called the .NET Class Library that you can use in your applications. This unit explains what the .NET Class Library is and how it complements the C# programming language.

## What's the .NET Class Library?

The **.NET Class Library** is a collection of thousands of classes containing tens of thousands of methods. These methods are created by Microsoft and are available for use in your applications.

A class is simply a container for methods. Developers typically keep related methods together in a single class. For example, any methods that can send or receive information from a command-line window are collected into the `System.Console` class in the .NET Class Library.

In many cases, these classes and methods let you build a specific type of application. For example, one of the larger subsets of classes and methods allows you to create dynamic web applications. There's several families of classes that allow you to build native desktop applications. Another subset of classes and methods lets you access a database.

There are other classes with methods that are more general-purpose in nature. In other words, their utility spans across different frameworks. If you want to read or write to files, perform trigonometry or calculus operations, or make calls to retrieve data from across the internet, you could use these classes and their methods whether you're building a web, desktop, mobile, or cloud application.

As you can imagine, having a massive library of functionality available to your applications is a huge time saver for you as a software developer. What if you had to start from scratch with each new application you wanted to build?

### Even data types are part of the .NET Class Library

The C# data types you've already learned about are actually part of the .NET Class Library, too. C# masks the true identity of the data types we've used in order to simplify our work. However, behind the scenes, the data types are implemented just like every other class in the .NET Class Library. This also means that there are helpful methods that are built in and available on your variables.

### What is a namespace?

Think of a namespace as the last name, surname, or "family name" for a type. A class contains the code that implements a type. Classes are organized into namespaces to prevent naming collisions. After all, when there are thousands of classes, it's possible that there might be a need to reuse a class name. The namespace helps to make sure no two classes have the same *full* name.

## How to find what you need in the .NET Class Library

With so many classes and methods, how can you find what you need for your application?

First of all, there's a small subset of classes you'll likely use throughout your tenure as a C# software developer. Depending on the projects on which you work, you'll become more familiar with some parts of the .NET Class Library and less familiar with others. No one knows it all, not even people who work at Microsoft.

Second, as you have a need, you'll likely use your favorite search engine to find blog posts, articles, or forums where other users have needed to do things similar to those you want to do. Third-party sources will give you clues and even provide some sample code you can try.

Next, you'll likely spend time reading Microsoft's documentation for specific methods to understand exactly what they do, how they work, what their limitations are, under what conditions they'll raise exceptions (errors), and how you can mitigate those problems. The documentation will become your source of truth for the .NET Class Library. The documentation team works closely with the .NET Class Library's software developers to ensure its accuracy.

Finally, you'll begin to experiment with small code projects to deepen your understanding of how the classes and methods work.

All software developers follow a similar process when stepping into unfamiliar territory. The process of discovery is enjoyable, albeit challenging.

## Recap

- The .NET Class Library supplies us with a wealth of functionality that we can use by merely referencing the classes and methods we need.
- Even our data types are part of the .NET Class Library. C# merely provides an alias for those data types.
- A *namespace* prevents naming collisions between class names in the .NET Class Library.
