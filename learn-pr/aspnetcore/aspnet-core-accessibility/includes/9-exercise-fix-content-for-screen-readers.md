Before attempting to navigate through our page using a screen reader, we'll find and fix our remaining accessibility issues.

## Fixing Image alt text

1. Run the site and **FastPass**. Our last remaining issue is the missing `alt` text for the one image on the page.

   :::image type="content" source="../media/missing-alt-error.png" alt-text="Screenshot of Accessibility Insights displaying a missing alt error for an image.":::

1. This is a purely decorative image, so we can just add an empty `alt` description:

   ```html
   <img alt="" width="120" src="data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M.226 112L36.2.2c60 16 74 49 81 84z' fill='%23ea8'/%3e%3cpath d='M.197 112L31 14C84 29 96 57 103 88z' fill='%23fea' /%3e%3c/svg%3e">
   ```

1. Run the application and check **FastPass** one last time. You should see all automated checks have now passed.

## Check Tab Stops

1. Now that we've cleared all automated checks, it's time to check tab stops. Select **Tab stops** in the left navigation in **FastPass**.

   :::image type="content" source="../media/select-tab-stops.png" alt-text="Screenshot of Accessibility Insights for Web with the second option of Tab stops selected.":::

1. Toggle the **Show tab stops** switch in **FastPass**.
1. Switch to the web application and begin using the tab key to navigate through the page. You will see that the navigation flows from the top of the page, through the form and page links, to the links in the footer.

   :::image type="content" source="../media/tab-stop-display.png" alt-text="Screenshot of the pizza app showing tab stops from top to bottom.":::

The first step before implementing accessible features in the app is to turn on the screen reader. Let's walk through how to turn on the screen reader for each operating system to test accessibility in the app.

## Testing with a screen reader

There are a few remaining issues that aren't detected by **FastPass**. These are found in the full **Assessment** tool, which performs a full accessibility assessment for the page and is beyond the scope of this tutorial. Instead, we'll experience them by running through the page using the screen reader.

### Enable Windows screen reader

Narrator is a screen reader built directly into Windows to enable users to complete common tasks without a mouse. You can enable Narrator in one of two ways:

- Press the **Windows logo key** + **Ctrl** + **Enter** together to start Narrator. Press these keys again to stop Narrator. (On older versions of Windows, the command was the **Windows logo key** + **Enter**.) On many keyboards, the Windows logo key is located on the bottom row of keys, to the left or right of the Alt key.

- Press the **Windows logo key** + **Ctrl** + **N** to open Narrator settings, and then turn on the toggle under Use Narrator.

:::image type="content" source="../media/windows-narrator.png" alt-text="Windows screenshots to enable Narrator.":::

It is suggested to go through the Narrator tutorial, which can be found in the Narrator settings screen.
 
### Navigate the page using Narrator

1. If it is not already running, launch the Narrator using **Windows logo key** + **Ctrl** + **Enter**
1. With Narrator running, switch to the pizza web page (you can click on the browser or use **alt** + **tab** to do that).
1. Press the **one (1)** key to list the top-level heading. You should hear "Welcome" read aloud.
1. Press the **one (1)** key again. You will hear "Join our mailing list". This isn't correct, there should only be one `<h1>` element on a page.
1. Press the **one (1)** key again. Narrator reports that there are no more heading level 1 elements.
1. Press the **two (2)** key. Narrator reports that there are no heading level 2 elements.
1. Press the **three (3)** key. Narrator reports that there are no heading level 3 elements. Clearly something is wrong with the remaining headings on the page.
1. Press the **tab** key repeatedly to navigate through the form and submit button. This works well, as we should expect based on our previous tab stop validation.
1. Press the **tab** key once more. You will hear a link read aloud as "Link: click here." This is unclear... what is the link we're being told to click on?
1. Stop the Narrator using **Windows logo key** + **Ctrl** + **Enter**.

## Fixing issues found through screen reader testing

We have a couple remaining items to fix on this page: headings and the mysterious "Click here" link.

### Fix headings

1. First, let's demote the "Join our mailing list" heading from `<h1>` to `<h2>`. There can be only one `<h1>`, and the "Welcome" at the top of the page was there first.

   ```html
   <h2>Join our mailing list</h2>
   ```

1. Viewing the HTML for the "All about our wonderful pizza!" heading reveals the problem that prevented Narrator from finding it - it wasn't actually a heading!

   ```html
   <p style="font-size: 30px"><b>All about our wonderful pizza!</b></p>
   ```

   This text is styled to use bold text and a large typeface, but it's not using a heading element. Change this tag to an `<h2>`:

   ```html
   <h2>All about our wonderful pizza!</h2>
   ```

1. Now that we know what to look for, we can see that this same problem was repeated in the other headings further down the page. Change the "We take your privacy seriously!" heading to use an `<h2>`:

   ```html
   <h2>We take your privacy seriously!</h2>
   ```

1. Change the "Delivery options" heading to use an `<h2>`:

   ```html
   <h2>Delivery options</h2>
   ```

## Get rid of "Click here"

"Click here" is not helpful to screen readers. Let's change that line from this:

   ```html
   Want to know more? <a href="/Privacy">Click here.</a>
   ```

   to this:

   ```html
   View our <a href="/Privacy">privacy policy</a> for more information.
   ```

## Final verification with screen reader

1. Launch the Narrator using **Windows logo key** + **Ctrl** + **Enter**
1. With Narrator running, switch to the pizza web page.
1. Press **tab** repeatedly to navigate through the links on the page. This time, instead of hearing "Link: Click here", you will hear "Link: Privacy policy". That's fixed!
1. Press the **one (1)** key to list the top-level heading. You should hear "Welcome" read aloud.
1. Press the **one (1)** key again. You will hear Narrator report that there are no remaining level one headings. Success!
1. Press the **two (2)** key repeatedly to cycle through the level 3 headings. Narrator will read them all aloud.
1. Stop the Narrator using **Windows logo key** + **Ctrl** + **Enter**.

In this exercise, we've seen how to find and fix issues that impact screen reader functionality.
