The design for the app you will be creating is a form used to collect project information. It includes a visual image for the company, an entry for the project name, and a button to submit the project to the database.

## Screen reader narration

As mentioned in the previous section, each operating system has its own screen readers with their own unique behaviors and configurations. Xamarin.Forms has properties that can be used to set the underlying native APIs for accessibility. Most screen readers will automatically read any text associated with a control that receives accessibility focus. This means that elements such as a `Label` or `Button` that have the `Text` property set will be accessible for the user. However, an `ImageButton`, `ActivityIndicator`, `Image`, and others may not be in the accessibility tree since no text is associated with them. This is where Xamarin.Forms accessibility features come in.

## Automation properties

Xamarin.Forms accessibility properties provide additional information about which elements should receive accessibility focus and what text should be read back to the user. There are four different properties that can enhance the screen reader experience. These are called `AutomationProperties` and are attached properties that can be added to any element: 
- `AutomationProperties.IsInAccessibleTree` indicates whether or not the element is accessible by screen readers.
- `AutomationProperties.Name` is a short description that serves as a speakable identifier for the element.
- `AutomationProperties.HelpText` is a longer description of the element, which can be thought of as tooltip text associated with the element. 
- `AutomationProperties.LabeledBy` allows another element to define the accessibility text for the current element. 

## IsInAccessibleTree

This attached property is a `boolean` that tells the operating system if the element should be accessible and visible to screen readers. It can be set on an element in XAML:

```xaml
<Entry AutomationProperties.IsInAccessibleTree="true" />
```

Or in the code-behind:

```csharp
var entry = new Entry();
AutomationProperties.SetIsInAccessibleTree(entry, true);
```

## Name

This attached property is a short descriptive text string that a screen reader uses to announce an element. It should be set for elements that have a meaning that is important for understanding the content or interacting with the user interface. It can be set on an element in XAML:

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

## HelpText

This attached property is a longer description of the element that can be thought of as a tooltip for the element. It can be set on an element in XAML:

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
> Screen readers may differ in the order of how they read back the `HelpText`, among other accessible information.

## LabeledBy

This attached property allows another element to specify information for accessibility for the current element. A common use case would be where a `Label` is placed above an `Entry` to represent what the user needs to enter. This can be set on an element in the XAML:

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
> The `AutomationProperties.LabeledByProperty` is not yet supported on iOS and the `AutomationProperties.NameProperty` must be used.

Now that you have an understanding of the available automation properties that Xamarin.Forms provides, we can start to implement some of them in our project.
