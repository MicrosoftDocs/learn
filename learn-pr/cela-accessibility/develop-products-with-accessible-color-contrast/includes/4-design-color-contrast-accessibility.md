During the design phase, it is essential to prioritize accessibility from the outset. Key considerations include ensuring adequate contrast ratios, avoiding the use of color as the sole method of conveying information, designing with high-contrast modes for users with visual impairments, and testing for accessibility throughout the development process with both automated and manual tools.

## Use of Color

Here are some techniques to make sure your design is perceivable and distinguishable. If you use color to convey information through specific words, backgrounds, or other content:

- Make sure any information presented in color is also available in the text.

- Add a text cue to form control labels that use color.

- Provide additional visual cues when using text color to convey information, such as patterns or textures.

- Use a contrast ratio of **3:1** with surrounding text and add extra visual cues on hover for links or controls identified by color alone.

In the example, green is used to indicate something good, and red is used to indicate something bad—a common way to use colors. However, the design includes symbols to communicate “good” and “bad” and text to explain the information. Therefore, this design doesn't rely solely on color to convey important information. Using color to convey information is effective as long as it is not the only method used.

:::image type="content" source="../media/color-contrast-design-use-color.png" alt-text="Screenshot of The Document Inspector tool shows inspection  results. It shows a green check mark within a circle to indicate that no comments were found. However, it flags Document Properties and Personal Information with a red exclamation mark, listing items such as document properties, author, related people, server properties, content type, and picture crop information. The tool also notes that no content add-ins were found." lightbox="../media/color-contrast-design-use-color.png":::

If you use color within an image to convey information, such as different values or required form fields:

- Include patterns to show the same information.

- Convey information in text. 

In this example of a transportation map, each route is presented using a different color, and each stop is marked with a unique icon or shape. 

:::image type="content" source="../media/color-contrast-transportation-map.png" alt-text="Screenshot of a transportation map illustrating three distinct routes, each defined by a specific color and shape: Route A is represented by the color blue and circles, Route B by the color green and squares, and Route C by the color red and triangles." lightbox="../media/color-contrast-transportation-map.png":::

Finally, use color combinations that are easily distinguishable for users with color vision deficiencies.

:::image type="content" source="../media/color-contrast-accessible-color-combinations-black.png" alt-text="Screenshot of the first combination features white and bright green text on a black background." lightbox="../media/color-contrast-accessible-color-combinations-black.png":::

:::image type="content" source="../media/color-contrast-accessible-color-combinations-dark.png" alt-text="Screenshot of the second combinations use white and bright green text on dark blue and medium blue background." lightbox="../media/color-contrast-accessible-color-combinations-dark.png":::

:::image type="content" source="../media/color-contrast-accessible-color-combinations-medium.png" alt-text="Screenshot of the third combinations use white and bright green text on dark blue and medium blue background." lightbox="../media/color-contrast-accessible-color-combinations-medium.png":::

:::image type="content" source="../media/color-contrast-accessible-color-combinations-bright.png" alt-text="Screenshot of the fourth combination shows dark and black text on a bright green background." lightbox="../media/color-contrast-accessible-color-combinations-bright.png":::

:::image type="content" source="../media/color-contrast-accessible-color-combinations-light.png" alt-text="Screenshot of the fifth combination shows dark and  black text on light and white background." lightbox="../media/color-contrast-accessible-color-combinations-light.png":::

:::image type="content" source="../media/color-contrast-accessible-color-combinations-white.png" alt-text="Screenshot of the sixth combination shows dark and  black text on light and white background." lightbox="../media/color-contrast-accessible-color-combinations-white.png":::

### Color Design Resources

- [How to Use Color Blind Friendly Palettes in Your Design](https://venngage.com/blog/color-blind-friendly-palette/)

- [Color as the Only Indicator of Meaning](https://accessibility.umich.edu/training/color-meaning) 

- [Technique G14: Ensuring That Information Conveyed by Color Differences Is Also Available in Text](https://www.w3.org/WAI/WCAG21/Techniques/general/G14)

- [Technique G17: Ensuring That a Contrast Ratio of at Least 7:1 Exists Between Text (and Images of Text) and Background Behind the Text](https://www.w3.org/WAI/WCAG22/Techniques/general/G17.html)

- [Technique G111: Using Color and Pattern](https://www.w3.org/WAI/WCAG21/Techniques/general/G111)

## Contrast

The goal is to ensure readers can read text that is presented over a background. Here are some techniques to make sure your design has enough contrast: 

- Ensure that the contrast ratio between the text or image of text and their background is **at least 4.5:1** if the text is **less than** 18-point and unbolded, or less than 14-point and bolded. 

- Ensure that the contrast ratio between the text or image of text and the background is **at least 3:1** if the text is **at least** 18-point and unbolded, or at least 14-point and bolded.

For example, in a website that uses a patterned background image, the designer should add a semi-transparent dark overlay behind the text to achieve a contrast ratio of **4.5:1**. 

To ensure good contrast, pair dark colors with light colors. Some medium colors can be paired with both dark and light colors. Very few colors in the palette are in high-contrast mode, so other styling will need to be used to differentiate various control states. You can:

- Let the user's browser or device settings determine the color of the text and the background by not specifying them in your design.

- As an alternative, allow users to switch to a version of the page with enough contrast to be easily readable. This high-contrast version should have all the information and functionality as the original page but with better readability.

Controls with low contrast are harder to see and might be missed by people with visual disabilities. Therefore, any visual information needed to identify a control or understand a graphic must meet the minimum contrast ratio. For active user interface elements (like buttons and links) and important graphics, make sure the contrast ratio is **at least 3:1** against adjacent colors for these elements. Keep in mind that visual indicators such as checkboxes or menu arrows should have enough contrast to be easily visible. As a recommendation, outline the boundaries of controls to help people with cognitive disabilities recognize them more easily. 

:::image type="content" source="../media/color-vision-deficiencies.png" alt-text="Screenshot of various color combinations showcasing good contrast for different types of **color vision deficiencies** (CVD), where a  person's ability to distinguish between certain colors is impaired." lightbox="../media/color-vision-deficiencies.png":::

:::image type="content" source="../media/color-contrast-comparison-chart-good-bad.png" alt-text="Screenshot of the image contains another color contrast  comparison chart, but this time, it includes good and bad contrast pairs." lightbox="../media/color-contrast-comparison-chart-good-bad.png":::
 

### Contrast Design Resources

- [G18: Ensuring That a Contrast Ratio of at Least 4.5:1 Exists Between Text (and Images of Text) and Background Behind the Text](https://www.w3.org/WAI/WCAG21/Techniques/general/G18) [G174: Providing a Control With a Sufficient Contrast Ratio That Allows Users to Switch to a Presentation That Uses Sufficient Contrast](https://www.w3.org/WAI/WCAG21/Techniques/general/G174) 

- [Understanding Success Criterion 1.4.11: Non-text Contrast](https://www.w3.org/WAI/WCAG21/Understanding/non-text-contrast)
  