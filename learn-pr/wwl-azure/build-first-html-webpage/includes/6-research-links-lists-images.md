The word "hypertext" means you can display more than just text on a web page. HTML offers the ability to create links to other resources and add images to a page.

## Hyperlinks

Hyperlinks (or just links) allow a user to navigate to other things. This could be another page on your website, a completely separate website, or even an email address. One of the main goals of HTML was to allow these "pointers" to be added to a page for easy access. This is done through links.

The tag used to create a link is `a`, which is short for **anchor**. The content between the open and close `a` tag becomes hypertext that enables a user to access the resource.

The resource being referenced is indicated by using an **attribute** called `href` (or hypertext reference). Attributes are added inside the opening tag and are typically a name paired with a value (called key-value pairs) with the value contained in quotes.

```html
<a href="some url">clickable text</a>
```

Key-value pairs are used in forms. If you fill out a form, you may be asked for your first name and last name separately. The form will have a label **First name** and a blank space and another label **Last name** and a blank space. The labels are like *keys* in HTML attributes, and whatever you put in the blank space is the *value*. In HTML attributes, the key and the value are joined by an equal sign to show they belong together.

### Resource Indicators

There are many types of resources a link can point to. Many times links point to other web pages or websites. But a link also can point to an email address, a file (like a PDF document), a video, or an image.

To create a link to an external site, you use the full address of the site. For example, to create a link to Microsoft's documentation site, you could use:

```html
<a href="https://learn.microsoft.com/">Microsoft Technical Documentation</a>
```

It's possible to link to an email address. This type of link will automatically open the user's email client and complete the **To** field with the address indicated after the `mailto:` directive.

```html
<a href="mailto:someone@example.com">Email us!</a>
```

### Accessibility and Links

If you put a link in the HTML page you're creating, you'll notice that the text between (not inside) the opening and closing tag turns blue. You'll also notice that the address is hidden. Finally, you'll notice that the word is now selectable. That is, you select the word to be taken to the resource.

The text that is displayed as the link is known as link text. Using good link text is a key to ensuring your page is accessible to all users. Phrases like "click here" are disruptive to screen readers and other non-browser tools used to navigate the web. As a best practice, always use link text that briefly describes the resource being referenced. You can learn more about ensuring accessibility by exploring the Accessibility Learn module.

## Images

The `img` tag is used to display images on a page. Unlike most other elements, `img` has no closing tag. The `src` attribute is used to point to the location of the image to display on the page, and the `alt` describes the contents of the image for things like search engines and screen readers.

> [!IMPORTANT]
> While the `height` and `width` attributes can be used to specify the display height and width of the image, they do not resize the image file itself. The best practice is to make the image file the dimensions you will use on the page.

```html
<img src="headshot.png" alt="Picture of an employee.">
```

## Creating Lists

You will quite frequently need to display a list of information on a page. When building your resume, you will want to list prior roles or qualifications. HTML provides two different types of lists, ordered and unordered.

To create a list, you will first decide the type of list you wish to create. An ordered list is ordered with numbers (the default) or letters and uses `ol` for **ordered list**. An unordered list uses bullet points and is identified with `ul` for **unordered list**. The items are indicated with `li` for **list item**.

### Unordered List

The following creates an unordered list:

```html
<ul>
    <li>First item</li>
    <li>Second item</li>
    <li>Third item</li>
</ul>
```

The list generated:

- First item
- Second item
- Third item

### Ordered List

The following creates an ordered list:

```html
<ol>
    <li>First item</li>
    <li>Second item</li>
    <li>Third item</li>
</ol>
```

The list generated:

1. First item
1. Second item
1. Third item
