Let's look at how to create and modify dashboards using the Azure portal, and by editing the underlying JSON file directly. In this unit, you'll learn to effectively use dashboards. And in the next unit, you will try out the things you've learned.

## What is a dashboard?

A *dashboard* is a customizable collection of UI tiles displayed in the Azure portal. You can add, remove, and position tiles to create the exact view you want, and then save that view as a dashboard. Multiple dashboards are supported, and you can switch among them as needed. You can even share your dashboards with other team members.

Dashboards give you considerable flexibility in managing Azure. For example, you can create dashboards for specific roles within the organization, then use role-based access control (RBAC) to control who can access that dashboard. Hence, your database administrator would have a dashboard that contains views of the SQL database service, whereas your Azure Active Directory administrator would have views of the users and groups within Azure AD. You can even customize the portal between your production and development environments within the portal, creating a specific dashboard for each environment you are managing.

Dashboards are stored as JavaScript Object Notation (JSON) files. This format means they can be uploaded and downloaded to other computers, or shared with members of the Azure directory. Azure stores dashboards within resource groups, just like virtual machines or storage accounts that you can manage within the portal.

Because dashboards are JSON files, you can also [customize them programmatically](/azure/azure-portal/azure-portal-dashboards-create-programmatically), making them compelling administrative tools. Also, some tile types can be query-based, so they update automatically when the source data changes.

## Explore the default dashboard

The default dashboard is named "Dashboard". When you log into the portal for the first time and select **Dashboard** from the portal menu, you are presented with this dashboard containing five tiles.

![Screenshot showing the default dashboard with different parts numbered and highlighted.](../media/6-dashboard-default-webparts.png)

These default web parts are

1. Dashboard controls

1. All resources tile

1. Quickstarts + tutorials tile

1. Service Health tile

1. Marketplace tile

## Creating and managing dashboards

At the top of the dashboard are the controls that let you create, upload, download, edit, and share a dashboard. You can also switch a dashboard to full screen, clone it, or delete it.

![Screenshot showing the Customize dashboard controls.](../media/6-customise-dashboard-controls.png)

## Select dashboard

At the top of the toolbar on the far left is the dashboard selection drop-down control. Clicking this control allows you to select from dashboards that you have already defined for your account. This control makes it simple for you to define multiple dashboards for different purposes and then switch from one to another and back again, depending on what you are trying to do at the time.

Dashboards that you create will initially be private; that is, only you can see them. To make a dashboard available across your enterprise, you need to share it. We'll look at that option shortly.

## Create a new dashboard

To create a new dashboard, select **New dashboard**. If you select **Blank dashboard**, the dashboard workspace appears with no tiles present. You can then add, remove, and adjust tiles however you like. When you are finished customizing the dashboard, click **Done customizing** to save and switch to that dashboard. You can also select **New dashboard**, then select **Upload** to upload a JSON file you've customized.

## Export

Select **Export**, then select **Download** to download your current dashboard as a JSON file. You can then customize it, distribute it, and upload it, or have someone else upload that file back to the Azure portal, thereby replacing their current dashboard.

When you select **Download**, the current dashboard downloads the JSON code as a file you can edit locally. You can then upload it back to Azure by selecting **New dashboard**, then selecting the **Upload** button. Downloading and uploading dashboards is discussed further below.

You can also select **Export**, then select **Print** to print a copy of your dashboard.

## Edit a dashboard using the portal

Although you can edit a dashboard by downloading the JSON file, changing values in the file, and uploading the file back to Azure, you may prefer a graphical approach to designing the user interface. To use the GUI to configure your current dashboard, you can switch to editing mode in several ways:

* Select the **Edit** (pencil icon) button.
* Right-click  the dashboard background area and select **Edit**.
* Right-click  a tile and a menu will appear with edit options.
* Hover over a tile on the dashboard - a `...` menu will appear on the top/right corner with a **Customize** option.

The dashboard will switch to edit mode.

![Screenshot showing the dashboard in the Edit mode.](../media/6-edit-dashboard.png)

On the right-hand side you'll find the **Tile Gallery**, showing many different tiles you can add to your dashboard. You can filter the Tile Gallery by using the search box to show only items that match your search term.

To add a tile to your dashboard, selecting the tile from the list and then drag it to the work area. You can then move each tile, resize it, or change the data that it displays.

> [!TIP]
> One cool feature is that you can take elements from a resource page and pin them to your dashboard. When using a service, look for the **Pin** icon. When you select it, you'll see a **Pin to dashboard** pane which allows you to select a dashboard (or create a new one) for the new tile.

In edit mode, the dashboard work area is divided into squares. Each tile must occupy at least one square, and tiles will snap to the nearest largest set of tile dividers. Any overlapping tiles will be moved out of the way. When you make a tile smaller, the surrounding tiles will resize to move back up against it.

### Change tile sizes

Some tiles have a set size, and you can only edit their size  programmatically. However, you can edit tiles with a gray bottom right-hand corner by dragging the corner indicator.

![Screenshot of a tile with the corner indicator highlighted.](../media/6-resizable-tile.png)

Alternatively, right-click the tile and then specify the size you want.

![Screenshot of the tile with the context menu displaying different sizing options.](../media/6-tile-size.png)

### Change tile settings

Some tiles have editable settings. For example, with the clock tile, you can select **Edit** to open the **Edit clock** tile. You can then set the time zone and choose whether the time displays in 12- or 24-hour format.

![Screenshot showing the Edit clock settings for the clock tile.](../media/6-edit-clock.png)

For multi-national/regional or transcontinental companies, you could add several clocks, each with a different time zone.

### Accepting your edits

You can select **Preview** to see your proposed edits. When you have arranged the tiles as you want them, either select **Save** or right-click anywhere in your Dashboard and select **Done customizing**.

## Edit a dashboard by changing the JSON file

You can also edit a dashboard by changing the JSON file. This approach provides more options for changing settings, but you can't see the changes until you upload the file back into Azure. The easiest starting point is to download the dashboard JSON, as previously described, and then edit that file.

![Screenshot of the downloaded dashboard JSON file.](../media/6-json-code.png)

As an example, in the JSON shown above, to change the size of the tile you would edit the **colSpan** and **rowSpan** variables, then save the file and upload it back to Azure.

> [!TIP]
> You can also distribute the dashboard JSON file to other users.

## Reset a dashboard

You can reset any dashboard to the default style. In edit mode, right-click the dashboard background and select **Reset to default state**. A dialog box will ask you to confirm that you want to reset that dashboard.

## Share or unshare a dashboard

When you define a new dashboard, it is private and visible only to your account. To make it visible to others, you need to share a dashboard. However, as with any other Azure resource, you need to specify a new resource group (or use an existing resource group) in which to store shared dashboards. If you do not have an existing resource group, Azure will create a *dashboards* resource group in whichever location you specify. If you have existing resource groups, you can specify that resource group to store the dashboards.

![Screenshot of the Sharing and access control pane before the dashboard is shared.](../media/6-share-dashboards-default.png)

When you have shared the template, you will see a second **Sharing + access control** pane.

![Screenshot of the Sharing and access control pane after the dashboard is shared.](../media/6-share-dashboards-access-control.png)

You can then select **Manage users** to specify the users who have access to that dashboard.

### Switching to a shared dashboard

To switch to a shared dashboard, you select the list of dashboards, and then select **Browse all dashboards**.

![Screenshot showing a list of shared dashboards with the Browse all dashboards link highlighted.](../media/6-browse-dashboards.png)

You will now see the **All dashboards** pane, with the names of any shared dashboards displayed. Select a dashboard to apply it to the Azure portal.

![Screenshot showing the Shared dashboards in the All dashboards pane.](../media/6-select-shared-dashboard.png)

## Display a dashboard as a full screen

If you want the largest dashboard real estate, select the **Full screen** button to display your current dashboard without any browser menus. If any tiles are outside the boundaries of your screen display, slider bars will appear at the right and bottom of your screen.

When you have finished working in full-screen mode, press the ESC key or select the **Full screen** button next to the Dashboard name at the top of the screen.

## Clone a dashboard

Cloning a dashboard creates an instant copy called "Clone of \<dashboard name>" and switches to that copy as the current dashboard. Cloning is also an easy way to create dashboards before sharing them. For example, if you have a dashboard that is almost as you want it, clone it, make the changes that you need, and then share it.

## Delete a dashboard

Deleting a dashboard removes it from your list of available dashboards. You are prompted to confirm that you want to delete the dashboard, but there is no facility to recover a dashboard that has been deleted.

Let's try out some of these options by creating a new dashboard.
