## Introduction

It is essential to know the key principles and requirements that ensure digital products are accessible to all users, including those with visual disabilities. The Web Content Accessibility Guidelines (WCAG) provide a comprehensive framework for creating accessible web content and user interface (UI) components. This section will outline their primary accessibility principles and requirements related to color and contrast.

## Overview of Accessibility Guidelines 

The WCAG standards provide specific guidelines to ensure that the color and contrast of content and UI components are perceivable and [distinguishable (Guideline 1.4)](https://www.w3.org/WAI/WCAG21/Understanding/distinguishable). These criteria focus on ensuring that information is presented in a way that is easy for people with disabilities to perceive. While it supports making information available in alternate formats, its primary goal is to clarify the default presentation. The primary aim is to help users distinguish foreground information from the background. To meet these criteria, designers and developers should take into consideration the following:

#### [Use of Color (SC 1.4.1)](https://www.w3.org/WAI/WCAG21/Understanding/use-of-color)

This criterion focuses on using color to share information, indicate actions, prompt responses, or distinguish visual elements. Color shouldn't be used as the only way to convey meaning. About 8% of men and 0.5% of women have some color blindness. This can make it hard for them to distinguish certain colors. If information is presented using only colors, they might miss out on it. Also, people using displays or browsers that show limited colors or just black and white won't be able to see information that relies only on color. 

For the embedded links within a paragraph there should be a differentiation between text and link. This can be achieved either by meeting the 3:1 color contrast ratio or adjusting attributes of the link such as underline or Italic etc.

#### [Contrast (SC 1.4.3)](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum)

The contrast ratio measures the difference in luminance between two colors. It is expressed as a ratio, such as 4.5:1, indicating that the foreground color is 4.5 times brighter than the background color. WCAG specifies minimum contrast ratios to ensure text readability:

- **Normal text**: A minimum contrast ratio of **4.5:1**

- **Large text**: A minimum contrast ratio of **3:1** for text that is 18-point (24 pixels) or larger, or 14-point (18.66 pixels) if bold

While the focus of contrast requirements is primarily on text and images of text, WCAG also provides guidance for non-text content. UI components such as buttons, form fields, and links should also meet a minimum contrast ratio of **3:1** against adjacent colors to ensure they are easily identifiable and usable ([Non-text Contrast SC 1.4.11](https://www.w3.org/WAI/WCAG21/Understanding/non-text-contrast)). In this example, there is a link within a paragraph. The link is only distinguished from the regular text by color. Both the regular text and the link have enough contrast with the background. However, the regular text and the link text don't have a 3:1 contrast ratio with each other. 

:::image type="content" source="../media/color-contrast-requirement-example.png" alt-text="Screenshot of an example of color contrast analysis for link text color. It lists text color, link text color, and background color with their respective hex codes: #595959, #b7472a, and #ececec. Three contrast ratios are displayed: 5.929:1, 4.502:1, and 1.316:1. A green check mark appears next to the first two ratios, indicating they meet contrast requirements, while a red X marks the third ratio, indicating it does not." lightbox="../media/color-contrast-requirement-example.png":::

Text (and images of text) should maintain a contrast ratio of at least **7:1** against its background. This higher standard improves readability for users with low vision. For solid backgrounds, simply ensure the text color is sufficiently distinct. For patterned backgrounds, adjust the area behind the text or add effects like halos to enhance contrast. This technique helps create more accessible content, making it easier for everyone to read. There are certain exceptions where minimum contrast requirements do not apply. For example, text that is purely decorative, incidental, or part of an inactive user interface component (such as disabled buttons) does not need to meet the minimum contrast standards. However, it's important to note that even for exempt text, best practices suggest maintaining sufficient contrast wherever possible to enhance overall accessibility.

#### [High Contrast (SC 1.4.6)](https://www.w3.org/WAI/WCAG21/Understanding/contrast-enhanced)

High contrast refers to the use of color combinations that have a high-contrast ratio, making text and important elements stand out. High contrast is particularly important for users with low vision or color blindness. UI components should also be designed with high contrast to ensure they are easily distinguishable and operable.

Many users with visual impairments rely on high-contrast modes or themes provided by their operating systems or browsers. Ensuring that digital content respects these user settings and remains fully functional and readable in high-contrast modes is a critical aspect of accessibility. The application needs to support system-wide accessibility features such as Windows High-Contrast Mode and should not need to be restarted if the app is turned on or off. Providing adequate color contrast flexibility helps accommodate user preferences and enhances the overall accessibility of digital content.

:::image type="content" source="../media/windows-high-contrast-settings.png" alt-text="Screenshot of an example of image showing windows contrast settings that user can select or edit. Currently showing aquatic theme with background as white rectangle, Text with white color, hyperlink with cyan, inactive text with grey, selected text with cyan and button with white text and white border. 2 buttons appearing at bottom as disabled save and cancel." lightbox="../media/windows-high-contrast-settings.png":::     

:::image type="content" source="../media/windows-high-contrast.png" alt-text="Screenshot of an example of image showing  windows contrast themes, Aquatic, desert, dusk and night sky." lightbox="../media/windows-high-contrast.png":::

#### [Visual Presentation (SC 1.4.8)](https://www.w3.org/WAI/WCAG21/Understanding/visual-presentation)

Designers and developers should ensure the text is easier to read for everyone by allowing users to choose their own foreground and background colors. This can be done in different ways, such as by theming or at least supporting light and dark mode themes.

#### [Images of Text (SC 1.4.9)](https://www.w3.org/WAI/WCAG21/Understanding/images-of-text-no-exception#techniques)

Images of text refer to text presented within an image. Accessibility guidelines advise against using images of text unless the text cannot be presented in any other way. This is because text in images can be hard to read and doesn't scale well.

By adhering to these WCAGs for color and contrast, designers and developers can create digital experiences that are more inclusive and accessible to a diverse range of users. Implementing these guidelines ensures that all users can perceive the content regardless of their visual abilities.

### Contrast Checker 

Tools like the [axe for Designers plugin](https://www.figma.com/community/plugin/1085612091163821851/axe-for-designers-a-free-accessibility-plugin) help you check the contrast ratio between text and background colors to meet WCAG standards.

:::image type="content" source="../media/color-contrast-annotations-contrast-check.png" alt-text="Screenshot of an example of contrast checker tool displaying two color samples: #EF5DA8 and #F178B6. The tool shows a contrast ratio of 1.19:1. Below, it lists results for different text sizes and graphics, with red FAIL labels for normal text, large text, and graphics indicating insufficient contrast. Options to enable Smart Sample and use the APCA algorithm (Beta) are also visible at the bottom." lightbox="../media/color-contrast-annotations-contrast-check.png":::

:::image type="content" source="../media/color-contrast-accessibility-insights-contrast-check.png" alt-text="Screenshot of an example of showing how to check color contrast ratio of a control using Accessibility Insights for Windows tool. Pick color 1 (foreground) and then pick color 2 (background) and as per that result will reflect as Pass/Fail as below." lightbox="../media/color-contrast-accessibility-insights-contrast-check.png":::

### Color Simulation

Plugins like [Include- Accessibility Annotations](https://www.figma.com/community/plugin/1208180794570801545/includeaccessibility-annotations) allow you to simulate how your design looks to people with different types of color blindness.