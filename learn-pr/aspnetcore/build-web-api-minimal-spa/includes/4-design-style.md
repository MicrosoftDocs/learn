The functionality of the front end app is complete but it isn't engaging visually. Let's fix that. 

## Design systems for front-end apps

A design system is a collection of reusable components, guided by clear standards, that can be assembled together to build any number of applications. Design systems are used to create consistent, high-quality user experiences. 

A design system specifies the look and feel of an application, and the way that users interact with it. They also provide a common language for designers and developers to communicate with each other.

You don't have to use a design system. You can create your own CSS and components. However, using a design system is a great way to ensure that your application has a consistent look and feel.

Design systems are made up of many parts, some of which are:

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

A design system is specified in the application with a combination of features, which interact together to create the look and feel of the site. Some of the common features are Cascading Style Sheets (CSS) along with prebuilt components and topography.  

Once you select your design system, add the packages. Many design systems have a default style, so you can add the packages and see the changes immediately. You can change the style by adding your own CSS at any time. 

This typically means adding class names to your HTML elements and/or renaming the HTML elements to use the system's components. For example, an HTML button is `button`, and a design system will use `Button` or `PrimaryButton`. 

### CSS Styles

A style is defined with CSS syntax. It can appear in a *.css file, be transpiled into a *.css file (such as with SASS), or be defined in a JavaScript file (such as with styled-components). Styled components are a way to use CSS in JavaScript and are a popular way to use CSS in React.

### Components 

A component is a reusable piece of code that can be used to build elements sharing functionality and styling. Components can be used to build other components, and they can be used to build entire applications. Common components are buttons, forms, and navigation bars.

### Typography

Typography is the style and appearance of text. It includes font size, font weight, font color, and font family.

### Icons

Icons are small images that represent an object or action. They're used to communicate information quickly and clearly. Icons are often used in navigation bars and buttons.

## Apply a design system to your React app

Design systems can provide either default themes or custom themes. Because a theme is meant to apply to the entire site, you add it at the top React component. This is typically in main.jsx or index.jsx. The following example uses Material UI to add a default theme to the app.

```javascript
import * as React from 'react';
import * as ReactDOM from 'react-dom/client';

import { ThemeProvider, createTheme } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
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
<Button onClick={incrementCounter}>Increment</Button>
```

The `Button`, with default styling, is on the left and the `button` is on the right:

:::image type="content" source="../media/button-comparison.png" alt-text="The left button is a default styled button with a design system, showing a blue background, shading, and default topography. The button on the right is the standard HTML button with black text and a grey background. ":::
