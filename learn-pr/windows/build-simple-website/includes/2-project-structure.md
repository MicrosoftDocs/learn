There are different ways to create and manage website projects. Some of these differences depend on the specific tools you have, and also the preferences of your organization. When creating a website, it's not uncommon for your project structure to change over time as it becomes more complicated. The key is to keep a semblance of organization, and there are common strategies to help. Large projects often require a higher degree of care and attention so that many people can keep everything organized.

In this unit, you'll create a simple project structure using Visual Studio Code that includes three files: an HTML file, a CSS file, and a JavaScript file. You'll also add a VS Code extension to simplify running the website in the browser.

## Create a new folder for your website

1. Open Visual Studio Code.

   When you open Visual Studio Code, the **Welcome** page opens. Notice that you can create a new file or open a folder in the **Start** section.

   :::image type="content" source="../media/vs-code-welcome.png" alt-text="Screenshot of Visual Studio Code welcome window":::

   If the **Welcome** page isn't visible, you can display the **Welcome** window by selecting **Help > Welcome** on the VS Code menu. (Alternatively, you can display the **Welcome** window using the VS Code command palette. You can open the command pallete by using the keyboard shortcut <kbd>Shift+Ctrl+P</kbd> on a Windows computer or <kbd>Shift+Cmd+P</kbd> on macOS, or by selecting **View > Command Palette** from the VS Code menu. When the command palette is displayed, enter **>Help: Welcome** in the search field to open the **Welcome** window.)

1. Select **Open folder** in the **Start** section of the **Welcome** page, or select **File > Open Folder** from the VS Code menu.

   :::image type="content" source="../media/vs-code-open-folder.png" alt-text="Screenshot of Visual Studio Code open folder":::

   When opening a folder, the operating system provides a button to create a **New Folder**.

1. Navigate to the location where you want to create the new folder for your website, and select **New Folder**.
 
1. Name the folder **simple-website**, and then select **Select Folder**.

## Create some files

1. Create a new file by select **File > New File** from the VS Code menu, or by using <kbd>Control+N</kbd> on Windows, or <kbd>Command+N</kbd> on macOS.

1. Save the file by using <kbd>Control+S</kbd> on Windows, or <kbd>Command+S</kbd> on macOS.
 
1. Enter `index.html` for the file name, and then select **Save**.

1. Repeat the preceding steps to create two more files: `main.css` and `app.js`. When you're finished, your project folder will contain the following files that make up your website:

   - index.html
   - main.css
   - app.js

   Under the folder name in the Explorer window, you see the three files that comprise your website.

   :::image type="content" source="../media/vs-code-explorer-view.png" alt-text="Screenshot of your files in VS Code Explorer view":::

You could build a website by including all of your HTML, CSS styles, and JavaScript code within a single file. However, in this exercise you're using an HTML file for your content and page structure, with a CSS file for your presentation and styling, and a JavaScript file for your behaviors and interactivity.

Setting up three files helps keep your website project organized, and the separatation of content, styles, and logic is an example of *progressive enhancement*. If JavaScript isn't enabled or supported by your customers, your CSS and HTML will still work. However, if CSS isn't supported by your customers, at least your HTML content will appear.

### Install extensions or packages

You can extend the functionality of Visual Studio Code using the extensions marketplace. Keep in mind these are community-developed resources. There are often a few solutions for the same type of feature. You can install extensions individually in your editor, or several at once with the command line.

For web development, all you need right now is **open-in-browser**. This extension helps you to quickly open the website in your default browser, instead of copying and pasting the file URL into your browser.

To install this extension, use the following steps:

1. Select the **Extensions** icon on the VS Code **Activity Bar** (left pane).

1. Enter "open in" in the search bar, then select the **open in browser** extension that is published by *TechER*

1. Select **Install**, and VS Code will install the extension.

   :::image type="content" source="../media/vs-code-get-extension.png" alt-text="Screenshot of finding a VS Code extension":::

1. Switch back to the **Explorer** window by clicking the top icon in the VS Code **Activity Bar**, or use <kbd>Control+Shift-E</kbd> on Windows or <kbd>Command+Shift-E</kbd> on macOS.

Way to go! Installation and setup takes a little extra time, but you only need to install and set up once. Now you're ready to create a website.
