Now that you have added a custom skill to the enrichment pipeline, you can search the index and see the data it has extracted.

:::zone pivot="csharp"

1. In the **Terminal** pane, select the bash terminal for the **enriched-search-client** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **C-Sharp/enriched-search-client** folder and select **Open in Integrated Terminal**.
2. In the terminal for the **enriched-search-client** folder, enter the following command:

    ```bash
    dotnet run
    ```

3. Follow the link for the `https://localhost:5000/` address to open the web site in a new browser tab. Then in the Margie's Travel website, enter **Las Vegas volcano** into the search box and click **Search**.
4. When the results are displayed, observe that they include a list of the top words found in each document.
5. Close the browser tab containing the Margie's Travel web site and return to Visual Studio Code. Then in the terminal for the **search-client** folder (where the dotnet process is running), enter Ctrl+C to stop the app.

:::zone-end

:::zone pivot="python"

1. In the **Terminal** pane, select the bash terminal for the **enriched-search-client** folder. If you have closed this terminal, right-click (Ctrl+click if using a Mac) the **Python/enriched-search-client** folder and select **Open in Integrated Terminal**.
2. In the terminal for the **enriched-search-client** folder, enter the following command:

    ```bash
    flask run
    ```

3. Follow the link for the `https://127.0.0.1:5000/` address to open the web site in a new browser tab. Then in the Margie's Travel website, enter **Las Vegas volcano** into the search box and click **Search**.
4. When the results are displayed, observe that they include a list of the top words found in each document.
5. Close the browser tab containing the Margie's Travel web site and return to Visual Studio Code. Then in the Python terminal for the **enriched-search-client** folder (where the flask application is running), enter Ctrl+C to stop the app.

:::zone-end

## Clean up resources

Now that you have finished the exercises, you can delete the Azure resources.

1. Right-click (Ctrl+click if using a Mac) the **02-Create-an-enriched-pipeline** folder and select **Open in Integrated Terminal**. This will open a new bash terminal pane.
2. In the terminal pane, enter the following command to delete the resources used in this module:

    ```bash
    bash reset.sh
    ```

3. When prompted, follow the link, enter the provided code, and sign into your Azure subscription. Then wait for the script to complete and confirm that the resource group has been deleted.

When your resources have been deleted, continue to the next unit to check your learning.
