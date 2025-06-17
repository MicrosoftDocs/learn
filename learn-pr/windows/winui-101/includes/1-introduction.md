Building Windows apps is an exciting journey into creating software that runs seamlessly on the Windows operating system, and this course guides you through the development process step by step. Whether you're building simple utilities or complex enterprise solutions, this learning path introduces you to the latest Windows development frameworks: the Windows App SDK and WinUI. Together, these frameworks provide a robust foundation for creating high-performance, visually appealing applications that use modern Windows capabilities while maintaining compatibility across devices.

:::image type="content" source="../media/1-introduction/tech-stack.png" alt-text="Highlevel Overview of Windows Techstack.":::

The **Windows App SDK** offers a comprehensive set of tools, libraries, and APIs that enable developers to build feature-rich applications with cutting-edge functionality. Crucially, this SDK decouples from the underlying operating system, allowing your app to access the latest features without being tied to a specific Windows version. This decoupling ensures wide compatibility across devices while delivering modern capabilities. **WinUI**, as part of the Windows SDK, is a powerful user interface framework that provides a rich set of controls and styles for building applications with a consistent and modern look. The **Windows Community Toolkit** complements these frameworks by providing a collection of helper functions, custom controls, and app services. These resources help simplify and demonstrate common developer tasks, which speeds up the development process.

## What will you be doing?

:::image type="content" source="../media/1-introduction/preview-game.png" alt-text="Screenshot of SnowPal Game.":::

Throughout this course, we put these tools into practice by building SnowPal, a word-guessing game. In this SnowPal game, the app selects a word for the user to guess, displaying it as a series of blank spaces where each space represents a letter. The player guesses letters one at a time; for every incorrect guess, part of the SnowPal character melts away. If the player guesses all letters before exhausting their turns, they win; otherwise, they lose. By building this SnowPal app step by step, you gain hands-on experience with core development concepts while creating something fun and functional.

## Software Architecture

For this course, we’ll use three key terms -— **View**, **ViewModel**, and **Model** -— to represent distinct parts of our application architecture:

:::image type="content" source="../media/1-introduction/mvvm-intro.png" alt-text="Highlevel Overview MVVM.":::

- The **View** term refers to the User Interface (UI) of the application. This View component displays data to users and handles user interactions.
- The **ViewModel** term handles presentation logic and transforms data from the Model into a form that the View can easily display.
- The **Model** term represents the data and business logic of the application.

These three components form the Model-View-ViewModel (MVVM) software architecture design. Using an MVVM approach allows us to build applications with clear separation of concerns between UI and logic. This MVVM approach makes your application easier to develop, test, and maintain. It also fosters better communication among developers by ensuring each component remains focused on its specific purpose.

The **ViewModel** component performs the databinding between View and Model components. This databinding enables automatic propagation of data changes in both directions. The ViewModel handles syncing raw Model data to reflect UI changes automatically. If the user makes a change, the View updates the ViewModel, which can then update the Model and notify the View.

:::image type="content" source="../media/1-introduction/mvvm-bi-directional-syncing.png" alt-text="Demonstrates that the View, ViewModel, and Model sync bi-directionally.":::

This bi-directional syncing between View and Model components allows us to have functionality that enables a user to press a letter button in our game. This button press triggers the ViewModel to both update the View (by disabling the button) and the Model (by processing the user's guessed letter).

Now that you have an overview of Windows development tools and our project goals for this course, let's dive in and start building your first Windows app!

> [!Note]
> You can check out the completed project [here](https://aka.ms/snowpal-sample).
