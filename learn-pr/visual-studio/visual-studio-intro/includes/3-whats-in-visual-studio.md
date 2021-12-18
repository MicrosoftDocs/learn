Visual Studio is best known for the rich experiences it provides developers in the editor and debugger as well as many other programming tools!

## Editor

The Visual Studio editor has excellent code completion, syntax highlighting, quick info hints, errors and warnings that come with codefix suggestions. That help you understand more about the code you are writing.

:::image type="content" source="../media/vs-intro-editor.png" alt-text="Screenshot of Visual Studio's code editor with callouts indicating the different colors in the UI, the lightbulbs that give suggestions in the margin, quick info boxes that appear when hovering, and the IntelliSense completion list.":::

IntelliSense is taken a step further with IntelliCode, the AI tool that is build into the editor. [IntelliCode](https://aka.ms/intellicode) is trained from open source code to bring common patterns and smart completion to your editor. It may appear as you type in the form of gray text suggetsions or it can make our intellisense completion list smarted by bubbling the most likely completions to the top of the list.

Built-in codefixes and refactorings appear as lightbulbs or screwdrivers in the margin of the editor. These helpful menus can suggest common actions, code fixes for errors or warnings in your files, and even make suggestions to improve your code style.

:::image type="content" source="../media/vs-intro-lightbulb.png" alt-text="Screenshot of Visual Studio's code editor selecting Generate constructor from the light bulb menu. A second screenshot shows the generated constructor in the code editor.":::

There are many navigation commands that can help you move around your code and files such as Go To Definition, Peek Definition, and Go To Base. Icons in the margin can also help you navigate your inheritance chain. You can even navigate backward to a previos location your cursor was at where you made changes with a button or by using a keyboard shortcut (Ctrl+-).

:::image type="content" source="../media/vs-intro-navigation.png" alt-text="Multiple screenshots of Visual Studio. First is the right-click menu showing navigation commands including go to definition and peek definition. The second shows an icon in the margin showing the base type of a class. The last shpws the navigation buttons at the top left corner of Visual Studio that have arrows pointing forwards and backwards to help navigate the cursor to different edit points.":::

Visual Studio even comes pre-loaded with templates and snippets to help you scaffold the right projects and code. For example, simply typing "prop" in the editor and typing `tab tab` will insert a Property.

:::image type="content" source="../media/vs-intro-snippet.png" alt-text="Two screenshots of Visual Studio with the first picture triggering snippet completion by typing prop in the editor and prompting the user to type tab tab to accept the snippet. The second screenshot shows the full property declaration inserted in the editor now saying public int MyProperty { get; set; }":::

## Debugger

After you've written some code you want to see it running in your app or webste! The green play button at the top of Visual Studio can help you do that. This launches the debugger.

:::image type="content" source="../media/vs-intro-debug-button.png" alt-text="Screenshot of Visual Studio's big green play button that launches the debugger.":::

If your app is a website it will start up a browser in your local host.

:::image type="content" source="../media/vs-intro-web-app.png" alt-text="Screenshot of Visual Studio debugging a website with a browser window open to localhost to a website called My First Website.":::

If it's a console app a console will pop up to run your app.

:::image type="content" source="../media/vs-intro-console-app.png" alt-text="Screenshot of Visual Studio with a debug console window in front of it showing the text Hello World.":::

You can click in the margin to set a break point. This pauses the debugger at that line of execution.

:::image type="content" source="../media/vs-intro-breakpoint.png" alt-text="Screenshot of Visual Studio in an active debug session. A red circle in the margin shows where the break point is in the code and a yellow arrow indicates where execution is currently at. The yellow arrow is overlaying the breakpoint.":::

Arrow buttons in the top of Visual Studio toolbar allow you to step into and around different lines of code. Note how the arrow is now one line past the breakpoint after selecting Step Into.

:::image type="content" source="../media/vs-intro-breakpoint-step.png" alt-text="Screenshot of Visual Studio debugging. The yellow arrow is now one line past the breakpoint. A red box calls out the Step Into button in the top visual Studio toolbar.":::

While debugging you can hover to view variables values at this point in execution. You can also pin these to your editor window so you can keep an eye on the values without needing to hover or you can search the autos, local, and watch windows for variable values as well.

:::image type="content" source="../media/vs-intro-debug-inspect.png" alt-text="Screenshot of Visual Studio debugging an object of type hobby. The cursor is hovering over the name property. The debugger shows the value in a window layered over it. At this point in execution the hobby name is "programming."":::

The debugger can also break when an exception is thrown in your program. This can be really helpful to determine what is going wrong if you app doesn't seem to be running correctly and you need more information. For example, in this case, we can't call Length on a null string so the debugger is throwing a Null Reference Exception. This shows when and where a null reference is being used which could break the running program.

:::image type="content" source="../media/vs-intro-break-exception.png" alt-text="Screenshot of Visual Studio debugging with the yellow execution cursor paused on a Length call on a null string. An exception window appears over and highlights the line where the exception is occuring and calls out the string that is null.":::

## Customization

Visual Studio is highly customizable allowing different themes, fonts, colors, and window layouts to be used! You can set these preferences in **Tools > Options**.

:::image type="content" source="../media/vs-intro-theme.png" alt-text="Screenshot of Visual Studio with the Tools Options dialog open and navigated to Environment General section. The theme drop down is expanded with the blue theme selected. The colors of Visual Studio are now blue as opposed to dark gray.":::

There are a ton of different themes created [by the community](https://devblogs.microsoft.com/visualstudio/custom-themes/) as well that might mimic some of your favortie color pallettes.

:::image type="content" source="../media/vs-intro-community-themes.png" alt-text="Collage of screenshots of different Visual Studio instances with a wide range of themes in different colors ranging from dark blue to vibrant red to light purple themes.":::

Customize the colors of different text display items and fonts in **Tools > Options > Environment > Fonts and Colors**

:::image type="content" source="../media/vs-intro-colors.png" alt-text="Screenshot of Visual Studio with the Tools Options dialog open and navigated to the Environment Fonts and Colors section. The font drop down has Comis Sans selected. The plain text color drop down now has magenta selected. The code in the editor window behind the Tools Options pane is now magenta and the font is Comic Sans.":::

All the windows in Visual Studio can be dragged and dropped to different sections around the editor. You can even drag windows outside the editor entirely for use on a different desktop. You can also save and reset your window layout for different tasks.

:::image type="content" source="../media/vs-intro-layout.png" alt-text="Screenshot of Visual Studio with one cs file being dragged to a different part of the editor. When dragging the file a semi-transparent display appears showing the different places the window can snap to including many different horizontal and vertical docking options above, below, to the left, or to the right of each window.":::

The toolbar at the top of Visual Studio contains lots of helpful buttons for different actions and commands. You can completely customize what buttons appear and even what commands they execute. 

:::image type="content" source="../media/vs-intro-toolbar.png" alt-text="Screenshot of Visual Studio with a menu open for selecting multiple different buttons to be pinned in the toolbar at the top of the Visual Studio app.":::

## Extensions

Visual Studio prides itself on being an open ecosystem where the community is empowered to create amazing developer tools. There are thousands of extensions in the [Visual Studio Marketplace](https://marketplace.visualstudio.com/vs) with millions of downloads. Some are paid for and some are free and even open source! Some developers have even found full-time jobs developing extensions for other developers. You can find an extension for tons of functionality from changing the editor background to a picture, adding even more colors to your editor with colorized indent guides, and testing with community-built open source frameworks.

:::image type="content" source="../media/vs-intro-extensions.png" alt-text="Screenshot of Visual Studio with the Manage Extensions top-level menu item called out and the manage extensions dialog page open. The extension page has installed extensions listed including Markdown Editor, Visual Studio IntelliCode, and Live Share extensions.":::

Of course, in an ecosystem that is constantly evolving there isn't an extension for *everything* so if you are at all interested or missing functionality, keep in mind that you can [build extensions yourself](/visualstudio/extensibility/starting-to-develop-visual-studio-extensions)! 

## Pair programming with Live Share

Pair programming is the idea of collaboratively editing and debugging code with others. Coding together with classmates or colleagues is a great way to transfer coding knowledge, do code reviews, troubleshoot, or share code while working remotely. [Live Share](https://aka.ms/liveshare) allows users to share a link and let others join your programming session. Building and debugging still happen on the host machine, but the host can see the cursors of the guests' live edits. The guests can see the hosts code, debug values, and build output all from within their own IDE.

:::image type="content" source="../media/vs-intro-liveshare.png" alt-text="Screenshot of Visual Studio with a code file open. Part of the code is highlighted in a different cursor labled with the user's name Aaron Yim. A Live Share chat window is also open with the host, Kendra Havens, thanking Aaron for joining the live share session.":::

Live Share is specifically good for students and teachers, but also used everyday by professional developers to literally get everyone on the same page!

## Publishing to the cloud

You can [publish](/visualstudio/deployment) your app directly to the cloud using Visual Studio's built-in publishing and pipeline management tools. It integrates with Azure so you can select and view cloud resources right from the IDE and select how you'd like to deploy.

:::image type="content" source="../media/vs-intro-publish.png" alt-text="Screenshot of Visual Studio with a Publish dialog open asking if the user wants to publish to Azure, docker, or a local folder.":::

## More to explore

This is just a taste of the developer experiences in Visual Studio. There are a lot more amazing tools packed into this IDE including Git and GitHub integration, UI designers, database explorers, code analysis, testing tools, and more! You can find more info on these features in the extensive [Visual Studio documentation](/visualstudio/) or stick around and explore the rest of the Visual Studio learning paths.
