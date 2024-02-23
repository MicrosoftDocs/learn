We discussed screen readers briefly in the "Accessibility and screen readers" unit. A screen reader does what the name implies: it reads the screen to you. Plus, it provides audible cues, context, and control to move through and interact with web applications and complex content.

## Screen reader options
On Windows, [Narrator](https://support.microsoft.com/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1) is included by default. [JAWS](https://webaim.org/articles/jaws/) and [NVDA (Non-Visual Desktop Access)](https://www.nvaccess.org/about-nvda/) can also be installed on Windows. On macOS and iOS, [VoiceOver](https://support.apple.com/guide/voiceover/welcome/10) is installed by default.

In the next exercise, you enable a screen reader provided by an operating system and use it to interact with the pizza website.

## Creating accessible content for screen readers

Modern web applications aren't simple pages filled with text. At a minimum, they also include navigation, headings, and images. Many include interactive forms, registration and sign-in, search functionality, structured data tables, and more.

Screen readers can help users interact with complex content, if that content is structured correctly. Creating the right structure requires adhering to web standards rather than just making things look good in your browser.

### Page structure

When you're designing visually, it can be tempting to just use `<div>` everywhere. A `<div>` element can be styled to look like anything through CSS, and Bootstrap certainly doesn't discourage using `<div>` elements liberally.

However, you can provide a lot more semantic information and context to screen readers by instead using structural HTML elements whenever possible. Structural HTML elements include:

- `<header>`: The content you commonly see at the top of a page, including a logo, navigation, search, and sign-in.
- `<nav>`: Indicates a portion of the page with navigational links.
- `<main>`: As the name implies, this tag indicates the dominant content for a page.
- `<article>`: An individual article with a header, normally shown in a list.
- `<aside>`: Extra information on a page, such as sidebars or callouts.
- `<footer>`: The information at the bottom of a page that generally includes copyright info and a privacy policy.
- `<section>`: Indicates a block of content that doesn't fit in one of the preceding groupings.

All these items can generally be styled the same as a `<div>` element, so you can just replace the tag. The default ASP.NET Core layout page (found in */Pages/Shared/_Layout.cshtml*) uses many of these elements, including `header`, `nav`, `main`, and `footer`. 

### Heading elements

The HTML `<h1>` - `<h6>` elements show headings for the content. `<h1>` is the highest level, reserved for the page title, and should be used only once per page. The levels after `<h1>` are nested in order of importance.

Imagine a page on our website that has detailed information about pizza ingredients. You might use the following headings:

```md
- Margherita Pizza Ingredients (h1)
  - Dough (h2)
    - Flour (h3)
    - Yeast (h3)
    - Salt (h3)
    - Sugar (h3)
  - Sauce (h2)
  - Toppings (h2)
    - Mozzarella (h3)
    - Basil (h3)
    - etc.
```

As we see in the next exercise, a common mistake is to use text styling to denote a heading rather than using an actual heading element. Screen readers don't see those pseudo-headings. You need to use the actual heading elements to provide navigation to screen readers.

## Tab order

Many of your users move through your application by using a keyboard and rely on tab order. Fortunately, it's difficult (though not impossible) to accidentally break the tab order on an HTML page. Still, you should check the tab order by using FastPass. Practice moving through your application by using only the keyboard to understand the user experience.

## Images and alt text

We use images on webpages in a few different ways. Some are important to the content, whereas others are decorative. To provide this information to screen readers, all images should include an `alt` attribute.

If the image is an important part of the content, the `alt` attribute should include a brief description. Imagine you're describing the webpage to someone over the phone - what would you say?

```html
<img src="/img/mozzarella.png" alt="A close-up picture of a fresh baked mozzarella pizza">
```

If the image is purely decorative, just include an empty description, like this:

```html
<img src="/img/divider.png" alt="">
```
