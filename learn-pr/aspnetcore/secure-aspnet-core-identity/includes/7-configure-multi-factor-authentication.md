In the previous unit, you learned how ASP.NET Core Identity implements time-based one-time password (TOTP) for multi-factor authentication (MFA). In this unit, you customize the existing **Configure authenticator app** form to provide a QR code that contains the registration key.

## Generating QR codes

Multiple strategies exist for generating the QR code. An example in the documentation uses a [client-side JavaScript library](/aspnet/core/security/authentication/identity-enable-qrcodes). In this unit, however, a third-party NuGet package is used to generate the QR code with C# on the server. The resulting QR code image is injected into an HTML placeholder element as a base-64 encoded string.

## Add a QR code service

Let's build everything you need to generate QR codes on the **Configure authenticator app** form.

1. In the terminal pane, install the `QRCoder` NuGet package:

    ```dotnetcli
    dotnet add package QRCoder --version 1.4.3
    ```

1. In the **Explorer** pane, right-click on the *Services* folder and add a new file named *QRCodeService.cs*. Add the following code:

    ```csharp
    using QRCoder;

    namespace RazorPagesPizza.Services;
    public class QRCodeService
    {
        private readonly QRCodeGenerator _generator;
    
        public QRCodeService(QRCodeGenerator generator)
        {
            _generator = generator;
        }
        
        public string GetQRCodeAsBase64(string textToEncode)
        {
            QRCodeData qrCodeData = _generator.CreateQrCode(textToEncode, QRCodeGenerator.ECCLevel.Q);
            var qrCode = new PngByteQRCode(qrCodeData);
    
            return Convert.ToBase64String(qrCode.GetGraphic(4));
        }
    }
    ```

    The preceding code:

    * Uses constructor injection to gain access to an instance of the library's `QRCodeGenerator` class.
    * Exposes the `GetQRCodeAsBase64` method to return the base-64 encoded string. The QR code dimensions are determined by the integer value passed to `GetGraphic`. In this case, the generated QR code is composed of blocks sized four pixels squared.

1. In *Program.cs*, add the highlighted lines:

    [!code-csharp[](../code/program-after-customization.cs?range=1-17,22-23&highlight=5-6,17)]

    `QRCodeService` is registered as a singleton service in the IoC container within *Program.cs*.

## Customize multi-factor authentication

Now that you can generate QR codes, you can embed a QR code into the **Configure authenticator app** form.

1. Open *:::no-loc text="Areas/Identity/Pages/Account/Manage/EnableAuthenticator.cshtml.cs":::* and make the following changes:
    1. Add the following property to the `EnableAuthenticatorModel` class to store the QR code's base-64 string representation:

        [!code-csharp[](../code/areas/identity/pages/account/manage/enableauthenticator.cshtml.cs?name=snippet_qrcodeasbase64&highlight=7)]

    1. Incorporate the highlighted changes in the `OnGetAsync` page handler:

        [!code-csharp[](../code/areas/identity/pages/account/manage/enableauthenticator.cshtml.cs?name=snippet_ongetasync&highlight=1,10)]

        In the preceding page handler, parameter injection provides a reference to the `QRCodeService` singleton service.

    1. Add the following `using` statement to the top of the file to resolve the reference to `QRCodeService`. Save your changes.

        ```csharp
        using RazorPagesPizza.Services;
        ```

    1. Incorporate the highlighted change to the `GenerateQrCodeUri` method.

        [!code-csharp[](../code/areas/identity/pages/account/manage/enableauthenticator.cshtml.cs?name=snippet_generateqrcodeuri&highlight=6)]

        This sets the display name for the key in your TOTP app.

1. In *:::no-loc text="Areas/Identity/Pages/Account/Manage/EnableAuthenticator.cshtml":::*, make the following highlighted changes and save:

    [!code-cshtml[](../code/areas/identity/pages/account/manage/enableauthenticator.cshtml?highlight=3-5)]

    The preceding markup embeds the base-64 encoded image in the page.

## Test multi-factor authentication

You've made all the changes needed for a QR code on the **Configure authenticator app** form. Now you can easily test the MFA functionality.

1. Ensure that you've saved all your changes.
1. Build and run the app with `dotnet run`.
1. Navigate to the site and sign in with either registered user, if you're not already signed in. Select **Hello, [First name] [Last name]!** link to navigate to the profile management page, and then select **Two-factor authentication**.
1. Select the **Add authenticator app** button.
1. Follow the on-screen instructions to register and verify your authenticator app for this user.

    For example, using Microsoft Authenticator on Android, follow these steps to add the account to the app:

    1. Open the Microsoft Authenticator app.
    1. Select the kebab menu (vertical ellipsis) in the upper right.
    1. Select **Add account**.
    1. Select **Other account (Google, Facebook, etc.)**.
    1. Scan the QR code as indicated.

1. Enter the verification code provided by your TOTP app in the **Verification Code** text box.
1. Select **Verify**.

    Upon successful verification, the page displays a **Your authenticator app has been verified** banner and some recovery codes.

1. In the *SQL Server* tab in VS Code, right-click the **RazorPagesPizza** database and select **New query**. Enter the following query and press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd> to run it.

    ```sql
    SELECT FirstName, LastName, Email, TwoFactorEnabled
    FROM dbo.AspNetUsers
    ```

    For the signed in user, the output shows that the `TwoFactorEnabled` column is equal to `1`. Because multi-factor authentication hasn't been enabled for the other registered user, the record's column value is `0`.

1. In the web app, select **Logout**, and then sign in again with the same user.
1. Enter the verification code from the TOTP authenticator app in the **Authenticator code** text box. Select the **Log in** button.
1. Select **Hello, [First name] [Last name]!**. Then, select the **Two-factor authentication** tab.

    Because Microsoft Authenticator has been set up, the following buttons appear:

    * **Disable 2FA**
    * **Reset recovery codes**
    * **Set up authenticator app**
    * **Reset authenticator app**

1. In the terminal pane in VS Code, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.

## Summary

In this unit, you added the ability to generate a QR code to the **Configure authenticator app** form. In the next unit, you can learn about using Identity to store claims and apply authorization policies.
