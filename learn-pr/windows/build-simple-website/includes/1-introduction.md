
It's impressive what you can do on the web today. You can build websites or web apps that look and feel like native applications, but run in your web browser. If you're interested in starting web development today, you may be faced by a dizzying array of options. In this module, you'll learn the basic components of a website, and the tools you can use to start web development. You'll use HTML, CSS, and JavaScript together to build a simple website, and you'll use developer tools in the browser to understand what's happening.

With this fundamental knowledge in place, you'll have a better context to make decisions in the future when building your websites. For example, whether you should choose JavaScript frameworks to build your website or create your own JavaScript functions.

Let's get started by taking a look at where we want to go.

## Scenario

Imagine that you're a web developer, and you've been asked to make your company's website appeal to a broader range of customers. To allow your customers to customize their experience on your website, you decide to add support for light and dark themes. You create a simple, proof-of-concept website to demonstrate support for themes using CSS, and you write a JavaScript function to toggle the theme.

When completed, the simple website will look like the following example when the dark theme is selected.

:::image type="content" source="../media/chrome-themed-website.png" alt-text="Website showing dark theme":::

## What's in a web page?

In a web page, hypertext markup language (HTML) provides your content, cascading style sheets (CSS) define the appearance of the page, and JavaScript is used to provide interactivity with the user (that is, your business logic).

The content, style, and business logic are respectively separated into HTML, CSS, and JavaScript files. A design principle in modern programming is the separation of concerns. Among the many reasons to separate concerns, two are simplicity and re-use. For example, by styling elements your HTML using CSS, you can simplify the formatting for your pages by applying CSS styles to all the elements on a page, no matter the page complexity, rather than coding the appearance separately within each HTML element. In addition, you can link multiple HTML pages to a single CSS file, which can help you simplify a consistent look and feel across your entire website.

## Learning objectives

In this module, you'll:

- Create a basic web page using HTML
- Apply styles to page elements using CSS
- Create themes using CSS
- Add support for switching between themes using JavaScript
- Inspect the website using browser developer tools

You'll run the site in your default browser. At the end of the module, we'll link to other modules that show how to deploy the website using Azure Static Web Apps.

## Prerequisites

- [Visual Studio Code](https://code.visualstudio.com), a cross-platform code editor.
- Familiarity with at least one programming language and one markup language like HTML
- A computer that's running one of the following:
  - Windows: Windows 7, 8, 10
  - Mac: macOS 10.9 or later
  - Linux: Ubuntu, Debian, Red Hat, Fedora, or SUSE
