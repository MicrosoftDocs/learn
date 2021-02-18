React uses a special syntax known as JavaScript XML (JSX). JSX allows you to integrate both HTML (or custom components you might create) and JavaScript into a single file or even single line of code. By using JSX, you can rely on JavaScript syntax for logic. Visual Studio Code provides IntelliSense for JSX files, making it easier to work with React.

> [!NOTE]
> JSX relies on Extensible Markup Language (XML). XML's syntax is similar to HTML. In many instances you might not notice a difference. However, XML places a couple of important restrictions on your syntax:
>
> - All elements must be placed inside one parent element.
> - All elements must be closed.

## The build process

Browsers don't natively support JSX. So JavaScript and HTML must be generated from the JSX files to be rendered by a browser. There are several bundlers and other tools that can perform the necessary tasks, including [Webpack](https://webpack.js.org/?azure-portal=true), [Parcel](https://parceljs.org/?azure-portal=true), and [Snowpack](https://www.snowpack.dev/?azure-portal=true). We'll use Snowpack because it doesn't require code or extra scripting.

## Components

React development is based on components. Components are self-contained units of both display and work. They can be reused in your application, and allow you to logically break down your application into smaller chunks (or components).
