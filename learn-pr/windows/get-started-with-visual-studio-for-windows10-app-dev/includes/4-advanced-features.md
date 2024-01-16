## Advanced Visual Studio features

It could take years to master all that Visual Studio has to offer. Here are some highlights you might find useful.

## Themes

The Visual Studio IDE has light themes and dark themes with lots of variation between. Try switching to a dark theme:

1. Select **Tools**, hover over **Theme**, and then select **Dark** to apply the *Dark theme*.

    :::image type="content" source="../media/theme.png" alt-text="Screenshot of the Visual Studio tools menu. The tools, theme, and dark options are all highlighted.":::

    An example of Visual Studio with the *Dark theme*:

    :::image type="content" source="../media/dark-theme.png" alt-text="Screenshot that shows the Visual Studio user-interface with the dark theme.":::

Feel free to choose your preferred theme.

## Refactoring

Visual Studio has powerful refactoring tools that apply changes to your source code in intelligent ways. For example, you can highlight a piece of code, use the refactoring tool to extract it, and then turn it into a method. The tool is also great for renaming variables.

Try it out in your project:

1. Select the **MainPage.xaml.cs** file in **Solution Explorer**. The file opens.

    :::image type="content" source="../media/open-code.png" alt-text="Screenshot of the Visual Studio solution explorer. The MainPage.xaml.cs file is highlighted.":::

2. Hover over the method called `Hello()` that's nested inside of the `MainPage()` method. Right-click the method, and then select **Rename**.

    :::image type="content" source="../media/rename-method.png" alt-text="Screenshot of a Visual Studio context menu after right-clicking a function. The rename option is highlighted.":::

3. Type a new name, and then select **Apply**. The name changes everywhere it occurs.

    :::image type="content" source="../media/apply-rename.png" alt-text="Screenshot of the Visual Studio editor window. A rename pop-up window is displayed and the apply button within it is highlighted.":::

## Code snippets

Code snippets are predefined pieces of code that Visual Studio can add into your project. They save you lot's of typing once you've gotten familiar with them.

Use a snippet to quickly insert a `do/while` loop:

1. Select the **MainPage.xaml.cs** file in **Solution Explorer**.

    :::image type="content" source="../media/open-code.png" alt-text="Screenshot of the Visual Studio solution explorer. The MainPage.xaml.cs file is highlighted.":::

2. Add a new line in the `MainPage()` method.

3. Hold *Ctrl*, press *K*, and then press *X* to open the **Insert Snippet** window.

    :::image type="content" source="../media/insert-snippet.png" alt-text="Screenshot of a Visual Studio insert snippet selection screen after pressing and holding the ctrl key while pressing the K and then X keys.":::

4. Select **Visual C#**, and then select **do** from the list. Your `MainPage()` method should look like this:

    :::image type="content" source="../media/code-snippet.png" alt-text="Screenshot of the editor window in Visual Studio. Sample code from the insert snippet step is shown.":::

5. Enter missing any information. The **do** loop requires a condition. The loop continues for as long as that condition is true.

## GitHub

GitHub is a service and website used to store code, including projects created in Visual Studio. It offers several benefits:

- **Security**: Your code is stored remotely. Remote storage is great in case something happens to your computer.
- **Source code management**: GitHub uses Git. Git makes it easy to undo changes and try new ideas.
- **Sharing**: GitHub makes it easy to share projects, collaborate, and use code from other developers.

Download a project from GitHub directly in Visual Studio:

1. Find the example project ([Windows coloring book sample](https://github.com/Microsoft/Windows-appsample-coloringbook)) in GitHub:

    :::image type="content" source="../media/coloring-book-repo.png" alt-text="Screenshot of the Windows coloring book repository hosted on GitHub.":::

2. Select the green **Code** button. The URL for the project displays. Select the **clipboard icon** to copy it.

    :::image type="content" source="../media/clone-repo.png" alt-text="Screenshot of the clone repository context menu in GitHub. The copy URL icon is highlighted.":::

3. Open Visual Studio. Select **Git**, and then select **Clone Repository**.

    :::image type="content" source="../media/clone-repo-two.png" alt-text="Screenshot of the Git menu in Visual studio. The Git menu and clone repository options are highlighted.":::

    The solution is cloned to your computer.

    > [!NOTE]
    > When you first load a project you've cloned from GitHub, you might need to set the default project. Solutions can contain multiple projects. You might need to specify *this* particular project as the one Visual Studio should build and run.
    >
    > You'll have to set that option manually. For this example, right-click **ColoringBook (Universal Windows)** in the *Solution Explorer*, and then select **Set as Startup Project**. Visual Studio now runs this project by default.

    :::image type="content" source="../media/set-startup-project.png" alt-text="Screenshot of a Visual Studio context menu when a project is right-clicked. An example project is highlighted along with the correct menu option.":::

4. Select the green triangle **Run** button.

    ![Run app](../media/run-app.png)

    Visual Studio might ask you to download more components. After you confirm these downloads, the app begins building. A loading screen displays:

    :::image type="content" source="../media/coloring-book-one.png" alt-text="Screenshot of the Windows coloring book loading screen. It displays a fully colored page.":::

    After a few moments, a page selection screen displays:

    :::image type="content" source="../media/coloring-book-two.png" alt-text="Screenshot of the Windows coloring book page selection screen. It displays coloring book pages the user may select to color.":::

### ARM, x86, or x64?

Visual Studio builds apps for different types of hardware:

- Advanced RISC Machine (ARM)-based systems.
- Computers running the 32-bit or 64-bit version of Windows.

Projects loaded from GitHub might provide the incorrect default value for system architecture. For example, it might default to `ARM` if you have an Intel computer. Check that the architecture listed next to the **Run** button matches your hardware, which is usually **x86**.

### Other ways to use GitHub

You can download a project from GitHub as a zip file, unzip the project, and open it directly in Visual Studio. This approach is a good if you're not planning to submit changes to the project repository or share code with other developers.

### Using Git on a daily basis

Every developer knows that tracking changes in projects can be difficult. What if you try out something, realize it was a mistake, and need to revert to a previous version? What if you're working with a friend and you both make changes to the same files? These issues are what Git is designed to address.
