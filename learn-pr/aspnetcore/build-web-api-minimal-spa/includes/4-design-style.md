The functionality of the front end app is complete but it isn't engaging visually. Let's fix that. 

## Design systems for front-end apps

A design system is a collection of reusable components, guided by clear standards, that can be assembled together to build any number of applications. Design systems are used to create consistent, high-quality user experiences. 

A design system specifies the look and feel of an application, and the way that users interact with it. They also provide a common language for designers and developers to communicate with each other.

You don't have to use a design system. You can create your own CSS and components. However, using a design system is a great way to get started quickly and to ensure that your application has a consistent look and feel.

Design systems are made up of many parts:

* Component Library - A collection of reusable components that can be assembled together to build any number of applications.
* Pattern Library - A collection of components organized in particular ways to solve specific problems consistently.
* Brand Style Guide - A set of rules and guidelines for how to use the brand's visual identity.
* Brand Values - A set of ideas that guide to align teams on the overall design meant to result in specific emotions for users within the site.
* Design Principles - A set of ideas that guide the design of the site.
* Icon Library - A collection of icons that can be used in the site.
* Content Guidelines - A set of rules and guidelines for how to write content for the site.
* Accessibility Guidelines - A set of rules and guidelines for how to make the site accessible to all users.
* Design Tokens - A set of names meant to represent hard-coded values for visual elements such as spacing, color, typography, and more.

## Common frontend design systems

There are many frontend design systems available. Here are some of the most popular:

* [Material Design](https://material.io/)
* [Bootstrap](https://getbootstrap.com/)
* [Fluent UI](https://developer.microsoft.com/en-us/fluentui#/)
* [Chakra UI](https://chakra-ui.com/)


## Using a design system

A design system is specified in the application as Cascading Style Sheets (CSS) along with components (which may also bring along default styles). CSS works the HTML elements either by HTML element name, custom ID, or custom name, custom class name. This allows you to separate your design system from its use in your HTML. 

Once you select your design system, add the packages, select your core CSS values from branding colors and typography then use the system's components in your HTML. 

This typically means adding class names to your HTML elements and/or renaming the HTML elements to use the system's components. For example, an HTML button is `button`, and a design system will use `Button` or `PrimaryButton`. 


## CSS Styles defined

A style is defined with CSS syntax. It can appear in a *.css file, be transpiled into a *.css file (such as with SASS), or be defined in a JavaScript file (such as with styled-components).

Styled components are a way to use CSS in JavaScript. They're a popular way to use CSS in React.


## Apply a design system to your React app

Design systems can provide either default themes or custom themes. Because a theme is meant to apply to the entire site, you add it at the top React component. This is typically in main.jsx or index.jsx.

```javascript
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';

import { ThemeProvider } from '@emotion/react';
import { CssBaseline } from '@mui/material';
const theme = createTheme();

import Pizza from './Pizza'

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Pizza />
    </ThemeProvider>
  </React.StrictMode>,
);
```

## Apply a design system to your React component

Let's apply a design system component to an HTML button. Replace the `button` element with the design system `Button`.

Include the component in your component's page: 

```javascript
import Button from '@mui/material/Button';
```

**Find your HTML button**:

```jsx
<button onClick={incrementCounter}>Increment</button>
```

**Replace with the design system `Button`**:

```jsx
<Button className="button-success" onClick={incrementCounter}>Increment</Button>
```

If you chose not to name the class or create your own CSS, many design systems have default styles, which are more engaging than HTML without a design system.

