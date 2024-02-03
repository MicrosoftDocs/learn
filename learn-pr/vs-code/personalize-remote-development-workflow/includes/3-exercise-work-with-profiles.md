In this exercise, you'll use profiles to create, manage and switch between VS Code configurations. You'll also learn how to use profiles to share your configurations with others. You'll create a custom profile specifically working remotely with the Remote - SSH extension.

## Create a new profile

1. Open VS Code
1. Select on the gear icon in the bottom left corner of the window to open the **Manage** menu.
1. Put your mouse over the "Profiles (Default)" menu option.
1. Select "Create Profile"

    :::image type="content" source="../media/3-create-profile.png" alt-text="Screenshot of VS Code create profile menu option.":::

1. Name the profile "Remote SSH."
1. Leave "Copy from" set to "None."
1. Select on the gear icon to change the icon for the profile. You can choose any icon you like.
1. Take the defaults for all other options.

    :::image type="content" source="../media/3-remote-ssh-profile.png" alt-text="Screenshot of VS Code create profile menu.":::

1. Select "Create"

Observe how VS Code undergoes a reload. It gives the impression of a fresh installation, devoid of any extensions and displaying the default dark theme. If you made customizations to VS Code, rest assured, they remain intact. You can revert to your default profile whenever you wish."

## Configure the profile

You'll install the Remote-SSH extension and change the theme for the Remote SSH Profile.

### Install the Remote-SSH extension

1. Select on the "Extensions" icon in the left navigation bar (Activity Bar).
1. Search for "Remote SSH."
1. Select "Install" on the "Remote - SSH" extension.

### Change the theme

1. Select on the "Extensions" icon in the left navigation bar (Activity Bar).
1. Search for "GitHub."
1. Select "Install."
1. Select the "GitHub Dark Dimmed" theme.

### Increase the zoom

1. Open the User Settings with <kbd>Ctrl</kbd>+<kbd>,</kbd> or <kbd>Cmd</kbd>+<kbd>,</kbd>.
1. Type "zoom" in the search box.
1. Set the "Window: Zoom Level" to 3.
1. Close the Settings window.

### Move the sidebar to the right

- Open the Command Palette and select "Toggle Primary Sidebar Position."

Your editor should now look similar to this screenshot:

:::image type="content" source="../media/3-remote-ssh-profile-preview.png" alt-text="Screenshot of VS Code with the new Remote SSH profile applied.":::

## Export your profile

You can export profiles to share with others. You can also use this feature to back up your profiles.

1. Select on the custom icon in the bottom right corner of the window to open the **Manage** menu.
1. Put your mouse over the "Profiles (Remote SSH)" menu option.
1. Select the "Export Profile" option.

    :::image type="content" source="../media/3-export-profile-option.png" alt-text="Screenshot of VS Code the Export Profile option in the Profiles menu.":::

1. Accept all the default selections and select "Export."
1. Select "local"
1. Save the file as "remote-ssh-profile" to your "Documents" folder.

## Delete a profile

1. Select on the gear icon (or custom icon you selected) in the bottom left corner of the window to open the **Manage** menu.
1. Put your mouse over the "Profiles (Remote SSH)" menu option.
1. Select the "Delete Profile" option.
1. Select "Remote SSH."
1. Select "OK."

Your default profile is restored and the Remote SSH profile is deleted.

## Import the profile

You can share profiles with others by sending them the exported profile file. You can also use this feature to restore a profile from a backup. 

1. Select on the gear icon in the bottom left corner of the window to open the **Manage** menu.
1. Put your mouse over the "Profiles (Default)" menu option.
1. Select "Import Profile."
1. Select "Select file."
1. Select the "remote-ssh-profile" file you exported earlier.

    The profile will be loaded into the VS Code sidebar allowing you to select which items you want to import from the profile. In this case, you want to import everything.

    :::image type="content" source="../media/3-import-profile-preview.png" alt-text="Screenshot of VS Code the Import Profile options.":::
 
1. Select "Create Profile."
1. Select "Create."

VS Code imports the profile and applies it. You'll see the GitHub Dark Dimmed theme applied and the Sidebar positioned on the right-side of the editor instead of the default left-side position. Under extensions, you'll see the "Remote - SSH" extension is installed as well as "Remote - SSH: Editing Configuration Files" and "Remote Explorer." These other extensions are installed with the "Remote - SSH" extension.

:::image type="content" source="../media/3-import-profile-preview.png" alt-text="Screenshot of VS Code with the custom profile applied.":::

In this exercise, you learned how to create, manage and share profiles in VS Code. You also learned how to use profiles to share your configurations with others.

In the next section, you'll learn about Settings Sync, a feature that allows you to sync your settings across multiple machines.