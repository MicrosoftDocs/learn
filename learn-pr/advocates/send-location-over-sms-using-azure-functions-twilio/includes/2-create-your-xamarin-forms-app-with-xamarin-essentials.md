The application you're building is a cross-platform mobile app that talks to the Azure Functions to share your location. In this unit, you'll create a blank mobile app using Visual Studio and install a NuGet package that has an API for getting the user's location.

To complete the steps in this unit, you need Xamarin.Forms cross-platform UI toolkit and the Universal Windows Platform Development workload installed in your Visual Studio. If you don't have this already, visit [installing Xamarin](/xamarin/get-started/installation/?tabs=windows).

## Create the Xamarin.Forms project

1. From Visual Studio, select *File > New > Project...*.

1. Use the search bar to find *Mobile App (Xamarin.Forms)*, choose the item, and select **Next**.

1. Name the solution "ImHere".

1. Choose an appropriate location for the solution.

1. Select **Create**.

    :::image type="content" source="../media/2-new-solution-dialog.png" alt-text="Screenshot that shows the New Solution dialog.":::

1. From the **New Mobile App** dialog, select the *Blank App* template.

1. For this module you'll build a UWP app, so uncheck iOS and Android and leave Windows UWP checked.

1. Select **Create**.

    :::image type="content" source="../media/2-configure-solution-dialog.png" alt-text="Screenshot that shows how to configure the new solution.":::

Visual Studio will create two projects for you

- UWP app named `ImHere.UWP`
- .NET Standard library named `ImHere`

Xamarin.Forms apps are made up of two parts
    - one or more platform-specific app projects, and
    - one (or more) .NET Standard libraries.

The platform-specific app projects contain the platform-specific code needed to run an app on the relevant platform. These projects then launch a Xamarin.Forms app that is defined in a cross-platform .NET Standard library. You build your app in cross-platform code and, at runtime, any user interfaces you create are translated into the relevant platform-specific UI components.

## Adding Xamarin.Essentials

The UWP, Android, and iOS platforms provide numerous similar capabilities that take advantage of the operating system and hardware. Despite these similarities, the APIs are very different. Using these APIs from cross-platform code requires writing platform-specific code in your app projects that you expose to your .NET Standard libraries. [Xamarin.Essentials](/xamarin/essentials/?azure-portal=true) is a NuGet package that provides a cross-platform abstraction over a number of these APIs so that you don't need to write platform-specific code. This includes the geolocation APIs that you'll use in your app to get the user's location.

1. Right-click on the `ImHere` solution (the top level solution, not the `ImHere` .NET Standard project) in the Visual Studio Solution Explorer and select *Manage NuGet Packages for Solution...*.

1. Select the **Browse** tab and search for "Xamarin.Essentials".

    > [!TIP]
    > If you do not see the Xamarin.Essentials NuGet package, double check that *include prelease* is checked.

1. Select the **Xamarin.Essentials** NuGet package.

1. Check all your projects in the project list on the right-hand side.

1. Select the **Install** button to install the NuGet package. You'll need to accept the license to continue.

    :::image type="content" source="../media/2-add-essentials-nuget.png" alt-text="Screenshot that shows how to add the Xamarin dot Essentials New Get package.":::

## Building and running the app

1. Right-click on the `ImHere.UWP` project in Solution Explorer and select *Set as StartUp project*.

1. Set the build configuration to **Debug**, the platform to **x86**, and the device to run on to **Local Machine**.

    :::image type="content" source="../media/2-debug-configuration.png" alt-text="Screenshot that shows how to set the Debug x86 configuration to run on the local device.":::

1. Start debugging the app.

    :::image type="content" source="../media/2-debuging-app.png" alt-text="Screenshot that shows the app running.":::

## Summary

In this unit, you created a new Xamarin.Forms cross-platform mobile app and added the Xamarin.Essentials NuGet package. Next, you'll learn how to build up the mobile app UI and logic.
