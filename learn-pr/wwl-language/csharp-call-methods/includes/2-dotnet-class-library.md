There's more to building a C# application than stringing together lines of code. You'll need the .NET Runtime, which hosts and manages your code as it executes on the end user's computer. You'll also rely on the .NET Class Library, a prewritten collection of coding resources that you can use in your applications. This unit explains what the .NET Class Library is and how it complements the C# programming language.

## What is the .NET Class Library?

When you need to find a book, a public library is a good place to look. After all, libraries contain thousands and thousands of books, and they're organized into sections that help you to find what you're looking for. When you need to implement a programming task, the .NET Class Library is a good place to look, because it is an organized collection of programming resources.

The .NET Class Library is a collection of thousands of classes containing tens of thousands of methods. For example, the .NET Class Library includes the `Console` class for developers working on console applications. The `Console` class includes methods for input and output operations such as `Write()`, `WriteLine()`, `Read()`, `ReadLine()`, and many others. For example, you may already be familiar with the following code:

```csharp
Console.WriteLine("Hello, World!")
```

You can think of a class as a container for methods, kind of like the sections of the public library. Developers typically keep related methods together in a single class. As you saw in the previous example, any methods that can send or receive information from a console window are collected into the `System.Console` class in the .NET Class Library.

In many cases, these classes and methods enable you to build a specific type of application. For example, one of the larger subsets of classes and methods enable you to create dynamic web applications. There's also several families of classes that enable you to build native desktop applications. Another subset of classes and methods enable you to access a database. There are lots of classes in the .NET Class Library that support specific types of applications.

There are other classes with methods that provide support in a more general way. In other words, their utility spans a wide range of device platforms, application frameworks, and technology areas. For example, if you want to read or write file information, or perform trigonometry or calculus operations, there are general purpose classes/methods that you can use in your code. It doesn't matter whether you're building applications for the web, desktop, mobile device, or the cloud, general purpose classes and methods are there to help.

As you can imagine, having a massive library of functionality available to your applications is a huge time saver for you as a software developer. The classes and methods in the .NET Class Library are created by Microsoft and are available for use in your applications.

### Even data types are part of the .NET Class Library

C# data types (such as `string` and `int`) are actually made available through classes in the .NET Class Library. The C# language masks the connection between the data types and the .NET classes in order to simplify your work. However, behind the scenes, the data types are implemented just like every other class in the .NET Class Library. This connection provides your everyday variables with built-in methods that can be very helpful.

## How to find what you need in the .NET Class Library

With so many classes and methods, how can you find what you need for your application?

First of all, remember that finding every class and method in the .NET Class Library is like finding every book in a large public library. You don't need every book in the library, and you won't be using every class and method in the .NET Class Library. Depending on the types of projects that you work on, you'll become more familiar with some parts of the .NET Class Library and less familiar with others. Again, it's like spending time in a section of the public library, over time you become familiar with what's available. No one knows all of the .NET Class Library, not even people that work at Microsoft.

Second, necessity will drive you to what you need. Most people go to the library when they need to find a book, not to see how many different books they can find.You don't need to research classes and methods without a reason. When you have trouble figuring out a programming task, you can use your favorite search engine to find blog posts, articles, or forums where other developers have worked through similar issues. Third-party sources can give you clues about which .NET classes and methods you might want to use, and you may even find sample code that you can try.

Third, Microsoft provides an online language reference and programming guide for C# that you can search through. You'll likely spend time reading Microsoft's documentation when you need to understand exactly what methods do, how they work, and their limitations. This documentation will become your source of truth for the .NET Class Library. Microsoft's documentation team works closely with the .NET Class Library's software developers to ensure its accuracy.

Finally, as you begin to experiment with small code projects you'll deepen your understanding of how the classes and methods work.

All software developers follow a similar process when stepping into unfamiliar territory. The process of discovery is enjoyable, albeit challenging.

## Recap

- The .NET Class Library supplies you with a wealth of functionality that you can use by merely referencing the classes and methods that you need.
- Even your data types are part of the .NET Class Library. C# merely provides an alias for those data types.