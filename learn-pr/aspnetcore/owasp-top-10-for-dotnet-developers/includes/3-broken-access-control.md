<!-- ## A01: Broken Access Control -->
As you onboard to your new team and explore the codebase you discover a web project, ASP.NET Blazor. With OWASP Top 10 in mind, you setoff to deep dive into the code with security lenses on.
You start with the top of the list with #1 - broken access control. This category refers to incidents when confidential information is viewed by a user who shouldn't have permission to access that data.

### Leveraging Build-in Framework Security Capabilities

.NET has build in authentication and session management so there is no need to implement your own.
Let's consider a ASP.NET Core controller (example below). Controller without any authorization attributes treat each requests the same way without applying any security checks. By adding `Authorize` and `AllowAnonymous` attributes you can control which actions (or controllers) should inspect for authorization to be in place.

:::row:::
    :::column:::
        Plane ASP.NET controller with no authorization attributes.
```csharp

public class AccountController : Controller​
{​
        public ActionResult Login()​
        {
        }
               
        public ActionResult Logout()​
        {
        }
}

```

:::column-end:::
    :::column:::
        Controller with authorization attributes, based on policy or role assignments.
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
}​
```

:::column-end:::
:::row-end:::

Similarly the ASP.NET Minimal Api supports the attribute decoration, policy and claim authorization as seen in the example below.

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

ASP.NET Blazor's razor syntax supports conditionally displayed components depending on authorization status (code snippet below).

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


### Code Review Notes

Your team has thought of the broken access control risk and implemented Claims-Based and Policy Based authorization in your web app. Knowing the app gets deployed to Azure, other best practices  include:

- Use of Role-Based Access Control (RBAC) to restrict access to resources based on user roles
- Authorize users on all externally facing endpoints. ASP.NET  has many ways to authorize a user​ based on their role or claims
- Consider not only cookie or password policies but Multi-Factor Authentication (MFA) for sensitive operations and administrative tasks
