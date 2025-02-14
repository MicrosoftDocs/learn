Familiarizing yourself with key terms is essential for effectively implementing accessibility annotations. Let's define and explain some of the most important terms:          

- **Keyboard Navigation:** Users can move around and use a computer or digital content by pressing keys on the keyboard instead of using a mouse. This method is especially useful for people who find it difficult to use a mouse or prefer using the keyboard for quicker access. 

- **Keyboard Navigation Conventions:** These standard rules and practices allow users to move around and interact with digital content using a keyboard on interactive controls. These practices include using keys like **Tab** to switch between items, **Enter** to select them, and **arrow keys** to move up, down, left, or right through lists, tab items, etc. Keyboard navigation conventions ensure a consistent and predictable user experience, making it easier for everyone to navigate websites, apps, and other digital tools using a keyboard. Let's understand these with these three concepts of large jumps, medium jumps, and small movements.

  - **F6 = large jumps to large section of the app**

  - **Tab: medium jumps should take you between sets of controls**

  - **Small movements = navigate using arrow keys**

- **Accelerator Keys:** These keyboard shortcuts allow users to quickly perform common tasks without using a mouse. For example, pressing **Ctrl** + **C** copies text, and **Ctrl** + **V** pastes it. These shortcuts help users work more efficiently by saving time. 

**Screen Reader Navigation with Keyboard:** Screen reader users navigate content using arrow keys to understand and read all the elements on the page. They also use tab key to move through interactive elements. Additionally, users often utilize screen reader specific keyboard shortcuts built into the screen reader, i.e., to jump between different components. For example, pressing the "H" key allows them to quickly navigate to headings, "T" allows to access the table, "D" key is used to navigate between landmarks.

- **Sequential Navigation**: This feature allows you to move through the elements in a website or app one by one in a specific and logical order. Keyboard and screen reader users can navigate from one element to the next. For for example, with a screen reader, user can navigate between content such as moving from a heading to a paragraph or from one link to another. Ensuring a logical and meaningful order is crucial for accessibility. Read only text should never get a tab stop.

- **Link Purpose**: This involves providing clear and descriptive text for links so that users understand what happens or where they go when they click on a link. Screen readers announce links based on the semantics, so it's important to avoid vague phrases such as "Click here" and instead use descriptive text like "Read more about accessibility guidelines." Link purpose helps users know what to expect, making navigation easier and more intuitive. 

- **Labels**: They're used to describe the purpose of an element, typically a form input such as a text box, a checkbox, or a radio button. Labels should be short, specific, and focused solely on the specific purpose of the control in question. Avoid attempting to describe the behavior of the control through the label. Screen readers announce these labels to users, helping them understand what information is required. For example, a label for a text input might be "First Name."

- **Headings**: A heading is a text that describes the content that follows it. They're used to organize and structure content in manageable sections. Headings help users and screen readers understand the hierarchy and importance of the content, facilitating its reading and navigation. 

- **Landmarks**: These key elements or points in the code help users and screen readers navigate and understand the structure of a website or app. Landmarks serve as signposts, making it easier to find and manage different parts of the code. 

- **Alt-text**: These descriptions are provided for nontext content, such as images, icons, and multimedia, to help users who can't see or hear the content understand what it's about. Purely decorative nontext content doesn't require a text alternative. 

- **Contrast ratio**: This is a measurement of the difference in luminance between two colors. The Web Accessibility Guidelines (WCAG) define minimum contrast ratios for text and images of text to ensure readability. For example, normal text has a required minimum contrast ratio of **4.5:1**, which means the foreground color is 4.5 times brighter than the background color. nontext and Large-scale text (larger fonts) needs a contrast ratio of at least **3:1**.

- **Decorative Elements**: Decorative elements don't convey any information and aren't used for interaction. For accessibility purposes, these elements don't need to meet contrast requirements, as they don't impact the [user's understanding of content or navigation](https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html).
 

- **Windows Contrast Themes**: Windows contrast themes refer to the theme settings that use color combinations where text and important UI elements are presented with a significant difference in color and brightness from their background. Strongly contrasting colors can make it quicker and easier to read for people with low vision from your PC. Users can select respective themes by select Start button à SettingsàAccessibilityàContrast themes.
 

- **Resize**: This term refers to changing the size of elements on a screen, which may include increasing or decreasing the size of text, images, and other content to enhance readability and accessibility. Resize is particularly important for users with visual impairments, as they often require larger text or elements to interact with content effectively.

- **Reflow**: This is the process of rearranging content to fit the screen size and orientation. During reflow, the layout adjusts dynamically to maintain readability and usability, eliminating the need for horizontal scrolling. This is especially crucial for mobile devices and ensures users can access content comfortably in one direction. Except for parts of the content which require two-dimensional layout for usage or meaning. Examples of content which requires two-dimensional layout are images required for understanding (such as maps and diagrams), video, games, presentations, data tables (not individual cells), and interfaces where it's necessary to keep toolbars in view while manipulating content.

You can avoid many accessibility issues by planning for them during the design phase. Use helpful tips and tools, like plugins and templates, to save time when adding accessibility details to your designs in Figma. This unit will show you how to include accessibility features in your design process.

## Annotation principles:

Our core accessibility principles are making UI understandable, efficient, and habituating for users. These principles are based on three Tenets. Let's learn more on these three Tenets which help designing an experience that an assistive technology user love.

1. Understandable: I know what I can do

1. Efficient: I take fewer steps and process less information

1. Habituating: I quickly achieve command

Understandable: **When a UI has already been learned it's understood**. The user is aware of the actions they can take because they have already been exposed to the concepts. When a UI is understandable, the user is aware of the actions they can take because the UI contains **concepts that are learned quickly**. For example, on a website if a task is time bound, and it has timer displaying in the top then it should be announced to the assistive technology users so that they'll not miss this information. We should decide what should be the right interval to avoid making announcements too verbose.

:::image type="content" source="../media/understandable-tenet.png" alt-text="Screenshot of understandable tenet." lightbox="../media/understandable-tenet.png":::

Efficient: A UI has been reduced to its essential steps when users have a **minimal number of actual behavioral steps to achieve a goal**. And the most critical thing is the user's perception that there are fewer steps. For example, while creating an email when user click on the "New email" button then focus lands on the "To" edit area. That's not the first interactive control on the new email but that's the most important action that any user will take on the UI.

:::image type="content" source="../media/efficient-tenet.png" alt-text="Screenshot of efficient tenet." lightbox="../media/efficient-tenet.png":::

Habituating: Users can't help but learn habits. And habits are developed automatically by doing things over time. While designing new components or UI we should avoid changing or breaking habituating behavior that is learnt by the users else that would lead to confusion, frustration, mitigated learning and discomfort. Let's take a simple example to understand the habituating behavior. CTRL+Z is the standard, well known and learnt shortcut by the users to undo the last changes. If we change this shortcut to do some other action that will cause disruption to the habituating behavior.

:::image type="content" source="../media/habituating-tenet.png" alt-text="Screenshot of habituating tenet." lightbox="../media/habituating-tenet.png":::

## Points to consider while annotating a UI spec

- Not repeating visible names of elements: You don't have to define a label for a control that already has a visible label, like a button, or a check box. it's going to be read out. So often in the spec, you'll just go ahead and say visible name, and that way the engineer knows not to add an explicit label.

- Focus on adding annotations when essential: We should annotations when it's essential for for example, starting focus, lost focus that is, deleted item, zero states, Focus in and out of dialogs, frames, iFrames, popovers, Skip nav link, cluster of components for example. Should this be a grid or a list.

- Ensure reflow readiness. Pro tip: Auto layouts are best to design for reflow.

- Share and walkthrough in person with your engineer

## Annotation component types

Accessibility annotations play a crucial role in capturing design intent that can't be fully conveyed through visual design alone. By integrating these annotations, we can proactively prevent many accessibility issues and, ultimately, create more inclusive and user-friendly digital experiences for everyone.

Library Component - A **library component** refers to a reusable design element that is stored within a design system library. These components can range from simple buttons to more complex structures like navigation bars. By utilizing these reusable elements, we can ensure consistency across our designs.

Custom Component - In Figma, a **custom component** refers to a design element that you create to meet specific project needs rather than using predefined components from a design system or library. These components can be tailored to your unique design style or requirements but still need to consider accessibility in their design

Parent Component – A **parent component** refers to a component that contains one or more child components (or elements). The parent component serves as the overarching container or structure, which houses and organizes the child components within it.

Child Component - A **child component** refers to an individual element that is nested inside a **parent component.**

[Plugin](https://www.figma.com/community/plugin/7three1three100three6968threethree4777/a11y-focus-order) UI:

The plug-in will create a table that has all the components listed out and they're here in the table shown below in the image. A diamond shaped thing is a library component which is an established library with some minor tweaks that are good to use and populate details automatically. Custom Components denoted as circle, are a composite of certain controls and need to set up many properties for them. And then if necessary custom components can have a parent and have children. For example, grid is a parent and grid item are a child component. Another example is that radio groups are parents and radio button are a child component.

When we start the spec, name and focus order will be on the top when editing the component in the component UI. Next will be control typ. Any notes would be entered into the developer notes field, then will have properties if need to select. And finally, any custom keyboard shortcuts that need to be defined.

:::image type="content" source="../media/annotation-type-figma.png" alt-text="Screenshot of Figma file showing diamond shape badge as library component, round shape as custom component, round badge with right arrow as parent component and right arrow with 'A' label as child component." lightbox="../media/annotation-type-figma.png":::

:::image type="content" source="../media/annotation-type-figma-types.png" alt-text="Screenshot of showing different types of controls. One with circle shaped and label 1 is a custom image. The controls with circle shape followed by arrow with label 2 is parent control. Right arrow with 'A' and 'B' label as child. The component labeled as three,4 & 5 are library components with diamond shape." lightbox="../media/annotation-type-figma-types.png":::

:::image type="content" source="../media/pluginui.png" alt-text="Screenshot of When editing the component itself in the component UI, you notice that the name and focus order of the component are positioned at the top. Directly beneath this, you find the control type. Any notes you may have will be displayed in the edit box and will appear in the third column at the top.Moving down, properties are listed below the notes section. Some components have specific properties, and these will be represented by checkboxes for easy selection. Additionally, any custom keyboard shortcuts can be configured in the section below the properties. This is where you can input shortcuts such as 'Alt' and specify the desired action. If a shortcut involves multiple key presses, you can use the plus sign to add another keyboard press. It's important to note that these are custom keyboard shortcuts and aren't typically included within the component itself. Common keys like Enter and Space, which is natural parts of most components, don't need to be specified." lightbox="../media/pluginui.png":::
