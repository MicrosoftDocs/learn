Now you have improved the accessibility of the project data entry and images, it is now time to add entry information for the report and managers name. This will require a grid like system to enter the forename and surname. Screen readers attempt to do their best to read back information about controls in the correct order, however as user interfaces get more complex we can provide additional context by setting properties to help the screen reader.

## Keyboard accessibility

If an application does not provide appropriate keyboard access it can create difficulty when using a screen reader. You may have experienced this when filling out a form online when you use the Tab key on your keyboard to move through the data fields. When you press the Tab key and the focus is not where you expect, this is an error in keyboard accessibility and makes use of the form or app more difficult.

By default, the tab order of controls is the same order in which they are listed in XAML, or programmatically added to a child collection.

## TabIndex

Specifying a tab order for controls enables keyboard navigation, prepares application pages to receive input in a particular order, and permits screen readers to read focusable elements to the user. Xamarin.Forms provides a property on the `VisualElement` based controls called `TabIndex` that enables us to property set the order in which the screen reader will read back the element. The `TabIndex` is an `int` that follow these rules: 

- VisualElement instances with a TabIndex equal to 0 are added to the tab order based on their declaration order in XAML or child collections.
- VisualElement instances with a TabIndex greater than 0 are added to the tab order based on their TabIndex value.
- VisualElement instances with a TabIndex less than 0 are added to the tab order and appear before any zero value.
- Conflicts on a TabIndex are resolved by declaration order.

## Excluding controls

Sometimes you may want to exclude a control from the tab order. The `IsTabStop` property can be set to `false` to remove it from the tab-navigation infrastructure.

## Supported controls

Many controls in Xamarin.Forms support both `TabIndex` and `IsTabStop` properties including:

- Button
- DatePicker
- Editor
- Entry
- NavigationPage
- Picker
- ProgressBar
- SearchBar
- Slider
- Stepper
- Switch
- TabbedPage
- TimePicker

We will now take a look at how to use these together with the automation properties from the last section.


