Flask is an open source web "micro-framework". When the creators use the term "micro-framework", what they mean is the framework will perform the required tasks of a web framework, but don't include advanced features or other specific requirements your application must follow in order to work correctly. This allows Flask to be extremely flexible, and perfect for use as a front end to existing back-ends or APIs - like Cognitive Services!

When creating a web application with any framework, there are a couple of core concepts we need to understand - routing, methods and templating. Let's explore these concepts before we write our code.

## Responding to user requests with routes

When a user uses a web application they indicate what they want to do, or the information they're seeking, by navigating to different uniform resource locators (or URLs). They might do this by typing out an address directly (say https://adventure-works.com), or clicking on a link or button which includes the appropriate URL. On an e-commerce site you might have URLs which look like the following:

- https://adventure-works.com/ for the main page
- https://adventure-works.com/products/widget for details on a Widget
- https://adventure-works.com/cart/buy to complete a purchase

As a developer, we actually do not need to worry about the first part of the URL, or the domain (**adventure-works.com** in our example). Our application is put into action based on whatever comes after the domain name, starting with the **/**. The portion after the domain name is what's known as a **route**.

A **route** is a path to an action. Similar to tapping on a button in a mobile app, a route indicates the action the user wishes to perform. We will register different routes in our web application to respond to the various requests our application supports.

In our application, we indicate how we want to respond to a particular route request by providing a function. At the end of the day, a route is a map to a function. When we think about writing code in general, this is relatively natural. When we want to perform a particular action, we call a function. Our users will do the exact same thing! They'll just do this a little differently, by accessing a route.

## Methods or verbs

Routes can be accessed numerous ways, through what are known as methods or verbs (the two terms mean the same thing and can be used interchangeably). How the route is accessed provides additional context about the state of the user request and what action the user wishes to perform.

There are numerous methods available when creating a web application, but the two most common (and the only two we will focus on) are **GET** and **POST**. **GET** typically indicates the user is requesting information, while **POST** indicates the user needs to send us something **and** receive a response.

> [!NOTE]
> Regardless of the verb used, information can **always** be returned to the user.

A common application flow using **GET** and **POST** revolves around using a form. Let's say we create an application where the user wishes to register for a mailing list:

- User accesses the sign-up form via **GET**
- User completes the form, clicks on the submit button
- The information from the form is set back to the server using **POST**
- A success message is returned to the user

As you might suspect, the user doesn't directly indicate the verb they wish to use; this is controlled by the application. Generally speaking, if the user navigates to a URL directly by typing it in or clicking on a link they access the page using **GET**; hen they click on a button for a form they typically send the information via **POST**.

> [!NOTE]
> We are keeping this conversation relatively high level, as a full discussion of methods is beyond the scope of this module.

## Templates

Hypertext Markup Language, or HTML, is the language used to structure the information displayed on a browser, while Cascading Style Sheets, or CSS, is used to manage the style and layout. When creating an application most of the HTML will be static, meaning it won't change. However in order to make our pages dynamic we need to be able to programmatically put information into an HTML page. Nearly every web framework supports this through templates.

A template allows you to write the core HTML (or a template) and indicate placeholders for the dynamic information. Probably the most common syntax for placeholders is `{{ }}`. Jinja, the templating engine for Flask, uses this syntax.

```html
<h1>Welcome, {{ name }}</h1>
```

In the above example, we have our HTML of `h1` (a header), with the text we wish to display. The `{{ name }}` indicates we wish to display a variable named `name` right after **Welcome**. By using this syntax we can write our HTML using our existing skills, and inject the dynamic information as needed.
