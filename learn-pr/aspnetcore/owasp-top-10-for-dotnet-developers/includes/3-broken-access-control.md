
Recall that you recently joined a team at an IT software company that has tasked you with conducting a design and code review of the team-owned codebases. As you onboard to your new team and explore the codebase, you discover a web project, ASP.NET Blazor. With OWASP Top 10 in mind, you set off on a deep dive into the code with your security lenses on.

You start at the top of the OWASP Top 10 list with *#1 - Broken Access Control*. This category refers to incidents user who shouldn’t have permission to access that data viewed confidential information.

### Built-in framework security capabilities

.NET has built-in authentication and session management so there's no need to implement your own.
Let's consider a ASP.NET Core controller. A controller without any authorization attributes treats each requests the same way without applying any security checks. By decorating controller actions or the controller itself with `Authorize` (user must be signed in and authenticated) or `AllowAnonymous` (any unauthenticated caller can invoke method) attributes, you gain control over what can be accessed publicly and which functionality is for authorized users only.

:::row:::
    :::column:::
        Plain ASP.NET controller with no authorization attributes, no access restrictions applied.
```csharp

public class AccountController : Controller​
{​
    public ActionResult Login()​
    {
    }
            
    public ActionResult Logout()​
    {
    }

    public ActionResult<string> GetCitizenTaxId()​
    {
    }
}

```

:::column-end:::
    :::column:::
        Controller with authorization attributes, based on policy or role assignments. Authorized caller is able to invoke the `GetCitizenTaxId` method.
```csharp
[Authorize(Policy="", Roles=""]​
public class AccountController : Controller​
{​
    [AllowAnonymous]​
    public ActionResult Login()​            
    {
    }
                        
    public ActionResult Logout()​            
    {
    }
    
    [Authorize]
    public ActionResult<string> GetCitizenTaxId()​
    {
    }
}​
```

:::column-end:::
:::row-end:::

Similarly, the ASP.NET Minimal API supports the attribute decoration (Lambda *HTTP get* method with `[Authorize]` attribute), policy (AdminsOnly) and claim (admin) authorization, as seen in the example:

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

Your application's user interface should also reflect the user's authentication (the user is who they say they are) and authorization (whether the user is allowed to access certain information) state. Here, too, the OWASP Top 10 framework has you covered. ASP.NET Blazor's razor syntax supports conditionally displayed components depending on authorization status. The `AutorizeView` component selectively displays UI content based on user's authorized status.

```csharp
<AuthorizeView Roles="admin, superuser">​
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
        // Invoked only upon successful authorization
    }    ​ 
}
```

The `SecureMethod` is accessible once the user is authorized. Since `AutorizeView` component can validate against roles or policies, only role claim for either the *admin* or *superuser* roles would show the button.

### Code review notes

You and your team have considered the broken access control risk and implemented Claims-based and Policy-based authorization in your web app. Knowing the app gets deployed to Azure, other best practices include:

- Authorize users on all externally facing endpoints.
- Use role-based and policy-based authorization in your application. ASP.NET has many ways to authorize a user​ based on their role or claims.
