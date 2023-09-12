In this exercise, you'll construct the UI for the phone dialer app and implement the logic behind this UI.

You'll build a UI that takes advantage of the UI capabilities of .NET MAUI and the .NET MAUI Essentials package to dial the phone.

The app will let the user type text into an input field, and will translate that text to numeric digits. It will use the letters that show up on a telephone keypad as the basis for translation. For example, the letters **cab** translate to **222** because the digit **2** has all three letters **a**, **b**, and **c**.

You'll continue with the Phoneword solution you created in the previous exercise.

## Add a new C# source file to the app

1. Open the **Phoneword** solution in Visual Studio if you don't already have it open.

1. In the Solution Explorer window, right-click the **Phoneword** project, select **Add**, and select **Class**.

1. In the **Add New Item** dialog box, name the class file **PhonewordTranslator.cs**, then select **Add**.

    :::image type="content" source="../media/6-add-new-item.png" alt-text="A screenshot of the Add new item dialog box. The user has named the class file PhonewordTranslator.cs":::

## Add the translation logic

Replace the content of the class file with the following code and save the file. The static method `ToNumber` in the `PhonewordTranslator` class translates the number from alphanumeric text into a regular numeric phone number.

```csharp
using System.Text;

namespace Core;

public static class PhonewordTranslator
{
    public static string ToNumber(string raw)
    {
        if (string.IsNullOrWhiteSpace(raw))
            return null;

        raw = raw.ToUpperInvariant();

        var newNumber = new StringBuilder();
        foreach (var c in raw)
        {
            if (" -0123456789".Contains(c))
                newNumber.Append(c);
            else
            {
                var result = TranslateToNumber(c);
                if (result != null)
                    newNumber.Append(result);
                // Bad character?
                else
                    return null;
            }
        }
        return newNumber.ToString();
    }

    static bool Contains(this string keyString, char c)
    {
        return keyString.IndexOf(c) >= 0;
    }

    static readonly string[] digits = {
        "ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ"
    };

    static int? TranslateToNumber(char c)
    {
        for (int i = 0; i < digits.Length; i++)
        {
            if (digits[i].Contains(c))
                return 2 + i;
        }
        return null;
    }
}
```

## Create the UI

1. Open the **MainPage.xaml** file in the **Phoneword** project.

1. Remove the `ScrollView` control and its contents, leaving just the `ContentPage` control:

    ```xml
    <ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="Phoneword.MainPage">

    </ContentPage>
    ```

1. Add a `VerticalStackLayout` control with vertical orientation and a spacing of 15 units and padding of 20 units to the ContentPage:

    ```xml
    <ContentPage ... >
        <VerticalStackLayout Spacing="15" Padding="20">
        
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add a `Label` control to the StackLayout:

    ```xml
    <ContentPage ... >
        <VerticalStackLayout ...>
            <Label Text = "Enter a Phoneword"
                   FontSize ="20"/>
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add an `Entry` control to the StackLayout, below the label. An `Entry` control provides a text box into which the user can enter data. In this code, the property `x:Name` gives the control a name. You'll reference this control in the code for the app later:

    ```xml
    <ContentPage ... >
        <VerticalStackLayout ...>
            <Label .../>
            <Entry x:Name = "PhoneNumberText"
                   Text = "1-555-NETMAUI" />
        </VerticalStackLayout>
    </ContentPage>
    ```

1. Add two `Button` controls to the VerticalStackLayout, after the Entry control. Both buttons currently do nothing, and the second is disabled initially. You'll add the code to handle the `Clicked` event for these two buttons in the next task:

    ```xml
    <ContentPage ... >
        <VerticalStackLayout ...>
            <Label .../>
            <Entry ... />
            <Button x:Name = "TranslateButton"
                    Text = "Translate"
                    Clicked = "OnTranslate"/>
            <Button x:Name = "CallButton"
                    Text = "Call"
                    IsEnabled = "False"
                    Clicked = "OnCall"/>
        </VerticalStackLayout>
    </ContentPage>
    ```

## Respond to the **TranslateButton** button tap

1. In the Solution Explorer window, expand the **MainPage.xaml** entry and open the **MainPage.xaml.cs** code-behind file.

1. In the `MainPage` class, remove the `count` variable and the `OnCounterClicked` method. The class should look like this:

    ```csharp
    namespace Phoneword;
 
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
        }
    }
    ```

1. Add the `translatedNumber` string variable and the following `OnTranslate` method to the `MainPage` class, after the constructor. The `OnTranslate` method retrieves the phone number from the `Text` property of the `Entry` control and passes it to the static `ToNumber` method of the `PhonewordTranslator` class that you created earlier.


    ```csharp
    public partial class MainPage : ContentPage
    {
        ...
        string translatedNumber;
    
        private void OnTranslate(object sender, EventArgs e)
        {
            string enteredNumber = PhoneNumberText.Text;
            translatedNumber = Core.PhonewordTranslator.ToNumber(enteredNumber);
    
            if (!string.IsNullOrEmpty(translatedNumber))
            {
                // TODO:
            }
            else
            {
                // TODO:
            }
        }
    }
    ```

    > [!NOTE]
    > You'll fill in the missing TODO bits of this code in the next step.

1. In the `OnTranslate` method, add code to change the `Text` property of the **Call** button to include the phone number when it's successfully translated. You can use the value you stored in the translatedNumber field. Also, enable and disable the button based on the successful translation. For example, if `TranslateNumber` returned null, disable the button, but if it was successful, enable it.

    ```csharp
    private void OnTranslate(object sender, EventArgs e)
    {
        string enteredNumber = PhoneNumberText.Text;
        translatedNumber = Core.PhonewordTranslator.ToNumber(enteredNumber);
    
        if (!string.IsNullOrEmpty(translatedNumber))
        {
            CallButton.IsEnabled = true;
            CallButton.Text = "Call " + translatedNumber;
        }
        else
        {
            CallButton.IsEnabled = false;
            CallButton.Text = "Call";
        }
    }
    ```

## Create the event method for the **CallButton** button

1. Add the `OnCall` event handling method to the end of the `MainPage` class. This method will make use of asynchronous operations, so mark it as `async`:

    ```csharp
    public partial class MainPage : ContentPage
    {
    
        ...
        async void OnCall(object sender, System.EventArgs e)
        {

        }
    }
    ```

1. In the `OnCall` method, prompt the user, by using the **Page.DisplayAlert** method, to ask if they'd like to dial the number.

    The parameters to `DisplayAlert` are a title, a message, and two strings used for the Accept and Cancel button text. It returns a Boolean indicating whether the Accept button was pressed to dismiss the dialog box.

    ```csharp
    async void OnCall(object sender, System.EventArgs e)
    {
        if (await this.DisplayAlert(
            "Dial a Number",
            "Would you like to call " + translatedNumber + "?",
            "Yes",
            "No"))
        {
            // TODO: dial the phone
        }
    }
    ```

## Test the application

1. In the Visual Studio toolbar, select the **Windows Machine** profile and start debugging.

1. Tap the **Translate** button to convert the default text to a valid phone number. The caption on the **Call** button should change to **Call 1-555-6386284**:

    :::image type="content" source="../media/6-phoneword-ui.png" alt-text="A screenshot of the Phoneword U I. The user has translated the text to a valid phone number.":::

1. Tap the **Call** button. Verify that a prompt appears asking you to confirm the operation. Select **No**.

    :::image type="content" source="../media/6-prompt.png" alt-text="A screenshot of the PhoneWord user interface's Dial a Number prompt.":::

1. Return to Visual Studio and stop debugging.

## Dial the phone number

1. In the **MainPage.xaml.cs** code-behind file, edit the **OnCall** method and replace the **TODO** comment with the following `try/catch` blocks:

    ```csharp
    async void OnCall(object sender, System.EventArgs e)
    {
        if (await this.DisplayAlert(
            "Dial a Number",
            "Would you like to call " + translatedNumber + "?",
            "Yes",
            "No"))
        {
            try
            {
                if (PhoneDialer.Default.IsSupported)
                    PhoneDialer.Default.Open(translatedNumber);
            }
            catch (ArgumentNullException)
            {
                await DisplayAlert("Unable to dial", "Phone number was not valid.", "OK");
            }
            catch (Exception)
            {
                // Other error has occurred.
                await DisplayAlert("Unable to dial", "Phone dialing failed.", "OK");
            }
        }
    }
    ```

    The **PhoneDialer** class in the **Microsoft.Maui.ApplicationModel.Communication** namespace provides an abstraction of the phone dialing functionality (and others) for the Windows, Android, iOS (and iPadOS), and macOS platforms. The static **Open** method attempts to use the phone dialer to call the number provided as the parameter.

    The following steps show how to update the Android application manifest to enable Android to use the phone dialer. Windows, iOS, and MacCatalyst, applications follow the same general principle, except that you specify a different operating-system dependent capability in the manifest.

1. In the Solution Explorer window, expand the **Platforms** folder, expand the **Android** folder, right-click the **AndroidManifest.xml** file, and select **Open with** > **Automatic Editor Selector (XML)**. Select **OK**.

1. Add the following XML snippet inside the **manifest** node, after the existing content for this node.

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <manifest xmlns:android="http://schemas.android.com/apk/res/android">
        ...
        <queries>
            <intent>
                <action android:name="android.intent.action.DIAL" />
                <data android:scheme="tel"/>
            </intent>
        </queries>
    </manifest>
    ```

1. Save the file.

1. In the Visual Studio toolbar, select the **Android Emulators/Pixel 3a - API 30** (or similar) profile and start debugging.

1. When the app appears in the emulator (this can take a few minutes), enter a phone number (or accept the default) select **Translate**, then select **Call**.

1. In the **Dial a Number** alert, select **Yes**. Verify that the Android phone dialer appears with the number you provided in the app.

    :::image type="content" source="..\media\6-android-phone-dialer.png" alt-text="The Android phone dialer containing the number provided by the app.":::

1. Return to Visual Studio and stop debugging.

## Summary

In this exercise, you added a custom UI to your application by using pages and views. You also added support for placing a call by using platform-specific APIs available in Android.
