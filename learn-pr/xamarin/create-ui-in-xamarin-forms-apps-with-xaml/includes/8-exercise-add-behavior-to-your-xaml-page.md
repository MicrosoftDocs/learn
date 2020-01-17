In this exercise, you'll move the phone word logic from the original MainPage source file. You will continue working from the preceding exercise, in which you renamed the **MainPage** source file **OldMainPage**.

This exercise is a continuation of the previous one. Use your existing solution, or begin from the **exercise1** > **final** solution in your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].

## Copy existing code

1. Open the **OldMainPage.cs** file.

2. Copy the following field from that file into your **MainPage.xaml.cs** code-behind file:

    ```csharp
    public class MainPage : ContentPage
    {
        string translatedNumber;
        ...
    }
    ```

3. Copy the following methods from **OldMainPage.cs** to **MainPage.xaml.cs**:

    - `OnTranslate`
    - `OnCall`

    ```csharp
    void OnTranslate(object sender, EventArgs e)
    {
        ...
    }

    async void OnCall(object sender, System.EventArgs e)
    {
        ...
    }
    ```

4. Make sure you have a `using Xamarin.Essentials;` statement at the top of your class to use the dialer abstraction this code uses from the Xamarin.Essentials NuGet package.

## Set EventHandlers

You do a phone word translation by pressing the translate button and then dialing the translated number. Wire up the behavior to the `Button` by using the methods you imported in the preceding step.

1. Open **MainPage.xaml**.

2. Wire up the `Clicked` event in XAML on the translate button to the `OnTranslate` method.

3. Wire up the `Clicked` event in XAML on the call button to the `OnCall` method:

    ```xml
    <!-- Examples of wiring up a Clicked event -->
    <Button x:Name="translateButton" ...
            Clicked="OnTranslate" />
    <Button x:Name="callButton" ...
            Clicked="OnCall" />
    ```

## Using x:Static to use runtime values in XAML

First, create a C# static class to hold your shared values.

1. Add a new source file to the project and name it **SharedResources.cs**.

2. Make the class `static` and remove the constructor if one was created for you. Static classes can't have instance constructors.

    ```csharp
    public static class SharedResources
    {
    }
    ```

3. Create a new `Color` public static property in the `SharedResources` class. Name it `ButtonBkColor` and set the value to `Color.FromRgb(0xff, 0xa5, 0)`.

    > The `Color` class is available in the `Xamarin.Forms` namespace. You'll need to either add a `using` statement or fully qualify the class.

4. Create a second `Color` public static property in the `SharedResources` class. Name it `ButtonTextColor` and set the value to `Color.White`.

    ```csharp
    using Xamarin.Forms;

    public static class SharedResources
    {
        public static Color ButtonBkColor {
            get { return Color.FromRgb(0xff, 0xa5, 0); }
        }

        public static Color ButtonTextColor {
            get { return Color.White; }
        }
    }
    ```

You need to use the `{x:Static}` [markup extension](https://docs.microsoft.com/xamarin/xamarin-forms/xaml/xaml-basics/xaml-markup-extensions) to get the value from the property on each of the operator buttons.

1. Open **MainPage.xaml**.
1. To have access to our static code values, add a namespace to our XAML file. Insert the following `xmlns:local` attribute into the root `ContentPage` element to gain access to the resources under the namespace `local`:

    ```xml
    <ContentPage ...
                 xmlns:local="clr-namespace:Phoneword">
    ```

1. Use the `{x:Static}` markup extension to get the value from the `ButtonBkColor` property in `SharedResources` and assign it as the `Background` property on each of the buttons.

1. You need to define the namespace in XAML to access the properties in `SharedResources`. The exercise solution has it in the namespace `Phoneword`, but check your C# source file to verify that you're using the correct namespace.

1. Use the `{x:Static}` markup extension to get the value from the `ButtonTextColor` property in `SharedResources`. Assign it as the `TextColor` property on each of the buttons:

    ```xml
    // An example of adding the Background and TextColor colors to a button
    <ContentPage ...
                 xmlns:local="clr-namespace:Phoneword">
        ...
        <Button x:Name="translateButton" Text="Translate" Clicked="OnTranslate"
                TextColor="{x:Static local:SharedResources.ButtonTextColor}"
                BackgroundColor="{x:Static local:SharedResources.ButtonBkColor}" />
        ...
    </ContentPage>
    ```

## Add platform-specific customization

If you run the app on iOS, you'll notice it obscures the status bar. To correct this behavior, adjust the `Padding` property of `MainPage`. You need this change only on iOS; it's not required for Android.

1. Use the `OnPlatform<T>` tag to set the `ContentPage.Padding` property to a valid `Thickness`.

    Set the `<T>` of `OnPlatform<T>` to a `Thickness` value using the `x:TypeArguments` property.

    You can set the iOS specific value by setting an `On` element with a `Platform="iOS"` attribute. (Android is `Platform="Android"` and there are [several others pre-defined for us](https://github.com/xamarin/Xamarin.Forms/blob/master/Xamarin.Forms.Core/Device.cs#L14)). If you don't need to change the value (that is, you want a default value), then you don't need to supply that platform's `On` override element.

    ```xml
    <ContentPage.Padding>
        <OnPlatform x:TypeArguments="Thickness">
            <On Platform="iOS">0,40,0,0</On>
        </OnPlatform>
    </ContentPage.Padding>
    ```

2. Run the app on iOS to see the content move down from the status bar and any notch, if your chosen simulator has one.

    > [!NOTE]
    > This is a simple example of how to add platform-specific properties. To work around the status bar and device notch in iOS, specifically, the [iOS safe area system](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/platform/ios/page-safe-area-layout) is a better choice to use throughout your app.

3. Run the app on Android to verify that it doesn't include the padding.

In this exercise, you've added all the code-behind logic for the **Phoneword** app and wired it up to the views defined in XAML. If you look through the code, you can see it's primarily oriented around the behavior of the app and less concerned with the UI structure. The main benefit of using XAML to define our pages is that it allows us to focus the code portion of the app on the logic.

You also used a few built-in markup extensions to combine resources and specify platform-specific values for the UI to customize it per-platform.

You can view the completed solution in the **exercise2** > **final** folder of your copy of the cloned or downloaded [!INCLUDE [module-exercise-repo](module-exercise-repo.md)].
