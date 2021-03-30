Two of the most common components on any webpage are images and links. It stands to reason we should pay attention to these items as they will have a profound impact on the accessibility of the pages we create. Ensuring good link and alt text is one of the first actionable steps you can take to improve your pages for all users.

## The importance of link text

Hyperlinks are core to navigating the web, so much so it's the first word in the abbreviation for HTML (HyperText Markup Language). As a result, ensuring a screen reader can properly read links allows all users to navigate your site.

Consider the two links below:

- The little penguin, sometimes known as the fairy penguin, is the smallest penguin in the world. [Click here](https://en.wikipedia.org/wiki/Little_penguin) for more information.
- The little penguin, sometimes known as the fairy penguin, is the smallest penguin in the world. Visit https://en.wikipedia.org/wiki/Little_penguin for more information.

> [!IMPORTANT]
> The two examples demonstrate what you should not use as a web developer.

While these may appear to be perfectly fine for someone with full sight, they won't work as you might expect with a screen reader. Remember, screen readers read the text. If a URL appears in the text, the screen reader will read the URL. Generally speaking, the URL does not convey meaningful information, and can sound annoying. You may have experienced this if your phone has ever audibly read a text message with a URL.

Screen readers also have the ability to read only the hyperlinks on a page, much in the same way a sighted person would scan a page for links. If the link text is always "click here", all the user will hear is "click here, click here, click here, click here, click here, ..." All links are now indistinguishable from one another, and is generally a frustrating experience.

The word "click" is also a problem, as not all users may click. Phone users will tap, keyboard users may press enter or space bar, and other clients will use other means.

We need to ensure we're always using meaningful link text. Good link text briefly describes what's on the other side of the link. In the above example talking about little penguins, the link is to the Wikipedia page about the species. The phrase *little penguins* would make for perfect link text as it makes it clear what someone will learn about if they select the link - little penguins.

- The [little penguin](https://en.wikipedia.org/wiki/Little_penguin), sometimes known as the fairy penguin, is the smallest penguin in the world.

> [!NOTE]
> As an added bonus for ensuring your site is accessible to all, you'll help search engines navigate your site as well. Search engines use link text to learn the topics of pages. So using good link text helps everyone!

## Accessible Rich Internet Applications (ARIA)

Imagine the following product page:

| Product      | Description        | Order        |
| ------------ | ------------------ | ------------ |
| Widget       | [Description]('#') | [Order]('#') |
| Super widget | [Description]('#') | [Order]('#') |

This is a pretty common layout for a page showing information about various items in a table, with links to the description and order. Duplicating the text of description and order make sense for someone using a browser. However, someone using a screen reader would only hear the words *description* and *order* repeated without context.

To support these types of scenarios, HTML supports a set of attributes known as [Accessible Rich Internet Applications (ARIA)](https://developer.mozilla.org/docs/Web/Accessibility/ARIA). These attributes allow you to provide additional information to screen readers. For links, you can use `aria-label` to describe the link when the format of the page doesn't allow you to. The description for widget could be set as:

``` html
<a href="#" aria-label="Widget description">description</a>
```

ARIA has numerous uses beyond adding text for screen readers to read for links. It can be used to describe the roles certain elements play when semantic HTML isn't available. When creating a tree for example, you can use ARIA roles to describe the interface to a screen reader.

```html
<h2 id="tree-label">File Viewer</h2>
<div role="tree" aria-labelledby="tree-label">
  <div role="treeitem" aria-expanded="false" tabindex="0">Uploads</div>
</div>
```

> [!IMPORTANT]
>
> Using semantic markup and good link text as described earlier generally supersedes the use of ARIA. Browsers and screen readers are not the only clients a user may use, and designing your page to work well for all clients and users should be your primary goal.

## Images

It goes without saying screen readers are unable to automatically read what's in an image. Ensuring images are accessible doesn't take much work - it's what the `alt` attribute is all about. All meaningful images should have an `alt` to describe what they are or the information the image is trying to convey. Images that are purely decorative should have their `alt` attribute set to an empty string: `alt=""`; this prevents screen readers from unnecessarily announcing the decorative image.

> [!NOTE]
> As you might expect, search engines are also unable to understand what's in an image. They also use alt text. So once again, ensuring your page is accessible provides additional bonuses!
