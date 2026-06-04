In this exercise, you create a capacity pool for Azure NetApp Files, manage a manual QoS capacity pool, and manage billing using capacity pool tags.

### Task 1 – Create a capacity pool for Azure NetApp Files

In this task, you add a capacity pool for Azure NetApp Files.

1. In the Azure portal, go to your NetApp account. From the navigation pane, select **Capacity pools**.

    :::image type="content" source="../media/exercise-capacity-pools.png" alt-text="Screenshot of the Azure portal left-hand navigation menu for an Azure NetApp Files account, with Capacity pools highlighted." border="true" lightbox="../media/exercise-capacity-pools.png":::

1. Select **+ Add pools** to create a new capacity pool. The New Capacity Pool window appears.

    :::image type="content" source="../media/exercise-add-pool.png" alt-text="Screenshot of the toolbar showing the Add pool option highlighted." border="true" lightbox="../media/exercise-add-pool.png":::

1. Provide the following information for the new capacity pool:

    - Name: **NetAppLearnCP2**
    - Service level: **Standard**
    - Size: **4 TiB**
    - Enable cool access: **Unchecked**
    - QoS type: **Auto**
    - Encryption type: **Single**

    :::image type="content" source="../media/exercise-new-capacity-pool.png" alt-text="Screenshot of the Azure portal dialog for creating a new capacity pool, with the fields filled in for NetAppLearnCP2." border="true" lightbox="../media/exercise-new-capacity-pool.png":::

1. Select **Create**.

    The Capacity pools page shows the newly created capacity pool and configurations for the capacity pool.

    :::image type="content" source="../media/exercise-capacity-pool-list.png" alt-text="Screenshot of the Azure NetApp Files capacity pools list view showing the newly created NetAppLearnCP2 pool highlighted." border="true" lightbox="../media/exercise-capacity-pool-list.png":::

### Task 2 – Manage a manual QoS capacity pool for Azure NetApp Files

In this task, you perform various tasks to manage a capacity pool that uses the manual QoS type.

#### Change a capacity pool to use manual QoS

You can change a capacity pool that currently uses the auto QoS type to use the manual QoS type.

1. From your NetApp account, select **Capacity pools** from the left menu to display existing capacity pools.
2. Select the capacity pool that you created in the previous task to change to using manual QoS.
3. Select **Change QoS type**. Then set **New QoS Type** to **Manual.** Select **OK**.

    :::image type="content" source="../media/change-qos-type.png" alt-text="Screenshot of the Azure portal displaying the NetAppLearnCP2 capacity pool with the Change QoS type panel open, showing Manual and Auto options." border="true" lightbox="../media/change-qos-type.png":::
    

#### Modify the allotted throughput of a manual QoS volume

1. From the **Volumes** page, select the volume whose throughput you want to modify.
1. Select **Change throughput**. Specify the **Throughput (MiB/S)** that you want. Select **OK**.

    :::image type="content" source="../media/exercise-change-throughput.png" alt-text="Screenshot of the Azure portal Change throughput dialog box, showing available throughput and an editable throughput field." border="true" lightbox="../media/exercise-change-throughput.png":::

### Task 3 – Manage billing by using capacity pool billing tags

In this task, you use billing tags to help you manage Azure NetApp Files billing and expenses.

1. To add or edit a tag on a capacity pool, go to the **capacity pool** and select **Tags**.
2. Fill in the **Name** and **Value** pair. Click **Apply**.

    :::image type="content" source="../media/exercise-add-billing-tag.png" alt-text="Screenshot of the Azure portal Tags blade for a capacity pool resource, showing an existing tag and a new billing tag being added." border="true" lightbox="../media/exercise-add-billing-tag.png":::

3. You can display and download information about tagged resources by using the Microsoft Cost Management portal:

    - Click **Cost Analysis** and select the **Cost by resource** view.

        :::image type="content" source="../media/cost-analysis.png" alt-text="Screenshot of the Microsoft Cost Management Cost Analysis page showing resources with associated tags." border="true" lightbox="../media/cost-analysis.png":::

    - To download an invoice, select **Invoices** and then the **Download** button.

        :::image type="content" source="../media/invoices.png" alt-text="Screenshot of the Microsoft Cost Management Invoices page with the Download column highlighted." border="true" lightbox="../media/invoices.png":::


    - In the Download window that appears, download usage details. The downloaded csv file includes capacity pool billing tags for the corresponding resources.

        :::image type="content" source="../media/exercise-download-usage-details.png" alt-text="Screenshot of the Azure portal Download dialog for a billing period, with the Usage Details Download button highlighted." border="true" lightbox="../media/exercise-download-usage-details.png":::

        :::image type="content" source="../media/exercise-usage-billing-export.png" alt-text="Screenshot of a usage billing export spreadsheet showing resource tags in JSON format, including billing tags for HR/Legal and Sales." border="true" lightbox="../media/exercise-usage-billing-export.png":::
