
In this exercise, you'll download and run the ADT Explorer sample locally, connect it to your Azure ADT instance, and set up your chocolate factory digital twin.

1. Download the [Azure Digital Twins explorer](/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/), which is a locally hosted web application.

1. Extract all the files.

1. Locate the **client/src** folder in the extracted files. Take note of the full path to the **src** folder for a later step in this unit.

## Log in to Azure

For the ADT Explorer sample to run properly, you'll need to locally log in to the Azure subscription where you've deployed the ADT instance for your machine to create an environment variable that references those credentials. When running the ADT Explorer sample locally, it will look for this environment variable so that it can connect the sample to your ADT instance in Azure.

1. [Install the Azure CLI for your operating system](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&preserve-view=true).

1. Once you successfully installed the Azure CLI, you'll be able to log in to Azure by running the following command in PowerShell:

    ```PowerShell
    az login
    ```

    The command will launch a web browser tab that will ask you to log in to your Azure account.

## Run ADT Explorer

1. Open **PowerShell** as an administrator. Change directory to the path you saved off at the start of this unit, by typing **cd**, then pasting in the path to the **src** folder. For example:

    ```cmd
    cd C:\Users\<your alias>\Downloads\Azure_Digital_Twins__ADT__explorer\client\src
    ```

1. Run the following command to install all the required dependencies of the ADT Explorer sample:

    ```powershell
    npm install
    ```

    :::image type="content" source="../media/explorer-npm-install.png" alt-text="Terminal help output when running npm install" lightbox="../media/explorer-npm-install.png":::

1. Start the ADT Explorer sample by running the following command:

    ```powershell
    npm run start
    ```

    It might take a few seconds before the opening screen of the ADT Explorer sample appears in your web browser.

1. When prompted, enter your Azure Digital Twins URL - this string has the format of **https://** followed by the ADT host name.

1. You may have to grant consent for the app if a **Permissions requested** pop-up appears.

Great, the ADT Explorer sample is loaded and ready! The next stage is to start uploading the models you created in an earlier unit.

## Upload the chocolate factory production line models

1. Locate the icon that uploads models.

1. Navigate to your folder that contains all your chocolate factory production line models. Select all of them and upload them to the ADT Explorer sample.

1. If you get any errors, you'll need to go back to [unit 4](https://docs.microsoft.com/learn/modules/develop-with-azure-digital-twins/build-azure-digital-twins-graph-for-chocolate-factory/4-exercise-create-digital-twin-definition-language-models) and check your work for the model that has the error.

If there aren't any errors, you'll see a list of models in the left of your ADT Explorer sample window:

:::image type="content" source="../media/imported-models.png" alt-text="Screenshot showing the imported models in the ADT Explorer sample" lightbox="../media/imported-models.png":::

## Create digital twins

1. Select the **Create a Twin** icon for the Factory model. Name the twin "factory" and create it.

    :::image type="content" source="../media/create-twin.png" alt-text="Screenshot showing the icon for creating a model twin in the ADT Explorer sample" lightbox="../media/create-twin.png":::

1. Create digital twins for the following models, giving the models the suggested names or using your own names:
    - Factory floor: "floor"
    - Production line: "production_line"
    - Roasting step: "roasting"
    - Grinding step: "grinding"
    - Molding step: "molding"

1. There's no need to create a twin for the **Factory Production Steps** model. It's a base model, and its values are inherited by the three production steps.

You should now see all the created digital twins in the graph view. Also note that the properties for a selected digital twin will appear in the right-hand pane of the ADT Explorer sample:

:::image type="content" source="../media/twins-in-graph.png" alt-text="Screenshot showing the created twins in the ADT Explorer graph and the properties for a selected twin in the right-hand pane" lightbox="../media/twins-in-graph.png":::

## Create relationships

To create a relationship hold down the `CTRL` key and select the *source* twin, then select the *target* twin. Next, select the **Add relationship** icon, and select a relationship from the range you're offered. If you aren't offered any options, then no relationship can be created.

1. Locate the **Add Relationship** icon along the range of icons for the graph view. Don't select it yet.

    :::image type="content" source="../media/explorer-add-relationship-icon.png" alt-text="Screenshot showing the Add Relationship icon of the ADT Explorer sample" lightbox="../media/explorer-add-relationship-icon.png":::

1. Hold down the `CTRL` key and select your **factory** twin circle. Then, select the **floor** twin. From the list of relationships, select **rel_has_floors**.

1. Hold down the `CTRL` key and select your **floor** twin. Then, select the **production line** twin. From the list of relationships, select **rel_runs_lines**.

1. Hold down the `CTRL` key and select your **roasting** twin. Then, select the **production line** twin. From the list of relationships, select **rel_step_link**.

1. Repeat the previous step for the **grinding** twin, then again for the **molding** twin.

You should now see all the relationships between the digital twins in the graph view:

:::image type="content" source="../media/explorer-graph-relationships.png" alt-text="Screenshot showing the completed graph in the ADT Explorer sample" lightbox="../media/explorer-graph-relationships.png":::

## Explore the graph layout options

1. The button to switch graph layouts is grayed out until a query is run. To enable it, run the default query `select * FROM digitaltwins`:

    :::image type="content" source="../media/explorer-run-query.png" alt-text="Screenshot showing the layout of the ADT Explorer sample" lightbox="../media/explorer-run-query.png":::

1. Locate the icon in the graph view that gives a range of layout options, with names such as "Cola" and "Klay":

    :::image type="content" source="../media/explorer-graph-layout.png" alt-text="Screenshot showing the graph icon for changing layout options in the ADT Explorer sample" lightbox="../media/explorer-graph-layout.png":::

1. Try each of the layout options in turn.

1. Notice that you can zoom in and out, and that there are some other helpful icons to fit your graph to your screen.

Feel free to explore the graph view. However, you've completed all the steps for this unit. In the next unit, you'll go into the digital twin query language.
