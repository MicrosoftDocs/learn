By default, Identity represents a user with an `IdentityUser` class. One way to extend the data being captured at registration time is to create a class deriving from `IdentityUser`. In this unit, a derived class named `ContosoPetsUser` is created. `ContosoPetsUser` will contain properties to store the user's first and last name.

![derived IdentityUser class](../media/4-contosopetsuser.png)

UI changes are also required to collect the additional user profile information. The following steps explain the process of collecting a first and last name for the registered user.

## Customize the user account data

1. Add the user registration files to be modified to the project:

    ```bash
    dotnet aspnet-codegenerator identity \
        --dbContext ContosoPetsAuth \
        --files "Account.Manage.EnableAuthenticator;Account.Manage.Index;Account.Register" \
        --userClass ContosoPetsUser \
        --force
    ```

    In the preceding command:

    * The `--dbContext` option provides the tool with knowledge of the existing `DbContext`-derived class named `ContosoPetsAuth`.
    * The `--files` option specifies a semicolon-delimited list of unique files to be added to the *Identity* area.
    * The `--userClass` option results in the creation of an `IdentityUser`-derived class named `ContosoPetsUser`.
    * The `--force` option causes existing files in the *Identity* area to be overwritten.

    > [!TIP]
    > Run the `dotnet aspnet-codegenerator identity --listFiles --force` command from the project root to view valid values for the `--files` option.

    The following files are added to the *Areas/Identity* directory:

    * **Data/**
        * *ContosoPetsUser.cs*
    * **Pages/**
        * *_ViewImports.cshtml*
    * **Pages/Account/**
        * *_ViewImports.cshtml*
        * *Register.cshtml*
        * *Register.cshtml.cs*
    * **Pages/Account/Manage/**
        * *_ManageNav.cshtml*
        * *_ViewImports.cshtml*
        * *EnableAuthenticator.cshtml*
        * *EnableAuthenticator.cshtml.cs*
        * *Index.cshtml*
        * *Index.cshtml.cs*
        * *ManageNavPages.cs*

    Additionally, the *Data/ContosoPetsAuth.cs* file, which existed prior to running the preceding command, was overwritten because the `--force` option was used. The `ContosoPetsAuth` class declaration now references the newly created user type of `ContosoPetsUser`:

    ```csharp
    public class ContosoPetsAuth : IdentityDbContext<ContosoPetsUser>
    ```

    The *EnableAuthenticator* Razor page was scaffolded, though it won't be modified until later in the module.

1. In the `Configure` method of *IdentityHostingStartup.cs*, the call to `AddDefaultIdentity` needs to be made aware of the new Identity user type. Incorporate the following highlighted change, and save the file.

    [!code-csharp[](../code/Areas/Identity/IdentityHostingStartup.cs?name=snippet_ConfigureAddDefaultIdentity&highlight=1)]

1. Update *Pages/Shared/_LoginPartial.cshtml* to incorporate the following highlighted changes. Save your changes.

    [!code-cshtml[](../code/Pages/Shared/4-_LoginPartial.cshtml?range=1-6&highlight=2-4)]

    The preceding changes update the user type passed to both `SignInManager<T>` and `UserManager<T>` in the `@inject` directives. Instead of the default `IdentityUser` type, `ContosoPetsUser` user is now referenced. The `@using` directive was added to resolve the `ContosoPetsUser` references.

    *Pages/Shared/_LoginPartial.cshtml* is physically located outside of the *Identity* area. Consequently, the file wasn't updated automatically. The appropriate changes had be made manually.

    > [!TIP]
    > As an alternative to manually editing the *_LoginPartial.cshtml* file, it can be deleted prior to running the scaffold tool. The *_LoginPartial.cshtml* file will be recreated with references to the new `ContosoPetsUser` class.

1. Update *Areas/Identity/Data/ContosoPetsUser.cs* to support storage and retrieval of the additional user profile data. Make the following changes:
    1. Add the `FirstName` and `LastName` properties:

        [!code-csharp[](../code/Areas/Identity/Data/ContosoPetsUser.cs?highlight=3-5,7-9)]

        The properties in the preceding snippet represent additional columns to be created in the underlying `AspNetUsers` table. Both properties are required and are therefore annotated with the `[Required]` attribute. The `[Required]` attribute also results in a non-null constraint in the underlying database table column. Additionally, the `[MaxLength]` attribute indicates that a maximum length of 100 characters is allowed. The underlying table column's data type is defined accordingly.

    1. Add the following `using` statement to the top of the file. Save your changes.

        ```csharp
        using System.ComponentModel.DataAnnotations;
        ```

        The preceding code resolves the data annotation attributes applied to the `FirstName` and `LastName` properties.

## Update the database

1. Create and apply an EF Core migration to update the underlying data store:

    ```bash
    dotnet ef migrations add UpdateUser && \
        dotnet ef database update
    ```

    The `UpdateUser` EF Core migration applied a DDL change script to the `AspNetUsers` table's schema. Specifically, `FirstName` and `LastName` columns were added.

    Let's analyze the impact of the `UpdateUser` EF Core migration on the `AspNetUsers` table's schema. After completing the following steps, you'll gain an understanding of the impact extending the Identity data model has on the underlying data store.

::: zone pivot="pg"

2. Run the following command to view the table schema:

    ```bash
    db -c '\d "AspNetUsers"'
    ```

    The following output displays:

    ```console
                                        Table "public.AspNetUsers"
            Column        |           Type           | Collation | Nullable |        Default
    ----------------------+--------------------------+-----------+----------+-----------------------
        Id                   | text                     |           | not null |
        UserName             | character varying(256)   |           |          |
        NormalizedUserName   | character varying(256)   |           |          |
        Email                | character varying(256)   |           |          |
        NormalizedEmail      | character varying(256)   |           |          |
        EmailConfirmed       | boolean                  |           | not null |
        PasswordHash         | text                     |           |          |
        SecurityStamp        | text                     |           |          |
        ConcurrencyStamp     | text                     |           |          |
        PhoneNumber          | text                     |           |          |
        PhoneNumberConfirmed | boolean                  |           | not null |
        TwoFactorEnabled     | boolean                  |           | not null |
        LockoutEnd           | timestamp with time zone |           |          |
        LockoutEnabled       | boolean                  |           | not null |
        AccessFailedCount    | integer                  |           | not null |
        FirstName            | character varying(100)   |           | not null | ''::character varying
        LastName             | character varying(100)   |           | not null | ''::character varying
    ```

    The `FirstName` and `LastName` properties in the `ContosoPetsUser` class correspond to the `FirstName` and `LastName` columns in the preceding output. A data type of `character varying(100)` was assigned to each of the two columns because of the `[MaxLength(100)]` attributes. The non-null constraint was added because of the `[Required]` attributes.

3. Scroll down until the following index information displays:

    ```console
    Indexes:
        "PK_AspNetUsers" PRIMARY KEY, btree ("Id")
        "UserNameIndex" UNIQUE, btree ("NormalizedUserName")
        "EmailIndex" btree ("NormalizedEmail")
    ```

    The `PK_AspNetUsers` index shows that the `Id` column is the unique identifier for a user account.

4. Press <kbd>q</kbd> to exit the text viewer.

::: zone-end

::: zone pivot="sql"

2. Run the following command to view the table schema:

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

    The `FirstName` and `LastName` properties in the `ContosoPetsUser` class correspond to the `FirstName` and `LastName` columns in the preceding output. A data type of `nvarchar(100)` was assigned to each of the two columns because of the `[MaxLength(100)]` attributes. The non-null constraint was added because of the `[Required]` attributes.

3. Run the following command to view the primary key for the table:

    ```bash
    db -i $setupWorkingDirectory/list-aspnetusers-pk.sql -Y 15
    ```

    The following output shows that the `Id` column is the unique identifier for a user account:

    ```console
    Table           Column          Primary key
    --------------- --------------- ---------------
    AspNetUsers     Id              PK_AspNetUsers
    ```

::: zone-end

## Customize the user registration form

1. In *Areas/Identity/Pages/Account/Register.cshtml*, add the following highlighted markup:

    [!code-cshtml[](../code/Areas/Identity/Pages/Account/4-Register-FirstAndLastName.cshtml?range=1-19&highlight=5-14)]

    With the preceding markup, **First Name** and **Last Name** text boxes are added to the user registration form.

1. In *Areas/Identity/Pages/Account/Register.cshtml.cs*, add support for the name text boxes.
    1. Add the `FirstName` and `LastName` properties to the `InputModel` class:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/4-Register-FirstAndLastName.cshtml.cs?highlight=3-6,8-11)]

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

Update *Pages/Shared/_LoginPartial.cshtml* to display the first and last name collected during user registration. The highlighted lines in the following snippet are needed:

[!code-cshtml[](../code/Pages/Shared/4-_LoginPartial.cshtml?highlight=9-10,13)]

## Customize the profile management form

1. In *Areas/Identity/Pages/Account/Manage/Index.cshtml*, add the following highlighted markup. Save your changes.

    [!code-cshtml[](../code/Areas/Identity/Pages/Account/Manage/4-Index-FirstAndLastName.cshtml?range=1-16&highlight=3-12)]

1. In *Areas/Identity/Pages/Account/Manage/Index.cshtml.cs*, make the following changes to support the name text boxes.
    1. Add the `FirstName` and `LastName` properties to the `InputModel` class:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/4-Index.cshtml.cs?name=snippet_FirstAndLastNameInputModel&highlight=3-6,8-11)]

    1. Incorporate the highlighted changes in the `OnGetAsync` method:

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/4-Index.cshtml.cs?name=snippet_OnGetAsync&highlight=19-20)]

        The preceding code supports retrieving the first and last names for display in the corresponding text boxes of the profile management form.

    1. Incorporate the highlighted changes in the `OnPostAsync` method. Save your changes.

        [!code-csharp[](../code/Areas/Identity/Pages/Account/Manage/4-Index.cshtml.cs?name=snippet_OnPostAsync&highlight=14-16)]

        The preceding code supports updating the first and last names in the database's `AspNetUsers` table.

## Build, deploy, and test

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. [!INCLUDE[az webapp up command](../../includes/az-webapp-up-command.md)]

1. In your browser, navigate to the app. Select **Logout** if you're still logged in.

    > [!TIP]
    > If you need the URL to your app, display it with the following command:
    >
    > ```bash
    > echo $webAppUrl
    > ```

1. Select **Register** and use the newly modified form to register a new user.

    > [!NOTE]
    > The validation constraints on the **First Name** and **Last Name** fields reflect the data annotations on the `FirstName` and `LastName` properties of `InputModel`.

1. Run the following command to confirm that the first and last names are stored in the database:

    ::: zone pivot="pg"

    ```bash
    db -c 'SELECT "UserName", "Email", "FirstName", "LastName" FROM "AspNetUsers"'
    ```

    A variation of the following output displays:

    ```console
             UserName          |            Email          | FirstName | LastName
    ---------------------------+---------------------------+-----------+----------
     kai.klein@contoso.com     | kai.klein@contoso.com     |           |
     jana.heinrich@contoso.com | jana.heinrich@contoso.com | Jana      | Heinrich
    (2 rows)
    ```

    ::: zone-end

    ::: zone pivot="sql"

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

    ::: zone-end

    The user registered prior to adding `FirstName` and `LastName` to the schema. Consequently, the associated `AspNetUsers` table record doesn't have data in those columns.

## Test the changes to the profile management form

1. In the web app, log in with the first user you created.

1. Click the **Hello, !** link to navigate to the profile management form.

    > [!NOTE]
    > The link doesn't display correctly because there aren't yet any values for `FirstName` or `LastName` for this user.

1. Enter valid values for **First Name** and **Last Name**. Select **Save**.
