
In this exercise we'll enrich the documentation a developer sees about our API by adding comments and annotations to our code. First, let's see what we get from Swagger UI by default. 

1. Examine the Swagger UI endpoint of our API by navigating to **API-ROOT-URL**/swagger in your browser. **API-ROOT-URL** is the value you saved in the preceding exercise for the URL of your API You should see output in the browser similar to the following, when  you select the **Get** method. 

    :::image type="content" source="../media/swagger-ui-initial.png" alt-text="Default Swagger UI for our API." loc-scope="third-party":::

    Swagger UI gives us some useful information about the API. It shows the methods that you can call, in our simple case one method called **PriceFrame**. We see it is an HTTP Get operation and takes two required parameters, namely, Height and Width. You can also select **Try it out**, enter values for Height and Width and select **Execute** to see the API call in action. 

    Users of the API  don't have enough information to know what the limitations are on the PriceFrame method. Let's help them out with some more detailed information through XML comments. 

#### Add XML comments to your API

1. Navigate to the project folder in the Cloud Shell.

    ```bash
    cd ~/code/PrintFramerAPI
    ```

1. Open the Cloud Shell editor for the project using the following command.

    ```bash
    code .
    ```

1. Activate XML documentation in your project by updating **PrintFramerAPI.csproj** project file and setting GenerateDocumentationFile tag to `true`.

   ```XML
   <PropertyGroup>
       <GenerateDocumentationFile>true</GenerateDocumentationFile>
       <NoWarn>$(NoWarn);1591</NoWarn>
   </PropertyGroup>
   ```

1. In **Startup.cs** add the following using statements.

    ```csharp
    using System.Reflection;
    using System.IO;
    ```

1. In **Startup.cs**, update the call to the `AddSwaggerGen()` in `ConfigureServices` to tell Swashbuckle to use XML documentation

   ```csharp
   public void ConfigureServices(IServiceCollection services)
   {
       services.AddMvc()
            .SetCompatibilityVersion(CompatibilityVersion.Version_2_2)
            .AddJsonOptions(options =>
            {
                options.SerializerSettings.Formatting = Formatting.Indented;
            });

       // Register the Swagger generator, defining 1 or more Swagger documents
       services.AddSwaggerGen(c =>
       {
           c.SwaggerDoc("v1", new Info
           {
               Version = "v1",
               Title = "PrintFramer API",
               Description = "Calculates the cost of a picture frame based on its dimensions.",
               TermsOfService = "None",
               Contact = new Contact
               {
                   Name = "Your name",
                   Email = string.Empty,
                   Url = "https://www.microsoft.com/learn"
               }
           });

           // Set the comments path for the Swagger JSON and UI.
           var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
           var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
           c.IncludeXmlComments(xmlPath);
       });
   }
   ```
    In the preceding code, reflection is used to determine the name of the XML file to load XML comments. 

1. In **PriceFrameController.cs**, add the following XML comment block above the *HttpGet* attribute of the `GetPrice` method. Adding triple-slash comments to an action enhances the Swagger UI by adding the description to the section header.

   ```csharp
    /// <summary>
    /// Returns the price of a frame based on its dimensions.
    /// </summary>
    /// <param name="Height">The height of the frame.</param>
    /// <param name="Width">The width of the frame.</param>
    /// <returns>The price, in dollars, of the picture frame.</returns>
    /// <remarks> The API returns 'not valid' if the total length of frame material needed (the perimeter of the frame) is less than 20 inches and greater than 1000 inches.</remarks>
    [HttpGet("{Height}/{Width}")]
    public string GetPrice(string Height, string Width)
    {
        string result;
        result = CalculatePrice(Double.Parse(Height), Double.Parse(Width));
        return $"The cost of a {Height}x{Width} frame is ${result}";
    }
   ```

1. Save all changes and make sure it builds locally by running the following command. 

    ```bash
    dotnet build
    ```

1. Update the live app in production again with the following commands.

    ```azurecli
    git add .
    git commit -m "adds XML comment to GetPrice method"
    git push production
    ```

1. When prompted, enter the **DEPLOYMENT-PASSWORD** you saved earlier. 

1. Wait for the deployment to finish. The changes are pushed to our live API hosted at the URL we noted earlier. 

1. Look at the Swagger UI again at **API-ROOT-URL**/swagger and observe the added information provided by your XML comments. 

    :::image type="content" source="../media/swagger-ui-and-xml-comments.png" alt-text="Swagger UI with more documentation from XML comments for our API." loc-scope="third-party":::

## Add data annotations to your API

You use attributes from the `System.ComponentModel.DataAnnotations` namespace, to enable Swagger to improve the documentation.

1. In the API controller, add a `[Produces("text/plain")]` attribute to the controller, to show that our API supports a content type response for **text/plain**.

    ```csharp
    [Produces("text/plain")]
    [Route("api/[controller]")]
    [ApiController]
    public class PriceFrameController : ControllerBase
    {
    ```

    The Response Content Type drop-down selects this content type as the default for the controller's GET actions.

## Add Swashbuckle annotations to your API
So far, our API returns the status code 200 whether or not it could calculate a price for the given frame dimensions. In the description of the GetPrice method, we do note the case when a price can't be calculated. A more robust way to tell developers the response types and error codes is through the following XML comments and data annotations Swagger UI will use these values to clearly document expected HTTP response codes. 

1. In **PriceFrameController.cs** replace GetPrice with the following code and comment.

    ```csharp
    /// <summary>
    /// Returns the price of a frame based on its dimensions.
    /// </summary>
    /// <param name="Height">The height of the frame.</param>
    /// <param name="Width">The width of the frame.</param>
    /// <returns>The price, in dollars, of the picture frame.</returns>
    /// <remarks>
    /// Sample request:
    ///
    ///     Get /api/priceframe/5/10
    ///
    /// </remarks>
    /// <response code="200">Returns the cost of the frame in dollars.</response>
    /// <response code="400">If the amount of frame material needed is less than 20 inches or greater than 1000 inches.</response>
    [HttpGet("{Height}/{Width}")]
    [ProducesResponseType(200)]
    [ProducesResponseType(400)]
    public ActionResult<string> GetPrice(string Height, string Width)
    {
        string result;
        result = CalculatePrice(Double.Parse(Height), Double.Parse(Width));
        if (result == "not valid")
        {
            return BadRequest(result);
        }
        else
        {
            return Ok($"The cost of a {Height}x{Width} frame is ${result}");
        }
    }
    ```

    This code update makes the following changes:
    - The method uses the `BadRequest()` and `Ok()` methods to create a BadRequest (400) and an Ok status respectively, passing in the string result to the response.
    - The XML comments describe each status code that can be returned from this method.  
    - The ProducesResponseTypeAttribute lists the different responses that can be returned by the action. These attributes are combined with XML comments, as described above, to include human friendly descriptions with each response in the generated Swagger 

1. Save all changes and make sure it builds locally by running the following command. 

    ```bash
    dotnet build
    ```

1. Update the live app in production again with the following commands.

    ```azurecli
    git add .
    git commit -m "adds better status code information"
    git push production
    ```
1. Wait for the deployment to finish. The changes are pushed to our live API hosted at the URL we noted earlier. 

1. Look at the Swagger UI again at **API-ROOT-URL**/swagger and observe the added information provided by these annotations. The final Swagger Ui for our API is shown in the following screenshot. 

    :::image type="content" source="../media/swagger-ui-final.png" alt-text="Swagger UI with more documentation from XML comments for our API." loc-scope="third-party":::

In this exercise, we enriched the information that a developer receives about our API, making it much easier to consume. 
