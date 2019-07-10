## Add user registration support

1. Install the ASP.NET Core scaffolder:

    ```bash
    dotnet tool install -g dotnet-aspnet-codegenerator
    ```

1. Add the following NuGet package to the *ContosoPets.Ui* project:

    ```bash
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
    ```

1. Add the Identity Razor Class Library to the project. Run the following command from the root of the *ContosoPets.Ui* project:

    ```bash
    dotnet aspnet-codegenerator identity --useDefaultUI --dbContext ContosoPetsAuth
    ```

1. Modify the `Configure` method of *Startup.cs* in *ContosoPets.Ui*. Add the following:

    ```csharp
    var builder = new SqlConnectionStringBuilder(
            Configuration.GetConnectionString("Movies"));
    builder.Password = Configuration["DbPassword"];
    _connection = builder.ConnectionString;
    ```

1. In the `Configure` method of *Startup.cs* in *ContosoPets.Ui*, replace the `` comment with the following:

    ```csharp
    app.UseAuthentication();
    ```

1. Create and run an EF Migration to update the database:

    ```bash
    dotnet ef migrations add CreateIdentitySchema && \
        dotnet ef database update
    ```

::: zone pivot="pg"

```bash
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
```

::: zone-end

::: zone pivot="sql"



::: zone-end