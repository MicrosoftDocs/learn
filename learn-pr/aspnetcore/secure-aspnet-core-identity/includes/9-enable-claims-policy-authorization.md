In the previous unit, you learned the difference between authentication and authorization. You also learned how claims are used by policies for authorization. In this unit, you use Identity to store claims and apply policies for conditional access.

## Secure the pizza list

You've received a new requirement that the Pizza List page should be visible only to authenticated users. Additionally, only administrators are allowed to create and delete pizzas. Let's lock it down.

1. In *Pages/Pizza.cshtml.cs*, apply the following changes:
    1. Add an `[Authorize]` attribute to the `PizzaModel` class.

        [!code-csharp[](../code/pages/pizza.cshtml.cs?range=2-3&highlight=1)]

        The attribute describes user authorization requirements for the page. In this case, there are no requirements beyond the user being authenticated. Anonymous users aren't allowed to view the page and are redirected to the sign-in page.

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

    Hide **New pizza** form

    [!code-cshtml[](../code/pages/pizza.cshtml?name=snippet_create&highlight=2-3,20)]

    Hide **Delete pizza** button

    [!code-cshtml[](../code/pages/pizza.cshtml?name=snippet_delete&highlight=8-9,11,21-22,28)]

    The preceding changes cause UI elements that should be accessible only to administrators to be rendered only when the authenticated user is an administrator.

## Apply an authorization policy

There's one more thing you should lock down. There's a page that should be accessible only to administrators, conveniently named *Pages/AdminsOnly.cshtml*. Let's create a policy to check the `IsAdmin=True` claim.

1. In *Program.cs*, make the following changes:
    1. Incorporate the following highlighted code:

        [!code-csharp[](../code/program-after-customization.cs?range=14-23&highlight=5-8)]

        The preceding code defines an authorization policy named `Admin`. The policy requires that the user is authenticated and has an `IsAdmin` claim set to `True`.

    1. Modify the call to `AddRazorPages` as follows:

        ```csharp
        builder.Services.AddRazorPages(options =>
            options.Conventions.AuthorizePage("/AdminsOnly", "Admin"));
        ```

        The `AuthorizePage` method call secures the */AdminsOnly* Razor Page route by applying the `Admin` policy. Authenticated users who don't satisfy the policy requirements are presented an **Access denied** message.

        > [!TIP]
        > Alternatively, you could have instead modified *AdminsOnly.cshtml.cs*. In that case, you would add `[Authorize(Policy = "Admin")]` as an attribute on the `AdminsOnlyModel` class. An advantage to the `AuthorizePage` approach shown above is that the Razor Page being secured requires no modifications. The authorization aspect is instead managed in *Program.cs*.

1. In *Pages/Shared/_Layout.cshtml*, incorporate the following changes:

    [!code-cshtml[](../code/pages/shared/_layout.cshtml?name=snippet_navlist&highlight=11-12,16)]

    The preceding change conditionally hides the **Admin** link in the header if the user isn't an administrator.

## Add the `IsAdmin` claim to a user

In order to determine which users should get the `IsAdmin=True` claim, your app is going to rely on a confirmed email address to identify the administrator.

1. In *appsettings.json*, add the highlighted property:

    [!code-json[](../code/appsettings.json?range=1-3&highlight=2)]

    This is the confirmed email address that gets the claim assigned.

1. In *Areas/Identity/Pages/Account/ConfirmEmail.cshtml.cs*, make the following changes:
    1. Incorporate the following highlighted code:

        [!code-csharp[](../code/areas/identity/pages/account/confirmemail.cshtml.cs?name=snippet_configproperty&highlight=4,6-7,10)]

        The preceding change modifies the constructor to receive an `IConfiguration` from the IoC container. The `IConfiguration` contains values from *appsettings.json*, and is assigned to a read-only property named `Configuration`.

    1. Apply the highlighted changes to the `OnGetAsync` method:

        [!code-csharp[](../code/areas/identity/pages/account/confirmemail.cshtml.cs?name=snippet_ongetasync&highlight=18-24)]

        In the preceding code:

        * The `AdminEmail` string is read from the `Configuration` property and assigned to `adminEmail`.
        * The null-coalescing operator `??` is used to ensure `adminEmail` is set to `string.Empty` if there's no corresponding value in *appsettings.json*.
        * If the user's email is successfully confirmed:
            * The user's address is compared to `adminEmail`. `string.Compare()` is used for case-insensitive comparison.
            * The `UserManager` class's `AddClaimAsync` method is invoked to save an `IsAdmin` claim in the `AspNetUserClaims` table.

    1. Add the following code to the top of the file. It resolves the `Claim` class references in the `OnGetAsync` method:

        ```csharp
        using System.Security.Claims;
        ```

## Test admin claim

Let's do one last test to verify the new administrator functionality.

1. Make sure you've saved all your changes.
1. Run the app with `dotnet run`.
1. Navigate to your app and sign in with an existing user, if you're not already signed in. Select **Pizza List** from the header. Notice the user isn't presented UI elements to delete or create pizzas.
1. There's no **Admins** link in the header. In the browser's address bar, navigate directly to the **AdminsOnly** page. Replace `/Pizza` in the URL with `/AdminsOnly`.

    The user is forbidden from navigating to the page. An **Access denied** message is displayed.

1. Select **Logout**.
1. Register a new user with the address `admin@contosopizza.com`.
1. As before, confirm the new user's email address and sign in.
1. Once signed in with the new administrative user, select the **Pizza List** link in the header.

    The administrative user can create and delete pizzas.

1. Select the **Admins** link in the header.

    The **AdminsOnly** page appears.

## Examine the AspNetUserClaims table

Using the SQL Server extension in VS Code, run the following query:

```sql
SELECT u.Email, c.ClaimType, c.ClaimValue
FROM dbo.AspNetUserClaims AS c
    INNER JOIN dbo.AspNetUsers AS u
    ON c.UserId = u.Id
```

A tab with results similar to the following appears:

| Email                  | ClaimType | ClaimValue |
|------------------------|-----------|------------|
| admin@contosopizza.com | IsAdmin   | True       |

The `IsAdmin` claim is stored as a key-value pair in the `AspNetUserClaims` table. The `AspNetUserClaims` record is associated with the user record in the `AspNetUsers` table.

## Summary

In this unit, you modified the app to store claims and apply policies for conditional access.
