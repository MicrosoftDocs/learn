In this exercise, you classify the sensitive data types in a sample **:::no-loc text="eShopLite":::** application. 

The app is in active development and currently has two data classes, **:::no-loc text="Product":::** and **:::no-loc text="Order":::**. They're building out the ordering process and want you to add the code to classify data types.

In this exercise, see how to:

* Explore the current app and its data types.
* Add the code to classify the data types.
* Run and test the app.

## Open the development environment

You can choose to use a GitHub codespace that hosts the exercise, or complete the exercise locally in Visual Studio Code.

To use a **codespace**, create a preconfigured GitHub Codespace with [this Codespace creation link](https://codespaces.new/MicrosoftDocs/mslearn-dotnet-cloudnative?devcontainer_path=.devcontainer%2Fdotnet-compliance%2Fdevcontainer.json).

GitHub takes several minutes to create and configure the codespace. When the process completes, you see the code files for the exercise. The code to use for the remainder of this module is in the **/dotnet-compliance** directory.

To use **Visual Studio Code**, fork the [https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative) repository to your own GitHub account. Then:

1. Make sure Docker is running. In a new Visual Studio Code window, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette.
1. Search for and select **Dev Containers: Clone Repository in Container Volume**.
1. Select your forked repository. Visual Studio Code creates your development container locally.

### Test the :::no-loc text="eShopLite"::: app

1. At the bottom of the Visual Studio Code window, select the **TERMINAL** tab.
1. Move to the exercise folder:

    ```bash
    cd dotnet-compliance/eShopLite
    ```

1. Build the apps containers.

    ```dotnetcli
    dotnet publish /p:PublishProfile=DefaultContainer 
    ```

1. Run the app using docker:

    ```bash
    cd ..
    docker compose up
    ```

1. Select the **PORTS** tab, then select the **Open in Browser** globe icon for the **Front End (32000)** port.

1. Select the Products link. The app displays a list of products.

    :::image type="content" source="../media/eshoplite-screenshot.png" alt-text="A screenshot of the running eShopLite app.":::

1. Select the **TERMINAL** tab, then press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.

## Create taxonomies and attributes

In this task, add code to create two new taxonomies. Then annotate the **:::no-loc text="Product":::** and **:::no-loc text="Order":::** data types with the appropriate attributes.

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
    using Microsoft.Extensions.Compliance.Redaction;
    
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

1. On the **TERMINAL** pane at the bottom, go to the *dotnet-compliance/eShopLite* folder.

    ```bash
    cd ..
    ```

1. Update the apps containers.

    ```dotnetcli
    dotnet publish /p:PublishProfile=DefaultContainer 
    ```

1. Go to the *dotnet-compliance* folder, and start the app with Docker:

    ```bash
    cd ..
    docker compose up
    ```

1. If you closed the tab in your browser, select the **PORTS** tab, then select the **Open in Browser** icon for the **Front End (32000)** port.
1. Note the **:::no-loc text="eShopLite":::** app is unchanged.
1. Try adding some products to the basket, then select **Buy Basket**.
1. In the **TERMINAL** window, press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the app.

You'll add redacted logging in the next exercise.
