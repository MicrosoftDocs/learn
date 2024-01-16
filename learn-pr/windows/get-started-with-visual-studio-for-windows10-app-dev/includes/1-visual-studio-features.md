## Install Visual Studio and get started
> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2MhKX]

Visual Studio is an *Integrated Development Environment (IDE)* used to develop apps for Windows, the web, and other platforms. It consists of a *source code editor*, *designer*, *compiler*, and *debugger*.

There are three editions of Visual Studio 2022: the *Community*, *Professional*, and *Enterprise* editions. Visual Studio *Community* is free and it's the edition used throughout this module.

> [!NOTE]
> The images used in this module might look different if you're using the *Professional* or *Enterprise* edition.

[Download and install Visual Studio](https://visualstudio.microsoft.com/). Check out the [Introduction to Windows 10](/training/modules/introduction-to-windows10-dev/) module for more detailed instructions and some automated scripts.

> [!NOTE]
> Don't confuse *Visual Studio*—a comprehensive IDE for .NET and C# development—with [Visual Studio Code](https://code.visualstudio.com/). Visual Studio Code is a standalone lightweight code editor with a plug-in ecosystem that's ideal for web development.
>
> Visual Studio is also available for Mac. This module doesn't cover development with Mac. You might want to visit [Visual Studio for Mac](https://visualstudio.microsoft.com/vs/mac/).

## Install or update Visual Studio

Before starting, you need to install Visual Studio. Check that you're using the latest version by running the Visual Studio Installer:

1. Open the **Start** menu and select **Visual Studio Installer**.
2. Select the **Update** button if it appears. Visual Studio downloads and installs the most recent version.

:::image type="content" source="../media/update-visual-studio.png" alt-text="Screenshot showing Visual Studio Installer. The update button is highlighted.":::

## Some definitions

### Project

*Projects* include source code, like C# and XAML files. Projects also include resources, like images and sound, and other Visual Studio information.

### Solution

A *Solution* can encompass more than one project. Your app might use another project for some key functionality or might run on different types of devices and need to be built in different ways. Solutions bring all of your projects together in one place.

### IntelliSense

IntelliSense displays information about your code directly within the editor. It essentially provides inline documentation, which removes the need to look up reference information elsewhere. In some cases, it might even write small bits of code for you.

## A quick tour of Visual Studio

The following image is an example of the Visual Studio UI with a Solution open.

:::image type="content" source="../media/visual-studio-ui-updated.png" alt-text="Screenshot of the Visual Studio user-interface in editor view. The main features are labeled." lightbox="../media/visual-studio-ui-updated.png":::

The **Solution Explorer** helps you view, navigate, and manage files. Organize your code by grouping files into solutions and projects.

The **Editor Window** is where you edit code and design user interfaces (for example, a window with buttons and text boxes). It can also be used to display the contents of files.

The **Output Window** displays notifications from different message sources in separate tabs (including debugging and error messages, compiler warnings, publishing and status messages, and other notifications).

The **Team Explorer** allows you to track work items and share code with others using version control technologies such as [Git](https://git-scm.com/).

The previous image shows an example with C# code. You can also use the **Editor Window** to design the appearance of your app. If you select a XAML file, for example **MainPage.xaml**, you see:

:::image type="content" source="../media/editor-mode.png" alt-text="Screenshot of Visual Studio user-interface in design view.":::

Preview your UI in the upper window along with the XAML code used to define it. You can switch between views using the **arrow button**. The arrow button is in the border, between the Design and Code views, near the words **Design** and **XAML**. The preview changes whenever you change the XAML file and vice versa.

In this view, open the **Toolbox**, select your desired controls, and drag them into your app window.

> [!IMPORTANT]
> If you make changes to the XAML code that violate formatting rules—like misspelling the name of a control or leaving out a closing (`>`) tag—the design view displays an *Invalid Markup* message. You won't be able to display a preview.
>
> If you don't know how to fix your mistake, you can step back by selecting **Edit** > **Undo** until the preview works again.

## Create a project with Visual Studio

Now that Visual Studio is up and running and you're familiar with the environment, let's create a project to test that everything works.

1. Open Visual Studio. A **Visual Studio 2022** window displays. Select **Create a New Project**.

    :::image type="content" source="../media/create-new-project.png" alt-text="Screenshot of the Visual Studio 2022 start window. The Create a new project option is highlighted.":::

2. Type *Windows Universal* in the search box, select **Blank App (Universal Windows)**, and then select **Next**.

    :::image type="content" source="../media/select-project-type.png" alt-text="Screenshot of the Create a new project window. The search bar contains the text Windows Universal and is highlighted along with the correct template.":::

3. In the *Configure your new project* screen; name your app *Hello World*, leave **Location** and **Solution name** set to their default values, and select **Create**.

4. Set the **Minimum Version** to *Windows 10, version 1809* or later. Select **OK**.

    :::image type="content" source="../media/select-min-version.png" alt-text="Screenshot of the new Windows project screen. The minimum version Windows 10, version 1809 is selected and highlighted.":::

    Your project is created. Your project isn't empty – some files and settings are automatically generated for you.

5. Check your debug settings on the menu bar. They should be set to **Debug** and **x86**.

    :::image type="content" source="../media/check-debug-run-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The required debug settings are highlighted in green and the run button is highlighted in red.":::

6. Select the green triangle **Run** button to build and run your app. Or, press the *F5* key.

    :::image type="content" source="../media/run-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The run button, represented by a green triangle, is highlighted.":::

7. A large, blank window displays with the text *Hello World*. This screen is a preview of your app when it's running.

    :::image type="content" source="../media/hello-world.png" alt-text="Screenshot of the running Hello World app built in this unit. The debug toolbar is also shown.":::

    > [!NOTE]
    > The blue rectangle toward the top of your app window is a Visual Studio tool that helps with debugging. It won't appear in your final app.

8. Close your app or select the red square **Stop** button on the menu bar to stop running it.

    :::image type="content" source="../media/stop-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The stop button, represented by a red square, is highlighted.":::
