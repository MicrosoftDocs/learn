Considering accessibility throughout the product development cycle is crucial because it ensures that inclusivity is integrated into every stage of design and development. By addressing accessibility from the outset, you can identify and resolve potential barriers early, creating a more seamless and user-friendly experience for all users, including those with disabilities. This proactive approach not only enhances usability but also helps meet legal and ethical standards, ultimately leading to a more equitable digital landscape. By the end of this unit, you are equipped with the knowledge to navigate the product development process effectively, ensuring that your designs aren't only innovative but also accessible.

## The accessibility tree

An accessibility tree is a special structure that web browsers create to help assistive technologies, like screen readers, understand and interact with most HTML elements. Browsers convert HTML into a document object model (DOM) tree, which holds the structure and details of all elements, attributes, and text. Browsers use the DOM tree generate an accessibility tree, which is then used by platform-specific accessibility APIs to create a version of the web page that assistive technologies, like screen readers, can interpret. However, the accessibility tree only includes elements that are relevant for accessibility purposes, such as buttons, links, and form fields. Think of it as a map that shows how different parts of a web page are connected and what they do. This map includes information about buttons, links, images, and other elements, making it easier for people with disabilities to navigate and use the website. 

There are three crucial components of an accessibility tree:

- **Name**: The label or identifier for a user interface component. For example, the name of a button might be "Submit" or "Search." It tells users what the element is or what it does.
- **Role**: Defines what the element is, such as text, image, button, etc. For example, a `<button>` tag has the role of a button. The role helps users understand how they can interact with the element.
- **State/Value**: Represents the current state or value of an element, for example, the value of a slider (50%) or the state of a checkbox (checked or unchecked).

:::image type="complex" source="../media/screen-reader-name-role-value-sm.png" alt-text="Screenshot of a table with three columns labeled 'Name,' 'Role,' and 'Value.'":::
   A table with three columns labeled "Name," "Role," and "Value." The entries under "Name" include Footer, Footer Textbox, Slide Number, Don’t show on title slide, and Apply to All. Under "Role," they're identified as checkbox, textbox, or button. The "Value" column shows states such as On, Confidential, Off, and Apply to All. A small inset screenshot in the bottom right shows a UI with checkboxes and text input options matching the table entries.
:::image-end:::

The name, role, and state/value of each element must be programmatically determined so that assistive technologies like screen readers can accurately convey this information to users. 

:::image type="complex" source="../media/screen-reader-accessibility-dom-trees-sm.png" alt-text="Screenshot comparing a DOM tree and an accessibility tree." :::
   A comparison between a DOM tree and an accessibility tree. The DOM tree shows HTML code with a toolbar labeled "Ribbon" containing a tab panel labeled "Home" with buttons for "Bold," "Italic," and "Underline." The accessibility tree lists a window labeled "PowerPoint," with a pane labeled "Ribbon." Inside the pane is a group labeled "Home," which contains buttons for "Bold," "Italic," and "Underline."
:::image-end:::

### Resources

- [What Is a Website’s Accessibility Tree?](https://www.boia.org/blog/what-is-a-websites-accessibility-tree)
- [Accessibility Tree](https://developer.mozilla.org/en-US/docs/Glossary/Accessibility_tree)
- [Understanding Success Criterion 4.1.2: Name, Role, Value](https://www.w3.org/WAI/WCAG21/Understanding/name-role-value.html)

## Interaction between websites/apps and screen readers

In order to develop websites and apps that support screen readers, it's crucial that you understand how these interact with each other. 

### Apps and screen readers

The app calls the operating system's accessibility API to provide an accessibility tree. The screen reader then uses this API to access the tree. 

:::image type="complex" source="../media/screen-reader-accessibility-tree-sm.png" alt-text="Screenshot of a diagram showing the flow between a screen reader and an app through accessibility APIs.":::
   A diagram showing the flow between a screen reader and an app through accessibility APIs. At the top is a box labeled "App," connected by a line to "Accessibility API for Provider." Below it is "OS," followed by "Accessibility API for Client." At the bottom is a box labeled "Screen Reader," connected by lines to the elements above.
:::image-end:::

Apps can raise events about changes, allowing the screen reader to respond and perform actions such as toggling a checkbox. 

:::image type="complex" source="../media/name-role-state-accessibility-annotation-sm.png" alt-text="Screenshot of a diagram showing the interaction between a screen reader, operating system (OS), and an app using accessibility APIs." lightbox="../media/name-role-state-accessibility-annotation-lg.png":::
   A diagram showing the interaction between a screen reader, operating system (OS), and an app using accessibility APIs. At the top is a box labeled "App," connected by arrows labeled "Events" and "Patterns" to the "OS" box below. The "OS" box is connected by similar arrows to the "Screen Reader" box at the bottom. The arrows show a two-way flow of events and patterns between the app, OS, and screen reader.
:::image-end:::

In this model, the app and screen reader communicate only through the operating system's accessibility API, never directly. Other assistive technologies, such as screen magnifiers and voice control, also use this API.

### Web apps and screen readers

For web apps, the browser communicates with the accessibility API by converting the DOM tree provided by the web app into an accessibility tree for the operating system. Each rendered element on the page has a corresponding element in the accessibility tree, ensuring standardization across operating systems and browsers despite differences in underlying accessibility APIs. Web apps can't raise events directly and have limited ability to implement patterns on elements. 

:::image type="complex" source="../media/screen-reader-accessibility-tree-dom-tree.png" alt-text="Screenshot of a diagram showing the interaction between an app, browser, operating system (OS), and screen reader through APIs.":::
   A diagram showing the interaction between an app, browser, operating system (OS), and screen reader through APIs. At the top is a box labeled "App," with a downward arrow labeled "DOM" pointing to a "Browser" box. Below the browser is the "OS" box, connected by arrows labeled "Events" and "Patterns" to both the browser and the "Screen Reader" at the bottom. Arrows indicate a two-way flow of events and patterns between the browser, OS, and screen reader using accessibility APIs.
:::image-end:::

## Accessibility annotations for screen reader support

Many accessibility problems can be anticipated and avoided during the design phase. Use practical tips and a curated list of tools, plugins, and templates to save time documenting accessibility in your Figma mockups. Annotations for screen reader support help designers communicate how users can navigate and interact with their designs using a screen reader. Here are some common annotations using the [ A11y Focus Order Plugin and Fluent Accessibility Design Toolkit](https://www.figma.com/community/plugin/1208180794570801545/includeaccessibility-annotations?trackingId=6o88RA2ATkWCJlzn7jeJNg%3D%3D)[A11y Focus Order Plugin](https://www.figma.com/community/plugin/731310036968334777/a11y-focus-order)[ A11y Focus Order Plugin and Fluent Accessibility Design Toolkit](https://www.figma.com/community/plugin/1208180794570801545/includeaccessibility-annotations?trackingId=6o88RA2ATkWCJlzn7jeJNg%3D%3D):

### Name, role, and state

It's crucial that all user interface components, including but not limited to form elements, links, and components generated by scripts, have names and roles that can be programmatically determined. This ensures that assistive technologies can interpret and interact with these elements effectively. Furthermore, it's essential that states, properties, and values which can be set by users are also programmatically settled. This allows users to have a seamless experience while interacting with our interface. Additionally, we need to ensure that any changes to these items are notified to user agents, including assistive technologies, so that users are always aware of the current state and can interact with the interface accordingly.

For the library components, "Name" will be same as per the design and same will be announced by the screen reader. Role will auto populate and then select or define properties either by selecting via   provided checkboxes or mention in the edit field. If need to include any custom keyboard shortcuts that we can add, and all these other properties show up under ‘Developer notes" section. For custom components we need to do everything, selecting correct control type, review all the flows, set relevant properties, shortcuts. So before using custom components, ask, "do I need it? Is there any component that serves the purpose?" If not, then use it and ensure covers all flows and edge cases. 

:::image type="complex" source="../media/screen-reader-annotations-widget-dialog-specs-sm.png" alt-text="Screenshot of specs for screen reader annotations in a widget dialog." lightbox="../media/screen-reader-annotations-widget-dialog-specs-lg.png":::
   Specs for screen reader annotations: A widget dialog specification table with four labeled sections. The table includes screen reader labels, components, and developer notes. Label 1 point to "Category" with a dropdown component. Label 2 highlights "Show widget selector" with a checkbox component. Label 3 points to "Widget selector" with a custom widget link. Label 4 indicates "Save" with a button marked as optional. Developer notes mention properties and keyboard shortcuts.
:::image-end:::

When we have multiple components with the same visual name, we should override the visual name. Why should we do this? We have different navigation for buttons, links. When a screen reader user runs with the respective navigation it will just announce the name and no other context which is visible on the UI. For for example, In this image it announces Create, Create, Browse when user navigates with button navigation. You can provide more context using Aria override or another way that includes the visible name of the control.   

:::image type="complex" source="../media/keyboard-screen-reader-multiple-components-same-name-sm.png" alt-text="Screenshot showing incorrect example of multiple components with the same visual name." lightbox="../media/keyboard-screen-reader-multiple-components-same-name-lg.png":::
   Example shown in below image is where two components are having same visual name as ‘create’ which is incorrect as it announces Create for both and browse for third button when user navigates with button navigation and will create confusion and doesn’t describe the purpose of each button.
:::image-end:::

:::image type="complex" source="../media/keyboard-screen-reader-mulitple-components-different-name-sm.png" alt-text="Screenshot showing correct example of multiple components with different names." lightbox="../media/keyboard-screen-reader-mulitple-components-different-name-lg.png":::
   Example shown in below image is where two ‘create’ buttons are there, but we have added extra text in an Aria-Label override that includes the visible name of the control such as "Create a new hire onboarding", "Create urgent collaboration template" & "Browse other template" respectively which describes the purpose of each button.
:::image-end:::

States are critical only if they're illustrating a flow or a specific condition where that particular state is critical, like cases where in a flow something is disabled, marking out that as disabled is a good practice.

:::image type="complex" source="../media/name-role-state-accessibility-annotation-sm.png" alt-text="Screenshot of accessibility annotations for Name, Role, and State." lightbox="../media/name-role-state-accessibility-annotation-lg.png":::
   Example of accessibility for Name, Role, and state of input field and buttons. Element #1: Name -User name, Role – Input. Element #2: Name – Password, Role – Input. Element #3: Name – Forgot Password, Role – Link. Element #4: Name – sign in, Role- Button, State – Disabled. Element #5: Name – Remember Me, Role – Checkbox, State – Not checked.
:::image-end:::

### Shortcut keys

Highlight Add any keyboard shortcuts that aren't standard rather a customize one and can be used to perform actions within the design.

:::image type="complex" source="../media/shortcut-keys-accessibility-annotation-sm.png" alt-text="Screenshot of accessibility annotations for shortcut keys." lightbox="../media/shortcut-keys-accessibility-annotation-lg.png":::
   Example of accessibility annotations for shortcut keys, with the shortcuts "Ctrl+Shift+M"=Mute ", Ctrl+Shift+E"=Share Content, and "Ctrl+Shift+H"=Leave Meeting
:::image-end:::

:::image type="complex" source="../media/keyboard-interactions-accessibility-annotations-sm.png" alt-text="Screenshot of accessibility annotations for keyboard interactions and shortcuts." lightbox="../media/keyboard-interactions-accessibility-annotations-lg.png":::
   Example of accessibility annotations for keyboard interactions and shortcuts, with the text "Bold" button = Ctrl+B, "Italic" button = Ctrl+I, and "Underline" button = Ctrl+U
:::image-end:::

### Headings

Use headings to make it easy to jump through your designs. These are the titles and subtitles of a web page that can be navigated like a tree structure using hierarchy. 

- There can be only one H1 on the page.
- There can be any number of H2s, H3s, and H4s.
- Heading levels must follow an order. You can't jump from H2 to H4 without a subsequent H3.

:::image type="complex" source="../media/screen-reader-annotations-headers.png" alt-text="Screenshot of Microsoft Teams chat application interface with labeled annotations." lightbox="../media/screen-reader-annotations-headers.png":::
   Microsoft Teams chat application interface with two labeled annotations. The interface shows multiple conversations with timestamps, and a chat window on the right displays messages. Label 1 point to the left panel (H1) displaying a list of contacts and chat history. Label 2 highlights the top right section, which contains search and menu options (H2).
:::image-end:::

:::image type="complex" source="../media/screen-reader-annotations-headers-annotations-sm.png" alt-text="Screenshot of icons representing different header annotations." lightbox="../media/screen-reader-annotations-headers-annotations-lg.png":::
   A row of five circular icons, each labeled with a different heading level: h1, h2, h3, h4, and h5. These icons represent different header annotations used for screen reader navigation.
:::image-end:::

### Landmarks

Landmarks can be useful additions when defining entire screen experiences on the web. These are containers or regions that can be used to quickly navigate apps, sites across different regions such as main, search, header or footer etc. We have various landmarks such as Banner, Navigation, Main, Search and few others.
- If you have just one landmark, make that the main landmark so you can provide a skip link to go directly to the content via keyboard.
- Search is a critical landmark.
- Navigation landmark is also important.
- Most of the time, headings are going to be sufficient.
- For long pages/websites that are chunked out with regions and rectangles, define landmarks to make it more diverse and accessible.
- Fewer landmarks are better.
- There can only be one banner landmark, which is **usually the header of the page.**

:::image type="complex" source="../media/screen-reader-annotations-landmarks.png" alt-text="Screenshot of Microsoft Teams chat application interface with labeled annotations for landmarks." lightbox="../media/screen-reader-annotations-landmarks.png":::
   Microsoft Teams chat application interface with four labeled annotations. The interface includes multiple chat messages with timestamps. Annotation 1 point to the right panel, titled Main, showing a conversation. Annotation 2 highlights the navigation panel. Annotation 3 points to the banner. Annotation 4 points to the search bar at the top.
:::image-end:::

:::image type="complex" source="../media/screen-reader-annotations-landmarks-annotations-sm.png" alt-text="Screenshot of different screen reader landmarks annotations with labels and values." lightbox="../media/screen-reader-annotations-landmarks-annotations-lg.png":::
   A diagram showing different screen reader landmarks annotations with labels and values. It includes boxes labeled "Main," "Search," "Navigation," "Banner," "Region," "Complementary," "Content info," and "Form." Each landmark box has "Label: Value" so designers can input their respective label and value. The boxes are outlined in different styles, such as solid or dashed lines.
:::image-end:::

### Alerts, error message, live region

Alerts/Error message/Live region Notifies user of completion, any change on UI any errors. They're used to let screen reader users know when a long-running process has succeeded, a task has failed, or something has happened without user input. Ensure that visual messages are read out in an intelligible and equitable manner without stealing focus. 

:::image type="complex" source="../media/demonstration-screen-reader-alerts-sm.png" alt-text="Screenshot of a desktop notification from Microsoft Teams showing an error message." lightbox="../media/demonstration-screen-reader-alerts-lg.png":::
   A desktop notification from Microsoft Teams showing an error message. The message reads, "Could not send message in chat with Kat, Kayo, Babak, and four additional people." To the left, an accessibility annotation for the error message.
:::image-end:::

:::image type="complex" source="../media/demonstration-screen-reader-errors-sm.png" alt-text="Screenshot of error messages from a form requesting users to fill out the field of information before continuing." lightbox="../media/demonstration-screenreader-errors-lg.png":::
   Error messages from the Form requesting users to fill out the field of information before continuing. The accessibility annotations make note of error stating that it's an "Empty State Error Message," and to "Enter your name" to fix the error.
:::image-end:::

:::image type="complex" source="../media/demonstration-live-region-sm.png" alt-text="Screenshot of a search bar on Teach Access's Donate page displaying a query." lightbox="../media/demonstration-live-region-lg.png":::
   A search bar on Teach Access's Donate page displays the name "Microsoft" entered as a query. A pop-up notification appears, informing users that Microsoft offers a matching gift program.
:::image-end:::

### Focus management

Ensure that focus is managed correctly, especially when modal dialogs or menus are opened or closed then focus lands back to component from where it was triggered. This helps users navigate through the content efficiently by ensuring focus management is predictable and understandable

### Alternative text

Provide alternative text for images, icons, and other non-text content. This allows screen readers to describe these elements to users who can't see them. Be sure to follow best practices when writing alt text.

## Resources

- [A Guide to Accessible Form Validation](https://www.smashingmagazine.com/2023/02/guide-accessible-form-validation/) 
- [Write helpful Alt Text to Describe Images](https://accessibility.huit.harvard.edu/describe-content-images)