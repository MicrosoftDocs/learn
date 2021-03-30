Accessibility is a relatively large topic, and not one we can cover completely in a single Learn module. However, there are some of core tenets you will want to implement in every page you create. Designing an accessible page from the start is *always* easier than going back to an existing page to make it accessible.

## Using HTML the way it was designed

HTML provides numerous elements you can use to create a page, including buttons, links, and form controls. Each one of those elements has a set of built-in functionality, like being clickable, linkable, or accepting focus.

> [!NOTE]
> Focus is a web development term meaning a control is able to accept input from a keyboard. A button can accept focus, allowing someone to activate or "click" it by pressing the space bar.

With CSS and JavaScript it's possible to make any element look like any type of control. `<span>` could be used to create a `<button>`, and `<b>` could become `<a>`. While this may provide some shortcuts for styling or laying out your page, it removes the built-in functionality. Tools like a screen reader will not be able to understand a `<span>` is being used as a `<a>`. Someone navigating with a keyboard won't be able to set focus on a `<div>` element which has been programmed to simulate a `<button>`.

Another HTML element frequently skipped is headers (`<h1>` through `<h6>`). From a visual standpoint, header tags start from largest to smallest text size. This leads many developers to forgo header elements and instead stylize `<div>` or other generic elements. Unfortunately stylized generic elements only convey visual information rather than structural. Screen reader users [rely heavily on headings](https://webaim.org/projects/screenreadersurvey8/#finding) to find information and navigate through a page. Writing descriptive heading content and using semantic heading tags are important for creating an easily navigable site for screen reader users.

As a best practice, you should always use the appropriate HTML when creating controls on a page. If you want a hyperlink, use `<a>`, or a `<button>` for a button.

## Use good visual clues

Developers often think about screen readers as the only accessibility tool. However, there are numerous other tools one might use, or may not even use a tool at all. Users who are using the browser will rely on certain visual cues to understand how to interact with your page.

One of the great features of CSS is it provides complete control over how to display a page, including removing certain display elements. This includes removing the outline from a textbox, or the underline from a hyperlink. Unfortunately, removing those types of cues can make it more challenging for someone who depends on them to recognize the type of control.

## The keyboard

Some users are unable to use a mouse or trackpad/touchpad, instead relying on keyboard interactions to tab from one element to the next. It's important for your pages to present your content in logical order so a keyboard user can access each interactive element as they move down a document.

When navigating a page using tab, focus will move from one control to the next based on the order the controls are listed in the HTML source. The controls for your page should be listed in the HTML source in which you expect the page to be navigated, while relying on CSS to layout the page visually to users.

For example, imagine creating a form with two columns. You will want to consider what the natural flow is for someone filling out the form, and list the controls in that order. Then you can use CSS to create the columns, and display the controls in their appropriate locations.

Keyboard navigation relies heavily on semantic HTML. Certain controls (like buttons) accept focus while `div` elements do not. If you are recreating controls which already exist in HTML you are making it more difficult for someone to use your page with a keyboard.

> [!IMPORTANT]
> Keyboard navigation needs to be tested manually, and should be done on every page you create. WebAIM has more information about [keyboard navigation strategies](https://webaim.org/techniques/keyboard/).
