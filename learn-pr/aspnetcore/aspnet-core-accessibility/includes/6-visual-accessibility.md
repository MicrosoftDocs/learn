Your users will have various visual abilities. Someone who is color-blind might not be able to differentiate between colors. Or, might have difficulty working with colors that are similar to one another. Others may use zoom to enlarge content. Accommodating various visual abilities are an important part of accessibility.

## Contrast

Ensuring adequate contrast makes it easier for everyone to read text content, interpret graphical elements, identify UI components, and notice when those components change state. People with low vision often have difficulty reading text, identifying buttons that do not contrast with their background, or determining the state of UI components. The problems can be exacerbated if the person has a color  deficiency that lowers the perceived contrast even further.

Fortunately, contrast ratios can be checked programmatically. Accessibility Insights for Web include contrast checking in **FastPass**.

## Color

Color is an important part of web design, but it's important to keep in mind that everyone sees color a little differently. For some, it results in color blindness. About 1 in 12 men are color blind, and there are several different kinds such as red-green and blue-yellow color blindness.

Additionally, your users may be using a color to minimize eye fatigue, be using a display with poor color fidelity, or be working in lighting, which makes color perception difficult.

As you learned in the previous exercise by fixing a form that used colors to indicate required fields, you should design your web applications so they do not require color vision.

In addition to **FastPass** automated tests, you can check how your site will appear to people with varying degrees of color blindness using color filters, which are built into [Windows](https://support.microsoft.com/en-us/windows/use-color-filters-in-windows-10-43893e44-b8b3-2e27-1a29-b0c15ef0e5ce) and [macOS](https://support.apple.com/guide/mac-help/use-color-filters-mchl11ddd4b3/mac).

## Zoom

Your website looks beautiful on your enormous 4K monitor... but that doesn't mean all of your users will experience it the same way. Some users may zoom in up to 200% to be able to read the text, and some may be reading on a mobile device.

Web browsers are good at scaling text, and [Bootstrap was designed to facilitate responsive design](https://getbootstrap.com/docs/5.0/layout/grid/), which scales based on-screen size. The important thing is to keep things as simple as possible, use the web as it was designed, and test your site on different displays and at varying levels of zoom.

In the next exercise, we'll find and fix visual accessibility issues in our pizza restaurant website.
