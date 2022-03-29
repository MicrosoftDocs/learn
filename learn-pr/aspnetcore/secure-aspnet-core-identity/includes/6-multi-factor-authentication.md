By default, the ASP.NET Core project templates using Identity include multi-factor authentication support for TOTP authenticator apps. The Razor Pages template's **Configure authenticator app** form provides a 32-character registration key to seed the token value. In this unit, you'll customize the **Configure authenticator app** form to provide a QR code containing the registration key. The QR code will serve as an alternative authentication mechanism to the 32-character key.

Multiple strategies exist for generating the QR code. An example includes using a third-party JavaScript library. In this unit, however, a third-party NuGet package is used to generate the QR code with C#. The resulting QR code image is injected into an HTML placeholder element as a base-64 encoded string.

## Examine the QR code generation infrastructure

To avoid distracting from the focus on Identity, the boilerplate to support QR code generation has been provided. The supporting changes include:

* The NuGet package, `QRCoder`, has already been installed in the project.
* All interactions with the `QRCoder` library are abstracted away in the *:::no-loc text="Services/QRCodeService.cs":::* file. The `QRCodeService` class:
  * Uses constructor injection to gain access to an instance of the library's `QRCodeGenerator` class.
  * Exposes the `GetQRCodeAsBase64` method to return the base-64 encoded string. The QR code dimensions are determined by the integer value passed to `GetGraphic`. In this case, the generated QR code will be composed of blocks sized four pixels squared.
* `QRCodeService` is registered as a singleton service in the IoC container within *:::no-loc text="Startup.cs":::*.

## Customize multi-factor authentication

1. Open *:::no-loc text="Areas/Identity/Pages/Account/Manage/EnableAuthenticator.cshtml.cs":::* and make the following changes and save:
    1. Add the following property to the `EnableAuthenticatorModel` class to store the QR code's base-64 string representation:

        <!--[!code-csharp[](../code/areas/identity/pages/account/manage/5-enableauthenticator.cshtml.cs?name=snippet_qrcodeasbase64&highlight=7)]-->

    1. Incorporate the highlighted changes in the `OnGetAsync` page handler:

        <!--[!code-csharp[](../code/areas/identity/pages/account/manage/5-enableauthenticator.cshtml.cs?name=snippet_ongetasync&highlight=1,10)]-->

        In the preceding page handler, parameter injection provides a reference to the `QRCodeService` singleton service. `QRCodeService` is responsible for interactions with a third-party library that generates QR codes.

    1. Add the following `using` statement to the top of the file to resolve the reference to `QRCodeService`. Save your changes.

        ```csharp
        using ContosoPets.Ui.Services;
        ```

1. In *:::no-loc text="Areas/Identity/Pages/Account/Manage/EnableAuthenticator.cshtml":::*, make the following highlighted changes and save:

    <!--[!code-cshtml[](../code/areas/identity/pages/account/manage/5-enableauthenticator.cshtml?highlight=4-6)]-->

    The preceding markup embeds the base-64 encoded image in the page.

## Test multi-factor authentication

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. [!INCLUDE[az webapp up command](../../includes/az-webapp-up-command.md)]

1. Navigate to the site and log in with either registered user (if not already logged in). Select **Hello, [First name] [Last name]!** link to navigate to the profile management page, and then select **Two-factor authentication**.

    Notice the presence of the following message on the page:

    ```console
    Privacy and cookie policy have not been accepted.
    You must accept the policy before you can enable two factor authentication.
    ```

1. Click the **Accept** link in the privacy and cookie use policy banner to accept the policy. Refresh the page.

    A cookie named *:::no-loc text=".AspNet.Consent":::* is created to mark acceptance of the policy. The cookie expires one year from the acceptance date.

1. Select the **Add authenticator app** button.

1. Follow the on-screen instructions to register and verify your authenticator app for this user.

    Using Microsoft Authenticator on Android as an example, follow these steps to add the account to the app:

    1. Open the Microsoft Authenticator app.
    1. Select the kebab menu (vertical ellipsis) in the upper right.
    1. Select **Add account**.
    1. Select **Other account (Google, Facebook, etc.)**.
    1. Scan the QR code as indicated.
    1. Select **Finish** to verify the 32-character key.

1. Enter the verification code provided by your TOTP app in the **Verification Code** text box.

1. Select **Verify**.

    Upon successful verification, the page displays a **Your authenticator app has been verified** banner and some recovery codes.

1. Run the following command to see the effect on the `AspNetUsers` table's `TwoFactorEnabled` column:

    ```bash
    db -Q "SELECT FirstName, LastName, Email, TwoFactorEnabled FROM dbo.AspNetUsers" -Y 25
    ```

    For the logged in user, the output shows that the `TwoFactorEnabled` column is equal to `1`. Because multi-factor authentication hasn't been enabled for the other registered user, the record's column value is `0`.

1. Select **Logout**, and then log in again with the same user.

1. Enter the verification code from the TOTP authenticator app in the **Authenticator code** text box. Select the **Log in** button.

1. Select **Hello, [First name] [Last name]!**. Then, select the **Two-factor authentication** tab.

    Because Microsoft Authenticator has been set up, the following buttons appear:

    * **Disable 2FA**
    * **Reset recovery codes**
    * **Set up authenticator app**
    * **Reset authenticator app**
