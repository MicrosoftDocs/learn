In this exercise, you'll enable Settings Sync and explore how to manage your synced data and restore your settings on a new machine. The ability to sync settings is important in remote development scenarios because when you connect to a remote environment, your VS Code configuration is different than your local machine. Settings Sync allows you to easily restore your settings to the remote environment.

## Turn on Settings Sync

1. Select on the profile icon and select **Backup and Sync Settings**.

:::image type="content" source="../media/5-enable-settings-sync.png" alt-text="Screenshot of VS Code Manage menu showing Backup and Sync Settings":::

1. Take the default selections in the Settings Sync dialog and select **Sign In**.
1. Select either GitHub or Microsoft as your account provider and sign in with your account credentials.
1. Make sure to complete the authorization flow to fully sign-in to Settings Sync in VS Code.

## View Synced Data

1. Open the Command Palette with <kbd>F1</kbd> and select "Settings Sync: Show Synced Data."
1. Notice that you can see each of the groups of settings that had customizations on your machine. You can also see the last time that each of these settings was synced to the cloud.

:::image type="content" source="../media/5-settings-sync-activity.png" alt-text="Screenshot of VS Code Settings Sync activity view.":::

Another way to view the status of Settings Sync is to view the Settings Sync log.

## Make a change to your settings

1. Open the User Settings by selecting "Preferences: Open User Settings" from the Command Palette.
1. Type "activity bar" in the search box.
1. Change the **Workbench > Activity Bar: Location** setting to **Top**.

:::image type="content" source="../media/5-settings-activity-bar-top.png" alt-text="Screenshot of Activity Bar Location in VS Code settings":::

1. Your activity bar appears at the top of the sidebar, instead of next to it.

:::image type="content" source="../media/5-activity-bar-top-preview.png" alt-text="Screenshot of Activity Bar located at the top of the Sidebar in VS Code":::

1. Select on the Extensions icon in the sidebar.

:::image type="content" source="../media/5-extensions-icon.png" alt-text="Screenshot of Activity Bar in VS Code with the Extension icon highlighted":::

1. Search for and install the "Dev Containers" extension.

## Sync Settings

By default, VS Code will automatically sync your settings whenever you make configuration changes. However, you can manually synchronize settings at any time.

1. Open the Command Palette with <kbd>F1</kbd> and select "Settings Sync: Sync Now."

This command synchronizes your settings to the cloud. You can verify that your settings have been synced by opening the Settings Sync Activity view again.

:::image type="content" source="../media/5-sync-activity-updated.png" alt-text="Screenshot of Settings Sync activity VS Code with UI State and Extensions folders highlighted":::

## Restore settings on a new machine

In this section, you'll restore your settings on a new machine. For this exercise, we'll use Visual Studio Code for the Web (vscode.dev). vscode.dev is a free, zero-install VS Code experience running entirely in your browser, allowing you to quickly and safely browse source code repositories and make lightweight code changes. To learn more about vscode.dev, see [https://code.visualstudio.com/docs/editor/vscode-web](https://code.visualstudio.com/docs/editor/vscode-web).

Since vscode.dev is a lightweight environment that you can use to quickly edit files in a browser, not all extensions work in this environment.

1. Open a new browser tab and navigate to [https://vscode.dev](https://vscode.dev).
1. Select on the profile icon and select **Backup and Sync Settings**.
1. Take the default selections in the Settings Sync dialog and select **Sign In**.
1. Select either GitHub or Microsoft as your account provider and sign in with your account credentials.
1. Make sure to complete the authorization flow to fully sign-in to Settings Sync in VS Code.

Your editor is now configured with the same settings as your local machine. You can verify that your settings are synced by opening the Settings Sync Activity view again. Notice that the profile that you created in the previous exercise is now available in the browser-based editor.

In this exercise, you learned how to enable Settings Sync and restore your settings on a new machine. In the next exercise, you'll learn how to combine different remote environments for a customized remote development experience.
