Now that you have improved the accessibility of the project data entry and images, it is time to add entry information for the report's and manager's names. You will be using a grid like system to enter the forename and surname. Screen readers attempt to do their best to read back information about controls in the correct order, and as user interfaces get more complex, we must remain intentional about how we can support appropriate accessibility ordering.

## Accessibility order for screen reader and keyboard navigation

If an application does not provide appropriate keyboard access, it can create difficulty when using a screen reader. You may have experienced this when filling out a form online when you use the Tab key on your keyboard to move through the data fields. When you press the Tab key and the focus is not where you expect, this is an error in keyboard accessibility and makes use of the form or app more difficult.

By default, the accessibility order of controls is the same order in which they are listed in XAML, or programmatically added to a child collection.


We will now take a look at how to optimize our layouts to be more accessible.

