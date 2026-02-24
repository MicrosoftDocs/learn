With a clear understanding of security considerations, you're ready to enable GitHub Copilot and Fabric Copilot for your database development workflows. This unit walks you through the setup process for each tool across different development environments.

## Prerequisites for AI-assisted tools

Before enabling AI-assisted tools, ensure you have the required prerequisites:

**For GitHub Copilot:**
- A GitHub account with Copilot access (Individual, Business, or Enterprise subscription)
- A supported development environment (Visual Studio Code, Visual Studio, or SQL Server Management Studio 22+)
- An active internet connection for AI model communication

**For Fabric Copilot:**
- A Microsoft Fabric capacity (F2 or higher) or Power BI Premium capacity (P1 or higher)
- Appropriate permissions in your Fabric workspace
- Copilot features enabled at the tenant level by your administrator

## Enable GitHub Copilot in SQL Server Management Studio

SQL Server Management Studio (SSMS) 22 and later versions include native support for GitHub Copilot. To [install GitHub Copilot in SSMS](/ssms/github-copilot/installation-state?azure-portal=true), follow these steps:

1. Launch the **Visual Studio Installer** on your machine
2. Locate your SSMS installation and select **Modify**
3. On the Workloads tab, select **AI Assistance**
4. Select **Modify** to install the GitHub Copilot components

After installation, you'll see a GitHub Copilot status icon in the upper-right corner of SSMS. The icon indicates whether Copilot is active, inactive, unavailable, or not installed.

:::image type="content" source="../media/sign-in.png" alt-text="Screenshot showing the GitHub Copilot badge options in SSMS.":::

To sign in and activate Copilot:

1. Select the GitHub Copilot badge in SSMS
2. Choose **Open Chat Window to Sign In**
3. Sign in with your GitHub account that has Copilot access
4. If you don't have a Copilot subscription, select **Sign up for Copilot Free** to get started

> [!TIP]
> If you have multiple GitHub accounts, ensure you sign in with the account that has an active Copilot subscription. You can check your subscription status at GitHub's Copilot settings page.

## Enable GitHub Copilot in Visual Studio Code

Visual Studio Code provides a flexible environment for database development with the MSSQL extension combined with GitHub Copilot. To [set up GitHub Copilot in VS Code](/sql/tools/visual-studio-code-extensions/github-copilot/overview?azure-portal=true):

1. Open Visual Studio Code
2. Access the Extensions view (**Ctrl+Shift+X** on Windows/Linux, **Cmd+Shift+X** on macOS)
3. Search for and install the **GitHub Copilot** extension
4. Search for and install the **GitHub Copilot Chat** extension
5. Sign in to your GitHub account when prompted

:::image type="content" source="../media/github-copilot-extension-vs-code.png" alt-text="Screenshot showing the GitHub Copilot extension in Visual Studio Code.":::

For SQL database development, you'll also want the MSSQL extension:

1. In the Extensions view, search for `mssql`
2. Install the **SQL Server (mssql)** extension by Microsoft
3. Connect to your database using the Connections view

With both Copilot and MSSQL extensions installed, you can start conversations about your database directly in the Copilot Chat panel. Right-click on a connected database and select **Chat with this database** to begin a context-aware conversation.

:::image type="content" source="../media/vs-code-chat-database-context-menu.png" alt-text="Screenshot showing the database context menu with the Chat with this database option.":::

## Enable Fabric Copilot

Fabric Copilot is available within Microsoft Fabric workspaces when your organization meets the licensing requirements. Enabling Copilot involves both tenant-level and workspace-level settings.

**Tenant-level configuration** (requires Fabric Administrator):

1. Navigate to the Fabric Admin portal
2. Go to **Tenant settings**
3. Under the Copilot and Azure OpenAI Service section, enable **Users can use Copilot and other features powered by Azure OpenAI**
4. Configure which security groups have access to Copilot features

**Workspace-level usage:**

Once enabled at the tenant level, users with appropriate permissions can access Copilot within:
- Data Engineering experiences (notebooks, data pipelines)
- Data Warehouse experiences (SQL queries, semantic models)
- Data Science experiences (notebooks, experiments)

To use Copilot in a SQL database in Fabric:

1. Open your SQL database in the Fabric portal
2. Navigate to the query editor
3. Look for the Copilot button or icon in the toolbar
4. Start typing natural language queries or use the chat interface

## Configure Copilot for your team

For enterprise deployments, you'll want consistent configuration across your team. Consider these setup practices:

**Standardize subscriptions**: Ensure all team members have the same level of Copilot access to avoid confusion about available features.

**Document approved uses**: Create guidelines about when and how to use AI assistance, especially for production database changes.

**Set up shared instruction files**: You can create custom instruction files that guide Copilot's behavior for your team's coding standards (covered in a later unit).

## Verify your setup

After enabling AI-assisted tools, verify everything is working correctly:

**In SSMS:**
1. Connect to a database in the query editor
2. Open the Copilot Chat window (**Ctrl+\\, Ctrl+C**)
3. Ask a simple question like "What tables are in this database?"
4. Verify you receive a contextual response

**In VS Code:**
1. Connect to a database using the MSSQL extension
2. Open a new `.sql` file
3. Open the Copilot Chat panel (**Ctrl+Alt+I**)
4. Type a comment describing a query: `-- Get all customers from Seattle`
5. Press Enter and observe if Copilot suggests relevant SQL

**In Fabric:**
1. Open a SQL database in your workspace
2. Access the Copilot interface
3. Ask "Describe the tables in this database"
4. Verify the response reflects your actual schema

> [!NOTE]
> If Copilot isn't providing contextual suggestions, verify your database connection is active and that your account has the necessary permissions to query schema information.

With GitHub Copilot and Fabric Copilot enabled, you're ready to explore advanced configuration options that customize how the AI assistants behave for your specific workflows.
