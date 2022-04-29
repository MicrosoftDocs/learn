The **Scripts** property in the **Microsoft.Azure.Cosmos.Container** class contains a **CreateUserDefinedFunctionAsync** method that is used to create a new user-defined function from code.

> [!NOTE]
> The next set of examples assume that you already have a container variable defined.

To start, define the JavaScript function for the UDF in a string variable.

```csharp
string udf = @"function addTax(preTax) {
    return preTax * 1.15;
}";
```

> [!TIP]
> Alternatively, you can use file APIs such as **System.IO.File** to read a function from a *.js file.

Next, create an object of type **Microsoft.Azure.Cosmos.Scripts.UserDefinedFunctionProperties** with the **Id** and **Body** properties set to the unique identifier and content of the UDF, respectively.

```csharp
UserDefinedFunctionProperties properties = new()
{
    Id = "addTax",
    Body = udf
};
```

Finally, invoke the **CreateUserDefinedFunctionAsync** method of the container variable to create a new UDF passing in the properties composed earlier.

```csharp
await container.Scripts.CreateUserDefinedFunctionAsync(properties);
```
