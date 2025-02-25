The Swagger UI lets you interact with and visualize an API's resources without requiring access to the source code. The graphical representation of your API is automatically generated from your OpenAPI specification, and makes it easier for other developers to build apps that consume your APIs.

The Swagger UI visualizes operations and methods clearly, as shown in the following image.

:::image type="content" source="../media/Swagger_UI.png" alt-text="Operations of API in Swagger UI." loc-scope="third-party"::: <!-- Swagger, no-loc -->

The Swagger UI also allows you to interact, and even try out each operation.

:::image type="content" source="../media/Swagger_UI_interact.png" alt-text="Interaction with API Operation in Swagger UI." loc-scope="third-party":::

Automatically creating your API documentation with the Swashbuckle and Swagger tooling can help third parties understand your API's resources. But what if you wanted to go a little further and provide even more detailed information? If you're using an API for the first time, you want as much information as possible.

## XML comments

You can create documentation for your code by including XML comments. You would typically place these comments directly before the code block about which you're commenting.

```csharp
/// <summary>
/// Returns a group of Employees matching the given first and last names.
/// </summary>
/// <remarks>
/// Here is a sample remarks placeholder.
/// </remarks>
/// <param name="firstName">The first name to search for</param>
/// <param name="lastName">The last name to search for</param>
/// <returns>A string status</returns>
[HttpGet]
[Route("byname/{firstName}/{lastName}")]
public ActionResult<string> GetByName(string firstName, string lastName)
{
    return "Found another University employee";
}
```

Here's the XML nodes in use:

- summary: A high-level summary of what the method/class/field is or does.
- remarks: More detail about the method/class/field.
- param: A parameter to the method, and what it represents.
- returns: A description of what the method returns.

Once you [enable XML comments](/aspnet/core/tutorials/getting-started-with-swashbuckle#xml-comments), the Swashbuckle tooling can include your XML documentation comments in the OpenAPI documentation, and allows you to view it in Swagger UI.

:::image type="content" source="../media/Swagger_UI_XML.png" alt-text="Image showing Swagger UI and added XML Comments." loc-scope="third-party":::

## Data annotations

It's the same with data annotations. Just add an annotation to your model, and Swagger extends the API documentation to include it.

For example, if you add the following annotation to a controller:

```csharp
[Produces("application/json")]
```

... you see the added information in Swagger UI:

:::image type="content" source="../media/Swagger_UI_annotations.png" alt-text="Image showing Swagger UI with added content type added to annotations." loc-scope="third-party":::

## Tips

There are several data annotations you should use when describing your API.

- Identify which `content-types` your API handles on requests and responses. The following attributes specify that the API should only use the `application/json` content type in both directions.

    ```csharp
    [Produces("application/json")]
    [Consumes("application/json")]
    ```

- Identify the potential HTTP response codes that could be returned to the calling client. The following attribute illustrates an API that could return a 404 Not Found.

    ```csharp
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    ```

    Your API might produce a standard set of response codes, in that case you can use the following attribute to specify 200, 400, and 404 instead of specifying each individually. Learn more on [using web API conventions](/aspnet/core/web-api/advanced/conventions).

    ```csharp
    [ApiConventionMethod(typeof(DefaultApiConventions))]
    ```

- Generate an `operationId` to significantly improve the API consumption experience including documentation, code generation, and integration with other services. You can automatically generate the `operationId` by including the `Name` property in the HTTP verb filter. 

    ```csharp
    [HttpGet("{Height}/{Width}", Name="GetPrice")]
    ```
