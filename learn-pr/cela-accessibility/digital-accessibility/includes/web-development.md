There are several concepts, syntax, and elements to be aware of to make your web pages accessible for people of all abilities. This unit provides an overview of essential topics. To fully explore the details about making accessible websites, see the recommended resources.

## HTML5 and ARIA

HTML5 is the latest version of Hypertext Markup Language (HTML). The [World Wide Web Consortium (W3C)](https://www.w3.org/), an international community that develops web standards, recommends it. For all intents and purposes, HTML5 is the current standard for the web, and should be used to build the basic structure for your website. If you plan to create accessible websites, you should learn the syntax and tags for HTML5.

Accessible Rich Internet Applications (ARIA) is a technical specification that can work in tandem with HTML5 to help make web pages and applications more accessible. ARIA isn't part of HTML5, but its attributes can be used with HTML5 elements in certain instances.

For more information, learn more about [ARIA in HTML](https://www.w3.org/TR/html-aria/#rules-wd).

## Headings and landmarks

People who can't see the visual cues of a web page rely on title and heading elements to understand how the page is structured. HTML5 has a series of sectioning elements that can clearly communicate the structure
of a page: \<header\>, \<nav\>, \<main\>, and \<footer\>. If used properly, these HTML5 elements help people using screen readers to navigate a web page.

However, to maximize accessibility, it's best to use the HTML5 elements with ARIA roles. ARIA roles include: role="banner", role="navigation", role="main", and role="contentinfo." These ARIA roles
create a landmark structure that enables people using screen readers to quickly and easily navigate to a desired part of a web page. For example, rather than having to wait for the screen reader to narrate each element one-by-one, a person can skip to a specific landmark further down a web page right away.

For more information, explore the W3C [ARIA Landmarks Example](https://w3c.github.io/aria-practices/#aria_lh_main).

## Page structure

Websites should also include a programmatic title or proper formatting of headings. Web pages that don't have a title or use heading elements improperly, make it difficult for people who use screen readers to know where they are on a given page.

To avoid these issues:

- Ensure web pages provide an informative and context-appropriate page title, using the \<title\> element.
- Ensure programmatic headings are used whenever appropriate, and are nested properly—for example, an \<h3\> element shouldn't follow an \<h1\> element unless there's an \<h2\> element between them.  
- Avoid using heading elements just for stylistic reasons.

## Color

As with any digital content, the use of color is an essential consideration when creating a web page. You should ensure that color isn't the only visual means of conveying information, indicating an action, prompting a response, or distinguishing a visual element. When color alone is used, people who are blind or colorblind may not be able to tell which fields are required, which items are selected, and so on. Ensure that text and images of text provide a color contrast ratio of at least 4.5 to 1. Several color contrast analyzers are available online for free. For example, you can use the [Color Contrast Analyzer in Accessibility Insights in Windows](https://accessibilityinsights.io/docs/en/windows/getstarted/colorcontrast) to ensure accessible contrast ratios.

 A few exceptions to this guideline include:

- **Large Text**: Large-scale text (18-point regular or 14-point bold) and images of large-scale text can have a contrast ratio of 3:1.
- **Incidentals**: There's no context requirement for text or images of text that are part of an inactive user interface (UI) component. Or, for text or images of text that are pure decoration, not visible to anyone, or that's part of a picture that contains other significant visual content.
- **Logotypes**: Text that is part of a logo or brand name has no minimum contrast requirement.

:::image type="content" source="../media/large-text.png" alt-text="People viewing large text on a computer screen.":::

Large on-screen text for accessibility purposes

## Data tables

Data tables can be difficult for some assistive technology (AT) applications, such as screen readers. To make data tables as accessible as possible, when you use tables in your website, be sure to take the following steps:

- Use native HTML table elements (`table`, `thead`, `tbody`, `tr`, `th`, and `td`).
- Properly identify table headers (use the `th` element).
- With complex tables (more than one row of headers), ensure headers are associated with the right data.
- Use the scope attribute to identify whether the cell is a header for a row, column, or group of rows or columns (using the values *row*, *col*, *rowgroup*, or *colgroup*).
- Add an `id` attribute to any cell used as a header for other cells, and then reference the appropriate `id` value using a `headers` attribute in each data cell.

:::image type="content" source="../media/data-table-html.png" alt-text="Data table and its corresponding native HTML table elements.":::

If these steps aren't taken, people who use assistive technology may have difficulty understanding the data tables on your site.

## Form timeout and feedback

If error messages aren't clearly identified, people using assistive technology may not be able to complete a form accurately on a website. Timed responses may prevent people who use assistive technology from being able to complete a form or use a web application.

After validation, you can clearly indicate error messages by:

- Using a consistent method to point out error messages.
- Identifying the field(s) in error.
- Identifying error fields at the beginning of the form.
- Identifying error fields in the label for each field.

Suggestions for alternative inputs must be provided when possible. However, this approach isn't necessary when doing so would defeat the purpose of the form. For example, when the form is part of a test, a suggestion for alternative inputs could potentially provide a clue or answer to a question, which may not be appropriate.

Error prevention should be provided for legal or financial transactions. One option is to allow people to review their inputs before making a final submission.

## Links

People who use screen readers may navigate a web page by viewing a list of the web page\'s links.

If several links on a web page have the same name but point to different URLs, people may become confused. Ensure link names are meaningful, unique, and descriptive, whether in or out of context.

Avoid generic, nondescriptive link names that appear out of context, such as in an "Additional Resources" list. A person who is using a screen reader doesn't have any context or understanding as to what the link is, or why it has been provided. These examples show a list with generic, inaccessible link names, and a list with accessible, descriptive link names.

**Accessible links example:**

:::image type="content" source="../media/three-descriptive-link-names.png" alt-text="Web page with a series of three descriptive link names.":::

Series of descriptive link names

**Inaccessible links example:**

:::image type="content" source="../media/three-nondescriptive-link-names.png" alt-text="Web page with a series of three generic, non-descriptive link names":::

Series of generic, nondescriptive link names

## Images

People who are blind can't see images, and rely on website developers and content authors to describe them.

People who have low vision may have difficulty reading an image of text because it's pixelated when magnified. Other difficulties occur when the contrast isn't strong enough, or the image is too small.

Provide brief, specific, and informative alternative text for images such as photos and buttons.  

**Inaccessible image example:**

\<img src=\"MSFTlogo.jpg\" alt=\"logo\" /\>

**Accessible image example:**

\<img src=\"MSFTlogo.jpg\" alt=\"Microsoft logo\" /\>

While the inaccessible example describes the image as a logo, it doesn't specify the type of logo, so it isn't helpful to someone who relies on alt text. With the addition of the qualifier in the accessible
example, a user knows exactly what the logo is.

Another nontext element to consider is decorative images. For example, if a web page includes a stylized border, there's no need to describe it in detail in the alt text. You can indicate that it's decorative in the
code by adding a blank alt attribute.

:::image type="content" source="../media/examples-of-nontext-elements.png" alt-text="Example of nontext elements requiring and not requiring descriptive alternative text attributes.":::

Example of image and decorative border

**Inaccessible example:**

\<img src=\"border.gif\" /\>

**Accessible example:**

\<img src=\"border.gif\" alt=\"\" /\>

The accessible example doesn't include any text. However, the fact that the `alt` attribute is included but shows no text, indicates to someone using a screen reader that the image is decorative and doesn't contain critical information.

For more information about improving accessibility, explore the [W3C Inaccessible Home Page Before and After Demonstration](https://www.w3.org/WAI/demos/bad/before/home.html).
