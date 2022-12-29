[!include[](../../includes/xamarin-not-maintained.md)]

The design for the app you'll create is a form that's used to collect project information. It includes an image for the company, an entry for the project name, and a button to submit the project to the database.

## Screen reader narration

As mentioned in the previous unit, each operating system has its own screen readers with their own unique behaviors and configurations. Xamarin.Forms has properties that can be used to set the underlying native APIs for accessibility. Most screen readers will automatically read any text associated with a control that receives accessibility focus. This means that elements such as `Label` or `Button` that have the `Text` property set will be accessible for the user. 

However, `ImageButton`, `ActivityIndicator`, `Image`, and others might not be in the accessibility tree because no text is associated with them. This is where Xamarin.Forms accessibility features come in.

## Automation properties

Xamarin.Forms accessibility properties provide information about which elements should receive accessibility focus and what text should be read back to the user. The following four properties can enhance the screen reader experience. These are called `AutomationProperties` and are attached properties that can be added to any element. 

### IsInAccessibleTree

`IsInAccessibleTree` is a Boolean that tells the operating system if the element should be accessible and visible to screen readers. You can set it on an element in XAML:

```xaml
<Entry AutomationProperties.IsInAccessibleTree="true" />
```

Or in the code-behind:

```csharp
var entry = new Entry();
AutomationProperties.SetIsInAccessibleTree(entry, true);
```

### Name

`Name` is a short descriptive text string that a screen reader uses to announce an element. It should be set for elements that have a meaning that's important for understanding the content or interacting with the user interface. You can set it on an element in XAML:

```xaml
<ActivityIndicator AutomationProperties.IsInAccessibleTree="true"
                   AutomationProperties.Name="Progress indicator" />
```

Or in the code-behind:
	
```csharp
var activityIndicator = new ActivityIndicator();
AutomationProperties.SetIsInAccessibleTree(activityIndicator, true);
AutomationProperties.SetName(activityIndicator, "Progress indicator");
```

### HelpText

`HelpText` is a longer description of the element. Think of it as a tooltip for the element. You can set it on an element in XAML:

```xaml
<Button Text="Toggle"
        AutomationProperties.IsInAccessibleTree="true"
        AutomationProperties.HelpText="Toggles the activity indicator" />
```

Or in the code-behind:

```csharp
var button = new Button { Text = "Toggle" };
AutomationProperties.SetIsInAccessibleTree(button, true);
AutomationProperties.SetHelpText(button, "Toggles the activity indicator");
```

> [!NOTE]
> Screen readers might differ in the order of how they read back the `HelpText` description, among other accessible information.

### LabeledBy

`LabeledBy` allows another element to define accessibility text for the current element. A common use case is `Label` placed above `Entry` to represent what the user needs to enter. You can set it on an element in the XAML:

```xaml
<Label x:Name="label" Text="Enter your name: " />
<Entry AutomationProperties.IsInAccessibleTree="true"
       AutomationProperties.LabeledBy="{x:Reference label}" />
```

Or in the code-behind:

```csharp
var nameLabel = new Label { Text = "Enter your name: " };
var entry = new Entry();
AutomationProperties.SetIsInAccessibleTree(entry, true);
AutomationProperties.SetLabeledBy(entry, nameLabel);
```

> [!NOTE]
> `AutomationProperties.LabeledByProperty` is not yet supported on iOS. You must use `AutomationProperties.NameProperty`.

Now that you understand of the available automation properties that Xamarin.Forms provides, you can start to implement some of them in your project.
