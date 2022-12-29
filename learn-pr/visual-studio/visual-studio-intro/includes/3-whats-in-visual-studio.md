Visual Studio is best known for the rich experiences it provides developers in the editor, debugger, and many other programming features.

## Editor

The Visual Studio editor has excellent code completion, syntax highlighting, quick info hints, errors and warnings that come with code fix suggestions. These help you understand more about the code you're writing.

:::image type="content" source="../media/intro-editor.png" alt-text="Screenshot of Visual Studio's code editor. Callouts indicate the different colors in the UI and the light bulbs that give suggestions in the margin. More callouts point to quick info boxes that appear when the cursor hovers and the IntelliSense completion list.":::

IntelliSense is taken a step further with IntelliCode, the AI tool that is built into the editor. [IntelliCode](https://aka.ms/intellicode) is trained from open-source code to bring common patterns and smart completion to your editor. It may appear as you type in the form of gray text suggestions. IntelliCode can make your IntelliSense completion list smarter by bubbling the most likely completions to the top of the list.

Built-in code fixes and refactorings appear as light bulbs or screwdrivers in the margin of the editor. These helpful menus can suggest common actions and code fixes for errors or warnings in your files. They can even make subtle suggestions to improve your code style.

:::image type="content" source="../media/intro-light-bulb.png" alt-text="Screenshot of Visual Studio's code editor selecting Generate constructor from the light bulb menu. A second screenshot shows the generated constructor in the code editor.":::

There are many navigation commands that help you move around your code and files. Go To Definition, Peek Definition, and Go To Base are a few. Icons in the margin can also help you navigate your inheritance chain. You can even navigate backward to a previous location your cursor was at where you made changes with a button or by using a keyboard shortcut (Ctrl+-).

:::image type="content" source="../media/intro-navigation.png" alt-text="Three screenshots of Visual Studio. First is the right-click menu showing navigation commands including go to definition and peek definition. The second shows an icon in the margin showing the base type of a class. The last shows the navigation buttons at the top-left corner of Visual Studio. The arrows on these buttons point left and right to help navigate the cursor forwards and backwards to different edit points.":::

Visual Studio even comes pre-loaded with templates and snippets to help you scaffold the projects and code correctly. For example, simply typing `prop` in the editor and then pressing the <kbd>Tab</kbd> key twice will insert a Property.

:::image type="content" source="../media/intro-snippet.png" alt-text="Two screenshots of Visual Studio. The first picture shows how snippet completion is triggered. The user types prop in the editor and a prompt appears to press the Tab key twice to accept the Property snippet. The second screenshot shows the full property declaration inserted in the editor now saying public int MyProperty { get; set; }":::

## Debugger

After you've written some code, you want to see it running in your app or website! The green play button at the top of Visual Studio can help you do that; it launches the debugger.

:::image type="content" source="../media/intro-debug-button.png" alt-text="Screenshot of Visual Studio's big green play button that launches the debugger.":::

If your app is a website, it will start up a browser in your local host.

:::image type="content" source="../media/intro-web-app.png" alt-text="Screenshot of Visual Studio debugging a website. A browser window is open to localhost showing a website page titled My First Website.":::

If it's a console app, a console will pop up to run your app.

:::image type="content" source="../media/intro-console-app.png" alt-text="Screenshot of Visual Studio and a debug console window. The console window shows the text Hello World.":::

You can click in the margin to set a breakpoint. Breakpoints pause the debugger at a certain line of execution.

:::image type="content" source="../media/intro-breakpoint.png" alt-text="Screenshot of Visual Studio in an active debug session. A red circle in the margin shows where the breakpoint is in the code. A yellow arrow indicates what line the execution is on. The yellow arrow is overlaying the breakpoint.":::

Arrow buttons in the top of Visual Studio toolbar allow you to step into and around different lines of code. Note how the arrow is now one line past the breakpoint after selecting Step Into.

:::image type="content" source="../media/intro-breakpoint-step.png" alt-text="Screenshot of Visual Studio debugging. The yellow arrow is now one line past the breakpoint. A red box calls out the Step Into button in the top visual Studio toolbar.":::

While debugging, you can hover to view variables values at this point in execution. You can also pin these variable values to your editor window so you can keep an eye on the values without needing to hover. You can also use the autos, local, and watch windows to search for variable values.

:::image type="content" source="../media/intro-debug-inspect.png" alt-text="Screenshot of Visual Studio debugging an object of type hobby. The cursor is hovering over the name property. The debugger shows the value in a window layered over it. At this point in execution, the hobby name is programming.":::

The debugger can also break when an exception is thrown in your program. Breaking on exceptions can be helpful to determine what's going wrong if your app doesn't seem to be running correctly. It can give you more information on what exceptions are thrown and on what lines of code. For example, in this case, we can't call Length on a null string, so the debugger is throwing a Null Reference Exception. This exception shows when and where a null reference is being used, which could break the running program.

:::image type="content" source="../media/intro-break-exception.png" alt-text="Screenshot of Visual Studio debugging with the yellow execution cursor paused on a Length call on a null string. An exception window highlights the line where the exception occurs and calls out the string that is null.":::

## Customization

Visual Studio is highly customizable, allowing you to use different themes, fonts, colors, and window layouts. You can set these preferences in **Tools > Options**.

:::image type="content" source="../media/intro-theme.png" alt-text="Screenshot of Visual Studio with the Options dialog open to the Environment General section. The theme drop-down is expanded, with the blue theme selected. The colors of Visual Studio are now blue as opposed to dark gray.":::

There's also a ton of different themes created [by the community](https://devblogs.microsoft.com/visualstudio/custom-themes/) that might mimic some of your favorite color palettes.

:::image type="content" source="../media/intro-community-themes.png" alt-text="Collage of screenshots of different Visual Studio instances with a wide range of themes in different colors. The themes range from dark blue to vibrant red to light purple themes.":::

You can customize the colors of different text display items and fonts in **Tools > Options > Environment > Fonts and Colors**

:::image type="content" source="../media/intro-colors.png" alt-text="Screenshot of Visual Studio with the Options dialog open to the Environment Fonts and Colors section. The font drop-down has Comic Sans selected. The plain text color drop-down now has magenta selected. The code in the editor window behind the Options pane is now magenta, and the font is Comic Sans.":::

You can drag and drop all the windows in Visual Studio to different sections around the editor. You can even drag windows outside the editor entirely for use on a different desktop. You can also save and reset your window layout for different tasks.

:::image type="content" source="../media/intro-layout.png" alt-text="Screenshot of Visual Studio as a cs file is dragged to a different part of the editor. When dragging the file, a semi-transparent display appears. The display shows the different places the window can snap to, including many different horizontal and vertical docking options above, below, to the left, or to the right of each window.":::

The toolbar at the top of Visual Studio contains many helpful buttons for different actions and commands. You can completely customize what buttons appear and even what commands they execute.

:::image type="content" source="../media/intro-toolbar.png" alt-text="Screenshot of Visual Studio's toolbar at the top of the Visual Studio app. A menu on the toolbar is open for selecting multiple different buttons to be pinned in the toolbar.":::

## Extensions

Visual Studio prides itself on being an open ecosystem where the community is empowered to create amazing developer tools. There are thousands of extensions in the [Visual Studio Marketplace](https://marketplace.visualstudio.com/vs) with millions of downloads. Some are paid, and some are free and even open source. Some developers have even found full-time jobs developing extensions for other developers. You can find extensions for tons of functionality, from changing the editor background to a picture, adding even more colors to your editor with colorized indent guides, to testing with community-built open source frameworks.

:::image type="content" source="../media/intro-extensions.png" alt-text="Screenshot of Visual Studio with the Manage Extensions top-level menu item called out and the manage extensions dialog page open. The extension page has installed extensions listed including Markdown Editor, Visual Studio IntelliCode, and Live Share extensions.":::

Despite how many extensions are out there, in an ecosystem that is constantly evolving, there isn't an extension for *everything*. If you're interested or missing functionality, keep in mind that you can [build extensions yourself](/visualstudio/extensibility/starting-to-develop-visual-studio-extensions).

## Pair programming with Live Share

Pair programming is the idea of collaboratively editing and debugging code with others. Coding together with classmates or colleagues is a great way to transfer coding knowledge, do code reviews, troubleshoot, or share code while working remotely. [Live Share](https://aka.ms/liveshare) allows you to share a link and let others join your programming session. Building and debugging still happen on the host machine, but the host can see the cursors of the guests' live edits. The guests can see the host's code, debug values, and build output all from within their own IDE.

:::image type="content" source="../media/intro-live-share.png" alt-text="Screenshot of Visual Studio with a code file open. Part of the code is highlighted in a different cursor labeled with the user's name Aaron Yim. A Live Share chat window is also open with the host, Kendra Havens, thanking Aaron for joining the live share session.":::

Live Share is helpful for students and teachers, but also used everyday by professional developers to literally get everyone on the same page.

## Publishing to the cloud

You can [publish](/visualstudio/deployment) your app directly to the cloud using Visual Studio's built-in publishing and pipeline management tools. It integrates with Azure so you can select and view cloud resources right from the IDE. You can also select how you'd like to deploy.

:::image type="content" source="../media/intro-publish.png" alt-text="Screenshot of Visual Studio with a Publish dialog open asking if the user wants to publish to Azure, Docker, or a local folder.":::

## More to explore

These examples are just a taste of the developer experiences in Visual Studio. There are a lot more amazing tools packed into this IDE, including Git and GitHub integration, UI designers, database explorers, code analysis, testing tools, and more. You can find more info on these features in the extensive [Visual Studio documentation](/visualstudio/), or stick around and explore the rest of the Visual Studio learning paths after this module.
