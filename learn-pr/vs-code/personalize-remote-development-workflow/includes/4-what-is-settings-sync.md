
Settings Sync lets you share your Visual Studio Code configurations such as settings, keybindings, and installed extensions across your machines so you are always working with your favorite setup.

## How does Settings Sync work?

Settings Sync requires a sign-in with either your Microsoft or GitHub accounts. Once you have signed in, you can choose which settings you want to sync across your machines.You can choose to synchronize all of them or only a few of them.

:::image type="content" source="../media/1-enable-settings-sync.png" alt-text="Screenshot of Visual Studio Code Settings Sync sign-in interface.":::

* Settings - Any settings in Visual Studio Code that you have configured, such as increasing the font size or having the editor format your code when you save a file. These settings can be found by selecting "Preferences: Open User Settings" from the Command Palette.

* Keyboard Shortcuts - Any custom keyboard shortcuts that you have configured in Visual Studio Code. These keyboard mappings can be found by choosing "Preferences: Open Keyboard Shortcuts" from the Command Palette. 

* User Snippets - Any custom snippets that you have created for specific languages. These snippets can be found by choosing "Snippets: Configure User Snippets" from the Command Palette.

* User Tasks - Tasks that you have configured in VS Code to run scripts and start processes for existing build and linting tools. These user tasks can be found by choosing "Tasks: Configure Tasks" from the Command Palette.

* UI State - Any customizations you have made to the VS Code UI, such as the position of the Activity Bar or the visibility of the Status Bar.

* Extensions - Any extensions that you have installed in VS Code. These extensions can be found by choosing "Extensions: Show Installed Extensions" from the Command Palette.

* Profiles - Any profiles that you have created in VS Code. These profiles can be found by choosing "Profiles: Switch Profile" from the Command Palette.

### How do I see the status of Settings Sync?

Once Settings Sync is enabled, the Settings Sync explorer view will be avaialble in Visual Studio Code. You can access it by navigating to the Command Palette and choosing "Settings Sync: Show Synced Data". 

:::image type="content" source="../media/2-show-synced-data.png" alt-text="Screenshot of Visual Studio Code Settings Sync explorer view.":::

Additionally, you can select "Settings Sync: Show Log" from the Command Palette. This will open up the bottom panel where you can see the latest sync status for each of the items that you chose to sync with Settings Sync.

:::image type="content" source="../media/3-settings-sync-log.png" alt-text="Screenshot of Visual Studio Code Settings Sync log.":::

### How do I restore my settings on a new machine?

When you want to restore your settings from the cloud on a new machine or new instance of Visual Studio Code, you can do so by signing in to Settings Sync with the same account you used to sync your settings. You will be presented with the same UI when signing in to Settings Sync for the first time so you can decide at that point which settings you want to sync from the cloud and which you do not.

If you have already made configuration changes to Visual Studio Code that are different than those in the cloud, you will be prompted to choose which settings you want to keep. You can choose to keep the settings from the cloud or the settings from your local machine. In either case, only the settings that were in conflict will be replaced.

### How do I change what I am syncing?

You can change what you are syncing by navigating to the Command Palette and choosing "Settings Sync: Configure". This will open up the same UI that you saw when you signed-in to Settings Sync allowing you to choose which settings you want to sync.

### How do I stop syncing?

You can stop syncing by navigating to the Command Palette and choosing "Settings Sync: Turn Off". This will stop syncing your settings to the cloud. You can turn it back on at any time by choosing "Settings Sync: Turn On" from the Command Palette.

Note that this does not delete your synced data from the cloud.

### How do I delete my synced data from the cloud?

You can delete your synced data from the cloud by navigating to the Command Palette and choosing "Settings Sync: Show Synced Data". This will open up the Settings Sync explorer view. From there, you can click on the three dots and choose "Clear Data In Cloud".

In the next exercise, you will enable Settings Sync and explore how to manage your synced data and restore your settings on a new machine.



