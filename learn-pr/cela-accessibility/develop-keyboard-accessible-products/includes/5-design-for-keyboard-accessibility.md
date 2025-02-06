When designing an application, it's important to consider how it will function with a keyboard, just as it would with a mouse. 

Start by determining the hierarchy and order of elements and decide which keys will be used for navigation and actions.

Specify visual indicators for keyboard focus, such as changing the fill color or adding outlines. This ensures a consistent and cohesive experience across different themes, including high-contrast mode and compliance with contrast requirements.

:::image type="complex" source="../media/keyboard-focus-visual-indicators.png" alt-text="Screenshot showing focus indicators for buttons." lightbox="../media/keyboard-focus-visual-indicators.png":::
   The image consists of two sections. The top section displays three buttons—Simplified Ribbon, Go Premium, and Sign Out—in their normal state. The bottom section shows the same buttons in their focused state, highlighting focus indicators: dots, fill color, and outlines.
:::image-end:::

Decide if the keyboard focus should stay within a container while navigating. For example, pressing the **Tab** key should cycle through elements within a specific section without moving to other areas of the app. Also, specify where the focus should go after certain events, like expanding and dismissing a dropdown menu or if an element disappears. 

Determine whether users can navigate to disabled controls. For instance, in some dialogs, you can't navigate to disabled controls until they are enabled. Additionally, specify any keyboard shortcuts to improve efficiency. 

Only include interactive elements in the keyboard navigation. For example, navigating to a description area should not trigger any actions. 

:::image type="complex" source="../media/focus-order-accessibility-annotation-teams-meeting.png" alt-text="Screenshot of Teams meeting with focus order annotations." lightbox="../media/focus-order-accessibility-annotation-teams-meeting.png":::
   Focus Order Accessibility Annotation Teams meeting Image Description: Image of Teams meeting with Gallery and People tile defined as custom component, Overflow as library component, Drop-down menu as parent component and make me a signer is one of the child components. Each section has numerical labels indicating the focus order.
:::image-end:::

:::image type="complex" source="../media/focus-order-accessibility-annotation.png" alt-text="Screenshot of Teach Access homepage with focus order annotations." lightbox="../media/focus-order-accessibility-annotation.png":::
   Image of the Teach Access homepage, with focus order accessibility annotations on two sections labeled "Who We Are" and "What is the accessibility Skills Gap?" Each section has numerical labels indicating the focus order.
:::image-end:::

To make keyboard shortcuts discoverable, add documentation within the app, such as tooltips that show shortcuts when hovering and Keyboard focus over buttons, and include a section on keyboard navigation in the online help. 

:::image type="complex" source="../media/shortcut-keys-accessibility-annotation.png" alt-text="Screenshot showing shortcut keys annotations." lightbox="../media/shortcut-keys-accessibility-annotation.png":::
   Example of accessibility annotations for shortcut keys, with the shortcuts “Ctrl+Shift+M”=Mute “, Ctrl+Shift+E”=Share Content, and. “Ctrl+Shift+H”=Leave Meeting
:::image-end:::

:::image type="complex" source="../media/keyboard-interactions-accessibility-annotations.png" alt-text="Screenshot showing keyboard interactions and shortcuts." lightbox="../media/keyboard-interactions-accessibility-annotations.png":::
   Example of accessibility annotations for keyboard interactions and shortcuts, with the text “Bold” button = Ctrl+B, “Italic” button = Ctrl+I, and “Underline” button = Ctrl+U
:::image-end:::

By planning these details before implementation, you can create a more accessible and user-friendly design.

## Resources

[Guidelines for Keyboard User Interface Design](/previous-versions/windows/desktop/dnacc/guidelines-for-keyboard-user-interface-design)

[Windows Keyboard Shortcuts for Accessibility](https://support.microsoft.com/en-us/windows/windows-keyboard-shortcuts-for-accessibility-021bcb62-45c8-e4ef-1e4f-41b8c1fc87fd)<br>