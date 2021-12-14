With th steps completed to onboard the directory, you can direct Fabrikam users to sign in. Fabrikam users (users with the `fabrikam.onmicrosoft.com` suffix) sign in by visiting https://portal.local.azurestack.external.

You will direct foreign principals in the Fabrikam directory (without suffix `fabrikam.onmicrosoft.com`) to sign in using https://portal.local.azurestack.external/fabrikam.onmicrosoft.com.

> [!IMPORTANT]
> If users don't use this URL, they're sent to their default directory (Fabrikam) and receive an error that says their administrator hasn't consented.
