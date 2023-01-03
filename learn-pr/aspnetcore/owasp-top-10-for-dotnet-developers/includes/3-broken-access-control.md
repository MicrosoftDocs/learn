<!-- ## A01: Broken Access Control -->

Occurs when confidential information is viewed by a user who shouldn't have permission to access that data

Good practices would include

- Authorize users on all externally facing endpoints. The .NET framework has many ways to authorize a user​
- Set a cookie policy​
- Set secure password policy​
- Understand system’s trust boundaries​

> [!TIP]
> .NET has build in authentication and session management so there is no need to implement your own.

Let's consider a ASP.NET Core controller

:::row:::
    :::column:::
        Controller with no authorization attributes.
```csharp

public class AccountController : Controller​
{​
    public ActionResult Login()​
    {​
    }
           
    public ActionResult Logout()​
    {​
    }​
}

```

:::column-end:::
    :::column:::
        Controller with authorization attributes, based on policy or role.
```csharp
[Authorize(Policy="", Roles=""]​
public class AccountController : Controller​
{​
    [AllowAnonymous]​
    public ActionResult Login()​            
    {​        
    }​
                        
    public ActionResult Logout()​            
    {​            
    }​        
}​
```

:::column-end:::
:::row-end:::

Similarly the ASP.NET Minimal Api supports the attribute decoration, policy and claim authorization

>  ```csharp
> var builder = WebApplication.CreateBuilder(args);​
>// Policy and claim use below
>builder.Services.AddAuthorization(o => o.AddPolicy("AdminsOnly", b => b.RequireClaim("admin", "true")));
> var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");​
> builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(connectionString)); ​
> builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true).AddEntityFrameworkStores<ApplicationDbContext>(); ​
> var app = builder.Build(); ​
> app.UseAuthorization();​
> // Attribute use below
> app.MapGet("/auth",  [Authorize] () => "This endpoint requires authorization.");​
> app.MapGet("/", () => "This endpoint doesn't require authorization.");​
> app.Run();

ASP.NET Blazor's razor syntax supports conditionally displayed components depending on authorization status:

```csharp
<AuthorizeView Roles="admin, superuser" Policy="content-editor">​
    <Authorized>​
        <h1>Hello, @context.User.Identity.Name!</h1>​
        <p>You can only see this content if you are authorized.</p>​
        <button @onclick="SecureMethod">Authorized Only Button</button>​
    </Authorized>​
    <NotAuthorized>​
        <h1>Authentication Failure!</h1>​
        <p>You are not signed in.</p>​
    </NotAuthorized>​
</AuthorizeView>​

@code { ​

    private void SecureMethod() ​
    { ​
        ...
    }    ​ 
}
```

The `SecureMethod` will only be accessible once the user is authorized by the application.
