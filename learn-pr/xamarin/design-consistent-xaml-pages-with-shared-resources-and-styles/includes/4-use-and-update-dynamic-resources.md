In the previous unit, you defined a resource in XAML and used it as a static value. There are some cases where `StaticResource` isn't sufficient:

* You want to implement color themes that let the user change the look of the app at runtime. `StaticResource` does the dictionary lookup only once, so it can't update the UI dynamically.

* You store user preferences on a web server and load them when the application starts. `StaticResource` throws an exception if the key isn't found in the dictionary.

This unit shows you how to deal with both of these issues.

## How to update resources at runtime

Your resources are stored in a dictionary. If you can access the dictionary, you can write code to update those values at runtime. You can even add new resources or remove existing resources.

Recall that your `ResourceDictionary` object is stored in the `Resources` property of your page. The following code shows a typical case of a dictionary defined in XAML.

```xml
<Page.Resources>
    <Color x:Key="PanelBackgroundColor">Blue</Color>
</Page.Resources>
```

Suppose you want to change the value of the `PanelBackgroundColor` resource while the application is running. You'd write code in your page's code-behind file to access the `Resources` property. The following example shows how you'd update the resource value to a different color.

```csharp
this.Resources["PanelBackgroundColor"] = Color.Green;
```

## What is DynamicResource?

`DynamicResource` is a markup extension for looking up resources in a resource dictionary. It's similar to `StaticResource` in that it does a dictionary lookup when the target object is created. But it also listens for changes to the resource in the dictionary. If the resource value in the dictionary changes, `DynamicResource` automatically updates the UI.

`DynamicResource` has another advantage over `StaticResource`. If `DynamicResource` can't find the key in the dictionary, it leaves the property unset. Unlike `StaticResource`, a missing key isn't an error and it doesn't throw an exception.

Let's say you want to use the updated background color from the earlier example. Your definition will look like this XAML:

```xml
<ContentPage ...>
    <Page.Resources>
        <Color x:Key="PanelBackgroundColor">Blue</Color>
    </Page.Resources>

    <StackLayout BackgroundColor="{DynamicResource PanelBackgroundColor}">
    ...
    </StackLayout>
</ContentPage>
```

If the value of the `PanelBackgroundColor` resource changes, the `BackgroundColor` value of `StackLayout` will be updated automatically.