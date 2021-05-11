Now that you have improved the accessibility of the project data entry and images, it is time to add entry information for the report's and manager's names. You will be using a grid-like system to enter the forenames and surnames. Screen readers attempt to do their best to read back information about controls in the correct order; yet, as user interfaces get more complex, we must remain intentional about how we can support appropriate accessibility ordering.

## Accessibility order for screen reader and keyboard navigation

If an application does not support keyboard accessibility, it can create difficulties to the app's users. You may have experienced something similar when filling out a form online and using your keyboard to move through the data fields. When you press the Tab key, the focus may not always go next to where you expect. We can consider this an error in keyboard accessibility which makes the form and overall app less usable.

The default accessibility order of controls is the same order in which they are listed in XAML, or added to the layout. Furthermore, various layouts may have more factors influencing accessibility order: `StackLayout`'s accessibility order is also based on the `Orientation` and a `Grid`'s accessibility order is also based on the row and column arrangement.


We will now take a look at how to optimize our layouts to be more accessible.
