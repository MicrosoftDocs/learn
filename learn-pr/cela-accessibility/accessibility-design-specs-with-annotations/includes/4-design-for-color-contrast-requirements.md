You should design to meet the minimum color contrast requirement for text and nontext content.

:::image type="content" source="../media/color-contrast-comparison-chart.png" alt-text="Screenshot of color and contrast consideration example showing good and bad contrast ratio, Bad contrast ratio - #FFFFFF / #F2F2F2, good contrast ratio - #395556 / #E1FDFB." lightbox="../media/color-contrast-comparison-chart.png":::

#### Windows high contrast

Windows high contrast is different than dark mode. It uses semantic color slots, i.e., each color has a meaning. For for example, In Aquatic theme, ackground color is black, selected text is blue gray with blue-turquoise background. We generally don't need to mark up or create a high contrast spec for standard components but for custom components we need to spec them out.

:::image type="content" source="../media/windows-high-contrast.png" alt-text="Screenshot of showing windows contrast settings that user can select or edit. Currently showing aquatic theme with background as white rectangle, Text with white color, hyperlink with cyan, inactive text with grey, selected text with cyan and button with white text and white border. Two buttons appearing at bottom as disabled save and cancel." lightbox="../media/windows-high-contrast.png":::

:::image type="content" source="../media/windows-high-contrast-preview.png" alt-text="Screenshot of showing windows contrast themes, Aquatic, desert, dusk, and night sky." lightbox="../media/windows-high-contrast-preview.png":::

### Contrast checker 

Tools like the [axe for Designers plugin](https://www.figma.com/community/plugin/1085612091163821851/axe-for-designers-a-free-accessibility-plugin) help you check the contrast ratio between text and background colors to meet WCAG standards.

:::image type="content" source="../media/color-contrast-annotations-contrast-check.png" alt-text="Screenshot of a contrast checker tool displaying two color samples: #EF5DA8 and #F178B6. The tool shows a contrast ratio of 1.19:1. Below, it lists results for different text sizes and graphics, with red FAIL labels for normal text, large text, and graphics indicating insufficient contrast. Options to enable 'Smart Sample' and use the 'APCA algorithm (Beta)' are also visible at the bottom." lightbox="../media/color-contrast-annotations-contrast-check.png":::

:::image type="content" source="../media/color-contrast-accessibility-insights-contrast-check.png" alt-text="Screenshot of an example showing how to check color contrast ratio of a control using Accessibility Insights for Windows tool. Pick color 1 (foreground) and then pick color 2 (background) and as per that result will reflect as Pass/Fail as below." lightbox="../media/color-contrast-accessibility-insights-contrast-check.png":::

### Color simulation

Plugins like [Include- Accessibility Annotations](https://www.figma.com/community/plugin/1208180794570801545/includeaccessibility-annotations) allow you to simulate how your design looks to people with different types of color blindness.

## Break point designs for reflow support

Finally, we add break point designs to ensure the design supports reflow, making sure the content and user interface adjust properly on different screen sizes and for users with varying needs.

### Reflow and zoom

One of the most effective ways to assist users with low vision is by developing a responsive design with functional breakpoints across all devices. This involves creating style sets tailored to various viewport sizes and using media queries to apply the right styles to the corresponding device dimensions. 

Firstly, when testing your design drawings reduce your artboard size to 320x256. Utilizing auto layout istremendously beneficial in this process. It's crucial to avoid using groups and unstructured frames, as they can complicate things. Additionally, consider implementing out a responsive relay if feasible. The translation between larger screens and this smaller size should be straightforward, without rearranging the order of elements or shifting them to the opposite side of the layout.

:::image type="content" source="../media/reflow-zoom-accessibility-annotation.png" alt-text="Screenshot of various viewport sizes of Teach Access’ website using media queries. From left to right: @media max-width: 768px, @media max-width: 660px, and @media max-width 360 on a mobile device." lightbox="../media/reflow-zoom-accessibility-annotation.png":::

### Other annotations

- Indicate which areas are scrollable. For example, in a paragraph dialog, the entire body might be scrollable, including the title, to maximize vertical space for controls. Alternatively, the title could be outside the scrollable area, but this reduces vertical space for controls.

- Make sure to clearly state the app's minimum supported resolution and explain how scale settings affect it. Also, make sure your app reflows properly up to the stated minimum supported resolution.
