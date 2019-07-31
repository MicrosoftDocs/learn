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

    [!code-cshtml[](../code/Pages/Products/Index.cshtml?name=snippet_ModelIsAdmin&highlight=2-3,6)

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

1. Do claims stuff:

    [!code-csharp[](../code/Areas/Identity/IdentityHostingStartup.cs?name=snippet_ConfigureAddClaims&highlight=15)]

1. touch ClaimsPrincipalFactory.cs

1. Give it code:

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

1. Make Account pages changes
    1. Register.cshtml.cs
    1. Register.cshtml
    1. ContosoPetsUser.cs
