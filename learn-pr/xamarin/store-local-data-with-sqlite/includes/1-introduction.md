[!include[](../../includes/dotnet-maui-note.md)]

When you're building mobile applications, it's common to store data locally on a device for performance reasons. For example, let's say you're  building a social media application that enables users to post status updates to their followers. 

You decide to store the posts on a remote server, and you use a REST endpoint to retrieve the posts on your app. Since the posts are stored remotely, you have to call the REST endpoint to get the posts again every time you restart the application. 

This design works. However, it's inefficient because you have to keep downloading the posts from the server every time you restart the application.

A more efficiently designed app downloads the posts once and saves them locally to the device.  With this design, you only have to download newer posts when you restart the application. Let's create this more efficient design by using a local database.

In this module, you'll build a Xamarin.Forms application that stores data locally in a database. You'll start by exploring the different data storage options that are available.

 Next, you'll look at SQLite and learn how to insert and retrieve data. Finally, you'll use the asynchronous methods that are available in SQLite to interact with the database without blocking the UI. 

By the end of this module, you'll be able to build a Xamarin.Forms application that stores data locally in a SQLite database. 

[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Compare different data storage options that are available for mobile applications
- Store relational data in a SQLite database
- Interact with your database asynchronously to make sure that your UI remains responsive

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
- Basic knowledge of SQL and relational databases
