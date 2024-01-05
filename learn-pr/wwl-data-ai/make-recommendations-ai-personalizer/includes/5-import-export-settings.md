
You can export your Azure AI Personalizer's underlying model and its learning settings (also called *learning policy*) for backup and version control.

## Export and import a model

To export your model, you go to your AI Personalizer resource's Setup page, select the **Import/export** tab, and select **Export** model:

:::image type="content" source="../media/export-model.png" alt-text="A screenshot showing how to export the model.":::

This downloads the model in a `.zip` file to your device.

Alternatively, to import a previously exported model, you can select the **Select a file** field under **Import model**, choose your file in the file browser, then select **Upload**.

## Export and import learning settings

Your learning settings describe the *hyperparameters* for your model. These are parameters that your model relies on to carry out its learning process.

> [!NOTE]
> You should generally avoid changing these settings. You should only change them if you understand how they impact your AI Personalizer resource. Otherwise, this could create problems, and potentially break your model.

You can export your learning settings in the **Import/export** tab, by selecting **Export learning settings**:

:::image type="content" source="../media/export-import-settings.png" alt-text="A screenshot showing how to export and import settings.":::

This downloads a `.json` file that describes your settings.

To upload a learning settings file, you select the **Select a file** field under **Import learning settings**, choose your file in the file browser, then select **Upload**.

## Clear data for the learning loop

Suppose you want to reset your learning loop and its associated data to its original state at some point. This means you'll need to use the **Clear data** option. To do this you select the **Configuration** tab in the Setup page, and then select **Clear data**. You'll see a number of options:

:::image type="content" source="../media/clear-data.png" alt-text="A screenshot showing the clear data option.":::

- **Logged personalization and reward data**
    - This is log data that is used for offline evaluations. You select this option to remove that data.
- **Reset the Personalizer model**
    - You select this to reset the underlying model.

- **Set the learning policy to default**
    - If you've ever changed your learning policy, this will help you reset it to the original version.

To reset the entire learning loop, and all of its associated data, you select all three options and then select **Clear selected data**.