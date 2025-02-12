Testing is crucial for ensuring adequate color contrast. In this section, we'll introduce some of the processes and tools for testing color contrast in your digital products. 

## Testing Tools

You can use tools such as [Accessibility Insights for Windows](https://accessibilityinsights.io/docs/windows/overview/), [WebAIM's Contrast Checker](https://webaim.org/resources/contrastchecker/), [Accessible Web's Color Contrast Checker](https://accessibleweb.com/color-contrast-checker/), and [Colour Contrast Analyzer (CCA)](https://www.tpgi.com/color-contrast-checker/) to check the contrast of the color combinations in your design. Browser developer tools such as [Firefox Accessibility Inspector](https://developer.mozilla.org/en-US/docs/Web/Accessibility/Understanding_WCAG/Perceivable/Color_contrast) and [Chrome DevTools](https://developer.chrome.com/docs/devtools)[ and automated tools such as ](https://developer.chrome.com/docs/devtools)[Web Accessibility Evaluation Tool (WAVE)](https://wave.webaim.org/) offer features to inspect and test color contrast. In this section, we will present a couple of exercises with which you can follow along using any of these tools. 

## Manual Testing

Here's a list of ways to test color contrast:

- Check the contrast ratio between text and background colors manually using one of the color contrast tools.

- Convert your design to grayscale to ensure that information is not conveyed by color alone.

- Simulate various types of color blindness (such as Deuteranopia and Protanopia) using tools or browser extensions to ensure your design is accessible to users with color vision deficiencies.

- Test your design with users with different color vision deficiencies to get direct feedback.

When testing for color contrast, make sure to cover all control states. For example, this toggle button has different stakes, such as Normal, Hover, Focus, Hover + Focus, and Selected. 

:::image type="content" source="../media/color-contrast-testing.png" alt-text="Screenshot of A diagram displaying the color contrast for the  same button in different interaction states. The states are labeled as  "Normal", "Hover", "Focused", and "Hover + Focused". On the right, similar  states are shown for the selected button: "Selected", "Selected + Hover",  "Selected + Focused", and "Selected + Hover + Focused"." lightbox="../media/color-contrast-testing.png":::

You should also test all themes. For example, Microsoft Office apps have four themes: colorful, dark gray, black, and white. 

:::image type="content" source="../media/color-contrast-testing-windows-themes.png" alt-text="Screenshot of view of the PowerPoint UI in four different Windows  themes. The themes are labeled as Colorful, Dark Gray, Black, and White. Each theme shows slight variations in background and interface colors, demonstrating how the presentation appears under different color settings." lightbox="../media/color-contrast-testing-windows-themes.png":::

Additionally, in Windows high-contrast mode, you can choose from four themes: High Contrast 1, High Contrast 2, High Contrast Black, and High Contrast White. 

:::image type="content" source="../media/color-contrast-testing-windows-high-contrast-modes.png" alt-text="Screenshot of view of the PowerPoint UI in four high-contrast Windows themes. The themes are labeled as High Contrast #1, High Contrast #2,  High Contrast Black, and High Contrast White. Each theme alters the  background, text, and interface colors to demonstrate how the presentation appears with different high-contrast settings. The slides contain a title text box and decorative elements, adjusted to match each theme's color scheme." lightbox="../media/color-contrast-testing-windows-high-contrast-modes.png":::

MacOS and iOS operating systems support light and dark modes.

:::image type="content" source="../media/color-contrast-testing-mac-high-contrast-modes.png" alt-text="Screenshot of view of the PowerPoint UI in two Mac modes: Light Mode and Dark Mode. In Light Mode, the slide background is bright with dark  text, while in Dark Mode, the background is dark with lighter text and  interface elements. The comparison demonstrates how the presentation adapts to different color settings for better visibility and accessibility." lightbox="../media/color-contrast-testing-mac-high-contrast-modes.png":::

> [!NOTE]
> Mac OS has some contrast problems that make it challenging to see certain elements clearly. The Increase Contrast setting is off by default, but turning it on will improve the contrast for the operating system and in many apps. It will also turn on the "Reduce Transparency" setting. Before testing for contrast, ensure the "Increase Contrast" setting is turned on. To do this, go to System Settings > Accessibility > Display. Then, turn on the "Increase Contrast" setting.

### Exercise 1

```
Using one of the tools mentioned in this section, let's analyze the contrast for Microsoft PowerPoint's icon for inserting a new slide. Since users need to recognize the icon to know which feature it is for, the contrast requirement applies to it. The icon has five colors and five boundaries where the color pairs need sufficient contrast. 
```

:::image type="content" source="../media/power-point-insert-new-slide-button-focused.png" alt-text="Screenshot of the Microsoft PowerPoint button to insert a new slide." lightbox="../media/power-point-insert-new-slide-button-focused.png":::

All five instances pass the 3:1 contrast ratio requirement for UI components. Although the contrast for the interior and exterior fills are low, they both have sufficient contrast with the border that separates them. 

```
A keyboard focus visual indicator appears when we place the keyboard focus on this icon. The visual indicator is also important for meaning, so the contrast requirement also applies to it. We need to check the color contrast between the color of the focus border and the exterior fill color adjacent to it.
```

In this case, the contrast is sufficient, meeting our contrast requirements of 3:1 for non-text content. 


### Exercise 2

In this example, the icon and the text for the **Link** button on the ribbon are dimmed and have low contrast, but the control is disabled. 

:::image type="content" source="../media/power-point-icon-text-for-link-disabled-state.png" alt-text="Screenshot of the PowerPoint ribbon showing various options: "Icons," "SmartArt," "Link," "Text Box," and "Footer" . The "Link" control is  disabled; its text and icon are dimmed and have low contrast." lightbox="../media/power-point-icon-text-for-link-disabled-state.png":::

```
Controls in a disabled state are exempt from contrast requirements. Users don't have to read these controls because they can't interact with them. Since this is a common design for disabled controls, a compromise was made regarding the requirement, and the exemption was added.
```

#### Exercise 3

When we hover over a button in the PowerPoint toolbar, it renders with a darker fill that has low contrast compared to the normal background fill. 

:::image type="content" source="../media/power-point-toolbar-pencil-button-hovered.png" alt-text="Screenshot of Various buttons in the PowerPoint toolbar. The  pencil button is in hovered state, and shows a darker fill than the rest of  the buttons. **Colors** - Hover background color: #5f5f5e  -  Icon color: #ffffff  **Contrast  of Color Pairs** -  Hover background color: Icon color = 6.392:1." lightbox="../media/power-point-toolbar-pencil-button-hovered.png":::

Recall that the hover state is not important for meaning. People can already tell that these buttons are clickable without being able to see the hover indicator. However, the icon still needs to meet contrast requirements while in the hover state, which means that the hover background color and the icon need sufficient contrast. In this case, it does. 

### User Testing

User testing for color contrast is crucial to ensure that websites and applications are usable by everyone, including people with disabilities. This type of testing helps identify and address barriers that might prevent users with disabilities from fully interacting with digital content. By involving people with disabilities in the testing process, developers can gain valuable insights into real-world challenges and ensure that the user experience is inclusive and accessible. 

## Resources 

- [Microsoft Accessibility Insights](https://accessibilityinsights.io/)

- [WebAIM's Contrast Checker](https://webaim.org/resources/contrastchecker/)

- [Accessible Web's Color Contrast Checker](https://accessibleweb.com/color-contrast-checker/)

- [Colour Contrast Analyzer (CCA)](https://developer.paciellogroup.com/resources/contrastanalyser/)

- [Color Contrast Analyzer (CCA) for Mac](https://www.tpgi.com/color-contrast-checker/)

- [Firefox Accessibility Inspector](https://developer.mozilla.org/en-US/docs/Web/Accessibility/Understanding_WCAG/Perceivable/Color_contrast) 

- [[Chrome DevTools](https://developer.chrome.com/docs/devtools)](https://developer.chrome.com/docs/devtools)

