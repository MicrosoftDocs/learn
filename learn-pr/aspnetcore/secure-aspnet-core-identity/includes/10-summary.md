In this module, you added Identity to an existing ASP.NET Core Razor Pages project. The default Identity UI components were customized to satisfy the business and technical requirements. An authorization policy was created to secure certain features of the app. Finally, the authorization policy was employed to restrict access so that only administrators could view and access certain functionality.

A completed sample can be found on the `solution` branch. Note the following points:

- The connection string is preconfigured for the *.devcontainer*. If you run it locally, change the connection string to point to your LocalDB instance.
- Make sure you apply the migrations before running the app.

## Learn more about ASP.NET Core Identity

- [ASP.NET Core security topics](/aspnet/core/security/)
- [Scaffold Identity in ASP.NET Core projects](/aspnet/core/security/authentication/scaffold-identity)
- [Identity model customization in ASP.NET Core](/aspnet/core/security/authentication/customize-identity-model)
- [Enable QR code generation for TOTP authenticator apps in ASP.NET Core](/aspnet/core/security/authentication/identity-enable-qrcodes)
- [Claims-based authorization in ASP.NET Core](/aspnet/core/security/authorization/claims)

## Learn more

Channel 9 video series:
- [.NET Core 101](/shows/net-core-101/?wt.mc_id=educationaldotnet-c9-scottha)
- [ASP.NET Core 101](/shows/aspnet-core-101/?wt.mc_id=educationaspnet-c9-niner)
