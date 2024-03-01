Before you try to move through the sample webpage by using a screen reader, find and fix the remaining accessibility issues.

## Fix image alt text

1. Run the site and FastPass. The last remaining issue is missing alt text for the one image on the page.

   :::image type="content" source="../media/missing-alt-error.png" alt-text="Screenshot of Accessibility Insights for Web that shows an error about missing alt text for an image.":::

1. This image is purely decorative, so you can just add an empty `alt` description.

   ```html
   <img alt="" width="120" src="data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M.226 112L36.2.2c60 16 74 49 81 84z' fill='%23ea8'/%3e%3cpath d='M.197 112L31 14C84 29 96 57 103 88z' fill='%23fea' /%3e%3c/svg%3e">
   ```

1. Run the application and check FastPass one last time. You should see that all automated checks are now passing.

## Check tab stops

1. Now that all automated checks are cleared, it's time to check tab stops. Select **Tab stops** on the left pane in FastPass.

   :::image type="content" source="../media/select-tab-stops.png" alt-text="Screenshot of Accessibility Insights for Web with the second option of tab stops selected.":::

1. Turn on the **Show tab stops** toggle in FastPass.
1. Switch to the web application and begin using the Tab key to move through the page. Notice that the navigation flows from the top of the page, through the form and page links, to the links in the footer.

   :::image type="content" source="../media/tab-stop-display.png" alt-text="Screenshot of the pizza app that shows tab stops from top to bottom.":::

## Test with a screen reader

There are a few remaining issues that FastPass doesn't detect. You can find them in the Assessment tool, which performs a full accessibility assessment for the page. But that's beyond the scope of this tutorial. Instead, let's experience them by using the screen reader to move through the page.

### Enable a Windows screen reader

Narrator is a screen reader built directly into Windows that enables users to complete common tasks without a mouse. You can enable Narrator in one of two ways:

- Select Windows logo key+Ctrl+Enter to start Narrator. Select these keys again to stop Narrator. (On older versions of Windows, the shortcut was Windows logo key+Enter.) On many keyboards, the Windows logo key is located on the bottom row of keys, on either side of the Alt key.

- Select Windows logo key+Ctrl+N to open Narrator settings, and then turn on the toggle under **Use Narrator**.

:::image type="content" source="../media/windows-narrator.png" alt-text="Screenshot for turning on the toggle for enabling Narrator in Windows.":::

We suggest that you go through the Narrator tutorial, which you can find on the Narrator settings screen.

### Move through the page by using Narrator

1. If it's not already running, open Narrator by selecting Windows logo key+Ctrl+Enter.
1. With Narrator running, switch to the pizza webpage. You can select the browser or use Alt+Tab to do that.
1. Select the **1** key to list the top-level heading. You should hear "Welcome" read aloud.
1. Select the **1** key again. You hear "Join our mailing list." This narration isn't correct, because there should only be one `<h1>` element on a page.
1. Select the **1** key again. Narrator reports that there are no more `<h1>` elements.
1. Select the **2** key. Narrator reports that there are no `<h2>` elements.
1. Select the **3** key. Narrator reports that there are no `<h3>` elements. Clearly something is wrong with the remaining headings on the page.
1. Select the Tab key repeatedly to move through the form and the **Submit** button. This works well, as you'd expect based on your previous tab stop validation.
1. Select the Tab key once more. You hear a link read aloud as "Link: click here." This narration is unclear because we can't tell which link we're being told to select.
1. Stop Narrator by selecting Windows logo key+Ctrl+Enter.

## Fix issues found through screen reader testing

You have a couple of remaining items to fix on this page, headings and the mysterious "Click here" link.

### Fix headings

1. Demote the "Join our mailing list" heading from `<h1>` to `<h2>`. There can be only one `<h1>`, and the "Welcome" text at the top of the page was there first.

   ```html
   <h2>Join our mailing list</h2>
   ```

1. Viewing the HTML for the "All about our wonderful pizza!" heading reveals the problem that prevented Narrator from finding it: it wasn't actually a heading!

   ```html
   <p style="font-size: 30px"><b>All about our wonderful pizza!</b></p>
   ```

   This text is styled to use bold text and a large typeface, but it's not using a heading element. Change this tag to `<h2>`.

   ```html
   <h2>All about our wonderful pizza!</h2>
   ```

1. Now that you know what to look for, you can see that this same problem is repeated in the other headings farther down the page. Change the "We take your privacy seriously!" heading to use `<h2>`.

   ```html
   <h2>We take your privacy seriously!</h2>
   ```

1. Change the "Delivery options" heading to use `<h2>`.

   ```html
   <h2>Delivery options</h2>
   ```

## Change "Click here"

Find the line that has the unhelpful "Click here" text:

```html
Want to know more? <a href="/Privacy">Click here.</a>
```

Change it to the following wording.

```html
View our <a href="/Privacy">privacy policy</a> for more information.
```

## Do a final verification with the screen reader

1. Open Narrator by selecting Windows logo key+Ctrl+Enter.
1. With Narrator running, switch to the pizza webpage.
1. Select the Tab key repeatedly to move through the links on the page. This time, instead of hearing "Link: Click here," you hear "Link: privacy policy." You fixed it!
1. Select the **1** key to list the top-level headings. You should hear "Welcome" read aloud.
1. Select the **1** key again. You hear Narrator report that there are no remaining level 1 headings. Success!
1. Select the **2** key repeatedly to cycle through the level 2 headings. Narrator reads them all aloud.
1. Stop Narrator by selecting Windows logo key+Ctrl+Enter.
