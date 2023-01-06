Views and paths (or routes) are core to any web framework. They're used to determine what information should be displayed to the user and how the user will access it. Django uses these concepts too.

## Paths

All applications allow users to execute different methods or functions through certain mechanisms. This action might be tapping on a button in a mobile application or executing a command from the command line.

In a web application, user requests are made by:

- Navigating to different URLs.
- Typing it in.
- Selecting a link.
- Tapping a button.

A route tells Django what function to execute if the user makes a request for a particular URL, or path.

A URL like `https://adventure-works.com/about` might execute a function called **about**. The URL `https://adventure-works.com/login` might execute a function called **authenticate**.

Paths in Django are registered by configuring `urlpatterns`. These patterns identify what Django should look for in the URL the user is requesting and determine which function should handle the request. These patterns are collected into a module Django calls a `URLconf`.

## Views

Views determine what information should be returned to the user. Views are functions or classes that execute code in response to the user request. They return HTML or other types of responses, such as a 404 error.
