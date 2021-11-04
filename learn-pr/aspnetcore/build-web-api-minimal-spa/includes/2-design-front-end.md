Say you have sat down with two development teams, a front-end team that knows HTML, CSS and JavaScript and a front-end framework. The other team knows ASP.NET Core. You have all agreed on what features you want this full stack app should have. 

You as a front-end developer have different concerns than the back-end team. You need to think about the user's experience, how will they use these features, what layout do I need, what's the users interaction flow, and so on. Also, what if you are working faster than the back-end team, can you progress, or do you have to wait for the back-end team to deliver?

You sit down with your team consisting of a user experience person, a JavaScript specialist, and a designer, and start planning out the app.

## Build a front-end app

The first thing you want to know is what capabilities your front-end app should have. Once you know that, you can start to think about user journeys, how will a user accomplish a task, what views do they need, how will they interact with the app, and elements like buttons, sliders, text fields and so on. There are different ways to approach this problem.

### Select a framework

Users today are used to apps on the web that reacts fast to user's interactions. If the user selects a button or moves between pages, the app needs to respond quickly, just like in a client app like Microsoft Excel or Microsoft Word for example. A whole category of JavaScript frameworks was invented for this very reason, SPA frameworks, or Single Page Application frameworks.

### SPA framework

An application using a SPA framework is called a SPA application. So why is it called single-page? Well, in order for the app to be fast like a client app, it needs to stay in the same page. But does that mean that the app will have only one view? Single page doesn't mean there's only one view but it's more about how you go from one page to another. Instead of typing a new URL in the browser address field, you stay on the same page but replace the content using your SPA framework, which under the hood relies heavily on JavaScript to manipulate the DOM tree (the Document Object Model, a tree representing your app as different nodes, like leaves on a tree).

**So do I need a framework?**

As everything in IT, it depends. Usually a good measurement is it depend on how fast you need to get the app done and what features it needs. If you are in a hurry, and your app need to do things like moving between pages, collect user input data, and it needs to act like a client - it's a good candidate to use a SPA framework for.

**Which SPA framework do I choose?**

There's more than one SPA framework out there, and you want to select a framework that supports what you need to do. Additionally you want to make sure the framework you select is popular, has much documentation, many people using it (for future hiring and support). There are four major frameworks that each fulfills the criteria:

- **Angular**. This framework has been around for many years and uses TypeScript heavily. If you have a team of C# developers, TypeScript resembles C# and the tooling is good for Angular.
- **React**. React is popular and you can use ES6 and TypeScript. Like Angular, it has great tooling.
- **Vue.js**. Vue.js is also a good choice, and many people are using it.
- **Svelte**. Svelte is relatively new in this context but does a great job of looking like you are only working in HTML, JavaScript, and CSS as its compiler is powerful and able to _hide_ the framework parts to high degree.

### Component-based React example

As mentioned above, any of the four mentioned SPA frameworks is a good choice. What's good about all of them is that they use the idea of components. A component is logically separated part that does one thing well, like displaying a resource, or able to edit a resource, or able to show a piece of content you want to promote and so on. It's common that component contains both markup and JavaScript, and CSS. Another nice benefit from using a component is that ability to reuse it wherever you need to in your application.

Below is what a component can look like in React:

```javascript
import React from "react";
const Detail = ({ item: { title, description } }) => <React.Fragment>
  <div>{title}<div>
  <div>{description}</div>
</React.Fragment>
module.exports = Detail;
```

The component above is showing an item with properties `title` and `description`.

And to use it, you would type something like so:

```javascript
<Detail item={{ title: "Cheese Pizza", description : "Very cheesy" }} />
```

Here, you are passing in a JavaScript object that has properties `title` and `description`, that will be rendered by the `Detail` component.

## Plan your front-end app

At high level, your user will manage resources, regardless of whether those resources are nuts and bolts, orders, or pizzas, the user will need to do things like:

- **Create a resource**. Creating a resource means the user will type in information on a resource and at some point look to send that to a server app.
- **Read resource**. You will need to read the resource information from the server app and present that to the user.
- **Update a resource**. It's important that the user can update the information on a resource, they might mistype or information might change over time.
- **Delete a resource**. Sometimes, a resource isn't needed anymore and the user must be able to remove that resource.

### Master-detail pattern

A common pattern to use is something referred to as the Master-detail pattern. What it means is that you have a main view showing your resources as a list for example. From that view, you are able to drill down, to get into the details of a resource, either on the master view itself or in a special detail view, hence the name, master-detail.
