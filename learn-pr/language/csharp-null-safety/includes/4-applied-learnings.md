In the previous unit, you learned about expressing your nullablility intent in code. In this unit, you'll apply what you've learned to an existing C# project.

## Retrieve and examine the sample code

1. At a command terminal, clone the sample GitHub repository and switch to the cloned directory.

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

    The stack trace indicates that the exception occurred on line 13. On line 13, the `Add` method is called on the `pizza.Cheeses` property. Since `pizza.Cheeses` is `null`, a <xref:System.NullReferenceException> is thrown.

    :::code source="~/../csharp-null-safety-main/src/ContosoPizza.Service/Program.cs" highlight="13":::

## Enable nullable context

Now you'll enable a nullable context and examine its effect on the build.

1. In _src/ContosoPizza.Service/ContosoPizza.Service.csproj_, add the highlighted line and save your changes:

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Service/ContosoPizza.Service.csproj" highlight="7" range="1-7,9-15":::

    The preceding change enables the nullable context for the entire `ContosoPizza.Service` project.

1. In _src/ContosoPizza.Models/ContosoPizza.Models.csproj_, add the highlighted line and save your changes:

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Models/ContosoPizza.Models.csproj" highlight="7" range="1-6,8-10":::

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

    This time, the build succeeds with no errors or warnings. That's because the first build was successful regardless of warnings. Since the first build successfully completed, the compiler doesn't attempt to compile unchanged code again on subsequent builds. Warnings only occur at compile time. If the compiler doesn't run, warnings aren't generated.

    > [!TIP]
    > You can force a rebuild of all assemblies in a project by using the `dotnet clean` command prior to `dotnet build`.

1. In the _.csproj_ files, add the highlighted lines and save your changes.

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Service/ContosoPizza.Service.csproj" highlight="8":::

    :::code language="xml" source="~/../csharp-null-safety-solution/src/ContosoPizza.Models/ContosoPizza.Models.csproj" highlight="8":::

    The previous changes instruct the compiler to fail the build whenever a warning is encountered.

    > [!TIP]
    > The use of `<TreatWarningsAsErrors>` is optional. However, we recommend it as it ensures warnings aren't allowed to inadvertently pass a continuous integration build.

1. Build the sample solution using the `dotnet build` command.

    ```dotnetcli
    dotnet build
    ```

    The build fails with 2 errors.

    ```dotnetcli
    dotnet build
    
    #output
    #output
    #output
    ```

## Fix the errors

Possible solutions:

1. require a non-nullable collection of cheeses and toppings as .ctor parameters.
2. intercept the property get/set and add a null check.
3. express nullability as the desired property.
4. initialize the collection with a default value (empty).
5. assign it in the .ctor with a default value (empty).

