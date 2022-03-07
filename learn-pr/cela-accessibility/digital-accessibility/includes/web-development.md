There are several concepts, syntax, and elements to be aware of to make your web pages accessible for people of all abilities. This unit provides an overview of essential topics. To fully explore the details about making accessible websites, see the recommended resources.

## HTML5 and ARIA

HTML5 is the latest version of Hypertext Markup Language (HTML) and is recommended by the [World Wide Web Consortium (W3C)](https://www.w3.org/), an international community that develops web standards. For all intents and purposes, HTML5 is the current standard for the web, and should be used to build the basic structure for your website. If you plan to create accessible websites, you should learn the syntax and tags for HTML5.

Accessible Rich Internet Applications (ARIA) is a technical specification that can work in tandem with HTML5 to help make web pages and applications more accessible. ARIA is not part of HTML5, but its attributes can be used in conjunction with HTML5 elements in certain instances.

For more information, learn more about [ARIA in HTML](https://www.w3.org/TR/html-aria/#rules-wd).

## Headings and landmarks

People who cannot see the visual cues of a web page rely on title and heading elements to understand how the page is structured. HTML5 has a series of sectioning elements that can clearly communicate the structure
of a page: \<header\>, \<nav\>, \<main\>, and \<footer\>. If used properly, these HTML5 elements will help people using screen readers to navigate a web page.

However, to maximize accessibility, it is best to use the HTML5 elements in conjunction with ARIA roles. ARIA roles include: role="banner", role="navigation", role="main", and role="contentinfo." These ARIA roles
create a landmark structure that enables people using screen readers to quickly and easily navigate to a desired part of a web page. For example, rather than having to wait for the screen reader to narrate each element one-by-one, a person can skip to a specific landmark further down a web page right away.

For more information, explore the W3C [ARIA Landmarks Example](https://www.w3.org/TR/wai-aria-practices/examples/landmarks/main.html).

## Page structure

Websites should also include a programmatic title or proper formatting of headings. If a web page does not have a title or uses heading elements improperly, then it may be difficult for people who use screen readers to know where they are on a given page.

To avoid these issues:

- Ensure web pages provide an informative and context-appropriate page title, using the \<title\> element.
- Ensure programmatic headings are used whenever appropriate, and are nested properly—for example, an \<h3\> element should not follow an \<h1\> element unless there is an \<h2\> element between them.  
- Avoid using heading elements just for stylistic reasons.

## Color

The use of color is an essential consideration when creating any web page, just as it is when creating any other digital content. Ensure color is not the only visual means of conveying information, indicating
an action, prompting a response, or distinguishing a visual element. When color alone is used, people who are blind or colorblind may not be able to tell which fields are required, which items are selected, and so
on. Ensure that text and images of text provide a color contrast ratio of at least 4.5 to 1. There are several free color contrast analyzers available online. For example, you can use the [Color Contrast Analyzer in Accessibility Insights in Windows](https://accessibilityinsights.io/docs/en/windows/getstarted/colorcontrast) to ensure accessible contrast ratios.

 A few exceptions to this guideline include:

- **Large Text**: Large-scale text (18-point regular or 14-point bold) and images of large-scale text can have a contrast ratio of 3:1.
- **Incidentals**: Text or images of text that are part of an inactive user interface (UI) component, that are pure decoration, that are not visible to anyone, or that are part of a picture that contains significant other visual content, have no contrast requirement.
- **Logotypes**: Text that is part of a logo or brand name has no minimum contrast requirement.

:::image type="content" source="../media/large-text.png" alt-text="People viewing large text on a computer screen.":::

Large on-screen text for accessibility purposes

## Data tables

Data tables can be difficult for some assistive technology (AT) applications, such as screen readers. To make data tables as accessible as possible, when you use tables in your website, be sure to do the following:

- Use native HTML table elements (`table`, `thead`, `tbody`, `tr`, `th`, and `td`).
- Properly identify table headers (use the th element).
- With complex tables (more than one row of headers), ensure headers are associated with the right data.
- Use the scope attribute to identify whether the cell is a header for a row, column, or group of rows or columns (using the values row, col, rowgroup, or colgroup).
- Add an `id` attribute to any cell used as a header for other cells, and then reference the appropriate `id` value using a headers attribute in each data cell.

:::image type="content" source="../media/data-table-html.png" alt-text="Data table and its corresponding native HTML table elements.":::

If these steps are not taken, people who use assistive technology may have difficulty understanding the data tables on your site.

## Form timeout and feedback

If error messages are not clearly identified, people using assistive technology may not be able to complete a form accurately on a website. Timed responses may prevent people who use assistive technology from being able to complete a form or use a web application.

Ensure error messages are clearly indicated after validation by:

- Using a consistent method to point out error messages.
- Identifying the field(s) in error.
- Identifying error fields at the beginning of the form.
- Identifying error fields in the label for each field.

Suggestions for alternative inputs must be provided when possible. However, this is not necessary when doing so would defeat the purpose of the form. For example, when the form is part of a test, a suggestion for alternative inputs could potentially provide a clue or answer to a question, which may not be appropriate.

Error prevention should be provided for legal or financial transactions. One option is to allow people to review their inputs before making a final submission.

## Links

People who use screen readers may navigate a web page by viewing a list of the web page\'s links.

If several links on a web page have the same name but point to different URLs, people may become confused. Ensure link names are meaningful, unique, and descriptive, whether in or out of context.

If generic, non-descriptive link names appear out of context, such as in an "Additional Resources" list, a person who is using a screen reader will not have any context or understanding as to what the link is, or why
it has been provided. These examples show a list with generic, inaccessible link names, and a list with accessible, descriptive link names.

**Accessible links example:**

:::image type="content" source="../media/three-descriptive-link-names.png" alt-text="Web page with a series of three descriptive link names.":::

Series of descriptive link names

**Inaccessible links example:**

:::image type="content" source="../media/three-nondescriptive-link-names.png" alt-text="Web page with a series of three generic, non-descriptive link names":::

Series of generic, non-descriptive link names

## Images

People who are blind cannot see images, and rely on website developers and content authors to describe them.

People who have low vision may have difficulty reading an image of text because it is pixelated when magnified, or the contrast is not strong enough, or the image is too small.

Provide brief, specific, and informative alternative text for images such as photos and buttons.  

**Inaccessible image example:**

\<img src=\"MSFTlogo.jpg\" alt=\"logo\" /\>

**Accessible image example:**

\<img src=\"MSFTlogo.jpg\" alt=\"Microsoft logo\" /\>

While the inaccessible example describes the image as a logo, it does not specify the type of logo, so it is not helpful to someone who relies on alt text. With the addition of the qualifier in the accessible
example, a user will know exactly what the logo is.

Another non-text element to consider is decorative images. For example, if a web page includes a stylized border, there is no need to describe it in detail in the alt text. You can indicate it is decorative in the
code by adding a blank alt attribute.

:::image type="content" source="../media/examples-of-nontext-elements.png" alt-text="Example of non-text elements requiring and not requiring descriptive alternative text attributes.":::

Example of image and decorative border

**Inaccessible example:**

\<img src=\"border.gif\" /\>

**Accessible example:**

\<img src=\"border.gif\" alt=\"\" /\>

The accessible example does not include any text; however, the fact that the alt attribute is included but shows no text indicates to someone using a screen reader that the image is decorative, and does not contain critical information.

For more information about improving accessibility, explore the [W3C Inaccessible Home Page Before and After Demonstration](https://www.w3.org/WAI/demos/bad/before/home.html).
