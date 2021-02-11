
In this exercise, you download and run the Azure Digital Twins explorer sample locally, connect it to your Azure Digital Twins instance, and set up your chocolate factory digital twin.

1. Download the [Azure Digital Twins explorer](/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/), which is a locally hosted web application.

1. Extract all the files.

1. Locate the **client/src** folder in the extracted files. Take note of the full path to the **src** folder for a step you'll take later in this unit.

## Sign in to Azure

For the explorer sample to run properly, you need to sign in locally to the Azure subscription where you've deployed the Azure Digital Twins instance. This is because you create an environment variable that references those credentials. When you run the explorer sample locally, it looks for this environment variable so that it can connect the sample to your instance of Azure Digital Twins in Azure.

1. [Install the Azure CLI for your operating system](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&preserve-view=true).

1. After you successfully install the Azure CLI, you can sign in to Azure by running the following command in PowerShell:

    ```PowerShell
    az login
    ```

    The command launches a web browser tab that asks you to sign in to your Azure account.

## Run Azure Digital Twins explorer

1. Open **PowerShell** as an administrator. Change the directory to the path you saved off at the start of this unit, by typing **cd**. Then paste in the path to the **src** folder. For example:

    ```cmd
    cd C:\Users\<your alias>\Downloads\Azure_Digital_Twins__ADT__explorer\client\src
    ```

1. Run the following command to install all the required dependencies of the ADT Explorer sample:

    ```powershell
    npm install
    ```

    :::image type="content" source="../media/explorer-npm-install.png" alt-text="Terminal help output when running npm install." lightbox="../media/explorer-npm-install.png":::

1. Start the ADT Explorer sample by running the following command:

    ```powershell
    npm run start
    ```

    It might take a few seconds before the opening screen of the Azure Digital Twins explorer sample appears in your web browser.

1. When prompted, enter your Azure Digital Twins URL. This string has the format of **https://**, followed by the Azure Digital Twins host name.

1. You might have to grant consent for the app if a **Permissions requested** pop-up appears.

The Azure Digital Twins explorer sample is now loaded and ready.

## Upload the chocolate factory production line models

1. Locate the icon that uploads models.

1. Go to your folder that contains all your chocolate factory production line models. Select all of them, and upload them to the Azure Digital Twins explorer sample.

1. If you get any errors, you'll need to go back to [unit 4](https://docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/build-azure-digital-twins-graph-for-chocolate-factory/4-exercise-create-digital-twin-definition-language-models) and check your work for the model that has the error.

If there aren't any errors, you'll see a list of models in the left of your explorer sample window:

:::image type="content" source="../media/imported-models.png" alt-text="Screenshot showing the imported models in the explorer sample." lightbox="../media/imported-models.png":::

## Create digital twins

1. Select the icon (shown in the following image) to create a twin for the factory model. Name the twin *factory*, and create it.

    :::image type="content" source="../media/create-twin.png" alt-text="Screenshot showing the icon for creating a model twin in the explorer sample." lightbox="../media/create-twin.png":::

1. Create digital twins for the following models, giving the models the suggested names, or using your own names:
    - Factory floor: "floor"
    - Production line: "production_line"
    - Roasting step: "roasting"
    - Grinding step: "grinding"
    - Molding step: "molding"

1. There's no need to create a twin for the **Factory Production Steps** model. It's a base model, and its values are inherited by the three production steps.

You should now see all the created digital twins in the graph view. Also note that the properties for a selected digital twin appear in the right-hand pane of the explorer sample:

:::image type="content" source="../media/twins-in-graph.png" alt-text="Screenshot showing the created twins in the explorer graph, and the properties for a selected twin in the right pane." lightbox="../media/twins-in-graph.png":::

## Create relationships

To create a relationship, hold down the Ctrl key, select the *source* twin, and then select the *target* twin. Next, select the **Add relationship** icon, and select a relationship from the range you're offered. If you aren't offered any options, then no relationship can be created.

1. Locate the **Add Relationship** icon along the range of icons for the graph view. Don't select it yet.

    :::image type="content" source="../media/explorer-add-relationship-icon.png" alt-text="Screenshot showing the Add Relationship icon of the explorer sample." lightbox="../media/explorer-add-relationship-icon.png":::

1. Hold down the Ctrl key and select your **factory** twin circle. Then, select the **floor** twin. From the list of relationships, select **rel_has_floors**.

1. Hold down the Ctrl key and select your **floor** twin. Then, select the **production line** twin. From the list of relationships, select **rel_runs_lines**.

1. Hold down the Ctrl key and select your **roasting** twin. Then, select the **production line** twin. From the list of relationships, select **rel_step_link**.

1. Repeat the previous step for the **grinding** twin, and do this again for the **molding** twin.

You should now see all the relationships between the digital twins in the graph view:

:::image type="content" source="../media/explorer-graph-relationships.png" alt-text="Screenshot showing the completed graph in the explorer sample." lightbox="../media/explorer-graph-relationships.png":::

## Explore the graph layout options

1. The button to switch graph layouts is grayed out until a query is run. To enable it, run the default query `select * FROM digitaltwins`:

    :::image type="content" source="../media/explorer-run-query.png" alt-text="Screenshot showing the layout of the ADT Explorer sample" lightbox="../media/explorer-run-query.png":::

1. Locate the icon in the graph view that gives a range of layout options, with names such as "Cola" and "Klay":

    :::image type="content" source="../media/explorer-graph-layout.png" alt-text="Screenshot showing the graph icon for changing layout options in the explorer sample." lightbox="../media/explorer-graph-layout.png":::

1. Try each of the layout options in turn.

1. Notice that you can zoom in and out, and that there are some other helpful icons to fit your graph to your screen.

Feel free to explore the graph view. However, you've completed all the steps for this unit. In the next unit, you'll go into the digital twin query language.
