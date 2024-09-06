Flask is an open-source web "micro-framework". When the creators use the term "micro-framework", they mean that the framework will perform the required tasks of a web framework, but that it doesn't include advanced features, or other specific requirements that your application must follow to work correctly. This approach allows Flask to be extremely flexible, and perfect for use as a front end to existing back ends or APIs - like Azure AI services!

When creating a web application with any framework, there are a couple of core concepts we need to understand - routing, methods, and templating. Let's explore these concepts before we write our code.

## Responding to user requests with routes

When a user uses a web application, they indicate what they want to do, or the information they're seeking, by browsing to different uniform resource locators (or URLs). They might type out an address directly (say `https://adventure-works.com`), or select a link, or a button that includes the appropriate URL. On an e-commerce site you might have URLs that look like the following:

- `https://adventure-works.com/` for the main page
- `https://adventure-works.com/products/widget` for details on a Widget
- `https://adventure-works.com/cart/buy` to complete a purchase

As a developer, we actually don't need to worry about the first part of the URL, or the domain (**adventure-works.com** in our example). Our application is put into action based on whatever comes after the domain name, starting with the **/**. The portion after the domain name is what's known as a **route**.

A **route** is a path to an action. Similar to tapping on a button in a mobile app, a route indicates the action the user wants to perform. We'll register different routes in our web application to respond to the various requests our application supports.

In our application, we indicate how we want to respond to a particular route request by providing a function. A route is a map to a function. When we think about writing code in general, this concept is relatively natural. When we want to perform a particular action, we call a function. Our users will do the exact same thing! They'll just do it a little differently, by accessing a route.

## Methods or verbs

Routes can be accessed in many ways, through what are known as methods or verbs (the two terms mean the same thing and can be used interchangeably). How the route is accessed provides additional context about the state of the user request and what action the user wants to perform.

There are many methods available when creating a web application, but the two most common (and the only two we'll focus on) are **GET** and **POST**. **GET** typically indicates that the user is requesting information, while **POST** indicates that the user needs to send us something **and** receive a response.

> [!NOTE]
> Regardless of the verb used, information can **always** be returned to the user.

A common application flow that uses **GET** and **POST** revolves around using a form. Let's say we create an application where the user wants to register for a mailing list:

1. The user accesses the sign-up form via **GET**
1. The user completes the form and selects the submit button
1. The information from the form is sent back to the server by using **POST**
1. A "success" message is returned to the user

As you might suspect, the user doesn't directly indicate the verb they want to use, it is controlled by the application. Generally speaking, if the user navigates to a URL directly, by typing it in or by selecting a link, they access the page by using **GET**. When they select a button for a form, they typically send the information via **POST**.

> [!NOTE]
> We're keeping this conversation relatively high level, because a full discussion of methods is beyond the scope of this module.

## Templates

Hypertext Markup Language, or HTML, is the language used to structure the information displayed on a browser, while Cascading Style Sheets, or CSS, is used to manage the style and layout. When creating an application, most of the HTML will be static, meaning it won't change. However, to make our pages dynamic we need to be able to programmatically put information into an HTML page. Nearly every web framework supports this requirement through templates.

A template allows you to write the core HTML (or a template) and indicate placeholders for the dynamic information. Probably the most common syntax for placeholders is `{{ }}`. Jinja, the templating engine for Flask, uses this syntax.

```html
<h1>Welcome, {{ name }}</h1>
```

In the preceding example, we have our HTML of `h1` (a header), with the text we want to display. The `{{ name }}` indicates that we want to display a variable named `name` right after **Welcome**. By using this syntax we can write our HTML with our existing skills, and inject the dynamic information as needed.
