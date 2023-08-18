In the last unit, you saw how dashboards are a flexible tool for managing different aspects of Azure services through the portal. They make it convenient to monitor the state of your services. Because they are shareable, they help ensure that everyone on your team sees the same data and stays aware of the state of your critical components.

Let's create a new dashboard and add some tiles to it.

## Create a new dashboard

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), from the top left-hand side, select **Show portal menu** >  **Dashboard**.

1. Select the **Create** button, then select **Custom**.

1. At the top left, change **My Dashboard**  to `Customer Dashboard`.

## Add and configure the Clock tile

1. In the Tile Gallery, find the **Clock** tile and drag it onto the workspace. Place it on the top along the right side of the available space.

1. Select the **Preview** button at the top of the screen, then right-click the **Clock** tile and select **Edit**.

1. On the **Edit clock** pane, change the **Location** to **(UTC-08:00) Pacific Time (US & Canada)**.

1. Under **Time format**, select **24 hour**.

1. Select **Done**, then select **Save** at the top of the screen. 

1. Select the **Edit** button at the top of the screen to return to edit mode, then repeat the previous five steps to place a new clock right below the first one. This time, select **(UTC-05:00) Eastern Time (US & Canada)** for the **Location**.

   You should now have two clocks on your dashboard, each displaying a different time zone.

## Add and resize tiles

1. Select the **Edit** button to return to edit mode, then find the **All resources** tile in the Tile Gallery. Drag and drop it in the top left-hand corner of the dashboard workspace.

1. Hover over the new **All resources** tile and select the ellipsis icon (**...**); then select the **6 x 6** size.

1. Select the gray corner on the bottom right-hand side of the tile, and drag it up to resize the tile to about 3.5 squares vertically, keeping the horizontal size the same. When you finish resizing, the tile adjusts to the closest available size, **6 x 4**.

1. From the Tile Gallery, drag the **Resource Groups** tile onto the workspace. Place it underneath the **All resources** tile.

1. Frp, the Tile Gallery, select the **Metrics chart** tile, and drag it onto the workspace. Place it to the right of the **All resources** tile.

1. Continue to add the following tiles, rearranging them to fit as needed:

    - Help + support
    - Azure Active Directory quick tasks
    - Marketplace

1. After you've added these tiles, select *Save**. The **Customer Dashboard** dashboard that you just created will appear as your current dashboard.

## Clone a dashboard

You now want to create a similar dashboard for some other customers, but with a few changes.

1. Select the **Clone** button.

1. Rename the dashboard from **Clone of Customer Dashboard** to **Azure AD Admin Dashboard**.

1. On the **Resource Groups** tile, select the trash can icon to delete this tile.

1. Select the **Preview** button at the top of the screen, then select **Edit**.

1. From the Tile Gallery, locate and add the following tiles:

    - Users and groups
    - User sign-in summary

1. Reposition the tiles as necessary, then select **Save**. The **Azure AD Admin Dashboard** dashboard that you just created will appear as your current dashboard.

## Share a dashboard

You now want to make this dashboard available to other users. In the sandbox environment, you won't be able to share a dashboard with other users. But you can see how you'd publish a shared dashboard by completing the following steps.

1. From the Azure AD Admin dashboard, select the **Share** button at the top. The **Sharing + access control** appears.
1. If the **Publish to the 'dashboards' resource group** checkbox is selected, uncheck the box.
1. Select the resource group <rgn>[sandbox resource group name]</rgn> from the **Resource group** dropdown.
1. Select **Publish**.
1. Close the **Sharing + access control** pane.

## Delete a dashboard

1. From the dashboard selection drop-down control, ensure that **Azure AD Admin Dashboard** is selected.

1. Select the **Delete** button.

1. In the **Confirmation** message box, check the box to confirm that you want to delete the dashboard, then select **OK**.

## Reset a dashboard

1. Ensure that **Customer Dashboard** is selected.

1. Select **Edit**.

1. Right-click on the workspace, and select **Reset to default state**.

1. In the **Reset dashboard to default state** message box, select **Yes**.

   You'll see the Customer Dashboard with the default tiles instead of the edits you made.

1. Select **Save**.

1. Select your name at the top right of the portal.

1. Select **Sign out**.

1. Close your browser.

Congratulations! You have now created and edited dashboards, shared them, deleted them, and finally, reset them to the default state. You now understand how to use dashboards to create efficient interfaces showing appropriate information for different roles within an organization.
