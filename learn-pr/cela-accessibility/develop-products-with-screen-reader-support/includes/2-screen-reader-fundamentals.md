## Key terms and concepts

Familiarizing yourself with key terms is essential for effective screen reader support. Let's define and explain some of the most important terms:

 **Screen reader navigation with keyboard**: Screen reader users navigate content using arrow keys to understand and read all the elements on the page. They also use tab key to move through interactive elements. Additionally, screen reader users often utilize quick navigation keys to jump between different components. For example, pressing the "H" key allows them to quickly navigate to headings, "T" will allow to access the table, "D" key is used to navigate between landmarks.
- **Sequential navigation**: This feature allows you to move through the elements in a website or app one by one in a specific and logical order. Keyboard and screen reader users can navigate from one element to the next, such as moving from a heading to a paragraph or from one link to another. Ensuring a logical and meaningful order is crucial for accessibility.
- **Link purpose**: This involves providing clear and descriptive text for links so that users understand what will happen or where they will go when they click on a link. Screen readers announce links based on the semantics, so it's important to avoid vague phrases such as "Click here" and instead use descriptive text like "Read more about accessibility guidelines." Link purpose helps users know what to expect, making navigation easier and more intuitive. 
- **Labels**: They are used to describe the purpose of another element, typically a form input such as a text box, a checkbox, or a radio button. Screen readers announce these labels to users, helping them understand what information is required. For example, a label for a text input might be "First Name."
- **Headings**: They are used to organize and structure content in manageable sections. Headings help users and screen readers understand the hierarchy and importance of the content, facilitating its reading and navigation. In HTML, headings range from **\<h1>** to **\<h6>**. For example: Use **\<h1>** for the main title of the page, **\<h2>** for section titles, **\<h3>** for subsection titles, and continue with **\<h4>**, **\<h5>**, and **\<h6>** for smaller subheadings.
- **Landmarks**: These key elements or points in the code help users and screen readers navigate and understand the structure of a website or app. Landmarks serve as signposts, making it easier to find and manage different parts of the code. For example, \<header> is used to define the top section of a webpage, \<main> is used to define the primary content of the page, and \<nav> is used to define a section that contains navigation links such as a menu or table of contents.
- **Alt-text**: These descriptions are provided for non-text content, such as images, icons, and multimedia, to help users who can't see or hear the content understand what it is about. Purely decorative non-text content does not require a text alternative.** 
- **ARIA attributes**: Typically, ARIA is not something you would use broadly across all elements in your code. Instead, it's reserved for specific situations where standard HTML elements fall short. For example, consider a button that displays only an icon without any accompanying text label. In such cases, you would use ARIA to provide the necessary context that the icon alone cannot convey. This ensures that screen readers and other assistive technologies can accurately interpret the button's purpose.

## Importance of supporting screen readers

Screen readers are essential for users who are blind or have visual impairments. They allow them to independently access and interact with digital products and content. Ensuring apps and websites are compatible with screen readers empowers these users to achieve more and enhances the overall experience for all users. 

Additionally, adhering to accessibility standards and guidelines, such as the Web Content Accessibility Guidelines (WCAG), can help organizations avoid legal issues and improve their reputation. Many countries have laws and regulations that require digital products to be accessible, and failing to comply can result in legal consequences.

Ultimately, supporting screen readers is about recognizing and valuing the diversity of users. It reflects a commitment to inclusivity, ensuring that everyone can participate fully in the digital world regardless of their abilities.

## Practical examples of screen reader operation

To give you a hands-on understanding of how screen readers work, let's dive into a couple of practical examples. These examples will showcase how screen readers navigate through web pages, read out content, and provide feedback to users, highlighting their features and capabilities.

### Using Windows Narrator

#### Exercise 1
- Start Narrator by pressing **Ctrl** + **Windows** + **Enter**. 
- Open the Windows Start menu by pressing the **Windows** key.
- Move through the dialog by pressing **Tab** and listen for control type, position (n of m), and hint announcements.
- Navigate to the "More" button in the Recommended section by using **Tab** or **Narrator Key** + **Right Arrow**.
- Navigate to the "Back" button by using **Tab** or **Narrator Key** + **Left Arrow**.
- Turn off Narrator by pressing **Ctrl** + **Windows** + **Enter**. 

#### Exercise 2
- Start Narrator by pressing **Ctrl** + **Windows** + **Enter**. 
- Open your browser and navigate to the [Microsoft 365 blog](https://www.microsoft.com/en-us/microsoft-365/blog/2023/03/08/create-inclusive-content-with-the-new-accessibility-assistant-in-microsoft-365/).
- Turn scan mode off and back on by pressing **Caps Lock** + **Spacebar**.
- Cycle through all landmarks by pressing **D**.
- Cycle through all headings by pressing **H**.
- Navigate to the first H3 heading by pressing **3** while in scan mode.
- Navigate to a Microsoft Editor link by pressing **K**.
- Read several paragraphs. Press **P** to read the next paragraph.
- Stop reading in the middle of a paragraph by pressing **Ctrl**.
- Turn off Narrator by pressing **Ctrl** + **Windows** + **Enter**. 

### Using VoiceOver on Mac

#### Exercise 1
- Start VoiceOver by pressing **Command** + **F5**. 
- Open the VoiceOver Utilities dialog by pressing **Ctrl** + **Option** + **F8**.
- Move through the dialog by pressing **Tab** and listen for control type, position (n of m), and hint announcements. When focused on a list of elements, use the **Arrow keys** to navigate through each item.
- Navigate to the "Display welcome dialog when VoiceOver starts" tick box control by using **Tab** or **Ctrl** + **Option** + **Right Arrow**. Press **Spacebar** to toggle it on or off.
- In the utility category list, navigate to the "Verbosity" category by using **Ctrl** + **Option** + **Left Arrow** or **Right Arrow**.
- Turn off VoiceOver by pressing **Command + F5**. 

#### Exercise 2
- Start VoiceOver by pressing **Command + F5**. 
- Open your browser and navigate to the [Microsoft 365 blog](https://www.microsoft.com/en-us/microsoft-365/blog/2023/03/08/create-inclusive-content-with-the-new-accessibility-assistant-in-microsoft-365/).
- Turn quick navigation on and off by pressing the **[Left Arrow and Right Arrow](https://www.microsoft.com/en-us/microsoft-365/blog/2023/03/08/create-inclusive-content-with-the-new-accessibility-assistant-in-microsoft-365/)** simultaneously.
- Cycle through all landmarks by pressing **Ctrl** + **Option** + **U**, then **Left Arrow** or **Right Arrow**.
- Cycle through all headings by pressing **Ctrl** + **Option** + **Command** + **H**.
- Navigate between links by pressing **Ctrl** + **Option** + **Command** + **L**.
- Read several paragraphs. Press **Ctrl** +** Option** +** A** to start reading continuously or **Ctrl** +** Option** +** P** to read the next paragraph.
- Stop reading in the middle of a paragraph by pressing **Ctrl**.
- Turn off VoiceOver by pressing **Command** + **F5**. 

These practical examples demonstrate the importance of screen readers in providing accessible digital experiences. By understanding how screen readers operate, you can design and develop websites and apps that are inclusive of and user-friendly for users with visual impairments.

## Resources

- [Complete Guide to Narrator](https://support.microsoft.com/en-us/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1) 
- [VoiceOver User Guide for Mac](https://support.apple.com/guide/voiceover/welcome/mac)