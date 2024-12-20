
How do you know whether Visual Studio Code is the right choice for your development work? It depends. You have many choices when it comes to code editors and IDEs. In this section, we explore ways to help you make an evaluation.

## Decision criteria

The following table contains criteria to help you decide whether Visual Studio Code is right for your scenario.

| Factor | Description |
| ----| ---- |
| Is there an official code editor or IDE for the programming language or framework I'm using? | There might be many different editors and IDEs available for the programming language you want to work in. For example, you can edit HTML in just about any code editor or IDE. However, for some specialized use cases such as iOS and Android development, you might want to choose an official editor. |
| Does the code editor or IDE support the programming language or framework I want to use? | Out-of-the-box, Visual Studio Code supports HTML, CSS, JavaScript, TypeScript, and few other languages. With hundreds of different language extensions to choose from, Visual Studio Code can be configured to meet most programming needs. Language support means that Visual Studio Code can provide features such as code completion (IntelliSense) as you're editing and debugging capabilities for code written in that language. |
| Do I want a code editor or an IDE with a small download? | The installation footprint of Visual Studio Code is small, letting you download, install, and get started working quickly. Visual Studio Code is lightweight. You install only those extensions that you need  and don't have to load any unnecessary components that can slow you down. However, in some cases, such as for .NET or C# development on Windows, you might prefer to use an IDE such as Visual Studio. Visual Studio has a larger footprint but has all the language-support, debugging, and testing features you need out-of-the-box.|
| Do I want source control integrated with my code editor or IDE? | Visual Studio Code includes integrated source control management (SCM) and includes Git and GitHub support out-of-the-box. You can integrate with other SCM providers such as Subversion or Bitbucket by installing extensions from the Marketplace. |

> [!NOTE]
> Depending on the operating system that's installed on the computer you're using to develop code, your choices of code editor or IDE can be limited. Fortunately, Visual Studio Code runs on Windows, Linux, and macOS platforms.

## Apply the criteria

Now let's apply the decision criteria to our restaurant scenario. Recall that we're building: a web application in Node.js, an inventory application in C++, and a data analytics tool using Python and Jupyter notebooks.

Let's add one more requirement to our scenario. The restaurant manager likes the work you're doing and makes a further request: Can you develop mobile apps for patrons to place pickup and takeout orders? So, let's also apply the criteria to mobile app development for iOS and Android.

| Factor | Web development | C++ development | Data analytics | iOS/Android development |
| ---- | ----| ---- | ----| ---- |
| Is there an official code editor or IDE for this programming language or framework? | No | No | No | Yes |
| Does Visual Studio Code support the programming language or framework I'm using? | Yes | Yes | Yes | Yes |
| Do I want a code editor or an IDE with a small footprint? | Yes | Yes | Yes | Yes |
| Do I need source control integration with my code editor or IDE? | Yes | Yes | Maybe | Yes |
| **Use Visual Studio Code?** | **Yes** | **Yes** | **Yes** | **Maybe** |

After applying the criteria, you determine that Visual Studio Code is a good choice for your web development, C++, and data analytics projects for the restaurant. Although Visual Studio Code does have extensions to support iOS and Android development, you might prefer to use the full-featured official iOS (XCode) and Android (Android Studio) IDEs for developing the restaurant's mobile app.

You can revisit the criteria as your needs change. For example, in the future, you might decide you want to develop the inventory application in .NET and C# instead of C++. You also might determine that having a lightweight editor is no longer a priority. In this case, you might want to consider using Visual Studio instead. Visual Studio provides better built-in support and richer features for developing in .NET and C#.