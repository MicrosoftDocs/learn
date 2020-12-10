
It's impressive what's possible to accomplish with a website today. You can build websites, or web apps, that look and feel like native applications, but that run in your web browser. If you're interested in starting web development today, you may be faced by a dizzying array of options. In this module, we'll show you the basic components of a website, and the tools you can use to start web development. You'll use HTML, CSS, and JavaScript together to build a simple website, and you'll use developer tools in the browser to understand what's happening.

With this fundamental knowledge in place, you will have a better context to make decisions in the future about such things as choosing JavaScript frameworks to build your website.

Let's get started by taking a look at where we want to go.

## Scenario

Imagine that you're a web developer, and you're asked to make your company's website appeal to a broader range of customers, and you decide to add support for light and dark themes. You create a simple, proof-of-concept site to demonstrate support for themes using CSS, and you write a JavaScript function to toggle the theme.

When completed, the simple website will look like this, when the dark theme is selected.

:::image type="content" source="../media/chrome-themed-website.png" alt-text="Website showing dark theme":::

## What's in a web page?

In a web page, hypertext markup language (HTML) provides your content, cascading style sheets (CSS) define the appearance of the page, and JavaScript is used to provide interactivity with the user, that is, your business logic.

The content, style, and business logic are separated into HTML, CSS, and JavaScript files, respectively. A design principle in modern programming is the separation of concerns. Among the many reasons to separate concerns, one is simplicity and re-use. For example, by styling elements using CSS, you can apply styles to all the elements on a page, no matter the page complexity, rather than coding the appearance separately within each HTML element.

## Learning objectives

In this module, you will:

- Create a basic web page using HTML
- Apply styles to page elements using CSS
- Create themes using CSS
- Add support for switching the theme using JavaScript
- Inspect the website using browser developer tools

You will run the site in your default browser. At the end of the module, we link to other modules that show how to deploy the website using Azure Static Web Apps.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com), a cross-platform code editor.
- Familiarity with at least one programming language and one markup language like HTML
- A computer that's running one of the following:
  - Windows: Windows 7, 8, 10
  - Mac: macOS 10.9 or later
  - Linux: Ubuntu, Debian, Red Hat, Fedora, or SUSE
