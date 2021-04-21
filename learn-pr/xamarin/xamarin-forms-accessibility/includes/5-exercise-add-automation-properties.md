Let's start implementing the design for the app by creating a new project and specifying some user interface for entering the project name.

## Create a new solution

Create a new Xamarin app:

::: zone pivot="vstudio"
1. Open Visual Studio 2019.
1. Select **Create a new project**.
1. Select **Mobile** from the **Project type** drop-down.
1. Select the **Mobile App (Xamarin.Forms)** template and click **Next**.
1. Enter **AccessibleApp** as the project name and click **Create**.
1. Select the Blank template. Ensure Android and iOS are both selected, and click OK.
::: zone-end

::: zone pivot="vstudiomac"
1. Open Visual Studio 2019 for Mac
1. Select **New Project**
1. Select **Multiplatform** > **App** > **Blank Forms App** and click Next
1. Enter **AccessibleApp** as the app name, and click **Next**
1. Click **Create**
::: zone-end

## Create the data entry form

To create a simple for we will use several UI elements including `Label`, `Image`, `Entry`, and a `Button`.

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
        <Label  x:Name="LabelName" Text="Project name" />
        <Entry />

        <!-- Report and Manager Information -->

        <Button Text="Submit" />
    </StackLayout>

</ContentPage>
```

## Run the application

Run the application with the screen reader enabled on the operating system of your choice. Notice that on some platforms when you launch the application all elements will be read by the screen reader. Use gestures or a keyboard to tab through the items on the screen. Note the following:

- `Image` does have any information as to what it is
- `Entry` reads back a generic informatin
- `Button` reads the text of **Submit** outloud.

## Image accessibility

To have the screen reader see the `Image` as a visible element we must set the `AutomationProperties.IsInAccessibleTree` property to `true`. 

1. Add the following property to the `Image`:

```xaml
AutomationProperties.IsInAccessibleTree="true"
```
We can provide additional information as to what the image is when it becomes focused by the screen reader by setting the `AutomationProperties.Name` property. Add the following property to the `Image`:

```xaml    
AutomationProperties.Name="Image of .NET Bot"
```

When you run the application again you will see that when the image gains focus, "Image of .NET Bot" is read outloud.

## Entry accessibility with LabelBy

The `Entry` currently has no information about what the user should enter. There is a `Label` directly above the `Entry` which provides the descriptor and can be used as text that the screen reader can read out loud by using the `AutomationProperties.LabeledBy` property. 


1. Add the following property to the `Entry`:

```xaml
AutomationProperties.LabeledBy="{x:Reference LabelName}"
```

When you run the application again you hear "Project name" read outloud when the `Entry` is in focus.

## Improved Button descriptors

When the `Button` is in focus "Submit button" is read outloud by the screen reader. We can provide additional context as to what will happen when the user taps the button by setting the `AutomationProperties.HelpText` property. 

1. Add the following properties to the `Button`:

```xaml
AutomationProperties.Name="Submit Button"
AutomationProperties.HelpText="Tap to submit project information to backend"
```

When you run the application again you will hear an improved description of the UI element and what will happen when it is pressed.

We have now explored the built-in automation properties of Xamarin.Forms to add additional context for elements on the screen that will be read outloud by screen readers. Next, we will explore tab ordering to provide a better experience when a user navigates through elements.



