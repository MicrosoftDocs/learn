In this exercise, you configure to use customer-managed keys using Azure portal.

### Configure customer-managed keys for volume encryption

In this task, you use the Azure portal to configure a NetApp account to use customer-managed keys.

1. From your NetApp account, under **Azure NetApp Files**, select **Encryption**.

   :::image type="content" source="../media/exercise-encryption-page.png" alt-text="Screenshot of the Azure portal showing Encryption option selected under Azure NetApp Files." border="true" lightbox="../media/exercise-encryption-page.png":::

2. In the Encryption window, select **Customer Managed Key** as the **Encryption key source**.

   :::image type="content" source="../media/exercise-customer-managed-key.png" alt-text="Screenshot of the Encryption window showing Customer Managed Key selected as the encryption key source." border="true" lightbox="../media/exercise-customer-managed-key.png":::

3. To select an Encryption key, you have two options:
   - The **Select from key vault** option allows you to select a key vault and a key.
   - The **Enter key URI** option allows you to enter manually the key URI.
4. Choose **Select from key vault**.
5. Choose **Select a key vault and key** for Key vault and key.

   :::image type="content" source="../media/exercise-select-key-vault.png" alt-text="Screenshot of the Encryption window showing Select from key vault and Select a key vault and key action." border="true" lightbox="../media/exercise-select-key-vault.png":::

6. In **Select a Key** window, select the **Subscription**, select or create a new **Key vault**, and select or create a new **Key**.

   :::image type="content" source="../media/exercise-select-key.png" alt-text="Screenshot of the Select a key window with subscription, key vault, and key selections." border="true" lightbox="../media/exercise-select-key.png":::

7. In Identity type, select **System assigned** and click **Save**.

   :::image type="content" source="../media/exercise-system-assigned-save.png" alt-text="Screenshot of the Encryption window showing System assigned selected as the identity type." border="true" lightbox="../media/exercise-system-assigned-save.png":::
