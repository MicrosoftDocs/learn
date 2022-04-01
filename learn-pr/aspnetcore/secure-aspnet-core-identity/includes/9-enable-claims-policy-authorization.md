In the previous unit, you learned the difference between authentication and authorization. You also learned how claims are used by policies for authorization. In the next unit, you'll use Identity to store claims and apply policies for conditional access.

## Secure the pizza list

You've received a new requirement that the Pizza List page should be visible only to authenticated users. Additionally, only administrators are allowed to  create and delete pizzas. Let's lock it down.

1. In *Pages/Pizza.cshtml.cs*, apply the following changes:
    1. Add an `[Authorize]` attribute to the `PizzaModel` class.

        [!code-csharp[](../code/pages/pizza.cshtml.cs?range=2-3&highlight=1)]

        The attribute describes user authorization requirements for the page. In this case, there are no requirements beyond the user being authenticated. Anonymous users aren't allowed to view the page and are redirected to the login page.

    1. Resolve the reference to `Authorize` by adding the following line to the `using` directives at the top of the file:

        ```csharp
        using Microsoft.AspNetCore.Authorization;
        ```

    1. Add the following property to the `PizzaModel` class:

        [!code-csharp[](../code/pages/pizza.cshtml.cs?name=snippet_isadmin&highlight=4)]

        The preceding code determines whether the authenticated user has an `IsAdmin` claim with a value of `True`. The result of this evaluation is accessed via a read-only property named `IsAdmin`.

    1. Add `if (!IsAdmin) return Forbid();` to the beginning of **both** the `OnPost` and `OnPostDelete` methods:

        [!code-csharp[](../code/pages/pizza.cshtml.cs?name=snippet_admincheck&highlight=3,14)]

        You're going to hide the creation/deletion UI elements for non-administrators in the next step. That doesn't prevent an adversary with a tool like [HttpRepl](/aspnet/core/web-api/http-repl/) or Postman from accessing these endpoints directly. Adding this check ensures that if this is attempted, an HTTP 403 status code is returned.

1. In *Pages/Pizza.cshtml*, add checks to hide administrator UI elements from non-administrators:

    ***New pizza* form**

    [!code-cshtml[](../code/pages/pizza.cshtml?name=snippet_create&highlight=2-3,20)]

    ***Delete pizza* button**

    [!code-cshtml[](../code/pages/pizza.cshtml?name=snippet_delete&highlight=8-9,11,21-22,28)]

    The preceding changes cause UI elements that should be accessible only to administrators to be rendered only when the authenticated user is an administrator.

## TODO: WIP beyond this point

wip

## Register and apply the authorization policy

The **Create Product** and **Edit Product** pages should be accessible only to administrators. To encapsulate the authorization criteria for such pages, an `Admin` policy will be created.

1. In the `ConfigureServices` method of *:::no-loc text="Startup.cs":::*, make the following changes:
    1. Replace the `// Add call to AddAuthorization` comment with the following code:

        ```csharp
        services.AddAuthorization(options =>
            options.AddPolicy("Admin", policy =>
                policy.RequireAuthenticatedUser()
                    .RequireClaim("IsAdmin", bool.TrueString)));
        ```

        The preceding code defines an authorization policy named `Admin`. The policy requires that the user is authenticated and has an `IsAdmin` claim set to `True`.

    1. Incorporate the following highlighted code:

        [!code-csharp[](../code/6-startup.cs?highlight=2-3)]

        The `AuthorizePage` method call secures the *:::no-loc text="/Products/Edit":::* Razor Page route by applying the `Admin` policy. An advantage to this approach is that the Razor Page being secured requires no modifications. The authorization aspect is instead managed in *Startup.cs*. Anonymous users will be redirected to the login page. Authenticated users who don't satisfy the policy requirements are presented an **Access denied** message.

1. In *:::no-loc text="Pages/Products/Create.cshtml.cs":::*, apply the following changes:
    1. Replace the `// Add [Authorize(Policy = "Admin")] attribute` comment with the following attribute:

        ```csharp
        [Authorize(Policy = "Admin")]
        ```

        The preceding code represents an alternative to the `AuthorizePage` method call in *:::no-loc text="Startup.cs":::*. The `[Authorize]` attribute enforces that the `Admin` policy requirements are satisfied. Anonymous users will be redirected to the login page. Authenticated users who don't satisfy the policy requirements are presented an **Access denied** message.

    1. Uncomment the `//using Microsoft.AspNetCore.Authorization;` line at the top of the file.

        The preceding change resolves the `[Authorize(Policy = "Admin")]` attribute in the previous step.

## Modify the registration page

Modify the registration page to allow administrators to register using the following steps.

1. In *:::no-loc text="Areas/Identity/Pages/Account/Register.cshtml.cs":::*, make the following changes:
    1. Add the following property to the `InputModel` nested class:

        [!code-csharp[](../code/areas/identity/pages/account/6-register.cshtml.cs?name=snippet_adminenrollmentkey&highlight=3-5)]

    1. Apply the highlighted changes to the `OnPostAsync` method:

        [!code-csharp[](../code/areas/identity/pages/account/6-register.cshtml.cs?name=snippet_onpostasync&highlight=1-3,21-23)]

        In the preceding code:

        * The `[FromServices]` attribute provides an instance of `AdminRegistrationTokenService` from the IoC container.
        * The `UserManager` class's `AddClaimAsync` method is invoked to save an `IsAdmin` claim in the `AspNetUserClaims` table.

    1. Add the following code to the top of the file. It resolves the `AdminRegistrationTokenService` and `Claim` class references in the `OnPostAsync` method:

        ```csharp
        using ContosoPets.Ui.Services;
        using System.Security.Claims;
        ```

1. In *:::no-loc text="Areas/Identity/Pages/Account/Register.cshtml":::*, add the following markup:

    [!code-cshtml[](../code/areas/identity/pages/account/6-register.cshtml?highlight=6-10)]

## Test admin claim

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. [!INCLUDE[az webapp up command](../../includes/az-webapp-up-command.md)]

1. Navigate to your app and log in with an existing user, if not already logged in. Select **Products** from the header. Notice the user isn't presented links to edit, delete, or create products.

1. In the browser's address bar, navigate directly to the **Create Product** page. That page's URL can be obtained by running the following command:

    ```bash
    echo "$webAppUrl/Products/Create"
    ```

    The user is forbidden from navigating to the page. An **Access denied** message is displayed. Similarly, the user will be forbidden from navigating to a route such as *:::no-loc text="/Products/Edit/1":::* route.

1. Select **Logout**.

1. Obtain an administrator self-enrollment token using the following command:

    ```bash
    echo $(wget -q -O - $webAppUrl/admintoken)
    ```

    > [!WARNING]
    > The administrator self-enrollment mechanism is for illustrative purposes only. The *:::no-loc text="/api/Admin":::* endpoint for obtaining a token should be secured before using in a production environment.

1. In the web app, register a new user. The token from the previous step should be provided in the **Admin enrollment key** text box.

1. Once logged in with the new administrative user, click the **Products** link in the header.

    The administrative user can view, edit, and create products.

## Examine the AspNetUserClaims table

Run the following command:

```bash
db -Q "SELECT u.Email, c.ClaimType, c.ClaimValue FROM dbo.AspNetUserClaims AS c INNER JOIN dbo.AspNetUsers AS u ON c.UserId = u.Id" -Y25 -y10
```

A variation of the following output appears:

```console
Email                     ClaimType  ClaimValue
------------------------- ---------- ----------
scott@contoso.com         IsAdmin    True
```

The `IsAdmin` claim is stored as a key-value pair in the `AspNetUserClaims` table. The `AspNetUserClaims` record is associated with the user record in the `AspNetUsers` table.
