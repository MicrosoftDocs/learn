# Title

Introduction to Visual Studio Code

## Role(s)

Developer

## Level

Beginner

## Product(s)

Visual Studio Code

## Prerequisites

- Familiarity with integrated development environments (IDEs) and their features such as source control and debugging at the beginner level.
- Understanding of the software plugins concept for extensions and customization at the beginner level.

## Summary

Characterize the types of programming scenarios for which Visual Studio Code is a good IDE choice. Examine the development capabilities of Visual Studio Code such as the editor, debugger, and source control.

## Learning objectives

1. Evaluate whether Visual Studio Code is appropriate for your development work.
1. Describe how Visual Studio Code can be customized with extensions to configure a development environment to meet your needs.

## Outline the units

1. Introduction [(Introduction guidance)](/help/learn/id-guidance-introductions)

    - Whether you're a beginning or experienced developer, you'll need an integrated development environment (IDE) to create, edit, manage, run, and debug code.
    - There are many different IDEs available. Some are essentially simple text editors. Others can have many advanced features and support for multiple languages built in. But these full-featured IDEs often have a large installation footprint and a steeper learning curve than simpler IDEs.
    - So how do you know which IDE is right for you? It depends on what your needs are. For example, what programming languages are you using? Do you need to integrate with a source control management (SCM) provider such as GitHub?

    - **Example Scenarios**
    - Suppose you're building a web site for a restaurant in your hometown. You know that you'll need to create the pages using HTML, CSS, and JavaScript. In addition, you'd like to be able to debug your code and view your site locally on your computer as you're testing. You also want incorporate a version control system to manage changes to your web pages.
    - In addition, suppose the restaurant needs to create an inventory management system in C++ that can be used by employees from desktops in the kitchen and back office. You want to make sure that your IDE supports C++ syntax, libraries, compilers, and debuggers.
    - Furthermore, suppose the restaurant's chef has asked if you can help them with data analytics. The chef would like you to examine trends in sales of pizza when the local sports clubs win matches or games. You're comfortable using Python and Jupyter notebooks for your data science work and want an IDE that supports those languages and tools.
    - **What will we be doing?**
    - In this module, we’ll evaluate if Visual Studio Code is the right IDE for various scenarios. You'll also learn about the Visual Studio Code features that you can customize and configure to support many different types of development work.
    - **What is the main goal?**
    - By the end of this module, you'll evaluate if Visual Studio Code meets your set of programming requirements.

1. What is Visual Studio Code?
    - Visual Studio Code is a free, lightweight, open-source integrated development environment (IDE) that can be customized through extensions to support many different programming needs.
    - **What are the main features?**
    - Visual Studio Code has a small installation footprint so it starts up quickly and provides a fast, responsive editing experience.
    - Visual Studio Code's UI is based on Electron, a cross-platform technology for building desktop applications, so it runs on Linux, MacOs, or Windows.
    - Visual Studio Code contains an editor based on the Monaco technology that provides a workspace to create and edit code.
        - The editor has rich features such as code syntax coloring, bracket matching, and IntelliSense.
        - File explorer to work with files and folders. Your work does not have to be project based. However, you can work with solution or project files.
        - Search capability across your folders and files.
    - In addition to the editor, Visual Studio Code contains the following features:
        - Terminal so that you can run commands within your directory without having to leave Visual Studio Code
        - Debugger - inspect your code for issues without having open separate debugging tools
        - Source control - manage your code with Git-compatible tools and work directly with remote repositories within Visual Studio Code
        - Extensions - to add more features and functionality beyond what's in the initial download of Visual Studio Code
    - 

1. How Visual Studio Code works
    - Now that you’re familiar with the key features of Visual Studio Code, let’s see how Visual Studio code works—what capabilities you get out of the box and what you can add through the extensions marketplace.
    - Visual Studio Code has a lightweight footprint. Out-of-the-box, Visual Studio Code provides:
        - support for several languages including HTML, CSS, and JavaScript
        - integration with Git for source control
        - integration with Node.js for running and debugging JavaScript
    - Add more functionality and compatibility with other languages and tools by installing Extensions.
        - What are Extensions?
            - What are they? Code packages that plug into the Visual Studio Code UI and add support for features such as:
                - Themes to change the look-and-feel of the UI color scheme or file icons
                - Productivity tools such as Linters or code beautifiers
                - Support additional programming languages
                - Support specific debugging runtimes
            - Where do you get them? 
                - Search for, download, and install extensions from the Visual Studio Code Extensions Marketplace.
            - Is there a cost? 
                - Many are free. 
                - Some must be purchased.
            - Who built the extensions?
                - Microsoft publishes many extensions.
                - Third-party providers also publish extensions.
                - You can build your own as well and share them in the Marketplace.
        - You can add what you need to Visual Studio Code quickly and leave out what you don't through the Extensions Marketplace.
    - Scenarios – Now that we’ve seen how Visual Studio Code works, let’s apply this knowledge and see how we might set up Visual Studio Code in our scenario.
        - **Restaurant website**. The developer:
            - Downloads and installs Visual Studio Code. 
            - Using the built-in terminal, installs Node.js packages such as Express and runs a command to generate scaffolding of a simple Node.js application.
            - Uses the editor workspace to edit the website’s HTML, CSS, and JavaScript files. The editor provides hints for code completion, which helps the developer save time and ensure code is correct.
            - Using the extensions marketplace, installs the Prettier extension for formatting.
            - Debugs the application using the built-in debugger.
            - When finished working, checks in changes into GitHub using the built in Source Control Manager view (SCM).
        -What's great is that the developer can continue using Visual Studio Code for the other restaurant projects. To do so, the developer...
        - **Restaurant inventory application**. The developer:
            - Installs the C/C++ extension.
            - Installs the Microsoft Visual C++ (MSVC) compiler toolset.
            - Runs and debugs code locally. 
            - When finished, checks in code to remote repository using GitHub integration.
        - **Restaurant data analytics application**. The developer:
            - Installs the Python extension (which contains the Jupyter notebook extension)
            - Installs a Python interpreter


1. When to use Visual Studio Code

    - It depends! You have a lot of choices for code editors.
    - Here's a table to help you in making your decision:

| Factor | Description |
| ----| ---- |
| Is there an official IDE for the language or framework I’m using? | There may be many different editors available for the language you want to work in. For example, you can edit HTML is just about any IDE. However, for some specialized use cases such as MacOS and Android development, you may want to choose an official editor. |
| Does the IDE support the language I want to use? | Out-of-the-box, Visual Studio code supports HTML, CSS, JavaScript, TypeScript, and few others. With hundreds of different language extensions to choose from, Visual Studio Code can be configured to meet most programming needs. Language support means that Visual Studio Code can provide features such as code completion (IntelliSense) as you’re editing and debugging capabilities for code written in that language. |
| Do I want an IDE with a small download? | The installation footprint of Visual Studio Code is very small, letting you download, install, and get started working quickly. Visual Studio Code is lightweight. You install only those extensions that you need to work and don’t have to load any unnecessary components that can slow you down. |
| Do I want source control integrated with my IDE? | Visual Studio Code has integrated source control management (SCM) and includes Git and GitHub support out-of-the-box. You can integrate with other SCM providers such as Subversion or Bitbucket by installing extensions from the marketplace. |

- Apply the criteria to different scenarios:

| | Web development | C++ development | Data science | MacOS/Android Development |
| ---- | ----| ---- | ----| ---- |
| Is there an official IDE for this language or framework? | No | No | No | Yes |
| Does Visual Studio Code support the language or framework I'm using? | Yes | Yes | Yes | Yes |
| Do I want an IDE with a small footprint? | Yes | Yes | Yes | Yes |
| Do I need source control integration with my IDE? | Yes | Yes | No | No |
| Use Visual Studio Code? | Yes | Yes | Yes | Maybe * |

Note: Visual Studio Code does have extensions to support MacOS and Android development. However, there are full-featured official MacOS (XCode) and Android (Android Studio) IDEs.

1. Knowledge Check

    What types of questions will test the learning objective? [(Knowledge check guidance)](/help/learn/id-guidance-knowledge-check)

- Suppose you work for a company that manages a code repository on GitHub. Programmers are required to commit code regularly to this repository. Which feature of Visual Studio Code helps you meet this requirement?
    - This feature isn’t supported by Visual Studio Code.
    - You can use the built-in source control feature of Visual Studio Code.
    - You can install a code-formatting extension for Visual Studio Code.
- Suppose you’re developing an Android app. Should you use Visual Studio Code?
    - Yes. Visual Studio Code supports Android development out-of-the-box.
    - Maybe. You can install extensions to support Android development in Visual Studio Code. However, a better choice might be the official Android development tools.
- Suppose your team is planning to develop applications in Rust. How would you determine if Visual Studio Code can support this need?
    - You search the Extensions Marketplace to determine if there are Rust extensions.
    - You don’t need to do further research because Visual Studio Code is a lightweight editor that supports only a few languages.

    
1. Summary

- Our goal was to help you evaluate whether Visual Studio Code is a suitable choice for your programming needs. We developed the following criteria to guide your decision:
    - Is there an official IDE for the language or framework I’m using?
    - Does Visual Studio Code support the language or framework I’m using?
    - Do I want an IDE with a small footprint?
    - Do I need source control integration with my IDE?
- You applied these criteria to building a website for a restaurant. Your analysis helped you determine that Visual Studio Code has the features such as an integrated terminal and out-of-the-box support for HTML and JavaScript that helps you start building right away. You’re able to install extensions as needed such as Prettier to help make coding easier. As you build your pages, you’re able to commit them to a remote repository on GitHub. 
- The criteria also helped you determine that Visual Studio Code is an appropriate choice for C++ development of an inventory system for the restaurant and for performing data science tasks in a Python and Jupyter Notebooks environment in Visual Studio Code.


- Resources
    - Link to Visual Studio Code home page

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.