Let's start implementing the design for the app by creating a new project and specifying some user interface for entering the project name.

## Create a new solution

Create a new Xamarin app:

::: zone pivot="vsstudio"
1. Open Visual Studio 2019.
1. Select **Create a new project**.
1. Select **Mobile** from the **Project type** drop-down.
1. Select the **Mobile App (Xamarin.Forms)** template and select **Next**.
1. Enter **AccessibleApp** as the project name and select **Create**.
1. Select the Blank template. Ensure Android and iOS are both selected, and select OK.
::: zone-end

::: zone pivot="vsstudiomac"
1. Open Visual Studio for Mac
1. Select **New Project**
1. Select **Multiplatform** > **App** > **Blank Forms App** and select **Next**
1. Enter **AccessibleApp** as the app name, and select **Next**
1. Select **Create**
::: zone-end

## Create the data entry form

To create a simple form, we will use several UI controls including `Label`, `Image`, `Entry`, and `Button`.

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

        <!-- Report and Manager Information -->

        <Button Text="Submit" />
    </StackLayout>
    
</ContentPage>
```

## Run the application

Run the application with the screen reader activated on the operating system of your choice. Notice that on some platforms, when you launch the application, all elements will be read by the screen reader. Use touch gestures or a keyboard to navigate through the items on the screen. 

Note:

- `Image` does not have any information as to what it is.
- `Entry` reads back generic information.
- `Button` reads the text of **Submit** out loud.

## Image accessibility

To have the screen reader see the `Image` as an accessible element we must set the `AutomationProperties.IsInAccessibleTree` property to `true`.  Add the following property to the `Image`:

   ```xaml
   AutomationProperties.IsInAccessibleTree="true"
   ```

We can provide additional information as to what the image is when it becomes focused by the screen reader by setting the `AutomationProperties.Name` property. Add the following property to the `Image`:

   ```xaml    
   AutomationProperties.Name="Image of dot net bot"
   ```

When you run the application again you will see that when the image gains focus, "Image of .NET Bot" is read out loud. Notice that we spelled out "dot net bot" to assist the screen reader with proper pronunciation. When setting text that will be read it is best practice to be aware of how the screen reader will read back text. For example, "a11y" which is an abbreviation for accessibility would be read back as "ay eleven why". Setting the label simply to "accessibility" would alleviate the need for any additional automation properties.

## Improve Entry accessibility with LabelBy

The `Entry` currently has no information about what the user should enter. There is a `Label` directly above the `Entry`, which provides the descriptor and can be used as text that the screen reader can read out loud by using the `AutomationProperties.LabeledBy` property. 


1. Add the following properties to the `Entry`:

   ```xaml
   AutomationProperties.LabeledBy="{x:Reference LabelName}"
   AutomationProperties.Name="{OnPlatform iOS='Project name'}"
   ```

2. Setting accessible properties on the `Entry` means that the _Project name_ `Label` doesn't need to be in the accessibility tree. Set the following property on the _Project name_ `Label`:

   ```xaml
   AutomationProperties.IsInAccessibleTree="False"
   ```

When you run the application again, you hear "Project name" read out loud when the `Entry` is in focus.

> [!NOTE]
> We set the `AutomationProperties.Name` on iOS because `AutomationProperties.LabeledByProperty` is not currently supported. You may consider only setting the `AutomationProperties.Name` based on your use case.

## Improve Button descriptors

When the `Button` is in focus, "Submit button" is read out loud by the screen reader. We can provide more context as to what will happen when the user taps the button, by setting the `AutomationProperties.HelpText` property. Add the following property to the `Button`:

```xaml
AutomationProperties.HelpText="Submits project information to backend"
```

When you run the application again, you will hear an improved description of the UI element as well as context for what will happen when it is pressed.

We have now explored the built-in automation properties of Xamarin.Forms that enable developers to add more context for on-screen elements that are accessible to screen readers. Next, we will explore accessible content ordering to provide a better experience when a user navigates through elements.
