[!include[](../../includes/xamarin-not-maintained.md)]

Now that you've improved the accessibility of the project data entry and images, it's time to add entry information for the user's and manager's names. You'll use a grid-like system to enter the forenames and surnames. 

Screen readers try their best to read information about controls in the correct order. As user interfaces get more complex, developers must remain intentional about how to support an appropriate accessibility order.

## Accessibility order for screen reader and keyboard navigation

If an application doesn't support keyboard accessibility, it can create difficulties for the app's users. You might have experienced something similar when filling out a form online and using your keyboard to move through the data fields. When you press the Tab key, the focus might not always move to where you expect. You can consider this an error in keyboard accessibility that makes the form and overall app less usable.

The default accessibility order of controls is the same order in which they're listed in XAML or added to the layout. Various layouts might have more factors that influence accessibility order. For example, the accessibility order of `StackLayout` is also based on `Orientation`. The accessibility order of `Grid` is also based on the row and column arrangement.

We'll now look at how to optimize our layouts to be more accessible.
