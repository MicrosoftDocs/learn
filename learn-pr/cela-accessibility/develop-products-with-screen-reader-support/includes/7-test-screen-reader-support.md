Testing is crucial for ensuring screen reader accessibility. In this section, we'll introduce some of the processes and tools that are helpful for testing and debugging screen reader support in your digital products. 

## Manual testing

Here are some ways to manually test your website or app for screen reader support. 

- Use the feature with a Screen Reader and keyboard:
  - Windows: Narrator, JAWS, or NVDA
  - Mac: VoiceOver
  - iOS: VoiceOver
  - Android: Talkback
- Navigate the feature:
  - Use keyboard shortcuts to navigate through the app or website.
  - Ensure the screen reader announces each element as you navigate, providing accurate and sufficient information for understanding location and context without looking at the screen.
  - Ensure that the information is not overly verbose.
  - Ensure the feature is tracking properly.
- Review element identification:
  - Confirm that every element has a proper name, role, and value.
  - Ensure that labels are correctly associated with their respective elements.
- Test two (2) navigation methods:
  - Navigate the feature and ensure the screen reader follows.
  - Navigate with the screen reader and then interact with the feature.
- Check titles and labels:
  - Verify that each window or page has a title.
  - Ensure visible labels are part of the element's name and that each is unique.
- Check input controls:
  - Check that all input controls have names or instructions.
  - Verify that relationships between elements are specified and error messages are clear.
- Check images:
  - Ensure decorative images are skipped by the screen reader.
  - Verify that important images have descriptive names that describe their content and context.
- Other verifications:
  - Confirm that links have meaningful names, not just URLs.
  - Ensure all text is accessible and readable by the screen reader.
  - Verify that tables have headers and are announced correctly.
  - Ensure the language of the content is specified for the screen reader.

## User testing

User testing for screen reader support is crucial to ensure that websites and applications are usable by everyone, including people with disabilities. This type of testing helps identify and address barriers that might prevent users who rely on keyboards or assistive technologies from fully interacting with digital products. By involving people with disabilities in the testing process, developers can gain valuable insights into real-world challenges and ensure that the user experience is inclusive and accessible. 

## Tools

Here are some tools you can use to test your website or app's accessibility:

- **Browser debuggers**: Built-in tools in web browsers that assist developers in finding and correcting code errors. They enable you to set breakpoints, examine variables, and walk through code execution to diagnose and fix problems.
- [**Accessibility Insights for Web**](https://accessibilityinsights.io/docs/web/overview/): This is a plugin for Edge and Chrome. This tool helps catch common accessibility issues quickly, but manual testing is still necessary.

:::image type="complex" source="../media/accessibility-insights-launch-pad.png" alt-text="Screenshot of Accessibility Insights' launch pad." lightbox="../media/accessibility-insights-launch-pad.png":::
   View of Accessibility Insights’ launch pad. It provides four options: FastPass, which runs three tests to find common accessibility issues in under 5 minutes; Quick Assess, which runs 10 assisted checks to find more accessibility issues in 30 minutes; Assessment, which guides users through a process to assess accessibility compliance; and Ad hoc tools, which offer quick access to visual tools for identifying accessibility issues.
:::image-end:::

- [**Accessibility Insights for Windows**](https://accessibilityinsights.io/docs/windows/overview/): This tool is great for debugging rich client apps on Windows and can also be used for web apps. The Live Inspect tool shows the accessibility tree, including parent and sibling elements. It displays control types, names, and patterns and allows you to invoke patterns like toggling a button. This tool helps identify whether issues are in your apps' HTML and ARIA, the browser's UIA exposure, or the screen reader's experience.
- **Accessibility Insights for Android**: This app runs on Windows, Mac, and Linux and communicates with a service on your Android device or emulator. It includes FastPass automated tests to quickly identify accessibility issues.
- [**Apple’s Accessibility Inspector**](https://developer.apple.com/documentation/accessibility/accessibility-inspector): This tool is included with Xcode and allows you to inspect elements in iOS apps. Click the target tool, hover over an element to get information, and lock on it to see its properties and position in the accessibility tree. It also supports inspecting elements in an iOS simulator. However, we recommend always building to the device and running VoiceOver.
- [**Lighthouse**](https://developer.chrome.com/docs/lighthouse/overview): Lighthouse is a built-in Chrome tool that evaluates web pages for quality by checking performance, accessibility, best practices, SEO, and Progressive Web App features. It runs tests on any page and provides a report with issues and recommendations for improvement. Lighthouse helps developers optimize sites to be faster, more user-friendly, and accessible.

## Resources

- [Complete Guide to Narrator](https://support.microsoft.com/en-us/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1) 
- [Testing for Accessibility](/windows/win32/winauto/accessibility-testingtools) 
- [JAWS®](https://www.freedomscientific.com/products/software/jaws/) 
- [NV Access NVDA](https://www.nvaccess.org/download/)
- [VoiceOver User Guide for Mac](https://support.apple.com/lt-lt/guide/voiceover/welcome/mac)
- [Get Started on Android With TalkBack](https://support.google.com/accessibility/android/answer/6283677?hl=en) 
- [Manual Testing for Accessibility](https://accessibility.huit.harvard.edu/manual-testing-accessibility)