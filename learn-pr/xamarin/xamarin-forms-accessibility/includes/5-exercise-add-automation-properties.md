Let's start implementing the design for the app by creating a project and specifying some user interface for entering the project name.

## Create a Xamarin app

::: zone pivot="vsstudio"
1. Open Visual Studio 2019.
1. Select **Create a new project**.
1. Select **Mobile** from the **Project type** dropdown list.
1. Select the **Mobile App (Xamarin.Forms)** template, and then select **Next**.
1. Enter **AccessibleApp** as the project name, and then select **Create**.
1. Select the **Blank** template. Ensure that Android and iOS are both selected, and then select **OK**.
::: zone-end

::: zone pivot="vsstudiomac"
1. Open Visual Studio for Mac.
1. Select **New Project**.
1. Select **Multiplatform** > **App** > **Blank Forms App**, and then select **Next**.
1. Enter **AccessibleApp** as the app name, and then select **Next**.
1. Select **Create**.
::: zone-end

## Create the data entry form

To create a simple form, use the following code. It includes `Label`, `Image`, `Entry`, and `Button` UI controls.

```xaml
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage
    x:Class="AccessibleApp.MainPage"
    xmlns="http://xamarin.com/schemas/2014/forms"
    xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml">

    <StackLayout Padding="20">
        <Label Text="Please submit information for the project." />
        <Image
            HeightRequest="100"
            HorizontalOptions="Center"
            Source="https://aka.ms/dotnetbot"
            WidthRequest="100" />
        <Label x:Name="LabelName" Text="Project name" />
        <Entry />

        <!-- User and Manager Information -->

        <Button Text="Submit" />
    </StackLayout>
    
</ContentPage>
```

## Run the application

Run the application with the screen reader activated on the operating system of your choice. Notice that on some platforms, when you open the application, the screen reader will read all elements. Use touch gestures or a keyboard to move through the items on the screen. 

As you use the app, keep in mind:

- `Image` does not have any information about what it is.
- `Entry` reads back generic information.
- `Button` reads the text of **Submit** out loud.

## Improve image accessibility

To have the screen reader see `Image` as an accessible element, you must set the `AutomationProperties.IsInAccessibleTree` property to `true`.  Add the following property to `Image`:

   ```xaml
   AutomationProperties.IsInAccessibleTree="true"
   ```

By setting the `AutomationProperties.Name` property, you can provide more information about what the image is when the screen reader gives it focus. Add the following property to `Image`:

   ```xaml    
   AutomationProperties.Name="Image of dot net bot"
   ```

When you run the application again, you'll see that when the image gains focus, "Image of .NET Bot" is read out loud. Notice that we spelled out "dot net bot" to assist the screen reader with pronunciation. When you're setting text that will be read, be aware of how the screen reader will interpret it. 

For example, "a11y" is an abbreviation for accessibility, but a screen reader would read it as "ay eleven why." Setting the label simply to "accessibility" would alleviate the need for more automation properties.

## Improve entry accessibility

`Entry` currently has no information about what the user should enter. `Label` is directly above `Entry` and provides the descriptor. You can use the `AutomationProperties.LabeledBy` property to enable the screen reader to read `Label` text out loud. 


1. Add the following properties to `Entry`:

   ```xaml
   AutomationProperties.LabeledBy="{x:Reference LabelName}"
   AutomationProperties.Name="{OnPlatform iOS='Project name'}"
   ```

When you run the application again, you hear "Project name" read out loud when `Entry` is in focus.

> [!NOTE]
> We set `AutomationProperties.Name` on iOS because `AutomationProperties.LabeledByProperty` is not currently supported. You might consider setting only `AutomationProperties.Name`, based on your use case.

## Improve button descriptors

When `Button` is in focus, the screen reader reads "Submit button" out loud. You can use the `AutomationProperties.HelpText` property  to provide more context for what will happen when the user selects the button. Add the following property to `Button`:

```xaml
AutomationProperties.HelpText="Submits project information to backend"
```

When you run the application again, you'll hear an improved description of the UI element, along with context for what will happen when it's selected.

You've now explored the built-in automation properties of Xamarin.Forms that enable developers to add more context for on-screen elements that are accessible to screen readers. Next, you'll explore accessible content ordering to provide a better experience when a user moves through elements.
