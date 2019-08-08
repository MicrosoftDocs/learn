By default, Identity includes multi-factor authentication support for TOTP authenticator apps. However, the default implementation only provides a 32-character registration key to seed the token value. In this unit, you'll customize the **Configure authenticator app** form to provide a QR code containing the registration key.

Multiple strategies exist for generating the QR code. An example includes using a third-party JavaScript library. In this unit, however, a third-party NuGet package is used to generate the QR code with C#. The resulting QR code image is injected into an HTML element as a base-64 encoded string.

## Examine the QR code generation infrastructure

To avoid distracting from the focus on Identity, the boilerplate to support QR code generation has been provided. The supporting changes include:

* The NuGet package, `QRCoder`, has already been installed in the project.
* All interactions with the `QRCoder` library are abstracted away in the *Services/QRCodeService.cs* file. The `QRCodeService` class:
    * Uses constructor injection to gain access to an instance of the library's `QRCodeGenerator` class.
    * Exposes the `GetQRCodeAsBase64` method to return the base-64 encoded string. The QR code dimensions are determined by the integer value passed to `GetGraphic`. In this case, the generated QR code will be composed of blocks sized four pixels squared.
* `QRCodeService` is registered as a singleton service in the IoC container within *Startup.cs*.

## Customize multi-factor authentication

1. Open *Areas/Identity/Pages/Account/Manage/EnableAuthenticator.cshtml.cs* and make the following changes:
    1. Add the following property to the `EnableAuthenticatorModel` class to store the QR code's base-64 string representation:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/5-EnableAuthenticator.cshtml.cs?name=snippet_QrCodeAsBase64&highlight=7)]

    1. Incorporate the highlighted changes in the `OnGetAsync` page handler:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/5-EnableAuthenticator.cshtml.cs?name=snippet_OnGetAsync&highlight=1,10)]

        In the preceding page handler, parameter injection provides a reference to the `QRCodeService` singleton service. `QRCodeService` is responsible for interactions with a third-party library that generates QR codes.

    1. Add the following `using` statement to resolve the reference to `QRCodeService`. Save your changes.

        ```csharp
        using ContosoPets.Ui.Services;
        ```

1. In *Areas/Identity/Pages/Account/Manage/EnableAuthenticator.cshtml*, replace the following HTML. Save your changes.

    ```html
    <div id="qrCode"></div>
    ```

    With the following markup:

    ```cshtml
    <div id="qrCode">
        <img alt="embedded QR code" src="data:image/png;base64,@Model.QrCodeAsBase64" />
    </div>
    ```

## Test multi-factor authentication

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. [!INCLUDE[az webapp up command](../../includes/az-webapp-up-command.md)]

1. Navigate to the site and login with either registered user (if necessary). Select **Hello, [First Name] [Last Name]!** link to navigate to the profile management page, and then select **Two-factor authentication**.

1. Select **Set up authenticator app**.

1. Follow the on-screen instructions to register and verify your authenticator app for this user.

    Using Microsoft Authenticator as an example, follow these steps to add the account to the app:

    1. Select the kebab menu (vertical ellipsis) in the upper right.
    1. Select **Add account**.
    1. Select **Other account**.
    1. Scan the QR code as indicated.

1. Select **Logout**, and then log in again with the same user. Note the user is prompted for a token from the authenticator app. Provide the token value to log in.
