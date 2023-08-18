In the previous unit, you added default ASP.NET Core Identity functionality to an ASP.NET Core web app. In this unit, you learn about customizing and extending ASP.NET Core Identity.

## Extending the Identity data model

By default, Identity represents a user with an `IdentityUser` class. One way to extend the data captured at registration time is to create a class deriving from `IdentityUser`. In the next unit, a derived class named `RazorPagesPizzaUser` is created. `RazorPagesPizzaUser` contains properties to store the user's first and last name.

:::image type="content" source="../media/razorpagespizzauser.png" alt-text="Screenshot of RazorPagesPizzaUser class derived from IdentityUser." lightbox="../media/razorpagespizzauser.png":::

Extending the data model requires changes to the underlying database. Luckily, Entity Framework Core makes this task simple with migrations.

## Customizing the Identity user interface

The default Identity UI components are packaged in a .NET Standard Razor Class Library (RCL). Because an RCL is used, few files are added to the project when using the default UI.

When customizing the UI, you must first use the `aspnet-codegenerator` tool again to create files to be used in lieu of the RCL. The tool allows you to explicitly select which files are created. UI components from the RCL are used if the corresponding files aren't present.

## Summary

In this unit, you learned about extending and customizing ASP.NET Core Identity. In the next unit, you can customize the Identity UI.
