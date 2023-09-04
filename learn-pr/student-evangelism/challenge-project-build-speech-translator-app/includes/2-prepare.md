<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the project and setup requirements in 1-3 sentences.

    Heading: none

    Pattern: "You'll be <doing> a <thing> that <goal>. Here, we'll discuss the project <big picture>. We'll also cover the <things> you'll need."

    Example: "You'll be <building> a <Logic App> that <determines the sentiment of new tweets and reacts accordingly>. Here, we'll discuss the project <business logic and target behavior>. We'll also cover the <accounts and software> you'll need."
-->
TODO: add your topic sentences(s)

<!-- 2. Project specification -----------------------------------------------------------------------------

    Goal: Describe the success criteria for the entire project. Avoid hints and guidance on how they'll achieve the goal.

    Heading: "Project specification"

    Structure: The specification format is at the author's discretion and will vary based on project type. For example, you could provide any or all of the following:
        - Functional specification for what this part of the project should do when complete.
        - Acceptance criteria (functionality, capacity, resilience, performance, etc.).
        - List of the technologies they should use.
-->
## Project specification
TODO

<!-- 3. Setup -------------------------------------------------------------------------------------

    Goal: Guide the learner though any needed setup such as required accounts or local software installations.

    Structure:
        1. H2 of "Setup"
        2. 1 paragraph of text giving a conceptual overview of the needed setup
        3. One H3 per setup item explaining the need and giving instructions.
            - Use "Create <service> account" as the H3 for account creation.
            - Use "Install <product>" as the H3 for software installation.
            - For setup items beyond accounts and software, use an H3 that follows the "<verb> <item>" pattern.

    Example:
        "To complete the project, you'll need a Twitter account, an Azure account, and a local installation of Visual Studio Code.

        ### Create Twitter account
            Your Logic App needs to pull new tweets from Twitter using the Twitter connector. Under the hood, the Twitter connector uses the Twitter API. The Twitter API requires authentication via a username and password, which means that you'll need a Twitter account.
            1. Go to <link> and create an account.
            1. Record your username and password, you'll need it later.

        ...

        ### Install Visual Studio Code
            You'll use Visual Studio Code to create your Logic App. All your work will be done directly in VS Code: connecting to your Azure account, selecting your Azure subscription, and building your app. This section guides you through the installation and setup of VS Code on your local machine.
            1. Go to <link> and follow the installation steps for your platform.
            1. Go to <link> and follow the steps to connect to your Azure account from VS Code.
            1. Go to <link> and follow the steps to select your Azure subscription."

    Note: The "Setup" section is optional. If the project doesn't require any setup, omit this entire section.
    In that case, also remove the "Project specification" H2 (while leaving the content of that H2) to avoid a page
    containing a single H2.
-->
## Setup
Strong lead sentence stating the categories of what's needed: accounts, software, etc.
Remainder of paragraph if needed.
### Create (service) account (repeat as needed)
Strong lead sentence stating the required account.
Remainder of paragraph explaining why this is needed and what it will be used for.
Inline instructions or link to setup instructions.
### Install (product) (repeat as needed)
Strong lead sentence stating the product needing installation.
Remainder of paragraph explaining why this is needed and what it will be used for.
Inline instructions or link to setup instructions.

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->