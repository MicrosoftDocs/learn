## Customize the user account data

By default, Identity represents a user with an `IdentityUser` class. One way to extend the data being captured at registration time is to create a class deriving from `IdentityUser`. UI changes are also required to collect the additional user profile information. The following steps explain the process of collecting a first and last name for the registered user.

1. Add the user registration files to the project:

    ```bash
    dotnet aspnet-codegenerator identity \
        --dbContext ContosoPetsAuth \
        --files "Account.Manage.EnableAuthenticator;Account.Manage.Index;Account.Register" \
        --userClass ContosoPetsUser \
        --force
    ```

    The preceding command adds the following files to the *Areas/Identity* directory:

    * *Data/ContosoPetsUser.cs*
    * *Pages/Account/Manage/_ManageNav.cshtml*
    * *Pages/Account/Manage/_ViewImports_.cshtml*
    * *Pages/Account/Manage/EnableAuthenticator.cshtml*
    * *Pages/Account/Manage/EnableAuthenticator.cshtml.cs*
    * *Pages/Account/Manage/Index.cshtml*
    * *Pages/Account/Manage/Index.cshtml.cs*
    * *Pages/Account/Manage/ManageNavPages.cs*
    * *Pages/Account/Register.cshtml*
    * *Pages/Account/Register.cshtml.cs*

    Additionally, the *Data/ContosoPetsAuth.cs* file, which existed prior to running the preceding command, was overwritten. *ContosoPetsAuth.cs* now references the newly created `ContosoPetsUser` class. The *EnableAuthenticator* Razor Page was scaffolded, though it won't be modified until later in the module.

1. In the `Configure` method of *IdentityHostingStartup.cs*, the call to `AddDbContext` needs to be made aware of the new Identity user type. Incorporate the following highlighted change:

    [!code-csharp[](../code/Areas/Identity/4-IdentityHostingStartup-Configure.cs?highlight=12)]

1. Make the following changes to *Pages/Shared/_LoginPartial.cshtml*:

    * Add `@using ContosoPets.Ui.Areas.Identity.Data` to the top.
    * Change `@inject SignInManager<IdentityUser> SignInManager` to `@inject SignInManager<ContosoPetsUser> SignInManager`.
    * Change `@inject UserManager<IdentityUser> UserManager` to `@inject UserManager<ContosoPetsUser> UserManager`.

    The first four lines of *_LoginPartial.cshtml* will resemble the following code:

    [!code-cshtml[](../code/Pages/Shared/4-_LoginPartial.cshtml?range=1-4)]

    The preceding step created the `ContosoPetsUser` class, which is to be used instead of the default `IdentityUser`. *Pages/Shared/_LoginPartial.cshtml* wasn't updated automatically, so the appropriate changes must be made by hand.

    > [!TIP]
    > As an alternative to manually editing the *_LoginPartial.cshtml* file, it can be deleted prior to running the scaffold tool. The *_LoginPartial.cshtml* file will be recreated with references to the new `ContosoPetsUser` class.

1. Update *Areas/Identity/Data/ContosoPetsUser.cs* so that it supports storage and retrieval of the additional user profile data. Make the following changes:
    1. Add the following properties:

        ```csharp
        [Required]
        [MaxLength(100)]
        public string FirstName { get; set; }

        [Required]
        [MaxLength(100)]
        public string LastName { get; set; }
        ```

        The properties in the preceding snippet represent additional columns to be created in the underlying `AspNetUsers` table. Both properties are required and are therefore annotated with the `[Required]` attribute. The `[Required]` attribute also results in a non-null constraint in the underlying database table column. Additionally, the `[MaxLength]` attribute indicates that a maximum length of 100 characters is allowed. The underlying table column's data type is defined accordingly.

    1. Add the following `using` statement to the top of the file:

        ```csharp
        using System.ComponentModel.DataAnnotations;
        ```

        The preceding resolves the data annotation attributes in the previous step.

1. Create and apply an EF Core Migration to update the underlying data store:

    ```bash
    dotnet ef migrations add UpdateUser && \
        dotnet ef database update
    ```

1. Run the following command to view the table schema:

    ```bash
    db -Q "SELECT COLUMN_NAME, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH AS MAX_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='AspNetUsers'" -Y 20
    ```

    The following output displays:

    ```console
    COLUMN_NAME          IS_NULLABLE DATA_TYPE            MAX_LENGTH
    -------------------- ----------- -------------------- -----------
    Id                   NO          nvarchar                     450
    UserName             YES         nvarchar                     256
    NormalizedUserName   YES         nvarchar                     256
    Email                YES         nvarchar                     256
    NormalizedEmail      YES         nvarchar                     256
    EmailConfirmed       NO          bit                         NULL
    PasswordHash         YES         nvarchar                      -1
    SecurityStamp        YES         nvarchar                      -1
    ConcurrencyStamp     YES         nvarchar                      -1
    PhoneNumber          YES         nvarchar                      -1
    PhoneNumberConfirmed NO          bit                         NULL
    TwoFactorEnabled     NO          bit                         NULL
    LockoutEnd           YES         datetimeoffset              NULL
    LockoutEnabled       NO          bit                         NULL
    AccessFailedCount    NO          int                         NULL
    FirstName            NO          nvarchar                     100
    LastName             NO          nvarchar                     100
    ```

    The presence of the `FirstName` and `LastName` properties of the `ContosoPetsUser` class correspond to the `FirstName` and `LastName` columns in the preceding output. A data type of `nvarchar(100)` was assigned because of the `[MaxLength(100)]` attribute. The non-null constraint was added because of the `[Required]` attribute.

1. Run the following command to view the primary key for the `AspNetUsers` table:

    ```bash
    db -i $setupWorkingDirectory/list-aspnetusers-pk.sql -Y 15
    ```

    The following output shows that the `Id` column is the unique identifier for a user account:

    ```console
    Table           Column          Primary key
    --------------- --------------- ---------------
    AspNetUsers     Id              PK_AspNetUsers
    ```

## Customize the user registration form

1. In *Areas/Identity/Pages/Account/Register.cshtml*, add the following markup to the line immediately after `<div asp-validation-summary="All" class="text-danger"></div>`:

    ```cshtml
    <div class="form-group">
        <label asp-for="Input.FirstName"></label>
        <input asp-for="Input.FirstName" class="form-control" />
        <span asp-validation-for="Input.FirstName" class="text-danger"></span>
    </div>
    <div class="form-group">
        <label asp-for="Input.LastName"></label>
        <input asp-for="Input.LastName" class="form-control" />
        <span asp-validation-for="Input.LastName" class="text-danger"></span>
    </div>
    ```

    With the preceding markup, a **First Name** and a **Last Name** text box are added to the user registration form.

1. In *Areas/Identity/Pages/Account/Register.cshtml.cs*, add support for the name text boxes.
    1. Add the following properties to the `InputModel` class:

        ```csharp
        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }
        ```

    1. Modify the `OnPostAsync` method to populate set the `FirstName` and `LastName` properties on the `ContosoPetsUser` object. Replace the following code:

        ```csharp
        var user = new ContosoPetsUser { UserName = Input.Email, Email = Input.Email };
        ```

        With the following code:

        ```csharp
        var user = new ContosoPetsUser
        {
            FirstName = Input.FirstName,
            LastName = Input.LastName,
            UserName = Input.Email,
            Email = Input.Email,
        };
        ```

        With the preceding change, the `FirstName` and `LastName` properties are set to the user input from the registration form.

## Customize the site header

1. Update *Pages/Shared/_LoginPartial.cshtml* to display the first and last name collected during user registration. The highlighted lines in the following snippet are needed:

    [!code-cshtml[](../code/Pages/Shared/4-_LoginPartial.cshtml?highlight=9-10,13)]

## Customize the profile management form

1. In *Identity/Pages/Account/Manage/Index.cshtml.cs*, make the following changes to support the name text boxes.
    1. Add the following two properties to the `InputModel` class:

        ```csharp
        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }
        ```

    1. Incorporate the highlighted changes in the `OnGetAsync` method:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/4-Index.cshtml.cs?name=snippet_OnGetAsync&highlight=19-20)]

    1. Incorporate the highlighted changes in the `OnPostAsync` method:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/4-Index.cshtml.cs?name=snippet_OnPostAsync&highlight=14-16)]

        Save your changes.

1. In *Areas/Identity/Pages/Account/Manage/Index.cshtml*, add the following markup to the line immediately after `<div asp-validation-summary="All" class="text-danger"></div>`:

    ```cshtml
    <div class="form-group">
        <label asp-for="Input.FirstName"></label>
        <input asp-for="Input.FirstName" class="form-control" />
        <span asp-validation-for="Input.FirstName" class="text-danger"></span>
    </div>
    <div class="form-group">
        <label asp-for="Input.LastName"></label>
        <input asp-for="Input.LastName" class="form-control" />
        <span asp-validation-for="Input.LastName" class="text-danger"></span>
    </div>
    ```

## Build, deploy, and test

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. Deploy the site by running the following command:

    ```bash
    az webapp up
    ```

    The preceding command deploys the app to Azure App Service. The *.azure/config* file contains the configuration values used by `az webapp up`.

1. In your browser, navigate to the app. Select **Logout**.

1. Select **Register** and use the newly modified form to register a new user.

1. Run the following command to confirm that the first and last name are stored in the database:

    ```bash
    db -Q "SELECT UserName, Email, FirstName, LastName FROM dbo.AspNetUsers" -Y 25
    ```

    A variation of the following output displays:

    ```console
    UserName                  Email                     FirstName                 LastName
    ------------------------- ------------------------- ------------------------- -------------------------
    kai.klein@contoso.com     kai.klein@contoso.com
    jana.heinrich@contoso.com jana.heinrich@contoso.com Jana                      Heinrich
    ```

    The user registered prior to adding `FirstName` and `LastName` to the schema doesn't have data in those columns.

## Login as first user, update FName, LName

<!-- TODO -->
