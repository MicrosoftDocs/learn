The functionality of the front end app is complete but it isn't engaging visually. Let's fix that. 

## Design systems for front-end apps

A design system is a collection of reusable components, guided by clear standards, that can be assembled together to build any number of applications. Design systems are used to create consistent, high-quality user experiences. 

A design system specifies the look and feel of an application, and the way that users interact with it. They also provide a common language for designers and developers to communicate with each other.

You don't have to use a design system. You can create your own CSS and components. However, using a design system is a great way to get started quickly and to ensure that your application has a consistent look and feel.

Design systems are made up of two parts:

* **Design tokens:** Design tokens are the visual design atoms of the design system. They're named entities that store visual design attributes used in place of hard-coded values to maintain a scalable and consistent design. 

* **Component library:** A component library is a set of building blocks that allow developers to build applications quickly. Examples of components are buttons, form elements, and typography.

## Common frontend design systems

There are many frontend design systems available. Here are some of the most popular:

* [Bootstrap](https://getbootstrap.com/)
* [Material Design](https://material.io/)
* [Fluent UI](https://developer.microsoft.com/en-us/fluentui#/)
* [Chakra UI](https://chakra-ui.com/)

## Using a design system

A design system is specified in the application as Cascading Style Sheets (CSS) along with components (which may also bring along default styles). CSS works the HTML elements either by HTML element name, custom ID, or custom name, custom class name. This allows you to separate your design system from its use in your HTML. 

Once you select your design system, add the packages, select your core CSS values from branding colors and typography then use the system's components in your HTML. 

This typically means adding class names to your HTML elements and/or renaming the HTML elements to use the system's components. For example, an HTML button is `button`, and a design system will use `Button` or `PrimaryButton`. 

## An example CSS file

A CSS file can specify site and brand colors. This provides consistency throughout the site. 

```css
/* Design token: color palette */
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --success-color: #28a745;
  --danger-color: #dc3545;
  --warning-color: #ffc107;
  --info-color: #17a2b8;
  --light-color: #f8f9fa;
  --dark-color: #343a40;
}

/* Typography */
body {
  font-family: Arial, sans-serif;
  font-size: 16px;
  line-height: 1.5;
}

/* Headings */
h1, h2, h3, h4, h5, h6 {
  font-weight: bold;
  margin-top: 0;
  margin-bottom: 0.5rem;
}

/* all buttons with class `button-success */
button .button-success {
    background-color: var(--primary-color);
}
/* all buttons with class `button-danger */
button .button-danger {
    background-color: var(--danger-color);
}
```

## Apply a design system to your React app

Design systems can provide either default themes or custom themes. Because a theme is meant to apply to the entire site, you add it at the top React component. This is typically in main.jsx or index.jsx.

```javascript
/* Import the UI Framework */
import React from 'react'
import ReactDOM from 'react-dom/client'

/* Import the UI design system */
import {
      FluentProvider,
      webLightTheme
} from "@fluentui/react-components";

/* Import your customer styles from CSS file */
import './index.css'

/* Attach to Document Ojbect Model (DOM) */
ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <FluentProvider theme={webLightTheme}>
        <Pizza />
    </FluentProvider>
  </React.StrictMode>,
)
```

## Apply a design system to your React component

Let's apply a design system component from _Fluent_ to an HTML button. Replace the `button` element with the _Fluent_ `PrimaryButton`.

Include the component in your component's page: 

```javascript
import { PrimaryButton } from '@fluentui/react';
```

**Find your HTML button**:

```jsx
<button onClick={incrementCounter}>Increment</button>
```

**Replace with the _Fluent_ design system `PrimaryButton`**:

```jsx
<PrimaryButton className="button-success" onClick={incrementCounter}>Increment</PrimaryButton>
```

If you chose not to name the class or create your own CSS, many design systems have default styles, which are more engaging than HTML without a design system.

