Working with a relational database requires a different mindset than working with objects in an application. Switching between these two environments can slow the process of creating an application. Also, converting the results of queries from a database into data that the application can use requires extra code.

Object-relational mappers, or ORMs, solve this problem by acting as middleware between an application and the database. You can create objects that model the data, including adding constraints and other forms of metadata. The ORM then:

- Manages creating and updating the database as needed.
- Handles the queries.
- Converts (or maps) the requests that you make through your objects into the appropriate database calls.

## Overview of the Django ORM

Django was created for data-driven apps, so it's only natural that it would have an integrated ORM. The Django ORM will feel natural to Python developers, because it uses class syntax and inheritance that you're already familiar with.

Because Django is designed to be a web framework, it can use the structure of the models that you create to automatically generate HTML and forms. In most situations, Django can dynamically create the HTML to allow the user to edit data without requiring us to create the form manually. It can even manage the database calls for us!
