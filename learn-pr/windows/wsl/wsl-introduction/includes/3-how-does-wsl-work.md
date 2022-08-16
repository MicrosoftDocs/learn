<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

How does WSL work?

    - Overview of the main components/features
        - Introduce the two architectures (WSL 1 and 2)
        - Compare the features for WSL 1 and WSL 2
        - Choosing between WSL 1 and WSL 2
    - Overview of development environment and workflow
        - File system separation, etc.
        - Why WSL is intended for CI/CD and not production
        - Demonstration of workflow
-->
# How does WSL work?

Windows Subsystem for Linux supports two different versions of architectural set up which work in slightly different ways - "WSL 1" and "WSL 2." WSL 2 is now the default architecture, but there are a few specific use-cases that may lead someone to want to use WSL 1.

## WSL 1

The original WSL, now known as "WSL 1", is a translation layer, providing a Linux-compatible kernel interface on top of the Windows kernel. It basically emulates a system call from the Linux executable file format ("unmodified ELF64 binaries").

The main reason to use WSL 1 would be specific scenarios that require your project files to be stored in the Windows file system or if your project requires cross-compilation using both Windows and Linux tools on the same files. WSL 1 offers faster access to files mounted from Windows.

## WSL 2

The current default for WSL architecture, known as "WSL 2", uses an actual Linux kernel, built by Microsoft, based on the Linux source kernel, and benefiting from all of the latest security fixes and kernel improvements. It is opensource so you can report bugs or request features and check the release notes if that interests you.

WSL 2 provides faster access to local files and full system call compatibility because it's running an actual Linux kernel inside a lightweight virtual machine (VM), but it avoids all of the overhead of a traditional VM, requiring few resources and needing no configuration or management.

## Switching between WSL 1 and WSL 2

Once you have installed a Linux distribution, WSL allows you to switch between running it with the version 1 or version 2 architecture, using the simple command: `wsl --set-version <distribution name> <version#>`. It is generally recommended to use WSL 2 unless you have a specific reason not to.

## Using WSL in an app development workflow

Now that you have an idea of how WSL works behind the scenes, let's take a look at how it works in a practical development workflow for building or maintaining an app. This is a high-level overview, step-by-step guidance is available in the WSL documentation or a later WSL training module.

Typically we would start with the one-time install steps that include:

- Install WSL (and the Ubuntu distro by default)
- Install Visual Studio Code and the Remote-WSL Extension
- Install Windows Terminal
- Install Git and the Git Credential Manager

*These install steps are covered in more detail in a separate training module.*

![WSL workflow diagram showing Ubuntu, VS Code, Remote-WSL extension, and web browser.](../media/wsl-workflow.png)

The steps for setting up a WSL development environment would typically include:

- Open Ubuntu, set up your Linux user name and password, then reopen Ubuntu in Windows Terminal and customize your command prompt just how you like it.
- Install the code project or framework that you want to work with on Linux. This might mean installing frameworks like NodeJS, NextJS, or React, cloning a GitHub repo, or downloading a Docker container image. It will also likely mean using a package manager, updating/upgrading the packages available in your distribution, and possibly installing a version manager.
- Once your project is created or installed on your Linux file system (Ubuntu by default), you can open it in VS Code using the Remote-WSL extension. Once open, you can edit and debug your code, taking advantage of VS Code features like Intellisense code completion, linting, etc. because the remote extension handles the pathing for you between Linux (where your project code is stored) and Windows (where the VS Code app is stored).
- You can build and run your project code on Linux (in Ubuntu) and then view your project using the Microsoft Edge web browser and debug using VS Code. There is even support for live reloading as you update your code.

*The set up for a WSL development environment is covered in more detail in a separate training module.*

## A tool for development, not production

The intent is for WSL to be used as a tool for development. It is not intended to be used for production workloads. This means that it is great for learning to work with Linux tools and great for building and testing applications, but when it comes to deploying for production, we recommend checking out [Docker Containers](https://docs.docker.com/cloud/aci-integration/) and [Azure App Service](/azure/app-service/overview), both of which work great with [WSL](/windows/wsl/tutorials/wsl-containers) and [VS Code](https://code.visualstudio.com/docs/containers/app-service).

### CI/CD Inner Development Loop

A common developer practice is to set up an inner development loop. An inner development loop is the process a developer takes from writing their code to committing to a version control system (like Git), getting it ready to enter "Continuous Integration" (CI) and ultimately deploying to production, or "Continuous Delivery" (CD). This is commonly called a "CI/CD pipeline." CI/CD is usually a part of "DevOps", the joining of development and operations. These are important concepts to understand as you advance in the world of professional development. Continuous Integration is the practice of integrating your code changes into the main branch of a shared source code repository early and often, automatically testing each change when you commit or merge them to see if your code works or breaks things. It helps to identify and fix any errors or security issues, as well as to avoid conflicts with others who may be contributing to code for a project. Continuous Delivery (also called Continuous Deployment) is the part after the code has been tested and built as part of the CI process and often involves automated bug testing and "deploying" code from a repository or container registry to a live production environment (often by an Operations team), where it can be used by customers. Sometimes this is "shipping" a new feature, "releasing" a new version, or maybe fixing a bug.

### How WSL offers parody to live production environments

WSL supports this process by letting developers test Linux-based code on their "local" machine (their laptop or desktop computer) before deploying it to the cloud, which is often running the code on a Linux-based operating system or virtual machine. Because Linux can be customized and stripped down to only use what you need, it is often a good fit for cloud-deployed apps. Using a Linux-based environment with WSL enables there to be parody between the Linux tools and operating system you're working on and what will be running your project's code in the cloud. It is always wise to preview how your code will work before pushing changes to a live environment where errors or bugs could be dangerous for security or cause outages for the end users.

<!-- ## A common end-to-end app development workflow with WSL

1. Install everything you need, this may include...

- a Linux distribution (like Ubuntu)
- code language frameworks (such as Node, React, Python, etc. keeping in mind that you may need a specific version of these depending on the project requirements)
- any existing project code if your not starting something new (this might be cloning a Git repo or downloading a Docker image)
- a code editor (such as Visual Studio Code) for writing, editing, and debugging your code
- A version control manager (such as Git) for collaborating with others and maintaining different versions of your project
- A container manager (such as Docker) if you are working on a project stored in a container
- A customized command line (such as Windows Terminal) set up to show you helpful information (such as version management info like what branch you're working in) or quickly switch between directories or even different command lines (such as Ubuntu, PowerShell, and an Azure CLI)

2. 
- Open your project directory in the command line and check that you have the correct versions of your code languages and frameworks using a command like `python --version`
-  -->

<!-- 5. Validation -------------------------------------------------------------------------------------------

    Goal: Enables the learner to evaluate if they completed the exercise correctly. Feedback like this is critical for learning.

    Structure:
        1. A heading of "## Check your work".
        2. An introductory paragraph describing how they'll validate their work at a high level.
        3. Numbered steps (if the learner needs to perform multiple steps to verify if they were successful).
        4. Video of an expert performing the exact steps of the exercise (optional).

    Example:
         "At this point, the app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->


<!-- Do not add a unit summary or references/links -->
