<!-- TODO: Introduction text that explains the need to create a ClaimsPrincipalFactory -->

## Grant administrative rights to a user

1. In the `ConfigureServices` method of *Startup.cs*, replace the `// Add call to AddAuthorization` comment with the following code:

```csharp
services.AddAuthorization(options =>
                options.AddPolicy("Admin", policy =>
                    policy.RequireAuthenticatedUser()
                          .RequireClaim("IsAdmin", bool.TrueString)));
```

The preceding code defines an authorization policy named `Admin`. The policy requires that the user is authenticated and has an `IsAdmin` claim set to `True`.

1. In *Pages/Products/Index.cshtml.cs*, apply the following changes:
    1. Replace the `// Add [Authorize] attribute` comment with the following attribute:

        ```csharp
        [Authorize]
        ```

    1. Replace the `// Add IsAdmin property` comment with the following property:

        ```csharp
        public bool IsAdmin => HttpContext.User.HasClaim("IsAdmin", bool.TrueString);
        ```

    1. Replace the `// Add IsAdmin check` comment with the following code:

        ```csharp
        if(!IsAdmin)
        {
            return Forbid();
        }
        ```

    1. Replace the `// Add using Microsoft.AspNetCore.Authorization;` comment with the following code:

        ```csharp
        using Microsoft.AspNetCore.Authorization;
        ```

        The preceding resolves the `[Authorize]` attribute in the previous step.

1. In *Pages/Products/Index.cshtml*, update the **Edit**, **Delete**, and **Add Product** links with the highlighted code:

    [!code-cshtml[](../code/Pages/Products/Index.cshtml?name=snippet_ModelIsAdmin&highlight=2-3,6)]

    [!code-cshtml[](../code/Pages/Products/Index.cshtml?name=snippet_AddProductLink&highlight=1-2,4)]

1. In *Pages/Products/**Create**.cshtml.cs*, apply the following changes:
    1. Replace the `// Add [Authorize(Policy = "Admin")] attribute` comment with the following attribute:

        ```csharp
        [Authorize(Policy = "Admin")]
        ```

    1. Replace the `// Add using Microsoft.AspNetCore.Authorization;` comment with the following code:

        ```csharp
        using Microsoft.AspNetCore.Authorization;
        ```

1. In *Pages/Products/**Edit**.cshtml.cs*, apply the following changes:
    1. Replace the `// Add [Authorize(Policy = "Admin")] attribute` comment with the following attribute:

        ```csharp
        [Authorize(Policy = "Admin")]
        ```

    1. Replace the `// Add using Microsoft.AspNetCore.Authorization;` comment with the following code:

        ```csharp
        using Microsoft.AspNetCore.Authorization;
        ```

1. Execute the following command to create an empty file named *Areas/Identity/ClaimsPrincipalFactory.cs*:

    ```bash
    touch ./Areas/Identity/ClaimsPrincipalFactory.cs
    ```

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

1. Populate *Areas/Identity/ClaimsPrincipalFactory.cs* with the following code:

    ```csharp
    using ContosoPets.Ui.Areas.Identity.Data;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.Extensions.Options;
    using System.Security.Claims;
    using System.Threading.Tasks;

    namespace ContosoPets.Ui.Areas.Identity
    {
        public class ClaimsPrincipalFactory : UserClaimsPrincipalFactory<ContosoPetsUser>
        {
            public ClaimsPrincipalFactory(UserManager<ContosoPetsUser> userManager, IOptions<IdentityOptions> optionsAccessor) : base(userManager, optionsAccessor)
            {
            }

            protected override async Task<ClaimsIdentity> GenerateClaimsAsync(ContosoPetsUser user)
            {
                var identity = await base.GenerateClaimsAsync(user);
                identity.AddClaim(new Claim("IsAdmin", user.IsAdmin.ToString()));
                return identity;
            }
        }
    }
    ```

1. In the `Configure` method of *IdentityHostingStartup.cs*, make the following highlighted changes:

    [!code-csharp[](../code/Areas/Identity/IdentityHostingStartup-Configure.cs?name=snippet_ConfigureAddClaims&highlight=15)]

    The preceding configures Identity to use `ClaimsPrincipalFactory` when generating the claims for the logged in user.

1. Modify the registration page to allow administrators to register using the following steps:
    1. In *Areas/Identity/Pages/Account/Register.cshtml.cs*, add the following property to the `InputModel` class:

        ```csharp
        [DataType(DataType.Password)]
        [Display(Name = "Admin creation key")]
        public long? AdminCreationKey { get; set; }
        ```

    1. In that same file, make the highlighted change to `OnPostAsync`:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Register.cshtml.cs?highlight=7)]

    1. In *Areas/Identity/Pages/Account/Register.cshtml*, add the following:

        [!code-cshtml[](../code/Areas/Identity/Pages/Account/Register.cshtml?highlight=6-10)]

    1. In *Areas/Identity/Data/ContosoUser.cs*, add the following property:

        ```csharp
        public bool IsAdmin { get; set; }
        ```

## Test admin claim

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. Deploy the site by running the following command:

    ```bash
    az webapp up
    ```

1. Navigate to your app and login with an existing user, if required. Select **Products** from near the top. Note that your user is is not presented links to edit, delete, or create products.

1. Attempt to navigate directly to the **Create Product** page by navigating to: `https://[web app name].azurewebsites.net/products/create`. Note that this use is forbidden from navigating to the page.

1. Select **Logout**.

1. Obtain an administrator self-enrollment token using the following command:

    ```bash
    echo $(wget -q -O - $webAppUrl/api/admintoken)
    ```

    > [!NOTE]
    > This administrator self-enrollment mechanism is for illustrative purposes only and should not be used in production environments.

1. In the web app, register a new user, using the token from the previous step for the **Admin creation key** field.

1. Once logged in with the new administrative user, note that the administrative user can view, edit, and create products.
