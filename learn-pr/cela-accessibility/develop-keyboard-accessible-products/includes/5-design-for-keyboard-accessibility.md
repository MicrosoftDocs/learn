When designing an application, it's important to consider how it will function with a keyboard, just as it would with a mouse. 

- Start by determining the hierarchy and order of elements and decide which keys will be used for navigation and actions.
- Specify visual indicators for keyboard focus, such as changing the fill color or adding outlines. This ensures a consistent and cohesive experience across different themes, including high-contrast mode and compliance with contrast requirements.
- Decide if the keyboard focus should stay within a container while navigating. For example, pressing the **Tab** key should cycle through elements within a specific section without moving to other areas of the app. Also, specify where the focus should go after certain events, like expanding and dismissing a dropdown menu or if an element disappears. 
- Determine whether users can navigate to disabled controls. For instance, in some dialogs, you can't navigate to disabled controls until they are enabled. Additionally, specify any keyboard shortcuts to improve efficiency. 
- Only include interactive elements in the keyboard navigation. For example, navigating to a description area should not trigger any actions. 
- To make keyboard shortcuts discoverable, add documentation within the app, such as tooltips that show shortcuts when hovering and Keyboard focus over buttons, and include a section on keyboard navigation in the online help. 

By planning these details before implementation, you can create a more accessible and user-friendly design.

## Resources

- [Guidelines for Keyboard User Interface Design](/previous-versions/windows/desktop/dnacc/guidelines-for-keyboard-user-interface-design)
- [Windows Keyboard Shortcuts for Accessibility](https://support.microsoft.com/en-us/windows/windows-keyboard-shortcuts-for-accessibility-021bcb62-45c8-e4ef-1e4f-41b8c1fc87fd)