Suppose you have met with two development teams: one team knows HTML, CSS, JavaScript, and a front-end framework, and the other team knows ASP.NET Core. You have all agreed on what features you want this full stack app to have. 

As a front-end developer, you have different concerns than the back-end team. You need to think about the user's experience, including:

- How will the user be working with these features?
- What layout do I need?
- What's the user's interaction flow?

You also need to consider how to work with the back-end team, particularly if you're working faster than them. Can you progress independently, or do you have to wait for the back-end team to deliver?

You sit down with your team to figure out the answers. The team consists of a user experience person, a JavaScript specialist, and a designer. Together, you start planning out the app.

## Build a front-end app

The first thing you want to know is what capabilities your front-end app should have. When you know that, you can start to think about user journeys: things like how a user will accomplish a task, what views they need, and how they interact with the app. You'll also be able to imagine some of the UI you might need, including buttons, sliders, and text fields. There are different ways to approach this problem.

### Select a framework

Users today expect that apps on the web can react fast to interactions. For example, if the user selects a button or moves between pages, the app needs to respond quickly, just like in a client app like Microsoft Excel or Microsoft Word. A whole category of JavaScript frameworks was invented for this very reason, called *SPA* frameworks, or single-page application frameworks.

### SPA framework

An application that uses a SPA framework is called a *SPA application*. So why is it called single page? Well, in order for the app to be fast like a client app, it needs to stay in the same page.

But does that mean that the app has only one view? Single page doesn't mean there's only one view. It's more about how you go from one page to another. Instead of typing a new URL in the browser address field, you stay on the same page but replace the content by using your SPA framework. Your SPA framework relies heavily on JavaScript to manipulate the Document Object Model, a tree representing your app as different nodes (like leaves on a tree).

#### Do I need a framework?

As with everything in IT, it depends. On this matter, it depends on how fast you need to get the app done and what features it needs. If you're in a hurry, and your app needs to move between pages, collect user input data, and act like a client, then your app should use a SPA framework.

#### Which SPA framework do I choose?

There's more than one SPA framework out there, and you want to select a framework that supports what you need to do. Additionally, you want to make sure the framework you select is popular and well-documented, because these aspects can be helpful for future hiring and support. There are four major frameworks that fulfill these criteria:

- **Angular:** This framework has been around for many years and uses TypeScript heavily. TypeScript resembles C#, and the tooling is good for Angular.
- **React:** React is popular and you can use ES6 and TypeScript. Like Angular, it has great tooling.
- **Vue.js:** Vue.js is also a good choice, and many people are using it.
- **Svelte:** Svelte is relatively new in this context, but it does a great job of looking like you are only working in HTML, JavaScript, and CSS. Its compiler is powerful and able to _hide_ the framework parts to high degree.

### Component-based React example

All of the SPA frameworks mentioned in the previous section use components. A *component* is logically separated part that does one thing well. For example, a component might display a resource, edit a resource, or show a piece of content that you want to promote. Components usually contain both markup and JavaScript, as well as CSS. Another nice benefit of using a component is that you can reuse it wherever you need to in your application.

Here's what a component can look like in React:

```javascript
import React from "react";
const Detail = ({ item: { title, description } }) => <React.Fragment>
  <div>{title}<div>
  <div>{description}</div>
</React.Fragment>
module.exports = Detail;
```

This component is showing an item with the properties `title` and `description`.

To use this component, you would type something like this:

```javascript
<Detail item={{ title: "Cheese Pizza", description : "Very cheesy" }} />
```

Here, you are passing in a JavaScript object that has the properties `title` and `description`. These properties are rendered by the `Detail` component.

## Plan your front-end app

At a high level, your user will manage resources. Regardless of whether those resources are nuts and bolts, orders, or pizzas, the user will need to do things like:

- **Create a resource:** Creating a resource means that the user will type in information on a resource, and send that to a server app.
- **Read a resource:** You will need to read the resource information from the server app, and present that to the user.
- **Update a resource:** It's important that the user can update the information on a resource. The user might mistype the information, or the information might change over time.
- **Delete a resource:** Sometimes, a resource isn't needed anymore, and the user must be able to remove that resource.

### Master-detail pattern

A common pattern to use is something referred to as the *master-detail* pattern. For example, you might have a main view that shows your resources as a list. From that view, you can drill down to get into the details of a resource. The details might be available on the master view itself, or in a special detail view.
