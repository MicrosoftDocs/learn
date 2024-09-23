WCAG industry standard guidelines for web content accessibility are organized around four principles: **Perceivable**, **Operable**, **Understandable**, and **Robust**. To remember these principles, many people use the acronym POUR. These universal POUR principles provide the foundation for web accessibility and ensure that web content is accessible to people with diverse needs and preferences. 

According to the [World Wide Web Consortium (W3)](https://www.w3.org/TR/UNDERSTANDING-WCAG20/intro.html), anyone who wants to use the web must have content that incorporates all four POUR principles. Let’s explore what they mean:

- **Perceivable** – Information and user interface components must be presentable to users in ways they can perceive. This means ensuring all users can see, hear, or sense all elements of a design. While many users may be able to understand visually, other users may perceive through sound or touch. This is when tools like alt text for images and links, high-contrast color, captions, and transcripts can help.

- **Operable** – This principle requires all user interface components and navigation to be operable. So, users must be able to successfully use controls, buttons, navigation, and other interactive elements. Not everyone can use a mouse. For many, being able to operate a website or web application means using assistive technology like voice recognition, keyboards, or screen readers.

- **Understandable** – Users must be able to comprehend the information on a website as well as how to access and navigate the site. This principle calls for sites and web applications to be predictable in design and usage patterns. They should be easy to navigate and read. This means creating a visual hierarchy that emphasizes headings and content structure with clear instructions and consistent navigation. Understandability can be context specific. For example, a website explaining how to complete a complex coding task can include information that would be understandable to a developer but might not be understandable to someone with no coding background.

- **Robust** – This principle requires content to be able to be accessed and interpreted reliably by a wide variety of user agents, including assistive technologies like screen readers, speech recognition, and text magnification. As agent technologies advance and evolve, the content should remain accessible across different types of devices and browsers.

**How do you rate the accessibility of a website or web application?**

Each of the four WCAG principles has guidelines with specific recommendations for web design and development. These guidelines are further broken down into measurable and testable 'success criteria' or statements that define the minimum requirements for web accessibility.

**Three levels of conformance: A, AA**, and **AAA**

This rating system indicates the level of compliance and conformity to accessibility guidelines – with A being the minimum level and AAA the maximum level of compliance. The recommended level of accessibility for most web content is the intermediate level of accessibility AA.

Levels are cumulative, meaning intermediate level AA web content must also meet all minimum level A success criteria, while AAA content must also meet success criteria for both level A and AA.

**Comparing levels of conformance with web accessibility principle**

Let’s compare the three levels of conformance by reviewing some SAMPLE success criteria for each of the POUR web accessibility principles.

**Perceivable**
- A: Provide text alternatives for non-text content (e.g., images, audio, and video)
- AA: Provide captions for live audio content (e.g., webinars, podcasts, and broadcasts)
- AAA: Provide sign language interpretation for pre-recorded audio (e.g., videos, animations, and presentations)

**Operable**
- A: Make all functionality available from a keyboard (e.g., links, buttons, and forms).
- AA: Provide enough time to read and use content (e.g., allow adjusting or extending time limits).
- AAA: Provide the option to re-authenticate without losing data (e.g. save progress or resume later).

**Understandable**
- A: Make sites appear and operate predictably (e.g., with consistent navigation and feedback mechanisms).
- AA: Make text readable and understandable (e.g., use clear, simple language; define unfamiliar words).
- AAA: Provide a way to expand abbreviations (e.g., by using \<abbr> element, or by providing a glossary).

**Robust**
- A: Maximize compatibility with future user agents (e.g., use valid, well-formed markup; follow standards).
- AA: Provide name, role, and value for all user interface (UI) components, by using appropriate HTML elements and attributes or WAI-ARIA* roles and properties.
- AAA: Provide the purpose and meaning of UI components (e.g., by using WAI-ARIA landmarks and labels.)

*(WAI-ARIA): [Web Accessibility Initiative – Accessible Rich Internet Applications standard.](https://www.w3.org/WAI/standards-guidelines/aria/)