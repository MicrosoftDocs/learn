Dashboards are a flexible tool for managing different aspects of Azure services through the Portal. They make it convenient to monitor the state of your services. Because they are shareable, they help ensure that everyone on your team sees the same data and stays aware of the state of your critical components. Let's create a new dashboard and add some tiles to it.

## Create a new dashboard

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **Dashboard** from the left navigation, then click the **New Dashboard** button at the top.

1. In the box saying **My Dashboard**, change the name to **Customer Dashboard**.

## Add and configure the Clock Tile

1. In the tile gallery, drag the clock onto the workspace. Place it on the top right of the available space.

1. On the **Edit clock** blade, change the Location to **Pacific Time (US & Canada)**.

1. Under **Time format**, click **24 hour**.

1. Click **Done**.

1. Repeat the preceding four steps, except select **Eastern Time (US & Canada)**. You should now have two clocks, one showing the time on the West Coast, the other on the East Coast.

## Resize a tile

1. In the **Tile Gallery** pane, click **All resources**, and then drop the tile onto the top left-hand side of the new dashboard workspace.

1. Click the tile, right-click the ellipsis, and then click **6x6**.

1. Click the gray corner on the bottom right-hand side of the tile, and resize the tile to 3.5 vertically by six horizontally. Note that when you finish resizing, it adjusts to 4x6.

1. In the Tile Gallery, click the **Resource Groups** tile, and drag it onto the workspace. Place it underneath the **All resources** tile.

1. In the Tile Gallery, click the **Service Health** tile, and drag it onto the workspace. Place it to the right of the **All resources** tile.

1. Continue to add the following tiles, rearranging them to fit:

    - Help + Support
    - Quick Tasks
    - Marketplace
    - What's New

1. When you have added these tiles, click **Done customizing**. The **Customer Dashboard** dashboard should appear.

## Clone a dashboard

You now want to create a very similar dashboard for some other customers.

1. Click the **Clone** button.

1. Rename the dashboard from **Clone of Customer Dashboard** to **Azure AD Admin Dashboard**.

1. On the **Resource Groups** tile, click the dustbin icon to delete this tile.

1. From the Tile Gallery, add the following tiles:

    - Organization Identity
    - Users and Groups
    - User Activity Summary
    - Welcome to the Azure AD Admin Center

1. Reposition the tiles as necessary, and then click **Done customizing**.

## Share a dashboard

You now want to make this dashboard available to other users. To do this, carry out the following steps:

1. From the Azure AD Admin dashboard, click the **Share** button at the top.

1. On the **Sharing and access control** panel that appears, uncheck the **Publish to the 'dashboards' resource group** checkbox and choose the resource group <rgn>[sandbox resource group name]</rgn> from the **Resource group** dropdown.

1. Click **Publish**, and then close the **Sharing + access control** blade.

1. Use the dropdown at the top to navigate to the **Customer Dashboard**.

    Note that in **All resources**, a Shared dashboard resource has appeared.

1. Repeat steps 1 to 3 to share the Customer Dashboard.

## Edit a dashboard.json file

To show how you can download and edit a dashboard file, carry out the following steps:

1. Click **Download**.

1. Open Windows Explorer, and navigate to your Downloads folder.

1. Find the *Customer Dashboard.json* file and double-click it.

1. In your file editor, look for the text *ClockPart*.

1. On the first occurrence of ClockPart, change the previous **rowSpan** value to 1.

1. On the second occurrence of Clockpart, also change the previous **rowSpan** value to 1.

1. On the second occurrence of Clockpart, change the Y value from 2 to 1.

1. Save the *Customer Dashboard.json* file and close your code editor.

1. On the Azure dashboard, click **Upload**.

1. In the **Open** dialog box, browse to the Downloads folder, and double-click *Customer Dashboard.json*.

    Note that the clocks have resized to one row high, and the bottom clock has moved up one row.

## Select a shared dashboard

You've realized that you don't like the smaller clocks, and you want to return to the earlier shared version of the Customer Dashboard. You can do that either by editing the file and uploading it again or by accessing the shared version. To do that, carry out the following steps:

1. Click the down arrow next to **Customer Dashboard**.

1. Click **Browse all dashboards**.

1. On the **All dashboards** blade, under **TYPE**, select **Shared dashboards**.

1. Click **Customer Dashboard**.

1. Close the **All dashboards** blade.

    Note that the clocks have returned to their original size.

## Switch to full screen

1. Click the down arrow next to **Customer Dashboard**. 

    Note that there is another Customer Dashboard, without the shared symbol next to it. Click that version of Customer Dashboard, and the clocks become small again.

1. Switch back to the shared Customer Dashboard.

1. Click the **Full Screen** button. 

    Note that the browser menus and bars have all disappeared.

1. Click the **Exit Full Screen** to return to the standard screen.

## Unshare a dashboard

If you want to prevent a shared dashboard from being available for selection, you can _unshare_ it. To unshare a dashboard, carry out the following steps:

1. Click the **Unshare** button. The **Sharing + access control** blade appears.

1. Click the **Unpublish** button.

1. In the confirmation message box, click **OK**.

1. Click the down arrow next to **Customer Dashboard**.

1. Click **Browse all dashboards**.

1. On the **All dashboards** blade, under **TYPE**, select **Shared dashboards**.

    Note that **Customer Dashboard** no longer appears in the list of available dashboards.

1. Close the **All dashboards** blade.

## Delete a dashboard

1. Ensure that the **Azure AD Admin** dashboard is selected.

1. Click the **Delete** button.

1. In the **Confirmation** message box, select the checkbox to confirm that this dashboard will no longer be visible, and then click **OK**.

## Reset a dashboard

1. Ensure that **Customer Dashboard** is selected.

1. Click **Edit**.

1. Right-click on the workspace, and click **Reset to default state**.

1. In the **Reset dashboard to default state** message box, click **Yes**.

    Note that the Customer Dashboard has reset to its default tiles.

1. Click **Done customizing**.

1. Click your name at the top right of the portal.

1. Click **Sign out**.

1. Close your browser.

Congratulations! You have now created and edited dashboards, shared them, altered them as **.JSON** files, unshared and finally, reset them to the default state. You should now be able to see what powerful tools dashboards can be and how you can use them to create efficient interfaces for differing roles within an organization.
