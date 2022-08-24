## Advanced Visual Studio features

It could take years to master all that Visual Studio has to offer. Here are some highlights you might find useful.

## Themes

The Visual Studio IDE has light themes and dark themes with lots of variation between. Try switching to a dark theme:

1. Click **Tools**, hover over **Theme** and select **Dark** to apply the *Dark theme*.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediatheme.png" alt-text="Screenshot of the Visual Studio tools menu. The tools, theme, and dark options are all highlighted.":::

    Visual Studio with *Dark theme*:

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediadark-theme.png" alt-text="Screenshot of the Visual Studio user-interface in dark mode.":::

Feel free to choose your preferred theme.

## Refactoring

Visual Studio has powerful refactoring tools that apply changes to your source code in intelligent ways. For example, you can highlight a piece of code, use the refactoring tool to extract it, and turn it into a method. The tool is also great for re-naming variables.

Try it out in your project:

1. Open the **MainPage.xaml.cs** file by selecting it in the **Solution Explorer**.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediaopen-code.png" alt-text="Screenshot of the Visual Studio solution explorer. The MainPage.xaml.cs file is highlighted.":::

2. Hover over the method called `Hello()` nested inside of the `MainPage()` method. Right click the method and select **Rename**.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediarename-method.png" alt-text="Screenshot of a Visual Studio context menu after right-clicking a function. The rename option is highlighted..":::

3. Type a new name and select **Apply**. Notice that the name changes everywhere it occurs.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediaapply-rename.png" alt-text="Screenshot of the Visual Studio editor window. A rename pop-up window is displayed and the apply button within it is highlighted.":::

## Code snippets

Code snippets are pre-defined pieces of code that Visual Studio can add into your project. They save you a lot of typing once you've gotten familiar with them.

Use a snippet to quickly insert a `do/while` loop:

1. Open the **MainPage.xaml.cs** file by selecting it in *Solution Explorer*.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediaopen-code.png" alt-text="Screenshot of the Visual Studio solution explorer. The MainPage.xaml.cs file is highlighted.":::

2. Add a new line in the `MainPage()` method.

3. Hold *Ctrl*, press *K*, and then press *X* to open the **Insert Snippet** window.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediainsert-snippet.png" alt-text="Screenshot of a Visual Studio insert snippet selection screen after pressing and holding the ctrl key while pressing the K and then X keys.":::

4. Click **Visual C#** and select **do** from the list. Your `MainPage()` method should look like this:

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediacode-snippet.png" alt-text="Screenshot of the editor window in Visual Studio. Sample code from the insert snippet step is shown.":::

5. Enter missing information (the **do** loop requires a condition. The loop continues for as long as that condition is true).

## GitHub

GitHub is a service and website used to store code (including projects created in Visual Studio). It offers several benefits:

- *Security*: Your code is stored remotely. (What if something bad happened to your computer?)
- *Source code management*: GitHub uses Git (which makes it easy to "undo" changes and try new ideas).
- *Sharing*: GitHub makes it easy to share projects, collabarate, and use code from other developers.

Download a project from GitHub directly in Visual Studio:

1. Find the example project ([Windows coloring book sample](https://github.com/Microsoft/Windows-appsample-coloringbook)) in GitHub:

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediacoloring-book-repo.png" alt-text="Screenshot of the Windows coloring book repository hosted on GitHub.":::

2. Click the green **Code** button. The URL for the project is displayed. Select the **clipboard icon** to copy it.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediaclone-repo.png" alt-text="Screenshot of the clone repository context menu in GitHub. The copy URL icon is highlighted.":::

3. Open Visual Studio. Click **Git** and select **Clone Repository**.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediaclone-repo-two.png" alt-text="Screenshot of the Git menu in Visual studio. The Git menu and clone repository options are highlighted.":::

    The solution will be cloned (downloaded) to your computer.

    > [!NOTE]
    > When you first load a project you've cloned from GitHub, you may need to set the default project. This is due to the fact that solutions can contain multiple projects. You may need to specify *this* particular project as the one Visual Studio should build and run.
    >
    > You'll have to set that option manually. For this example, right-click **ColoringBook (Universal Windows)** in the *Solution Explorer* and select **Set as Startup Project**. Visual Studio will now run this project by default.

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediaset-startup-project.png" alt-text="Screenshot of a Visual Studio context menu when a project is right-clicked. An example project is highlighted along with the correct menu option.":::

4. Select the **Run**(green triangle) button.

    ![Run app](../media/get-started-with-visual-studio-for-windows-10-app-dev/mediarun-app.png)

    Visual Studio may ask you to download additional components. After you confirm these downloads, the app will begin building. A loading screen displays:

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediacoloring-book-one.png" alt-text="Screenshot of the Windows coloring book loading screen. It displays a fully colored page.":::

    After a few moments, a page selection screen displays:

    :::image type="content" source="media/get-started-with-visual-studio-for-windows-10-app-dev/mediacoloring-book-two.png" alt-text="Screenshot of the Windows coloring book page selection screen. It displays coloring book pages the user may select to color.":::

### ARM, x86, or x64?

Visual Studio builds apps for different types of hardware:

- Advanced RISC Machine (ARM)-based systems.
- Computers running the 32-bit or 64-bit version of Windows.

Projects loaded from GitHub may provide the incorrect default value for system architecture (for example, it may default to `ARM` if you have an Intel computer). Check that the architecture listed next to the **Run** button matches your hardware (usually **x86**).

### Other ways to use GitHub

You can download a project from GitHub as a zip file, unzip the project, and open it directly in Visual Studio. This is a good approach if you're not planning to submit changes to the project repository or share code with other developers.

### Using Git on a daily basis

Every developer knows that tracking changes in projects can be difficult. What if you try something out, realize it was a mistake, and need revert to a previous version? What if you're working with a friend and you both make changes to the same files? These are the kinds of issues Git was designed to address.
