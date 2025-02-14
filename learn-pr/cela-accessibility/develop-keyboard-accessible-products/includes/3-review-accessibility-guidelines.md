It is essential to know the key principles and requirements that ensure digital products are accessible to all users, including those with disabilities. The Web Content Accessibility Guidelines (WCAG) provide a comprehensive framework for creating accessible web content and user interface (UI) components. This section will outline their primary accessibility principles and requirements related to keyboard accessibility.

## Overview of relevant accessibility guidelines

The WCAG standards provide specific guidelines to ensure websites and apps are [operable (Guideline 2.1)](https://www.w3.org/WAI/WCAG21/Understanding/keyboard-accessible), [navigable (Guideline 2.4)](https://www.w3.org/WAI/WCAG21/Understanding/navigable), [predictable (Guideline 3.2)](https://www.w3.org/WAI/WCAG21/Understanding/predictable), and [compatible (Guideline 4.1)](https://www.w3.org/WAI/WCAG21/Understanding/compatible). These success criteria focus on making websites and apps easier to navigate, predictable and consistent for users, and compatible with assistive technologies. To meet these guidelines, designers and developers should take into consideration the following:<br>

### Meaningful sequence (sc 1.3.2)

This criterion requires that content on a web page is organized in a logical, understandable order no matter how users access it. This is essential for people who use screen readers or other assistive tools that rely on a clear reading order. For instance, if a set of steps is listed in a random order, it could confuse users who listen to the content. Ensuring a meaningful sequence helps everyone follow instructions, read information, or navigate digital products smoothly.

### Keyboard accessible (guideline 2.1)

This criterion ensures that web content and apps can be navigated and operated using a keyboard. This means that users should be able to navigate through menus, activate buttons, and complete forms without a mouse. This criterion also ensures that users can navigate using a keyboard without getting stuck in any part of the page ([No Keyboard Trap](https://www.w3.org/WAI/WCAG21/Understanding/no-keyboard-trap)). Users should be able to move the focus to an element and away from it using the keyboard. If users need to use specific keys to leave an area, they should be told how to do so.

### Character key shortcuts (sc 2.1.4)

This criterion requires making sure keyboard shortcuts don't accidentally cause problems for users. If a website assigns single keys (like letters, numbers, or symbols) as shortcuts, users should have the option to turn them off or change them to a key combination, like **Ctrl** + **a letter**.

### Bypass blocks (sc 2.4.1)

Users must be able to skip over repeated content, like navigation menus, to get to the main content of a web page more quickly. For example, including a "Skip to main content" link at the top of the page, allows users to jump directly to the main section, avoiding repeated elements. This makes it easier for everyone to access the primary information on a website.

### Focus order (sc 2.4.3)

This criterion ensures that users can navigate through interactive elements on a webpage or application in a logical and intuitive order. When a user navigates using the **Tab** key, the focus should move in a predictable order that aligns with the visual layout of the content. This helps users understand where they are on the page and what actions they can take next. Focusable components need to be highlighted in an order that makes sense and keeps them usable, but only when the order affects their meaning and functionality. If there are multiple ways to order them that still make sense and work well, you only need to choose one of those ways.

### Predictable (guideline 3.2)

This criterion focuses on making websites and applications predictable and consistent for users. Websites and apps should provide consistent navigation to keyboard users. This means that navigation menus should always be in the same place on every page so that users can find what they need without confusion. Designers and developers should also provide keyboard users with consistent identification. This means that elements that look the same should perform the same actions. This predictability is crucial for keyboard users who rely on visual cues to understand functionality. When keyboard users navigate through a web page using the **Tab** key, focusing on different elements should not trigger unexpected actions, such as opening a new window or jumping to a different section of the page. On the other hand, when they interact with a form or input field, it should not result in unexpected actions such as submitting the form or navigating away from the page. 

### Compatible (guideline 4.1)

This criterion aims to maximize compatibility with both current and future user agents, including assistive technologies. It states that content created using markup languages must-have elements with complete start and end tags, properly nested elements, no duplicate attributes, and unique IDs (unless specifications allow otherwise). This guarantees that user agents can accurately interpret and parse the content. Furthermore, it requires that for all user interface components, the name and role must be programmatically determinable, and states, properties, and values that users can set must be programmatically adjustable. Any changes to these items must be communicated to user agents, allowing assistive technologies to interact with and provide information about these components. Finally, this criterion mandates that status messages be programmatically determined through roles or properties so that they can be presented to the user by assistive technologies without receiving focus. This ensures that users who rely on screen readers or other assistive technologies are informed of important changes in content.

## Resources

- [Keyboard Accessible WCAG Quick Ref Guide](https://www.w3.org/WAI/WCAG22/quickref/?showtechniques=131)
- [Focus Order WCAG Quick Ref Guide](https://www.w3.org/WAI/WCAG22/quickref/?showtechniques=131)
- [On Focus WCAG Quick Ref Guide](https://www.w3.org/WAI/WCAG22/quickref/?showtechniques=131%2C321)