<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-learning-unit-introduction-format)
-->
Before developing modern applications with Azure, there are some tools and configurations you might consider implementing on your development machine.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
In the bus-catching scenario, we will use several tools and languages to build out our microservices architecture.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->


<!-- 4. Image (highly recommended) ----------------------------------------------------------------

    Goal: Add a visual like an image, table, list, etc. that supports the topic sentence. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).
-->
TODO: add a visual, could be VS Code + Azure Data Studio. Is this required?

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. A visual like an image, table, or list

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->
## Tools for success
Here, you will learn how to download the latest recommended tools and extensions. You will also set up the code sample on your local machine. You'll also select a language for the rest of the learning path (Python, Node.js, or .NET Core).

### Visual Studio Code
Throughout the learning path, you'll use Visual Studio Code as your main IDE. If you have another IDE of choice, you are free to use it for the exercises, but note that the instructions will be catered to capabilities and options in Visual Studio Code.

1. Visual Studio Code is available on all operating systems. Navigate to the [Visual Studio Code Download](https://code.visualstudio.com/Download) page and download/install the application applicable to your operating system.

1. Open the **Extensions** blade from the left-hand taskbar. We recommend installing the following extensions:

    1. Azure Account
    1. Azure Functions
    1. GitHub
    1. Azure Resources
    1. SQL Server (mssql)

1. Sign in to GitHub in Visual Studio Code using your GitHub account. If you do not have a GitHub account, [create one here](https://github.com/join).

1. You'll need to fork and clone the GitHub repository so you can access it in Visual Studio Code. To do this, sign in to GitHub with your GitHub account and navigate to [this repository](https://github.com/Azure-Samples/serverless-full-stack-apps-azure-sql). In the top-right corner of your browser, select the **Fork** button.

1. Select **Code** and copy the HTTPS Clone URL, e.g. *https://github.com/<github-username>/serverless-full-stack-apps-azure-sql.git*.

1. Back in Visual Studio Code, select the **Source Control** blade from the left-hand taskbar.

1. Select **...** in the Source Control blade.

1. Select **Clone** from the drop-down menu and enter the URL copied in a previous step. Select the location you would like the repository to be copied locally.

1. In Visual Studio Code, select **File** > **Open folder** and navigate to the location where you cloned the repository. This will open the folder in your Visual Studio Code session.

1. Select the **Explorer** blade from the left-hand taskbar. Confirm that you see the repository files.

### Azure Data Studio
Azure Data Studio is a source-open application for managing various data services (SQL Server, Azure SQL, PostgreSQL, etc.) on any platform (Windows, Mac, Linux). In this module and learning path, you'll use Azure Data Studio to manage Azure SQL Database.

1. Navigate to the [Azure Data Studio Download](https://docs.microsoft.com/sql/azure-data-studio/download-azure-data-studio) page and download/install the application applicable to your operating system.

1. Azure Data Studio is very similar to Visual Studio Code in its layout. Select **File** > **Open folder**  and navigate to the location where you cloned the repository. This will open the folder in Azure Data Studio.

1. Select the **Explorer** blade from the left-hand taskbar. Confirm that you see the repository files.