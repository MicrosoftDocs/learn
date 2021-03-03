In this exercise, we're going to double the number of worker nodes. Then we'll rebalance the shards, to take advantage of the new worker nodes.

1. Sign in to the Azure portal using your Azure account.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Next, select the **server resource** (such as `payment-server-demo`).

    :::image type="content" source="../media/7a-resource.png" alt-text="Payment server resource.":::

1. Select the **Compute + storage** tab.

1. Select three worker nodes. Adjust the vCores for the coordinator node if you want, but the deployment process will take a few minutes longer.

    :::image type="content" source="../media/7c-workers.png" alt-text="Worker nodes and coordinator node vCores.":::

    > [!NOTE]
    > Once increased and saved, the number of worker nodes cannot be decreased using the slider.

1. At the bottom of the page, select **Save**, and then select **Continue**.

    To take advantage of newly added nodes, we must rebalance distributed table shards. You need to **wait** until the deployment of the new nodes is complete, though.

1. Go to Azure Cloud Shell.
    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com?azure-portal=true)

1. Connect to your Hyperscale instance by running the following command, and using your password.

    ```psql
    psql "host=$SERVERNAME-c.postgres.database.azure.com port=5432 dbname=citus user=citus sslmode=require"
    ```

    > [!NOTE]
    > You can reset your password in the [Azure Portal](https://portal.azure.com?azure-portal=true). Select the server resource you created in the previous exercise (such as `payment-server-demo`), and then select `Reset password`.

1. In the Cloud Shell, run the following query to rebalance the shards for our payment_events and payment_users tables.

    ```sql
    SELECT rebalance_table_shards('payment_events');
    SELECT rebalance_table_shards('payment_users');
    ```

    And that's it! You've now created and scaled a distributed database. Run the next step in the Azure Cloud Shell to delete the resource group, and avoid any unnecessary charges to your account.

1. In the Cloud Shell, run the following command to disconnect from the Hyperscale instance.

    ```sql
    \q
    ```

    Then, run the following command.

    ```azurecli
    az group delete --name Hyperscale
    ```
    
    Press `y`, and then press <kbd>Enter</kbd>. The process will take a while, and you can move onto the next unit.
