When you work in the console regularly, you might want to customize its settings by specifying custom preferences. For example, font size and type, the size and position of the console window and the screen buffer, the color scheme, and keyboard shortcuts.

## Font type, color, and size

If the font size and color make it difficult for you to review content, you can change them. You might also find that the font style and size that are set in the console make it difficult to differentiate between important characters, which can make it challenging to troubleshoot long, complex lines of code. To check if this issue exists, when you first open the console, enter the following characters, and make sure that you can easily differentiate between them:

- Grave accent (`).
- Single quotation mark (').
- Open parentheses (().
- Open curly bracket ({).
- Open square bracket ([).
- Open angle bracket or greater than symbol (<).

If you find it difficult to differentiate between these characters, try changing the font. To change the font, select the **PowerShell** icon in the console window. From the shortcut menu, select **Properties**, and then select the **Font** tab. Select a new font style and size. TrueType fonts, which the double-T symbol indicates, are considered easier to review than Raster fonts. The PowerShell **Properties** dialog box provides a preview pane in which you can review the results of your choice.

## Screen buffer and console window sizes

You can customize the console window's size and location. When setting the window size, you should understand the relationship between the **Screen Buffer Size** and **Windows Size** options, so that you don't accidentally miss any section of the output that appears on the console window. **Screen Buffer Size** is the width in number of characters, and the height in number of lines that appear in your text buffer. The **Windows Size** option, as the name suggests, is the width of the actual window. In most cases, you'll want to make sure that the **Width** option for **Screen Buffer Size** is equal to or smaller than the **Width** option for **Windows Size**. Doing so will prevent you from having a horizontal scroll bar on your console window. You can update these options in the **Layout** tab.

Set the width of both the screen buffer and console windows to be close to your actual screen's width. Doing so lets you maximize the amount of horizontal text you can display. This setting will prove useful later when you format the on-screen output that your scripts return.

The height of your screen buffer doesn't have to match your screen height. In most cases, it's much larger. If you set this value to a large number, you'll be able to scroll through large numbers of commands that are entered in a session or large amounts of output.

In the **Layout** tab, you can also set a specific position where the console window appears on screen. To do this, set the values for the **Window Position** in which the top‑left corner of the window should appear.

## Color scheme

Finally, if you want to change the default color scheme, you can select from a small range of alternative colors in the **Colors** tab of the console’s **Properties** dialog box. You can change only the primary text and the background color for the main window and any secondary pop-up windows. You can't change the color of error messages or other output from this dialog box.

After updating settings, close the dialog box. Verify that the window fits on the screen and that there isn't a horizontal scroll bar. A vertical scroll bar will still display in the console.

## Copying and pasting

The console host supports copying and pasting to and from the clipboard. It also supports using standard keyboard shortcuts, though they might not always work. This could be because of other applications that are running on the local computer and have changed settings for keyboard shortcuts. To enable this functionality, make sure that **QuickEdit Mode** is enabled in the console’s **Properties** dialog box. In the **Edit Options** section of the **Options** tab, enable keyboard shortcuts for copy and paste by selecting **Enable Ctrl key shortcuts**.

Within the console, select a block of text, and then select Enter to copy that text to the clipboard. Right-click or activate the context menu to paste. Starting with Windows 10 and Windows Server 2016, the Ctrl+C and Ctrl+V keyboard shortcuts also work for copy and paste.

