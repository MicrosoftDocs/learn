
Settings Sync lets you share your VS Code configurations such as settings, key bindings, and installed extensions across your machines so you're always working with your favorite setup.

## How does Settings Sync work?

Settings Sync requires a sign-in with either your Microsoft or GitHub accounts. Once you have signed in, you can choose which settings you want to sync across your machines. You can choose to synchronize all of them or only a few of them. Once you have enabled Settings Sync, your settings are uploaded to the cloud and kept in sync whenever you make any changes to them. There's no need to manually sync or save any setting when using Settings Sync.

Here are the settings that Settings Sync feature automatically syncs for you:

:::image type="content" source="../media/1-enable-settings-sync.png" alt-text="Screenshot of VS Code Settings Sync sign-in interface.":::

* Settings - Any settings in VS Code that you configured, such as increasing the font size or having the editor format your code when you save a file. These settings can be found by selecting "Preferences: Open User Settings" from the Command Palette.

* Keyboard Shortcuts - Any custom keyboard shortcuts that you configured in VS Code. These keyboard mappings can be found by choosing "Preferences: Open Keyboard Shortcuts" from the Command Palette. 

* User Snippets - Any custom snippets that you created for specific languages. These snippets can be found by choosing "Snippets: Configure User Snippets" from the Command Palette.

* User Tasks - Tasks that you configured in VS Code to run scripts and start processes for existing build and linting tools. These user tasks can be found by choosing "Tasks: Configure Tasks" from the Command Palette.

* UI State - Any customizations you made to the VS Code UI, such as the position of the Activity Bar or the visibility of the Status Bar.

* Extensions - Any extensions that you installed in VS Code. These extensions can be found by choosing "Extensions: Show Installed Extensions" from the Command Palette.

* Profiles - Any profiles that you created in VS Code. These profiles can be found by choosing "Profiles: Switch Profile" from the Command Palette.

It can be helpful to see exactly what settings have synced, the last time your settings were synced, etc. 

Once Settings Sync is enabled, the Settings Sync explorer view is available in VS Code. You can access it by navigating to the Command Palette and choosing "Settings Sync: Show Synced Data." 

:::image type="content" source="../media/2-show-synced-data.png" alt-text="Screenshot of VS Code Settings Sync explorer view.":::

Additionally, you can select "Settings Sync: Show Log" from the Command Palette. Selecting this option opens up the bottom panel where you can see the latest sync status for each of the items that you chose to sync with Settings Sync.

:::image type="content" source="../media/3-settings-sync-log.png" alt-text="Screenshot of VS Code Settings Sync log.":::

### How do I restore my settings on a new machine?

When you want to restore your settings from the cloud on a new machine or new instance of VS Code, you can do so by signing in to Settings Sync with the same account you used to sync your settings. You're presented with the same UI when signing in to Settings Sync for the first time so you can decide at that point which settings you want to sync from the cloud and which you don't.

If you have made configuration changes to VS Code that are different than the settings in the cloud, you're prompted to choose which settings you want to keep. You can choose to keep the settings from the cloud or the settings from your local machine. In either case, only the settings that were in conflict are replaced.

### How do I change what I'm syncing?

You can change what you are syncing by navigating to the Command Palette and choosing "Settings Sync: Configure." This command opens up the same UI that you saw when you signed-in to Settings Sync allowing you to choose which settings you want to sync.

### How do I stop syncing?

You can stop syncing by navigating to the Command Palette and choosing "Settings Sync: Turn Off." This command stops syncing your settings to the cloud. You can turn it back on at any time by choosing "Settings Sync: Turn On" from the Command Palette.

Turning off Settings Sync doesn't delete your synced data from the cloud.

### How do I delete my synced data from the cloud?

You can delete your synced data from the cloud by navigating to the Command Palette and choosing "Settings Sync: Show Synced Data." This command opens up the Settings Sync explorer view. From there, you can select on the three dots and choose "Clear Data In Cloud."

In the next exercise, you'll enable Settings Sync and explore how to manage your synced data and restore your settings on a new machine.



