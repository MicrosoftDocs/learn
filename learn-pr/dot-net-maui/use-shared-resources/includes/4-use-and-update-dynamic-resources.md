In the previous unit, you defined a resource in XAML and used it as a static value. However, there are some cases where **StaticResource** isn't appropriate. Consider the following scenarios:

- Suppose you want to implement color themes that let the user change the look of the app at runtime. The **StaticResource** mark-up extension does the dictionary lookup only once, so it can't update the UI dynamically.

- You store user preferences on a web server and load them when the application starts. The **StaticResource** mark-up extension throws an exception if the key isn't found in the dictionary.

This unit shows you how to handle issues such as these by using dynamic resources.

## How to update resources at runtime

You store resources in a resource dictionary. You can write code to update these resources at runtime. You can even add new resources or remove existing resources.

Consider the following example:

```XML
<ContentPage.Resources>
    <Color x:Key="PanelBackgroundColor">Blue</Color>
</ContentPage.Resources>
```

Suppose you want to change the value of the **PanelBackgroundColor** resource while the application is running. You can add code to the code-behind file for the page, to access the **Resources** property. The following example updates the resource value from the previous XAML example to a different color.

```csharp
this.Resources["PanelBackgroundColor"] = Colors.Green;
```

## What is DynamicResource?

**DynamicResource** is another mark-up extension for looking up resources in a resource dictionary. It's similar to **StaticResource** in that it does a dictionary lookup when the target object is created. But it also listens for changes to the resource in the dictionary. If the resource value in the dictionary changes, **DynamicResource** automatically updates the UI.

**DynamicResource** has an advantage over **StaticResource**. If **DynamicResource** can't find the key in the dictionary, it leaves the property unset. Unlike **StaticResource**, a missing key isn't an error and it doesn't throw an exception.

> [!NOTE]
> The nature of the **DynamicResource** mark-up extension imposes a small performance penalty on your application. Although you can use **DynamicResource** in place of **StaticResource** in your XAML pages, if a resource doesn't change then you should reference it with the **StaticResource** mark-up extension.

To use the updated background color from the earlier example, you can apply the **DynamicResource** in your XAML code like this:

```XML
<ContentPage ...>
    <ContentPage.Resources>
        <Color x:Key="PanelBackgroundColor">Blue</Color>
    </ContentPage.Resources>

    <StackLayout BackgroundColor="{DynamicResource PanelBackgroundColor}">
    ...
    </StackLayout>
</ContentPage>
```

If the value of the **PanelBackgroundColor** resource changes, the **BackgroundColor** value of the **StackLayout** control is updated automatically.
