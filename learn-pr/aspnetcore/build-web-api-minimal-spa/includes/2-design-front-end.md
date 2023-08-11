Suppose you have met with two development teams: one team knows HTML, CSS, JavaScript, and a front-end framework, and the other team knows ASP.NET Core. You have all agreed on what features you want this full stack app to have.

As a front-end developer, you have different concerns than the back-end team. You need to think about the user's experience, including:

- How will the user be working with these features?
- What layout do I need?
- What's the user's interaction flow?

You also need to consider how to work with the backend team, particularly if you're working faster than them. Can you progress independently, or do you have to wait for the back-end team to deliver?

You sit down with your team to figure out the answers. The team consists of a user experience person, a JavaScript specialist, and a designer. Together, you start planning out the app.

## Build a front-end app

The first thing you want to know is what capabilities your front-end app should have. When you know that, you can start to think about user journeys: things like how a user accomplishes a task, what views they need, and how they interact with the app. You'll also be able to imagine some of the UI you might need, including buttons, sliders, and text fields. There are different ways to approach this problem.

### Select a Framework

Users today expect that apps on the web can react fast to interactions. For example, if the user selects a button or moves between pages, the app needs to respond quickly, just like in a client app like Microsoft Excel or Microsoft Word. A whole category of JavaScript frameworks was invented for this very reason, called *SPA* frameworks, or single-page application frameworks.

### SPA framework

An application that uses a SPA framework is called a *SPA application*. So why is it called single page? Well, for the app to be fast like a client app, it needs to stay on the same page.

But does that mean that the app has only one view? A single page doesn't mean there's only one view. It's more about how you go from one page to another. Instead of typing a new URL in the browser address field, you stay on the same page but replace the content by using your SPA framework. Your SPA framework relies heavily on JavaScript to manipulate the Document Object Model, a tree representing your app as different nodes (like leaves on a tree).

### Do I need a framework?

As with everything in technology, it depends. Front-end frameworks provide the scaffolding to allow you to keep most functionality and operations on the browser, with the user's compute. Some frameworks, such as Next.js, even allow a hybrid model, with trips to the API wrapped into the framework allowing statically generated or hybrid generated pages. App Frameworks can also expediate the front-end development but providing build systems, scaffolding, component libraries, and other user interface options. If your app needs to move between pages on the browser, collect user input data, and act like a client, then your app should use a SPA framework.

### Which SPA framework do I choose?

There's more than one SPA framework out there, and you want to select a framework that supports what you need to do. Additionally, you want to make sure the framework you select is popular and well-documented, because these aspects can be helpful for future hiring and support. Four major frameworks fulfill these criteria:

- **React:** React is popular and you can use ES6 and TypeScript. Like Angular, it has great tooling.
- **Angular:** This framework has been around for many years and uses TypeScript heavily. TypeScript resembles C#, and the tooling is good for Angular.
- **Vue.js:** Vue.js is also a good choice, and many people are using it.
- **Svelte:** Svelte is relatively new in this context, but it does a great job of looking like you're only working in HTML, JavaScript, and CSS. Its compiler is powerful and able to _hide_ the framework parts to a high degree.
- **Next.js:** Next.js allows for hybrid static and server-side rendering, and is a great choice for a hybrid app. 

### What is a bundler? 

A bundler is a tool that takes JavaScript, CSS, images, and other artifacts and combines them into bundled files. This is useful because it reduces the number of files and file sizes that the browser needs to download. There are a few popular bundlers:

- **Webpack:** Webpack is a popular bundler that's used by many frameworks. It has a lot of features and is very configurable. 
- **Parcel:** Parcel is a newer bundler that's easy to use and provides a lot of features out of the box with no configuration.
- **Vite:** Vite is a newer bundler focusing on speed and simplicity. It provides configured templates from many frameworks.

## What is a front end development server?

When using a SPA framework, the framework can either provide a local HTTP server to serve the app or you may need to provide that server. A framework like **Vite** provides that server, and allows you to configure the server to help support your development work. 

Common settings you may need to change are: 

* **Port:** The port the server listens on.
* **Proxy:** Whether the server proxies requests to another server. In this module, you'll use a proxy to connect to the back-end API.

If is important to configure these settings so all developers on the project have a consistent experience. Remember to check the configuration into source control so the settings stay with the app.

### The React UI framework

This module uses the React UI framework. React is a UI framework that uses a virtual DOM to manipulate the web application's user interface. It creates a tree of components that represent the UI elements and updates them efficiently based on changes in the application's data. This makes React a popular choice for building complex web applications with a responsive and dynamic user interface.

### Component-based React example

All of the SPA frameworks mentioned in the previous section use components. A _component_ is a logically separated part that does one thing well. For example, a component might display data, edit data, or show a piece of content that you want to promote. Components usually contain HTML markup, JavaScript, and CSS. Another nice benefit of using a component is that you can reuse it wherever you need to in your application. The component only rerenders if the data sent to it changes, for efficiency.

Here's what a component can look like in React:

```javascript
import React from "react";

const Detail = ({ item: { title, description } }) => 
  <>
    <div>{title}<div>
    <div>{description}</div>
  </>

export default Detail;
```

This component accepts input of an item with the `title` and `description` properties. These properties are then displayed in HTML markup inside a React fragment `<>`. The `Detail` component is exported so that it can be used in other components.

To use this component, you would type something like this:

```javascript
<Detail item={{ title: "Cheese Pizza", description : "Very cheesy" }} />
```

Here, you're passing in a JavaScript object that has the properties `title` and `description`. These properties are rendered by the `Detail` component.

## Plan your front-end app state and database management

At a high level, your user manages data. Regardless of whether the data are nuts and bolts, orders, or pizzas, the user needs to do things like:

- **Create data:** Creating a data means that the user types in information on a data, and send that to a server app.
- **Read data:** You'll need to read the information from the server app, and present that to the user.
- **Update data:** It's important that the user can update the information. The user might mistype the information, or the information might change over time.
- **Delete data:** Sometimes, data isn't needed anymore, and the user must be able to remove it.

### One-way data binding

The ability to pass information from a parent component to a child component is referred to as one-way data binding. The data always moves from the parent to the child. The child component can't change the data. If the child component needs to change the data, it must send a message to the parent component, and the parent component can then change the data. This allows the parent to control when the child is rerendered. Over-rendering in React can be a performance issue, so it's important to be aware of this.

In order for the child component to signal to the parent that some of the data in the child has been updated, the parent sends along the data, and its own functions to update the data.

Using the previous example, here's how the parent component might look:

```javascript
import React, { useState } from "react";
import Detail from "./Detail";

const Parent = () => {
  const [item, setItem] = useState({ title: "Cheese Pizza", description: "Very cheesy" });

  return (
    <Detail item={item} setItem={setItem} />
  );
};
```

Here, the `Parent` component is using the `useState` hook to create a state variable called `item`. The `item` variable is initialized with a JavaScript object that has the properties `title` and `description`. The `Parent` component then passes the `item` variable and the `setItem` function to the `Detail` component.

The `Detail` component can then use the `item` variable to display the data, and the `setItem` function to update the data. Here's how the `Detail` component might look:

```javascript
import React from "react";

const Detail = ({ item, setItem }) => 
  <>
    <div>{item.title}<div>
    <div>{item.description}</div>
    <button onClick={() => setItem({ title: "Pepperoni Pizza", description: "Very meaty" })}>Change</button>
  </>
```

### Data binding and state management

In order to have effiient component rendering, you need to plan state management. State management is the process of managing the data that's used by your components. 

There are state management systems that you can use, such as Redux, but for simpler apps such as this Pizza, you can also use the built-in React state management system. The built-in system is called `useState`, and it's a hook that you can use in your components. Hooks are functions that you can use in your components to add functionality. The `useState` hook allows you to create state variables that you can use in your components.

To manage state for the Pizza app, create a parent component, _Pizza_, then use a child component, _PizzaList_, to display the list of pizzas. The _PizzaList_ component will need to be able to add a pizza to the list, so it will need to send a message to the _Pizza_ component. The _Pizza_ component will then update the list of pizzas, and send the updated list back to the _PizzaList_ component. The _PizzaList_ component will then rerender with the updated list of pizzas.

