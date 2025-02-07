Considering accessibility throughout the product development cycle is crucial because it ensures that inclusivity is integrated into every stage of design and development. By addressing accessibility from the outset, you can identify and resolve potential barriers early, creating a more seamless and user-friendly experience for all users, including those with disabilities. This proactive approach not only enhances usability but also helps meet legal and ethical standards, ultimately leading to a more equitable digital landscape. By the end of this unit, you will be equipped with the knowledge to navigate the product development process effectively, ensuring that your designs are innovative and accessible.

## Accelerator keys and shortcuts

Accelerator keys are keyboard shortcuts that provide an intuitive way for users to invoke common actions or commands without navigating through the app's interface or using a mouse. They consist of two types of keys: 
- **Modifiers** are special keys users press along with other keys to perform shortcuts, such as:
  - **Shift:** Often used to capitalize letters or access alternate functions of keys
  - **Ctrl/Cmd:** Used in many shortcuts, such as Ctrl/Cmd + V to paste
  - **Alt/Option:** Used for accessing menus and other functions
- **Non-modifiers** are the regular keys you press along with modifier keys to create shortcuts, such as:
  - **Delete:** Used to remove the selected items or text
  - **F3:** Used to search within applications. On Mac, it's the F key 
  - **Spacebar:** Used to select or activate items
  - **Arrow keys:** Used to navigate through menus or to move the cursor
  - **Esc:** Used to cancel actions or close menus 
  - **Letters, numbers, and punctuation keys:** Used in various shortcuts, such as Ctrl/Cmd + O to open or Ctrl/Cmd + S to save 

In addition to navigation, features are often accessible through accelerator keys and shortcuts. While not required for accessibility, these shortcuts are added for common commands to enhance keyboard efficiency. Accelerator keys make applications more accessible by supporting keyboard navigation and making it easier for users to learn and remember shortcuts.

### Resources

- [Keyboard Accelerators](/windows/apps/design/input/keyboard-accelerators)
- [Mac Keyboard Shortcuts](https://support.apple.com/en-us/102650)

## Keyboard focus visual indicators

Providing clear visual indicators for focused elements is essential for keyboard accessibility. Focused states should be visually distinct from normal states, using methods such as dots, fill color, or outlines. 

:::image type="complex" source="../media/keyboard-focus-visual-indicators.png" alt-text="Screenshot showing focus indicators for buttons." lightbox="../media/keyboard-focus-visual-indicators.png":::
   The image consists of two sections. The top section displays three buttons—Simplified Ribbon, Go Premium, and Sign Out—in their normal state. The bottom section shows the same buttons in their focused state, highlighting focus indicators: dots, fill color, and outlines.
:::image-end:::

Ensure that minimum contrast ratio requirements are met, including in high-contrast mode, to make focus indicators easily noticeable. Keyboard annotation labels can also be used to provide additional context for focused elements.

### Resource

[Non-Text Contrast WCAG Quick Ref Guide](https://www.w3.org/WAI/WCAG22/quickref/?showtechniques=131) 

## Accessibility annotations for keyboard navigation

Annotations for keyboard accessibility help designers communicate how users can navigate and interact with their designs using a keyboard. Here are some common annotations using these plugins for Figma:
- [ A11y Focus Order Plugin and Fluent Accessibility Design Toolkit](https://www.figma.com/community/plugin/1208180794570801545/includeaccessibility-annotations?trackingId=6o88RA2ATkWCJlzn7jeJNg%3D%3D)
- [A11y Focus Order Plugin](https://www.figma.com/community/plugin/731310036968334777/a11y-focus-order)

#### Focus Order

Indicate the sequence in which interactive elements should receive focus when navigating with the **Tab** key. This helps to ensure a logical and intuitive flow for keyboard users. 

1. Use the focus order indicators to show the intended ordering of elements when being navigated using a keyboard.
1. Long lists of like elements should be by-passable. For instance, imagine a Teams meeting where user has to make a user as signer. Users can invoke the menu item of that user and using arrow key they can drill down on the required menu item.

:::image type="complex" source="../media/focus-order-accessibility-annotation-wishcart-application.png" alt-text="Screenshot of WishCart application with focus order annotations." lightbox="../media/focus-order-accessibility-annotation-wishcart-application.png":::
   Image of WishCart application with wishcart, delivering to New Delhi, Search field, choose language for shopping, hello sign in accounts &lists, returns &orders and Cart defined as custom component, Search in all categories Drop-down list as parent component and ‘All categories’, ‘Devices’ & ‘fashion’ as its child components. Each section has numerical labels indicating the focus order.
:::image-end:::

:::image type="complex" source="../media/focus-order-accessibility-annotation.png" alt-text="Screenshot of Teach Access homepage with focus order annotations." lightbox="../media/focus-order-accessibility-annotation.png":::
   Image of the Teach Access homepage, with focus order accessibility annotations on two sections labeled "Who We Are" and "What is the accessibility Skills Gap?" Each section has numerical labels indicating the focus order.
:::image-end:::

#### Shortcut Keys

Highlight, add any keyboard shortcuts that are not standard rather a customize one and can be used to perform actions within the design.

:::image type="complex" source="../media/shortcut-keys-accessibility-annotation.png" alt-text="Screenshot showing shortcut keys annotations." lightbox="../media/shortcut-keys-accessibility-annotation.png":::
   Example of accessibility annotations for shortcut keys, with the shortcuts “Ctrl+Shift+M”=Mute “, Ctrl+Shift+E”=Share Content, and. “Ctrl+Shift+H”=Leave Meeting
:::image-end:::

:::image type="complex" source="../media/keyboard-interactions-accessibility-annotations.png" alt-text="Screenshot showing keyboard interactions and shortcuts." lightbox="../media/keyboard-interactions-accessibility-annotations.png":::
   Example of accessibility annotations for keyboard interactions and shortcuts, with the text “Bold” button = Ctrl+B, “Italic” button = Ctrl+I, and “Underline” button = Ctrl+U
:::image-end:::