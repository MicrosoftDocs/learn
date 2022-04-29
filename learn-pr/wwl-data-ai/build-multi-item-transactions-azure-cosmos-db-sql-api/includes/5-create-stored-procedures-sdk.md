Creating a stored procedure using the .NET SDK requires the use of a special **Scripts** property in the **Microsoft.Azure.Cosmos.Container** class. Let’s start with an example that assumes a container instance in a variable named **container**.

1. First, define the JavaScript function for the stored procedure in a string variable.

    ```csharp
    string sproc = @"function greet() {
        var context = getContext();
        var response = context.getResponse();
        response.setBody('Hello, Learn!');
    }";
    ```

    > [!TIP]
    > Alternatively, you can use file APIs such as **System.IO.File** to read a function from a *.js file.

1. Next, create an object of type **Microsoft.Azure.Cosmos.Scripts.StoredProcedureProperties** with the **Id** and **Body** properties set to the unique identifier and content of the stored procedure, respectively.

    ```csharp
    StoredProcedureProperties properties = new()
    {
        Id = "greet",
        Body = sproc
    };
    ```

    > [!TIP] 
    > Alternatively, you can provide the identifier and body of the stored procedure as constructor parameters.

    ```csharp
        StoredProcedureProperties properties = new("greet", sproc);
    ```

1. Now, use the **CreateStoredProcedureAsync\<\>** method of the container variable to create a new stored procedure passing in the properties composed earlier.

    ```csharp
    await container.Scripts.CreateStoredProcedureAsync(properties);
    ```

    If you'd like to parse the results, the **CreateStoredProcedureAsync\<\>** method returns an object of type **Microsoft.Azure.Cosmos.Scripts.StoredProcedureResponse** that contains metadata about the newly created stored procedure within the container.
