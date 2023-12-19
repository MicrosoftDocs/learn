In this excercise, you will enable Settings Sync and explore how to manage your synced data and restore your settings on a new machine. This is important in remote development scenarios because when you connect to a remote environment, your Visual Studio Code configuration will be different than your local machine. Settings Sync allows you to easily restore your settings to the remote environment.

## Turn on Settings Sync

1. Click on the profile icon and select **Backup and Sync Settings**.

:::image type="content" source="../media/5-enable-settings-sync.png" alt-text="Screenshot of Visual Studio Code Manage menu showing Backup and Sync Settings":::

1. Take the default selections in the Settings Sync dialog and click **Sign In**.
1. Select either GitHub or Microsoft as your account provider and sign in with your account credentials.
1. Make sure to complete the authorization flow to fully sign-in to Settings Sync in Visual Studio Code.

## View Synced Data

1. Open the Command Palette with <kbd>F1</kbd> and select "Settings Sync: Show Synced Data".
1. Notice that you can see each of the groups of settings that had customizations on your machine. You can also see the last time that each of these settings was synced to the cloud.

:::image type="content" source="../media/5-settings-sync-activity.png" alt-text="Screenshot of Visual Studio Code Settings Sync activity view.":::

Another way to view the status of settings sync is to view the settings sync log.

## Make a change to your settings

1. Open the User Settings by selecting "Preferences: Open User Settings" from the Command Palette.
1. Type "activity bar" in the search box.
1. Change the **Workbench > Activity Bar: Location** setting to **Top**.

:::image type="content" source="../media/5-settings-activity-bar-top.png" alt-text="Screenshot of Activity Bar Location in Visual Studio Code settings":::

1. You activity bar will now appear at the top of the sidebar, instead of next to it.

:::image type="content" source="../media/5-activity-bar-top-preview.png" alt-text="Screenshot of Activity Bar located at the top of the Sidebar in Visual Studio Code":::

1. Click on the Extensions icon in the sidebar.

:::image type="content" source="../media/5-extensions-icon.png" alt-text="Screenshot of Activity Bar in Visual Studio Code with the Extension icon highlighted":::

1. Search for and install the "Remote - Containers" extension.

## Sync Settings

By default, Visual Studio Code will automatically sync your settings whenever you make configuration changes. However, you can manually synchronize settings at any time.

1. Open the Command Palette with <kbd>F1</kbd> and select "Settings Sync: Sync Now".

This will synchronize your settings to the cloud. You can verify this by opening the Settings Sync Activity view again.

:::image type="content" source="../media/5-sync-activity-updated.png" alt-text="Screenshot of Settings Sync activity Visual Studio Code with UI State and Extensions folders highlighted":::

## Restore Settings on a new machine

In this section, you will restore your settings on a new machine. For this exericise, we'll use vscode.dev, which is a browser-based version of Visual Studio Code. This is a lightweight environment that you can use to quickly edit files in a browser. Not all extensions work in this environment.

1. Open a new browser tab and navigate to [https://vscode.dev](https://vscode.dev).
1. Click on the profile icon and select **Backup and Sync Settings**.
1. Take the default selections in the Settings Sync dialog and click **Sign In**.
1. Select either GitHub or Microsoft as your account provider and sign in with your account credentials.
1. Make sure to complete the authorization flow to fully sign-in to Settings Sync in Visual Studio Code.

Your editor will now be configured with the same settings as your local machine. You can verify this by opening the Settings Sync Activity view again. Notice that the profile that you created in the previous exercise is now available in the browser-based editor.

In this exercise, you learned how to enable Settings Sync and restore your settings on a new machine. In the next exercise, you will learn how to use Cloud Changes to ensure that any changes you make to a project are automatically synchronized to the cloud and available on any machine.
