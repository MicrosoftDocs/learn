The first step before implementing accessible features in the app is to turn on the screen reader. Let's walk through how to turn on the screen reader for each operating system to test accessibility in the app.

## Enable Windows screen reader

Narrator is a screen reader built directly into Windows to enable users to complete common tasks without a mouse. You can enable Narrator in one of two ways:

- Press the **Windows logo key** + **Ctrl** + **Enter** together to start Narrator. Press these keys again to stop Narrator. (On older versions of Windows, the command was the **Windows logo key** + **Enter**.) On many keyboards, the Windows logo key is located on the bottom row of keys, to the left or right of the Alt key.

- Press the **Windows logo key** + **Ctrl** + **N** to open Narrator settings, and then turn on the toggle under Use Narrator.

![Windows screenshots to enable Narrator](../media/windows-narrator.png)

It is recommended to go through the Narrator tutorial, which can be found in the Narrator settings screen.

// Should we walk through macOS VoiceOver? Mobile? Seems repetitive and unnecessary for web since they're all similar.

## Install Accessibility Insights for Web browser extension

[Accessibility Insights for Web](https://accessibilityinsights.io/docs/en/web/overview/) is an extension for Chrome and the new Microsoft Edge that helps developers find and fix accessibility issues in web apps and sites.

The tool supports two primary scenarios:

- *FastPass* is a lightweight, two-step process that helps developers identify common, high-impact accessibility issues in less than five minutes.
  - Automated checks - the tool automatically checks for compliance with approximately 50 accessibility requirements.
  - Tab stops - the tool provides clear instructions and a visual helper that makes it easy to identify critical accessibility issues related to keyboard access, such as missing tab stops, keyboard traps, and incorrect tab order.
- *Assessment* allows anyone with HTML skills to verify that a web app or web site is compliant with Web Content Accessibility Guidelines (WCAG) 2.1 Level AA.
  - Automated checks - the tool automatically checks for compliance with approximately 50 accessibility requirements.
  - Manual tests - the tool provides step-by-step instructions, examples, and how-to-fix guidance for approximately 20 tests; many tests are "assisted", which means that the tool identifies the test instances or provides a visual helper.

1. Browse to the [Accessibility Insights for Web](https://accessibilityinsights.io/docs/en/web/overview/) page in either Chrome or Microsoft Edge.
1. Click install button that corresponds to your browser. 
1. When the extension page is displayed, click the appropriate button for your browser ("Get" for Edge, "Add to Chrome" for Chrome) to install the extension.
