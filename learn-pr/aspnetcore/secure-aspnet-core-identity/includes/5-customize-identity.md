In the previous unit, you learned how customization works in ASP.NET Core Identity. In this unit, you extend the Identity data model and make the corresponding UI changes.

## Customize the user account UI

In this section, you're going to create and customize the Identity UI files to be used in lieu of the default Razor Class Library.

1. Add the user registration files to be modified to the project:

    ```dotnetcli
    dotnet aspnet-codegenerator identity --dbContext RazorPagesPizzaAuth --files "Account.Manage.EnableAuthenticator;Account.Manage.Index;Account.Register;Account.ConfirmEmail"
    ```

    In the preceding command:

    * The `--dbContext` option provides the tool with knowledge of the existing `DbContext`-derived class named `RazorPagesPizzaAuth`.
    * The `--files` option specifies a semicolon-delimited list of unique files to be added to the *Identity* area.
        * `Account.Manage.Index` is the profile management page. This page is modified later in this unit.
        * `Account.Register` is the user registration page. This page is also modified in this unit.
        * `Account.Manage.EnableAuthenticator` and `Account.ConfirmEmail` are scaffolded but not modified in this unit.

    > [!TIP]
    > Run the following command from the project root to view valid values for the `--files` option:
    > `dotnet aspnet-codegenerator identity --listFiles`

    The following files are added to the *:::no-loc text="Areas/Identity":::* directory:

    * **:::no-loc text="Pages/":::**
        * *:::no-loc text="_ViewImports.cshtml":::*
        * **:::no-loc text="Account/":::**
            * *:::no-loc text="_ViewImports.cshtml":::*
            * *:::no-loc text="ConfirmEmail.cshtml":::*
            * *:::no-loc text="ConfirmEmail.cshtml.cs":::*
            * *:::no-loc text="Register.cshtml":::*
            * *:::no-loc text="Register.cshtml.cs":::*
            * **:::no-loc text="Manage/":::**
                * *:::no-loc text="_ManageNav.cshtml":::*
                * *:::no-loc text="_ViewImports.cshtml":::*
                * *:::no-loc text="EnableAuthenticator.cshtml":::*
                * *:::no-loc text="EnableAuthenticator.cshtml.cs":::*
                * *:::no-loc text="Index.cshtml":::*
                * *:::no-loc text="Index.cshtml.cs":::*
                * *:::no-loc text="ManageNavPages.cs":::*

## Extend `IdentityUser`

You're given a new requirement to store your users' names. Since the default `IdentityUser` class doesn't contain properties for first and last names, you need to extend the `RazorPagesPizzaUser` class.

Make the following changes to *:::no-loc text="Areas/Identity/Data/RazorPagesPizzaUser.cs":::*:

1. Add the `FirstName` and `LastName` properties:

    [!code-csharp[](../code/areas/identity/data/razorpagespizzauser.cs?highlight=7-15)]

    The properties in the preceding snippet represent additional columns to be created in the underlying `AspNetUsers` table. Both properties are required and are therefore annotated with the `[Required]` attribute. Additionally, the `[MaxLength]` attribute indicates that a maximum length of 100 characters is allowed. The underlying table column's data type is defined accordingly. A default value of `string.Empty` is assigned since nullable context is enabled in this project and the properties are non-nullable strings.

1. Add the following `using` statement to the top of the file.

    ```csharp
    using System.ComponentModel.DataAnnotations;
    ```

    The preceding code resolves the data annotation attributes applied to the `FirstName` and `LastName` properties.

## Update the database

Now that the model changes are made, accompanying changes must be made to the database.

1. Ensure that all your changes are saved.
1. Create and apply an EF Core migration to update the underlying data store:

    ```dotnetcli
    dotnet ef migrations add UpdateUser
    dotnet ef database update
    ```

    The `UpdateUser` EF Core migration applied a DDL change script to the `AspNetUsers` table's schema. Specifically, `FirstName` and `LastName` columns were added, as seen in the following migration output excerpt:

    ```console
    info: Microsoft.EntityFrameworkCore.Database.Command[20101]
        Executed DbCommand (37ms) [Parameters=[], CommandType='Text', CommandTimeout='30']
        ALTER TABLE [AspNetUsers] ADD [FirstName] nvarchar(100) NOT NULL DEFAULT N'';
    info: Microsoft.EntityFrameworkCore.Database.Command[20101]
        Executed DbCommand (36ms) [Parameters=[], CommandType='Text', CommandTimeout='30']
        ALTER TABLE [AspNetUsers] ADD [LastName] nvarchar(100) NOT NULL DEFAULT N'';
    ```

1. Examine the database to analyze the effect of the `UpdateUser` EF Core migration on the `AspNetUsers` table's schema.

    In the **SQL Server** pane, expand the **Columns** node on the **dbo.AspNetUsers** table.

    :::image type="content" source="../media/aspnetusers-custom.png" alt-text="Screenshot of the schema of the AspNetUsers table." lightbox="../media/aspnetusers-custom.png":::

    The `FirstName` and `LastName` properties in the `RazorPagesPizzaUser` class correspond to the `FirstName` and `LastName` columns in the preceding image. A data type of `nvarchar(100)` was assigned to each of the two columns because of the `[MaxLength(100)]` attributes. The non-null constraint was added because `FirstName` and `LastName` in the class are non-nullable strings. Existing rows show empty strings in the new columns.

## Customize the user registration form

You added new columns for `FirstName` and `LastName`. Now you need to edit the UI to display matching fields on the registration form.

1. In *:::no-loc text="Areas/Identity/Pages/Account/Register.cshtml":::*, add the following highlighted markup:

    [!code-cshtml[](../code/areas/identity/pages/account/register-firstandlastname.cshtml?range=1-19&highlight=5-14)]

    With the preceding markup, **First name** and **Last name** text boxes are added to the user registration form.

1. In *:::no-loc text="Areas/Identity/Pages/Account/Register.cshtml.cs":::*, add support for the name text boxes.
    1. Add the `FirstName` and `LastName` properties to the `InputModel` nested class:

        [!code-csharp[](../code/areas/identity/pages/account/register-snippets.cshtml.cs?name=snippet_inputmodel&highlight=3-6,8-11)]

        The `[Display]` attributes define the label text to be associated with the text boxes.

    1. Modify the `OnPostAsync` method to set the `FirstName` and `LastName` properties on the `RazorPagesPizza` object. Add the following highlighted lines:

        [!code-csharp[](../code/areas/identity/pages/account/register-snippets.cshtml.cs?name=snippet_onpostasync&highlight=9-10)]

        The preceding change sets the `FirstName` and `LastName` properties to the user input from the registration form.

## Customize the site header

Update *:::no-loc text="Pages/Shared/_LoginPartial.cshtml":::* to display the first and last name collected during user registration. The highlighted lines in the following snippet are needed:

[!code-cshtml[](../code/pages/shared/_loginpartial.cshtml?name=snippet_razorpagesuser&highlight=4-5,8)]

`UserManager.GetUserAsync(User)` returns a nullable `RazorPagesPizzaUser` object. The null-conditional `?.` operator is used to access the `FirstName` and `LastName` properties only if the `RazorPagesPizzaUser` object isn't null.

## Customize the profile management form

You've added the new fields to the user registration form, but you should also add them to the profile management form so existing users can edit them.

1. In *:::no-loc text="Areas/Identity/Pages/Account/Manage/Index.cshtml":::*, add the following highlighted markup. Save your changes.

    [!code-cshtml[](../code/areas/identity/pages/account/manage/index-firstandlastname.cshtml?range=1-16&highlight=3-12)]

1. In *:::no-loc text="Areas/Identity/Pages/Account/Manage/Index.cshtml.cs":::*, make the following changes to support the name text boxes.
    1. Add the `FirstName` and `LastName` properties to the `InputModel` nested class:

        [!code-csharp[](../code/areas/identity/pages/account/manage/index-snippets.cshtml.cs?name=snippet_firstandlastnameinputmodel&highlight=3-6,8-11)]

    1. Incorporate the highlighted changes in the `LoadAsync` method:

        [!code-csharp[](../code/areas/identity/pages/account/manage/index-snippets.cshtml.cs?name=snippet_loadasync&highlight=11-12)]

        The preceding code supports retrieving the first and last names for display in the corresponding text boxes of the profile management form.

    1. Incorporate the highlighted changes in the `OnPostAsync` method. Save your changes.

        [!code-csharp[](../code/areas/identity/pages/account/manage/index-snippets.cshtml.cs?name=snippet_onpostasync&highlight=15-17)]

        The preceding code supports updating the first and last names in the database's `AspNetUsers` table.

## Configure the confirmation email sender

The first time you tested the app, you registered a user and then clicked a link to simulate confirming the user's email address. In order to send an *actual* confirmation email, you need to create an implementation of <xref:Microsoft.AspNetCore.Identity.UI.Services.IEmailSender> and register it in the dependency injection system. To keep things simple, your implementation in this unit doesn't actually send email to a Simple Mail Transfer Protocol (SMTP) server. It just writes the email content to the console.

1. Since you're going to view the email in plain text in the console, you should change the generated message to exclude HTML-encoded text. In *Areas/Identity/Pages/Account/Register.cshtml.cs*, find the following code:

    ```csharp
    await _emailSender.SendEmailAsync(Input.Email, "Confirm your email",
        $"Please confirm your account by <a href='{HtmlEncoder.Default.Encode(callbackUrl)}'>clicking here</a>.");
    ```

    Change it to:

    ```csharp
    await _emailSender.SendEmailAsync(Input.Email, "Confirm your email",
        $"Please confirm your account by visiting the following URL:\r\n\r\n{callbackUrl}");
    ```

1. In the **Explorer** pane, right-click the *RazorPagesPizza\Services* folder and create a new file named *EmailSender.cs*. Open the file and add the following code:

    ```csharp
    using Microsoft.AspNetCore.Identity.UI.Services;
    namespace RazorPagesPizza.Services;
    
    public class EmailSender : IEmailSender
    {
        public EmailSender() {}
    
        public Task SendEmailAsync(string email, string subject, string htmlMessage)
        {
            Console.WriteLine();
            Console.WriteLine("Email Confirmation Message");
            Console.WriteLine("--------------------------");
            Console.WriteLine($"TO: {email}");
            Console.WriteLine($"SUBJECT: {subject}");
            Console.WriteLine($"CONTENTS: {htmlMessage}");
            Console.WriteLine();
            
            return Task.CompletedTask;
        }
    }
    ```

    The preceding code creates an implementation of <xref:Microsoft.AspNetCore.Identity.UI.Services.IEmailSender> that writes the contents of the message to the console. In a real-world implementation, `SendEmailAsync` would connect to an external mail service or some other action to send email.

1. In *Program.cs*, add the highlighted lines:

    [!code-csharp[](../code/program-after-customization.cs?range=1-5,7-16,22-23&highlight=4-5,15)]

    The preceding registers `EmailSender` as an `IEmailSender` in the dependency injection system.

## Test the changes to the registration form

That's everything! Let's test the changes to the registration form and confirmation email.

1. Make sure you saved all your changes.
1. In the terminal pane, build the project and run the app with `dotnet run`.
1. In your browser, navigate to the app. Select **Logout** if you're logged in.
1. Select **Register** and use the updated form to register a new user.

    > [!NOTE]
    > The validation constraints on the **First name** and **Last name** fields reflect the data annotations on the `FirstName` and `LastName` properties of `InputModel`.

1. After registering, you get redirected to the **Register confirmation** screen. In the terminal pane, scroll up to find the console output that resembles the following:

    ```console
    Email Confirmation Message
    --------------------------
    TO: jana.heinrich@contoso.com
    SUBJECT: Confirm your email
    CONTENTS: Please confirm your account by visiting the following URL:
    
    https://localhost:7192/Identity/Account/ConfirmEmail?<query string removed>
    ```

    Navigate to the URL with <kbd>Ctrl</kbd>+*click*. The confirmation screen displays.

    > [!NOTE]
    > If you're using GitHub Codespaces, you might need to add `-7192` to the first part of the forwarded URL. For example, `scaling-potato-5gr4j4-7192.preview.app.github.dev`.

1. Select **Login** and sign in with the new user. The app's header now contains **Hello, [First name] [Last name]!**.
1. In the **SQL Server** pane in VS Code, right-click on the **RazorPagesPizza** database and select **New query**. In the tab that appears, enter the following query and press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd> to run it.

    ```sql
    SELECT UserName, Email, FirstName, LastName
    FROM dbo.AspNetUsers
    ```

    A tab with results similar to the following appears:

    | UserName                  | Email                     | FirstName | LastName |
    |---------------------------|---------------------------|-----------|----------|
    | kai.klein@contoso.com     | kai.klein@contoso.com     |           |          |
    | jana.heinrich@contoso.com | jana.heinrich@contoso.com | Jana      | Heinrich |

    The first user registered before adding `FirstName` and `LastName` to the schema. So the associated `AspNetUsers` table record doesn't have data in those columns.

## Test the changes to the profile management form

You should also test the changes you made to the profile management form.

1. In the web app, sign in with the first user you created.

1. Select the **Hello, !** link to navigate to the profile management form.

    > [!NOTE]
    > The link doesn't display correctly because the `AspNetUsers` table's row for this user doesn't contain values for `FirstName` and `LastName`.

1. Enter valid values for **First name** and **Last name**. Select **Save**.

    The app's header updates to **Hello, [First name] [Last name]!**.

1. To stop the app, press <kbd>Ctrl</kbd>+<kbd>C</kbd> in the terminal pane in VS Code.

## Summary

In this unit, you customized Identity to store custom user information. You also customized the confirmation email. In the next unit, you'll learn about implementing multifactor authentication in Identity.
