The design of your app is a form that is used to collect project information. It has a visual image for the company, an entry for the project name, and a button to submit the project to the database.

## Screen reader narration

As mentioned in the previous section, each operating system has its own screen readers with their own unique behaviors and configurations. Xamarin.Forms has properties that can be used to set the underlying native APIs for accessibility. Most screen readers will automatically read any text associated with a control when it receives accessibility focus. This means that elements such as a `Label` or `Button` with the `Text` property set will be accessible for the user. However, an `ImageButton`, `ActivityIndicator`, `Image`, and others may not be in the accessibility tree since no text is associated with them. This is where Xamarin.Forms automation properties come in handy to help provide additional information about which elements should receive focus and what text should be read back to the user.

## Automation Properties

Xamarin.Forms provides four different properties that can enhance the screen reader for the user interface that displayed to the user. These are called `AutomationProperties` and are attached properties that can be added to any element: 
- `AutomationProperties.IsInAccessibleTree` - indicates whether the element is reachable by screen readers.
- `AutomationProperties.Name` - a short description of the element that serves as a speakable identifier for the element. 
- `AutomationProperties.HelpText` - a longer description of the element, which can be thought of as tooltip text associated with the element. 
- `AutomationProperties.LabeledBy` - allows another element to define accessibility information for the current element. 

Screen readers also read different accessibility values. For example, on an `Entry`:

- VoiceOver will read the `Placeholder` value of the `Entry`, followed by instructions for using the control.
- TalkBack will read the `Placeholder` value of the `Entry`, followed by the `AutomationProperties.HelpText` value, followed by instructions for using the control.
- Narrator will read the `AutomationProperties.LabeledBy` value of the Entry, followed by instructions on using the control.

## IsInAccessibleTree

This attached property is a `boolean` that tells the operating system if the element should be accessible and visible to screen readers. It can be set on an element in XAML:

```xaml
<Entry AutomationProperties.IsInAccessibleTree="true" />
```
Or it can be set in code directly:

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

Or, it can be set in code directly:
	
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

Or, it can be set in code directly:

```csharp
var button = new Button { Text = "Toggle" };
AutomationProperties.SetIsInAccessibleTree(button, true);
AutomationProperties.SetHelpText(button, "Toggles the activity indicator");
```

> Note: Each platform may have a different order of how the `HelpText` is read back to the user when using a screen reader.

## LabeledBy

This attached property allows another element to specify information for accessibility for the current element. A common use case would be where a `Label` is placed above an `Entry` to represent what the user needs to enter. This can be set on an element in the XAML:

```xaml
<Label x:Name="label" Text="Enter your name: " />
<Entry AutomationProperties.IsInAccessibleTree="true"
    AutomationProperties.LabeledBy="{x:Reference label}" />
```

Or, it can be set in code directly:

```csharp
var nameLabel = new Label { Text = "Enter your name: " };
var entry = new Entry();
AutomationProperties.SetIsInAccessibleTree(entry, true);
AutomationProperties.SetLabeledBy(entry, nameLabel);
```

> Note: The `AutomationProperties.LabeledByProperty` is not yet supported on iOS and the `AutomationProperties.NameProperty` must be used.

Now that you have an understanding of the available automation properties that Xamarin.Forms provides we can start to implement some of them in our project.
