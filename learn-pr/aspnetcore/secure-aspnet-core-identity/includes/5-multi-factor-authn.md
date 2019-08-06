<!-- TODO: Intro text that talks about using a QR code -->

## Configure multi-factor authentication

1. Open *Pages/Account/Manage/EnableAuthenticator.cshtml.cs* and make the following changes:
    1. Add the following property to the `EnableAuthenticatorModel` class to store the QR code base-64 string representation:

        ```csharp
        public string QrCodeAsBase64 { get; set; }
        ```

    1. Incorporate the highlighted changes in the `OnGetAsync` page handler:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/5-EnableAuthenticator-OnGetAsync.cshtml.cs?highlight=1,10)]

        In the preceding page handler, parameter injection provides a reference to the `QRCodeService` singleton service. `QRCodeService` is responsible for interactions with a third-party library which generates QR codes.

    1. Add the following `using` statement to resolve the reference to `QRCodeService`, then save your changes:

        ```csharp
        using ContosoPets.Ui.Services;
        ```

1. In *Pages/Account/Manage/EnableAuthenticator.cshtml*, replace the following HTML:

    ```html
    <div id="qrCode"></div>
    ```

    With the following markup:

    ```cshtml
    <div id="qrCode">
        <img alt="embedded QR code" src="data:image/png;base64,@Model.QrCodeAsBase64" />
    </div>
    ```

    Save your changes.

## Test multi-factor authentication

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. Deploy the site by running the following command:

    ```bash
    az webapp up
    ```

1. Navigate to the site and login with either registered user (if required). Select **Hello, [First Name] [Last Name]!** link to navigate to the profile management page, and then select **Two-factor authentication**.

1. Select **Set up authenticator app**.

1. Follow the on-screen instructions to register and verify your authenticator app for this user.

    > [!TIP]
    > If using Microsoft Authenticator, use the following steps to add the account to the app:
    > 1. Select the three dots in the upper right.
    > 1. Select *Add account*.
    > 1. Select *Other account*.
    > 1. Scan the QR code as indicated.

1. Select **Logout**, and then log in again with the same user. Note the user is prompted for a token from the authenticator app. Provide the token value to log in.
