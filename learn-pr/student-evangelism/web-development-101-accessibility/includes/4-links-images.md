Two of the most common components on any webpage are links and images. These items have a profound impact on accessibility. Ensuring good link text and alt text is one of the first steps that you can take to improve your pages for all users.

## Link text

Hyperlinks are core to browsing the web. Ensuring that a screen reader can properly read links allows all users to browse through your site.

Consider the two links in the following example text:

- "The little penguin, sometimes known as the fairy penguin, is the smallest penguin in the world. [Click here](https://en.wikipedia.org/wiki/Little_penguin) for more information."
- "The little penguin, sometimes known as the fairy penguin, is the smallest penguin in the world. Visit https://en.wikipedia.org/wiki/Little_penguin for more information."

> [!NOTE]
> The two examples demonstrate what you should *not* use as a web developer.

Although these links might seem fine for someone with full sight, they won't work as you might expect with a screen reader. Remember, screen readers read the text. If a URL appears in the text, the screen reader will read the URL. In general, the URL does not convey meaningful information and can sound annoying. You might have experienced this problem if your phone has ever audibly read a text message with a URL.

Screen readers also have the ability to read only the hyperlinks on a page, much in the same way that a sighted person would scan a page for links. If the link text is always "click here", all the user will hear is "click here, click here, click here, click here, click here, ..." All links are now indistinguishable from one another, which is a frustrating experience.

The word "click" is also a problem, because not all users will click. Phone users will tap, keyboard users might select the Enter key or the Spacebar, and other clients will use other means.

We need to always use meaningful link text. Good link text briefly describes what's on the other side of the link. In the earlier example about little penguins, the link goes to the Wikipedia page about the species. The phrase *little penguins* would be perfect link text because it makes it clear what someone will learn about if they select the link:

- "The [little penguin](https://en.wikipedia.org/wiki/Little_penguin), sometimes known as the fairy penguin, is the smallest penguin in the world."

> [!NOTE]
> As a bonus for ensuring that your site is accessible to all, you'll also help search engines browse through your site. Search engines use link text to learn the topics of pages. So using good link text helps everyone!

### ARIA attributes

Imagine the following product page:

| Product      | Description        | Order        |
| ------------ | ------------------ | ------------ |
| Widget       | `[Description]('#')` | `[Order]('#')` |
| Super widget | `[Description]('#')` | `[Order]('#')` |

This is a common layout for a page that shows information about various items in a table, with links to the description and order. Duplicating the text of description and order make sense for someone who's using a browser. However, someone who's using a screen reader would only hear the words *description* and *order* repeated without context.

To support these types of scenarios, HTML supports a set of attributes known as [Accessible Rich Internet Applications (ARIA)](https://developer.mozilla.org/docs/Web/Accessibility/ARIA). You can use these attributes to provide more information to screen readers. 

For example, you can use `aria-label` to describe a link when the format of the page doesn't allow you to. The description for *widget* might be set as:

``` html
<a href="#" aria-label="Widget description">description</a>
```

ARIA has numerous uses beyond adding text for screen readers to read for links. You can use it to describe the roles that certain elements play when semantic HTML isn't available. When you're creating a tree, for example, you can use ARIA roles to describe the interface to a screen reader:

```html
<h2 id="tree-label">File Viewer</h2>
<div role="tree" aria-labelledby="tree-label">
  <div role="treeitem" aria-expanded="false" tabindex="0">Uploads</div>
</div>
```

> [!IMPORTANT]
> Using semantic markup and good link text as described earlier generally supersedes the use of ARIA. Browsers and screen readers are not the only clients that a user might use, and designing your page to work well for all clients and users should be your main goal.

## Alt text for images

As a general rule, screen readers can't read the contents of an image. Although some might use artificial intelligence, the generated results might not be contextually accurate. Fortunately, ensuring that images are accessible doesn't take much work - it's what the `alt` attribute is all about. All meaningful images should have an `alt` attribute (known casually as *alt text*) to describe what they are or the information that they're trying to convey. 

Images that are purely decorative should have their `alt` attribute set to an empty string: `alt=""`. This setting prevents screen readers from unnecessarily announcing the decorative image.

> [!NOTE]
> As you might expect, search engines can't understand what's in an image. They rely on alt text. So once again, ensuring that your page is accessible provides bonuses!
