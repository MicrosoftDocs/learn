In this exercise, you'll classify the sensitive data types in a sample **:::no-loc text="eShopLite":::** application. 

The app is in active development and currently has two data classes, **:::no-loc text="Product":::** and **:::no-loc text="Order":::**. They're building out the ordering process and wabt you to add the code to classify data types.

In this exercise, you'll:

* Explore the current app and its data types.
* Add the code to classify the data types.
* Run and test the app.

## Open the development environment

You can choose to use a GitHub codespace that hosts the exercise, or complete the exercise locally in Visual Studio Code.

To use a **codespace** create a pre-configured GitHub Codespace with [this Codespace creation link](https://codespaces.new/MicrosoftDocs/mslearn-dotnet-cloudnative?devcontainer_path=.devcontainer%2Fdotnet-compliance%2Fdevcontainer.json).

GitHub takes several minutes to create and configure the codespace. When it's finished, you see the code files for the exercise. The code that's used for the remainder of this module is in the **/dotnet-compliance** directory.

To use **Visual Studio Code**, fork the [https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative) repository to your own GitHub account. Then:

1. Make sure Docker is running. In a new Visual Studio Code window, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
1. Search for and select **Dev Containers: Clone Repository in Container Volume**.
1. Select your forked repository. Visual Studio Code creates your development container locally.

### Update docker settings to run in a codespace

If you're using a codespace for this exercise, you need to update the **docker-compose.yml** file to use the correct URL for the apps images.

1. Select the **PORTS** tab. To the right of the local address for the **Back End (32001)** port, select the **Copy** icon.

1. In the **EXPLORER** pane, expand the dotnet-compliance folder, then select the **docker-compose.yml** file.
1. Paste the copied URL in the `ImagePrefix` environment variable. Replace the text `http://localhost:32001`.
1. Append `images` to the pasted text, you're final `ImagePrefix` should look like this:

    ```docker-compose
    environment: 
      - ProductEndpoint=http://backend:8080
      - ImagePrefix=https://super-duper-space-broccoli-5200.app.github.dev/images
    ```

1. Press <kbd>Ctrl</kbd>+<kbd>S</kbd> to save the file.

### Test the :::no-loc text="eShopLite"::: app

1. At the bottom of the Visual Studio Code window, select the **TERMINAL** tab.
1. Move to the exercise folder:

    ```bash
    cd dotnet-compliance/
    ```

1. Build on run the app:

    ```bash
    docker-compose up --build
    ```

1. Select the **PORTS** tab, then select the **Open in Browser** globe icon for the **Front End (32000)** port.
1. Select the Products link. The app displays a list of products.

    :::image type="content" source="../media/eshoplite-screenshot.png" alt-text="A screenshot of the running eShopLite app.":::
1. Select the **TERMINAL** tab, then press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.

## Create taxonomies and attributes

In this task, you'll add the code to create two new taxonomies. Then you'll annotate the **:::no-loc text="Product":::** and **:::no-loc text="Order":::** data types with the appropriate attributes.

1. In the **TERMINAL** tab, move to the **:::no-loc text="eShopLite/DataEntities":::** folder:

    ```bash
    cd eShopLite/DataEntities/
    ```

1. Add the compliance package:

    ```bash
    dotnet add package Microsoft.Extensions.Compliance.Redaction
    ```

1. In the **EXPLORER** pane, right-click the **DataEntities** folder, then select the **New file**.
1. In the file name, enter **Compliance.cs**.
1. In the editor, enter this code:

    ```csharp
    using Microsoft.Extensions.Compliance.Classification;
    
    public static class DataClassifications
    {
        // End User Identifiable Information
        public static DataClassification EUIIDataClassification {get;} = new DataClassification("EUIIDataTaxonomy", "EUIIData");
    
        // End User Pseudonymous Information
        public static DataClassification EUPDataClassification {get;} = new DataClassification("EUPDataTaxonomy", "EUPData");
    }
    
    public class EUIIDataAttribute : DataClassificationAttribute
    {
        public EUIIDataAttribute() : base(DataClassifications.EUIIDataClassification) { }
    }
    
    public class EUPDataAttribute : DataClassificationAttribute
    {
        public EUPDataAttribute() : base(DataClassifications.EUPDataClassification) { }
    }
    
    ```

    The above code creates two taxonomies, **:::no-loc text="EUII":::** and **:::no-loc text="EUPI":::**. It also creates two attributes, **:::no-loc text="EUIIDataAttribute":::** and **:::no-loc text="EUPDataAttribute":::**. These attributes are used to annotate the data types.

### Classify the data types

Use these taxonomies and attributes to classify the data types in the **:::no-loc text="eShopLite":::** app.

1. In the **EXPLORER** pane, expand the **DataEntities** folder, then select the **Product.cs** file.

    There isn't specific customer sensitive data in this class, but the app could leak pseudonymous data if the product ID property is connected to a customer in the logs.

1. Add the **:::no-loc text="EUPData":::** attribute to the **:::no-loc text="ProductId":::** property:

    ```csharp
    [EUPData]
    [Key]
    [JsonPropertyName("id")]
    public int Id { get; set; }
    ```

    The above code tells the redaction engine that the **:::no-loc text="Id":::** property is pseudonymous data.

1. In the **EXPLORER** pane, expand the **DataEntities** folder, then select the **Order.cs** file.

    The **:::no-loc text="Order":::** class contains sensitive data. The **:::no-loc text="CustomerName":::** and **:::no-loc text="CustomerAddress":::** properties are end user identifiable information. The **:::no-loc text="Id":::** property is end user pseudonymous information.

1. Add the **:::no-loc text="EUIIData":::** attribute to the **:::no-loc text="CustomerName":::** and **:::no-loc text="CustomerAddress":::** properties:

    ```csharp
    [EUIIData]
    [JsonPropertyName("customerName")]
    public string? CustomerName { get; set; }

    [EUIIData]
    [JsonPropertyName("customerAddress")]
    public string? CustomerAddress { get; set; }
    ```

    The above code tells the redaction engine that the **:::no-loc text="CustomerName":::** and **:::no-loc text="CustomerAddress":::** properties are end user identifiable information.

1. Add the **:::no-loc text="EUPData":::** attribute to the **:::no-loc text="Id":::** property:

    ```csharp
    [Key]
    [EUPData]
    [JsonPropertyName("id")]
    public int Id { get; set; }
    ```

    The above code tells the redaction engine that the **:::no-loc text="Id":::** property is end user pseudonymous information.

### Test your changes to the :::no-loc text="eShopLite"::: app

1. At the bottom of the Visual Studio Code window, select the **TERMINAL** tab.
1. Move to the root folder:

    ```bash
    cd ../..
    ```

1. Build on run the app:

    ```bash
    docker-compose up --build
    ```

1. If you closed the tab in your browser, select the **PORTS** tab, then select the **Open in Browser** icon for the **Front End (32000)** port. 
1. Note the **:::no-loc text="eShopLite":::** app is unchanged. 
1. Try adding some products to the basket, then select **Buy Basket**.
1. In the **TERMINAL** tab, look through the log messages, nothing is redacted.
1. In the **TERMINAL** window, press <kbd>CTRL</kbd>+<kbd>C</kbd> to stop the app.
