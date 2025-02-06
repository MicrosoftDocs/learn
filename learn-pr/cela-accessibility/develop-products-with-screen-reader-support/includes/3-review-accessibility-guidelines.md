## Introduction

It's essential to know the key principles and requirements that ensure digital products are accessible to all users, including those with disabilities. The Web Content Accessibility Guidelines (WCAG) provide a comprehensive framework for creating accessible web content and user interface (UI) components. This section outlines their primary accessibility principles and requirements related to screen reader support.

## Overview of accessibility guidelines

The WCAG standards provide specific guidelines to ensure websites and apps are [adaptable (Guideline 1.3)](https://www.w3.org/WAI/WCAG21/Understanding/adaptable), [distinguishable (Guideline 1.4)](https://www.w3.org/WAI/WCAG21/Understanding/distinguishable), [keyboard accessible (Guideline 2.1)](https://www.w3.org/WAI/WCAG21/Understanding/keyboard-accessible), [navigable (Guideline 2.4)](https://www.w3.org/WAI/WCAG21/Understanding/navigable), [readable (Guideline 3.1)](https://www.w3.org/WAI/WCAG21/Understanding/readable), [predictable (Guideline 3.2)](https://www.w3.org/WAI/WCAG21/Understanding/predictable), and [compatible (Guideline 4.1)](https://www.w3.org/WAI/WCAG21/Understanding/compatible). These success criteria focus on making web content and apps easier to navigate, predictable and consistent for users, and compatible with assistive technologies. To meet these guidelines, designers and developers should consider:

### Text alternatives (Guideline 1.1)

This criterion requires providing text alternatives for non-text content, including images, icons, multimedia, controls, inputs, time-based media, CAPTCHAs. Note, decorative images shouldn't be given alternative text. Instead, they should be marked as decorative for screen readers to ignore them. The text alternative should convey the same information or function as the non-text content. For non-text content that doesn't fit into other specific categories like pictures, charts, diagrams, animations, and audio recordings, text alternatives can provide the same information in a way that can be accessed visually, by hearing, or by touch. For CAPTCHAs, the WCAG Working Group recommends implementing two different forms of CAPTCHA, offering multiple CAPTCHA modalities.

### Time-based media (Guideline 1.2)

This criterion focuses on time-based and synchronized media to ensure that people with disabilities can access their content. It includes several key requirements, such as providing text alternatives for pre-recorded audio-only and video-only content, captions for all pre-recorded audio content in synchronized media, and audio descriptions for all pre-recorded video content in synchronized media. In addition, it requires providing captions for live audio content in synchronized media and audio descriptions for prerecorded video content. Transcripts provide a written version of the spoken content, while captions provide synchronized text for both spoken content and important sounds. 

### Adaptable (Guideline 1.3)

This criterion focuses on ensuring that information, structure, and relationships conveyed through presentation are accessible to all users, helping users who rely on assistive technologies understand the content. It requires presenting content in a meaningful order that preserves the intended meaning and relationships when read by assistive technologies. It also requires ensuring that instructions don't depend solely on sensory features such as shape, size, visual location, orientation, or sound. Additionally, this criterion requires that content shouldn't be restricted to a single display orientation, such as portrait or landscape, unless a specific orientation is essential. It also mandates that the purpose of input fields collecting user information must be programmatically determined so that assistive technologies can present this information to users in a way that meets their needs. Finally, it requires that the purpose of user interface components, icons, and regions should be programmatically determined to help users understand and navigate the content more easily.

### Distinguishable (Guideline 1.4)

This criterion focuses on making content perceivable by ensuring that it's distinguishable and accessible to all users. It includes several key requirements, such as: 
- Ensuring that color isn't the only visual means of conveying information, indicating an action, prompting a response, or distinguishing a visual element
- Providing users with a way to stop, pause, or control the volume of audio that plays automatically for more than** three (3) seconds** 
- Ensuring that text and images of text have a contrast ratio of at least **4.5:1**, except for large text, incidental text, and logotypes
- Ensuring that text can be resized up to **200%** without losing content or functionality
- Ensuring that no loss of content or functionality occurs when the user adjusts text spacing and line height 
- Ensuring that non-text content has a contrast ratio of at least **3:1** against adjacent colors 
- Using text instead of images of text, except when a particular presentation is essential
- Ensuring that audio content that contains speech has a background sound that is either at least **20 dB** lower than the speech or that has no background sound at all
- Providing users with options to control the visual presentation of text, such as foreground and background color, line spacing, and text alignment
- Presenting content without loss of information or functionality and without requiring scrolling in two dimensions for vertical scrolling content at a width equivalent to **320 CSS pixels**
- Ensuring that other content triggered by hover or focus can be dismissed, is hoverable, and remains visible until dismissed or no longer relevant 

### Keyboard accessible (Guideline 2.1)

This criterion focuses on making websites and apps accessible through keyboard navigation, ensuring that users who can't use a mouse can still interact with the content. It requires all functionality of the content to be operable through a keyboard interface without requiring specific timings for individual keystrokes. This criterion also ensures that users can navigate using a keyboard without getting stuck in any part of the page ([No keyboard trap](https://www.w3.org/WAI/WCAG21/Understanding/no-keyboard-trap)). Users should be able to move the focus to an element and away from it using the keyboard. If users need to use specific keys to leave an area, they should be told how to do so.

### Navigable (Guideline 2.4)

This criterion focuses on providing clear navigation mechanisms in websites and apps. It includes several key requirements, such as:

- Providing a way for users to skip repetitive content and go directly to the main content of the page
- Ensuring that pages have descriptive and informative titles that help users understand the topic or purpose of the page
- Providing multiple ways for users to locate a page within a set of pages, such as a search function, site map, or table of contents
- Ensuring that the navigation order of interactive elements is logical and intuitive
- Using clear and descriptive headings and labels to help users understand the structure and purpose of the content
- Ensuring that the purpose of each link is clear from the link text alone or from the link text together with its surrounding context
- Ensuring that the keyboard focus indicator is visible so that users understand which element currently has focus

### Readable (Guideline 3.1)

This criterion is focused on making text content readable and understandable for all users. To achieve this, the default language of each page must be programmatically determined. Additionally, any passage or phrase in the content that differs from the default language of the page should also be identified. This ensures that assistive technologies can parse text correctly. Additionally, mechanisms should be provided to define unusual words, idioms, and jargon, and to expand abbreviations. For text that requires advanced reading skills, supplemental content or simpler versions should be available. Finally, specific pronunciations should be provided where necessary to avoid ambiguity. These measures help make web content more accessible and comprehensible, particularly for users with cognitive and learning disabilities.

### Predictable (Guideline 3.2)

This criterion aims to ensure that websites and apps operate in predictable ways. It requires that when a component receives focus, it shouldn't cause a change of context, preventing unexpected actions like opening new windows or submitting forms. This criterion also requires that changing the setting of any user interface component shouldn't automatically cause a change of context unless the user has been informed beforehand. This ensures that users aren't redirected without warning. Similarly, it mandates that navigational mechanisms repeated on multiple pages should appear in the same relative order each time, helping users predict where navigation elements will be. Additionally, components with the same functionality within a set of web pages should be identified consistently, such as labeling a search box the same way across different pages. Finally, it requires that changes of context are only initiated by a user request or that a mechanism is available to turn off such changes, giving users full control and preventing confusion from unexpected changes.

### Input assistance (Guideline 3.3)

This criterion focuses on helping users avoid and correct mistakes when interacting with websites and apps. If an input error is detected, the item in error should be identified and described to the user in text, helping users understand and fix the issue. Additionally, this criterion mandates providing labels or instructions when user input is required, ensuring they know what is expected of them and reducing errors. 

### Compatible (Guideline 4.1)

This criterion aims to maximize compatibility with both current and future user agents, including assistive technologies. It stipulates that content created using markup languages must have elements with complete start and end tags, properly nested elements, no duplicate attributes, and unique IDs (unless specifications allow otherwise). This guarantees that user agents can accurately interpret and parse the content. Furthermore, it requires that for all user interface components, the name and role must be programmatically determinable, and states, properties, and values that users can set must be programmatically adjustable. Any changes to these items must be communicated to user agents, allowing assistive technologies to interact with and provide information about these components. Finally, this criterion mandates that status messages be programmatically determined through roles or properties so that they can be presented to the user by assistive technologies without receiving focus. This ensures that users who rely on screen readers or other assistive technologies are informed of important changes in content.