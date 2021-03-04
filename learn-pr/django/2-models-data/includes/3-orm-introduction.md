Working with a relational database requires a different mindset than working with objects in an application. Navigating between these two environments can slow the process of creating an application, and requires extra code to convert the results of queries from a database into data the application can use.

Object Relational Mappers, or ORMs, solve this problem by acting as middleware between our application and the database. We can create objects that model the data, including adding constraints and other forms of metadata. The ORM then manages creating and updating the database as needed, handles the queries, and converts (or maps) the requests we make through our objects into the appropriate database calls.

## Overview of the Django ORM

Django was created for data driven apps, so it's only natural that it would also have an integrated ORM. The Django ORM will feel natural to Python developers, as it uses class syntax and inheritance you're already familiar with.

Because Django is designed to be a web framework, it is able to use the structure of the models we create to automatically generate HTML and forms for us. In most situations, Django will be able to dynamically create the HTML to allow the user to edit data without us having to create the form manually, and even manage the database calls for us!
