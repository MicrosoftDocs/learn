CSS selectors are used to select the elements to apply style. Selectors offer a great deal of flexibility and power. Selectors enable you to apply a style to all elements or to one specific element, and even one specific letter.

There are three core types of selectors:
- Elements
- Classes
- IDs

By using these selectors, you can apply styles to many elements or a few.

## Element Selectors

An element selector applies to all elements with that tag. Any HTML element can be used as an element selector. Using `h1` enables you to modify all `h1` elements on the page.

```css
h1 {
    /* style */
}
```

## Class Selectors

All HTML elements enable you to add a `class` attribute. `class` is used to group elements together and enable you to mark them for applying CSS settings.

When creating a resume, you'll likely have sections for your education and employment history. Using a class would allow you to format those elements with the same style.

```html
<div class="history">
    <h2>Employer name</h2>
    <h3>Job title</h3>
    <h3>3 Jun 19 - 8 Jun 21</h3>
</div>

<div class="history">
    <h2>School name</h2>
    <h3>Major</h3>
    <h3>Sep 2014 - May 2018</h3>
</div>
```

In the previous example, you would likely want the formatting for each `div` to be the same as they're displaying similar types of information. By marking the two `div` elements with the same class, you can apply the same CSS style to each.

To identify a class in CSS, you prefix a `.` in front of the name. In our example, you would use `.history`.

```css
.history {
    /* your styles */
}
```

If using a CSS file, you would write the class style definition in the CSS file. The class attribute in HTML references the definition from the CSS file.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE5amMK]
### Pseudo-classes

Pseudo-classes enable you to identify elements based on their location on a page or how the user is interacting with them.

As a user interacts with a web page, the state of various elements will change. A user could be hovering their mouse over an item, and you want the color to change when they hover. Or the user may have clicked a link. After they've visited that link, you may want to let them know by changing the style. CSS supports many *pseudo-classes*, which are applied dynamically based on what the user does or has done. Pseudo-classes are prefixed by a `:`, and are placed after another selector.

For example, to set the background color of a link to yellow when a user hovers their cursor over it, you could use the following CSS:

```css
a:hover {
    background-color: yellow;
}
```

Some of the most common pseudo-classes are listed in the following table:

| Pseudo-class  | Description                                          |
| ------------- | ---------------------------------------------------- |
| `hover`       | User is hovering their cursor over an item           |
| `visited`     | A link that has been previously clicked              |
| `link`        | An unvisited link                                    |
| `first-child` | The first child matching the selector in a hierarchy |
| `last-child`  | The last child matching the selector in a hierarchy  |

> [!IMPORTANT]
> Using pseudo-elements and CSS, you can remove the underline from hyperlinks. As a general rule, it's best to leave the underline for accessibility purposes. The underlined text allows a user to quickly identify links on a page.

## ID Selectors

Similar to classes, an ID allows you to apply a style to an element. But, while a class can be applied to multiple elements, an ID must be unique and refer to only one element.

On a resume, you might have a section for social media, such as Twitter, GitHub, or your blog. If you wanted a custom style for that section, you could set an ID:

```html
<div id="social-media">
    <!-- list of links -->
</div>
```

IDs are prefixed with a `#` in CSS:

```css
#social-media {
    /* style */
}
```

> [!NOTE]
> Standard naming convention for classes and IDs is to use "skewer-casing." Each word is lowercase, and separated with a `-`. The name skewer-case comes from how the words appear as if they could be on a skewer.
