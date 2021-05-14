We discussed screen readers briefly in the **Web accessibility fundamentals** unit. A screen reader does what the name implies: it reads the screen to you. They do more than that plus, plus provide audible cues, context, and controls to navigate and intreract with web applications and complex content.

## Screen reader options
On Windows, [Narrator](https://support.microsoft.com/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1) is included by default. [JAWS](https://webaim.org/articles/jaws/) and [NVDA](https://www.nvaccess.org/about-nvda/) can also be installed on Windows. On macOS and iOS, [VoiceOver](https://support.apple.com/guide/voiceover/welcome/10) is installed by default.

In the following exercise, we will enable an operating system provided screen reader and use it to interact with our pizza web site.

## Creating screen reader accessible content

Modern web applications aren't simple pages filled with text. At a minimum, they will also include navigation, headings and images. Many include interactive forms, registration and login, search functionality, structured data tables, and more. Screen readers can help users navigate and interact with complex content provided it is structured correctly. By this point in the course, you probably won't be surprised to hear that this requires adhering to web standards rather than just making things look good in your browser.

### Page Structure

When you're designing visually, it can be tempting to just use `<div>` everywhere. A `<div>` can be styled to look like anything using CSS, and Bootstrap certainly doesn't discourage using `<div>`'s very liberally.

However, you can provide a lot more semantic information and context to screen readers by using structural HTML elements. These include the following:

- `<header>` - This is the content you'll commonly see at the top of a page, including a logo, navigation, search, and login.
- `<nav>` - Represents the a portion of the page with navigational links.
- `<main>` - As the name implies, this is the dominant content for a page.
- `<article>` - This is an individual article with a header, normally shown in a list.
- `<aside>` - This is "extra information" on a page such as sidebars or call-outs.
- `<footer>` - This is the information at the bottom of that page that generally includes copyright info, privacy policy, etc.
- `<section>` - Represents a blocks of content that doesn't fit in one of the other groupings above.

All of these items can generally be styled the same as a `<div>`, so you can usually just replace the tag. The default ASP.NET Core layout page (found in `/Pages/Shared/_Layout.cshtml`) uses many of these, including `header`, `nav`, `main`, and `footer`. 

Use a structural HTML element instead of a generic `<div>` whenever possible to provide contextual information to screen readers.

### Heading elements

The HTML `<h1>` - `<h6>` heading elements show a title for the following content. `<h1>` is the highest level, reserved for the page title, and should only be used once per page. The levels below that are nested in order of importance. Imagine a page in our website with detailed information about all of our ingredients.  We might use the following headings:

   ```
   -| Magherita Pizza Ingredients (h1)
     -| Dough (h2)
       -| Flour (h3)
       -| Yeast (h3)
       -| Salt (h3)
       -| Sugar (hd)
     -| Sauce (h2)
     -| Toppings (h2)
       -| Mozzarella (h3)
       -| Basil (h3)
       -| etc.
   ```

A common mistake, as you'll see in the next exercise, is to use text styling to denote a heading rather than using an actual heading element. Screen readers won't see those pseudo-headings, you need to use the actual heading elements to provide navigation to screen readers.

## Tab order

Many of your users will navigate through your application using a keyboard, and will rely on tab order. Fortunately, it's pretty difficult (though not impossible) to break tab ordering in an HTML page accidentally. Still, you should check the tab ordering using **FastPass**, and practice navigating through your application using only the keyboard to understand the end-user experience.

## Images and alt text

We use images in web pages in a few different ways. Some are important to the content, while others are just decorative. In order to provide this information to screen readers, all images should include an `alt` attribute.

If the image is an important part of the content, the `alt` attribute should include a brief description. Imagine you were describing the web page to someone over the phone - what would you say?

```html
<img src="/img/mozzarella.png" alt="A close-up picture of a fresh baked mozzarella pizza">
```

If the image is purely decorative, just include an empty description, like this:

```html
<img src="/img/divider.png" alt="">
```

In the next exercise, we will find and fix screen reader accessibility issues in our pizza web page.
