# Customize the Dashboard

In this exercise, you will create and configure a custom dashboard.

## Create a new Dashboard

1. In the Azure portal, click the **New Dashboard** button.

2. In the box saying **My Dashboard**, change the name to **Customer Dashboard**.

## Add and configure the Clock Tile

1. In the tile gallery, drag and drop the clock onto the workspace. Place it to the top right of the available space.

2. In the Edit clock blade, change the Location to **Pacific Time (US & Canada)**.

3. Under **Time format**, click **24 hour**.

4. Click **Done**.

5. Repeat the above four steps, except select **Eastern Time (US & Canada)**. You should now have two clocks, one showing the time on the West Coast, the other on the East Coast.

## Resize a tile

1. In the Tile Gallery pane, click **All resources**, and then drop the tile on the top left-hand side of the new dashboard workspace.

2. Click the tile, then right-click the elipsis and click **6x6**.

3. Click the grey corner in the bottom right-hand side of the tile, and resize the tile to 3.5 vertically by 6 horizontally. Note that when you drop the corner, it resizes to 4x6.

4. In the Tile Gallery, click the **Resource Groups** Tile, and drag it to the workspace. Place it underneath the **All resources** tile.

5. In the Tile Gallery, click the **Service Health** tile, and drag it to the workspace. Place it to the right of the **All resources** tile.

6. Continue to add the following tiles, rearranging them to fit:

    * Help + Support
    * Quick Tasks
    * Marketplace
    * What's New

7. When you have added these tiles, click **Done customizing**. The **Customer Dashboard** dashboard should appear.

## Clone a dashboard

You now want to create a very similar dashboard for some other customers

1. Click the **Clone** button.

2. Rename the dashboard from **Clone of Customer Dashboard** to **Azure AD Admin Dashboard**.

3. On the **Resource Groups** tile, click the dustbin icon to delete this tile.

4. From the Tile Gallery, add the following tiles:

    * Organization Identity
    * Users and Groups
    * User Activity Summary
    * Welcome to the Azure AD Admin Centre

5. Reposition the tiles as necessary, then click **Done customizing**.

## Share a dashboard

You now want to make this dashboard available to other users. To do this, carry out the following steps:

1. Ensure the Azure AD Admin Dashboard is selected, then click **Share**.

2. In the **Sharing and access control** blade, ensure that **Publish to the 'dashboards' resource group** is selected.

3. Set the **Location** to one that is appropriate for your geography. Typically, this value defaults to your nearest data center.

4. Click **Publish**, then close the **Sharing + access control** blade.

5. Click **Azure AD Admin Dashboard**, and select **Customer Dashboard**.

6. Note that in **All resources**, a Shared dashboard resource has appeared, and that in **Resource groups**, a dashboards resource group has also appeared.

7. Repeat Steps 1 to 3 to share the Customer Dashboard.

## Edit a Dashboard File

To show how you can download and edit a dashboard file, carry out the following steps:

1. Click **Download**.

2. Open Windows Explorer, and navigate to your Downloads folder.

3. Find the **Customer Dashboard.json** file and double click on that file.

4. In your file editor, look for the text "ClockPart"

5. On the first occurrence of ClockPart, change the previous rowSpan value to 1.

6. On the second occurrence of Clockpart, also change the previous rowSpan value to 1.

7. On on the second occurrence of Clockpart, change the Y value from 2 to 1.

8. Save the Customer Dashboard.json file and close your code editor.

9. In the Azure dashboard, click **Upload**.

10. In the **Open** dialog box, browse to the Downloads folder, and double-click **Customer Dashboard.json**.

11. Note how the clocks have resized to one row high and the bottom clock has moved up one row.

## Select a Shared Dashboard

You've realized that you don't like the smaller clocks and you want to return to the earlier shared version of the Customer Dashboard. You can do that either by editing the file and uploading it again, or by accessing the shared version. To do that, carry out the following steps:

1. Click the down arrow next to **Customer Dashboard**.

2. Click **Browse all dashboards**.

3. In the **All dashboards** blade, under **TYPE**, select **Shared dashboards**.

4. Click **Customer Dashboard**.

5. Close the **All dashboards** blade.

6. Note how the clocks have returned to their original size.

## Switch to Full Screen

1. Click the down arrow next to **Customer Dashboard**. Note that there is another Customer Dashboard, without the shared symbol next to it. Click that version of Customer Dashboard and the clocks become small again.

2. Switch back to the shared Customer Dashboard.

3. Click the **Full Screen** button. Note how the browser menus and bars all disappeared.

4. Click the **Exit Full Screen** to return to the normal screen.

## Unshare a dashboard

If you want to prevent a particular shared dashboard from being available for selection, you can unshare it. To unshare a dashboard, carry out the following steps:

1. Click the **Unshare** button. The **Sharing + access control** blade appears.

2. Click the **Unpublish** button.

3. In the confirmation message box, click **OK**.

4. Click the down arrow next to **Customer Dashboard**.

5. Click **Browse all dashboards**.

6. In the **All dashboards** blade, under **TYPE**, select **Shared dashboards**.

7. Note that Customer Dashboard no longer appears in the list of available dashboards.

8. Close the "All dashboards" blade.

## Delete a dashboard

1. Ensure that Azure AD Admin Dashboard is selected.

2. Click the **Delete** button.

3. In the **Confirmation** message box, check the check box to confirm that this dashboard will no longe be visible, then click **OK**.

## Reset a dashboard

1. Ensure that Customer Dashboard is selected.

2. Click **Edit**.

3. Right-click on the workspace and click **Reset to default state**.

4. In the **Reset dashboard to default state** message box, click **Yes**.

5. Note how the Customer Dashboard has reset to its default tiles.

6. Click **Done customizing**.

7. Click your name at the top right of the Portal.

8. Click Sign out.

9. CLose your browser.

## Summary

You have now created and edited dashboards, shared them, altered them as .JSON files, unshared and finally, reset them to the default state. You should now be able to see what powerful tools dashboards can be and how you can use them to create efficient interfaces for differing roles within an organization.