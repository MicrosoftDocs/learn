Dashboards are a flexible tool for managing different aspects of Azure services through the portal. They make it convenient to monitor the state of your services. Because they are shareable, they help ensure that everyone on your team sees the same data and stays aware of the state of your critical components. Let's create a new dashboard and add some tiles to it.

## Create a new dashboard

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), from the top left-hand side, select **Show portal menu** >  **Dashboard**.

1. Select the **New Dashboard** button, then select **Blank dashboard**.

1. At the top left, change **My Dashboard**  to `Customer Dashboard`.

## Add and configure the Clock Tile

1. In the Tile Gallery, drag the clock onto the workspace. Place it on the top along the right side of the available space.

1. Select the **Preview** button at the top of the screen, then select **Edit** in the clock tile.

1. On the **Edit clock** pane, change the Location to **Pacific Time (US & Canada)**.

1. Under **Time format**, select **24 hour**.

1. Select **Done**, then select **Save** at the top of the screen. Select the **Edit** button at the top of the screen to return to edit mode.

1. Repeat these five steps to place a new clock right below the first one. This time, select **Eastern Time (US & Canada)**. You should now have two clocks, each displaying a different time zone.

## Resize a tile

1. In edit mode, find the **All resources** tile in the Tile Gallery. Drag and drop it in the top left-hand corner of the new dashboard workspace.

1. Hover over the new **All resources** tile and select the ellipsis icon (**...**); then select the **6x6** size.

1. Select the gray corner on the bottom right-hand side of the tile, and drag it to resize the tile to 3.5 squares vertically by six horizontally. When you finish resizing, the tile adjusts to the closest available size, 4 x 6.

1. In the Tile Gallery, drag the **Resource Groups** tile onto the workspace. Place it underneath the **All resources** tile.

1. In the Tile Gallery, select the **Metrics chart** tile, and drag it onto the workspace. Place it to the right of the **All resources** tile.

1. Continue to add the following tiles, rearranging them to fit as needed:

    - Help + support
    - Azure Active Directory quick tasks
    - Marketplace

1. When you have added these tiles, select *Save**. The **Customer Dashboard** dashboard that you just created will appear.

## Clone a dashboard

You now want to create a similar dashboard for some other customers, but with a few changes.

1. Select the **Clone** button.

1. Rename the dashboard from **Clone of Customer Dashboard** to **Azure AD Admin Dashboard**.

1. On the **Resource Groups** tile, select the trash can icon to delete this tile.

1. Select the **Preview** button at the top of the screen, then select **Edit**.

1.  From the Tile Gallery, locate and add the following tiles:

    - Organization identity
    - Users and groups
    - User sign-in summary

1. Reposition the tiles as necessary, and then select **Save**. The **Azure AD Admin Dashboard** dashboard that you just created will appear.

## Share a dashboard

You now want to make this dashboard available to other users. In the sandbox environment, you won't be able to share a dashboard with other users. But you can see how you'd publish a shared dashboard by completing the following steps.

1. From the Azure AD Admin dashboard, select the **Share** button at the top. The **Sharing and access control** panel that appears.
1. To publish to a specific resource group, uncheck the **Publish to the 'dashboards' resource group** checkbox.
1. Select the resource group <rgn>[sandbox resource group name]</rgn> from the **Resource group** dropdown.
1. Select **Publish**.
1. Close the **Sharing + access control** pane.

## Edit a dashboard.json file

To show how you can download and edit a dashboard file, carry out the following steps:

1. Select **Export**, then select **Download**.

1. Open a file explorer on your computer and navigate to where your web browser downloaded the dashboard, typically a **Downloads** folder.

1. Find the *Customer Dashboard.json* file and open it in a text editor.

1. In your editor, look for the text *ClockPart*.

1. On the first occurrence of ClockPart, change the previous **position** > **rowSpan** value to 1.

1. On the second occurrence of ClockPart, also change the previous **position** > **rowSpan** value to 1.

1. On the second occurrence of ClockPart, change the **position** > **y** value from 2 to 1.

1. Save the *Customer Dashboard.json* file and close your code editor.

1. On the Azure dashboard, select **New dashboard**, then select **Upload**.

1. In the **Open** dialog box, browse to the Downloads folder, and double-click *Customer Dashboard.json*.

   When the dashboard appears, you'll see that the clocks have both been resized to one row high, and the bottom clock has moved up one row.

## Delete a dashboard

1. From the dashboard selection drop-down control, ensure that the **Azure AD Admin Dashbard** dashboard is selected.

1. Select the **Delete** button.

1. In the **Confirmation** message box, confirm that you want to delete the dashboard, then select **OK**.

## Reset a dashboard

1. Ensure that **Customer Dashboard** is selected.

1. Select **Edit**.

1. Right-click on the workspace, and select **Reset to default state**.

1. In the **Reset dashboard to default state** message box, select **Yes**.

    The Customer Dashboard has reset to its default tiles.

1. Select **Save**.

1. Select your name at the top right of the portal.

1. Select **Sign out**.

1. Close your browser.

Congratulations! You have now created and edited dashboards, shared them, altered them as **JSON** files, and finally, reset them to the default state. You now understand how to use dashboards to create efficient interfaces showing appropriate information for different roles within an organization.
