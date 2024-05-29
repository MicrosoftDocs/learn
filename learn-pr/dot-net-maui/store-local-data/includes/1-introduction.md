When you're building mobile applications, it's common to store data locally on a device for performance reasons. .NET MAUI allows you to cache data locally on the device on which the application is running. You can store this data using several different technologies. To store relational data, you can use a SQLite database.

Suppose you're building a social-media application that lets users connect with each other. Because the data about users is stored remotely, you have to call the REST endpoint to get information about the users with which you're connected every time you restart the application.

This design works. However, it's inefficient, because you have to keep downloading the user information from the server every time you restart the application.

A more efficiently designed app downloads the user data once and saves it locally to the device. With this design, you only have to download information for other users when you want to make a new connection. You can create this more efficient design by using a local database.

In this module, you'll build a .NET MAUI application that stores data locally in a database. You'll start by exploring the different data-storage options that are available.

Next, you'll look at SQLite and learn how to insert and retrieve data. Finally, you'll use the asynchronous methods available in SQLite to interact with the database without blocking the UI.

By the end of this module, you'll be able to build a .NET MAUI application that stores data locally in a SQLite database.

## Learning objectives

In this module, you'll learn how to:

- Compare different data storage options that are available for .NET MAUI applications.
- Store relational data in a SQLite database.
- Interact with a database asynchronously to make sure that your UI remains responsive.

## Prerequisites

- Visual Studio 2022 with the .NET MAUI workload installed
- Optional: Visual Studio Code with the .NET MAUI Extension and .NET SDK with the .NET MAUI workload installed
- Familiarity with C# and .NET
- Basic knowledge of SQL and relational databases

[!include[](../../../includes/install-dotnet-maui-workload.md)]
