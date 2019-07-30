## Multi-factor authentication &mdash; generate QR code

1. Open *Pages/Account/Manage/EnableAuthenticator.cshtml.cs* and make the following changes:
    1. Add the following property to the `EnableAuthenticatorModel` class to store the QR code base-64 string representation:

        ```csharp
        public string QrCodeAsBase64 { get; set; }
        ```

    1. Incorporate the highlighted changes in the `OnGetAsync` page handler:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/5-EnableAuthenticator-OnGetAsync.cs?highlight=1,10)]

        In the preceding page handler, parameter injection provides a reference to the `QRCodeService` singleton service. `QRCodeService` is responsible for interactions with a third-party library which generates QR codes.

    1. Add the following `using` statement to resolve the reference to `QRCodeService`:

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

## Admin creation

<!-- TODO -->
