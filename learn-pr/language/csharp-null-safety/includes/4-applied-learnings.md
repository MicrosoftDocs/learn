In the previous unit, you learned about expressing your nullability intent in code. In this unit, you'll apply what you've learned to an existing C# project.

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet6-sdk-version.md)]

## Retrieve and examine the sample code

1. In a command terminal, clone the sample GitHub repository and switch to the cloned directory.

    ```bash
    git clone https://github.com/microsoftdocs/mslearn-csharp-null-safety
    cd mslearn-csharp-null-safety
    ```

1. Open the project directory in Visual Studio Code.

    ```bash
    code .
    ```

1. Run the sample project using the `dotnet run` command.

    ```dotnetcli
    dotnet run --project src/ContosoPizza.Service/ContosoPizza.Service.csproj
    ```

    This will result in a <xref:System.NullReferenceException> being thrown.

    ```dotnetcli
    dotnet run --project src/ContosoPizza.Service/ContosoPizza.Service.csproj
    Unhandled exception. System.NullReferenceException: Object reference not set to an instance of an object.
       at Program.<Main>$(String[] args) in .\src\ContosoPizza.Service\Program.cs:line 13
    ```

    The stack trace indicates that the exception occurred on line 13 in *.\src\ContosoPizza.Service\Program.cs*. On line 13, the `Add` method is called on the `pizza.Cheeses` property. Since `pizza.Cheeses` is `null`, a <xref:System.NullReferenceException> is thrown.

    :::code source="~/../csharp-null-safety-main/src/ContosoPizza.Service/Program.cs" highlight="13":::

## Enable nullable context

Now you'll enable a nullable context and examine its effect on the build.

1. In *src/ContosoPizza.Service/ContosoPizza.Service.csproj*, add the highlighted line and save your changes:

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Service/ContosoPizza.Service.csproj" highlight="7" range="1-7,9-15":::

    The preceding change enables the nullable context for the entire `ContosoPizza.Service` project.

1. In *src/ContosoPizza.Models/ContosoPizza.Models.csproj*, add the highlighted line and save your changes:

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Models/ContosoPizza.Models.csproj" highlight="6" range="1-6,8-10":::

    The preceding change enables the nullable context for the entire `ContosoPizza.Models` project.

1. Build the sample solution using the `dotnet build` command.

    ```dotnetcli
    dotnet build
    ```

    The build succeeds with 2 warnings.

    ```dotnetcli
    dotnet build
    Microsoft (R) Build Engine version 17.0.0+c9eb9dd64 for .NET
    Copyright (C) Microsoft Corporation. All rights reserved.
    
      Determining projects to restore...
      Restored .\src\ContosoPizza.Service\ContosoPizza.Service.csproj (in 477 ms).
      Restored .\src\ContosoPizza.Models\ContosoPizza.Models.csproj (in 475 ms).
    .\src\ContosoPizza.Models\Pizza.cs(3,28): warning CS8618: Non-nullable property 'Cheeses' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
    .\src\ContosoPizza.Models\Pizza.cs(3,28): warning CS8618: Non-nullable property 'Toppings' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
      ContosoPizza.Models -> .\src\ContosoPizza.Models\bin\Debug\net6.0\ContosoPizza.Models.dll
      ContosoPizza.Service -> .\src\ContosoPizza.Service\bin\Debug\net6.0\ContosoPizza.Service.dll
    
    Build succeeded.
    
    .\src\ContosoPizza.Models\Pizza.cs(3,28): warning CS8618: Non-nullable property 'Cheeses' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
    .\src\ContosoPizza.Models\Pizza.cs(3,28): warning CS8618: Non-nullable property 'Toppings' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
        2 Warning(s)
        0 Error(s)
    
    Time Elapsed 00:00:07.48
    ```

1. Build the sample solution **again** using the `dotnet build` command.

    ```dotnetcli
    dotnet build
    ```

    This time, the build succeeds with no errors or warnings. The previous build completed successfully, with warnings. Since the source didn't change, the build process doesn't run the compiler again. Since the build doesn't run the compiler, there are no warnings.

    > [!TIP]
    > You can force a rebuild of all assemblies in a project by using the `dotnet clean` command prior to `dotnet build`.

1. In the *.csproj* files, add the highlighted lines and save your changes.

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Service/ContosoPizza.Service.csproj" highlight="8":::

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Models/ContosoPizza.Models.csproj" highlight="7":::

    The previous changes instruct the compiler to fail the build whenever a warning is encountered.

    > [!TIP]
    > The use of `<TreatWarningsAsErrors>` is optional. However, we recommend it as it ensures you don't overlook any warnings.

1. Build the sample solution using the `dotnet build` command.

    ```dotnetcli
    dotnet build
    ```

    The build fails with 2 errors.

    ```dotnetcli
    dotnet build
    Microsoft (R) Build Engine version 17.0.0+c9eb9dd64 for .NET
    Copyright (C) Microsoft Corporation. All rights reserved.
    
      Determining projects to restore...
      All projects are up-to-date for restore.
    .\src\ContosoPizza.Models\Pizza.cs(3,28): error CS8618: Non-nullable property 'Cheeses' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
    .\src\ContosoPizza.Models\Pizza.cs(3,28): error CS8618: Non-nullable property 'Toppings' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
    
    Build FAILED.
    
    .\src\ContosoPizza.Models\Pizza.cs(3,28): error CS8618: Non-nullable property 'Cheeses' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
    .\src\ContosoPizza.Models\Pizza.cs(3,28): error CS8618: Non-nullable property 'Toppings' must contain a non-null value when exiting constructor. Consider declaring the property as nullable. [.\src\ContosoPizza.Models\ContosoPizza.Models.csproj]
        0 Warning(s)
        2 Error(s)
    
    Time Elapsed 00:00:02.95
    ```

    When treating warnings as errors, the app no longer builds. This is in fact desired in this situation, as the number of errors is small and we'll quickly address them. The two errors (CS8618) let you know there are properties declared as non-nullable that haven't yet been initialized.

## Fix the errors

There are many tactics to resolve the warnings/errors related to nullability. Some examples include:

- Require a non-nullable collection of cheeses and toppings as constructor parameters
- Intercept the property `get`/`set` and add a `null` check
- Express the intent for the properties to be nullable
- Initialize the collection with a default (empty) value inline using property initializers
- Assign the property a default (empty) value in the constructor

1. To fix the error on the `Pizza.Cheeses` property, modify the property definition on *Pizza.cs* to add a `null` check. It's not really a pizza without cheese, is it?

    :::code source="~/../csharp-null-safety-solution/src/ContosoPizza.Models/Pizza.cs" highlight="5,16-20":::

    In the preceding code:

    - A new backing field is added to help intercept the `get` and `set` property accessors named `_cheeses`. It's declared as nullable (`?`) and left uninitialized.
    - The `get` accessor is mapped to an expression that uses the null-coalescing operator (`??`). This expression returns the `_cheeses` field, assuming it's not `null`. If it's `null`, it assigns `_cheeses` to `new List<PizzaCheese>()` before returning `_cheeses`.
    - The `set` accessor is also mapped to an expression and makes use of the null-coalescing operator. When a consumer assigns a `null` value the <xref:System.ArgumentNullException> is thrown.

1. Since not all pizzas have toppings, `null` might be a valid value for the `Pizza.Toppings` property. In this case, it makes sense to express it as being nullable.

    1. Modify the property definition on *Pizza.cs* to allow `Toppings` to be nullable.

        :::code source="~/../csharp-null-safety-solution/src/ContosoPizza.Models/Pizza.cs" highlight="22":::

        The `Toppings` property is now expressed as being nullable.

    1. Add the highlighted line to *ContosoPizza.Service\Program.cs*:

        :::code source="~/../csharp-null-safety-solution/src/ContosoPizza.Service/Program.cs" highlight="17":::

    In the preceding code, the null-coalescing operator is used to assign `Toppings` to `new List<PizzaTopping>();` if it's `null`.

## Run the completed solution

1. Save your all your changes and then build the solution.

    ```dotnetcli
    dotnet build
    ```

    The build completes with no warnings or errors.

1. Run the app.

    ```dotnetcli
    dotnet run --project src/ContosoPizza.Service/ContosoPizza.Service.csproj
    ```

    The app runs to completion (without error) and displays the following output:

    ```dotnetcli
    dotnet run --project src/ContosoPizza.Service/ContosoPizza.Service.csproj
    The "Meat Lover's Special" is a deep dish pizza with marinara sauce.
    It's covered with a blend of mozzarella and parmesan cheese.
    It's layered with sausage, pepperoni, bacon, ham and meatballs.
    This medium size is $17.99. Delivery is $2.50 more, bringing your total $20.49!
    ```

## Summary

In this unit, you used a nullable context to identify and prevent possible `NullReferenceException` occurrences in your code.
