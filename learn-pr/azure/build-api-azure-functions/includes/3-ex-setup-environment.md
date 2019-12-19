Before you create the HTTP API with Azure Functions, you need to setup the database and the frontend web project that will be used in these exercises. First, you'll clone the main repo, which already contains a frontend for the API you will be building. Then you'll run a script which will create the products database and populate it with product data.

## Create the database

1. Sign into the sandbox as indicated above.

1. Clone the database scaffolding repo

   ```bash
   git clone https://github.com/burkeholland/tailwind-products.git
   ```

1. Run the following command to kick off the environment creation process

   ```bash
   ./CREATE_DB.sh
   ```

1. The first thing that the script will output is a tenant id. Copy this to your clipboard.

1. Press <kbd>Enter</kbd> key to continue the database creation process.

   > [!IMPORTANT]
   > The database creation step can take upwards of 10 minutes to complete. While it may look like nothing is happening in the Cloud Shell, the database creation process _is_ underway in Azure. Feel free to proceed through the Learn module; just make sure you leave the integrated terminal instance open until it completes.

## Setup the frontend project

1. Open your local terminal or command line.

1. Clone the frontend project repo.

   ```bash
   git clone https://github.com/burkeholland/tailwind-products-editor
   ```

1. Open the project in VS Code

   ```bash
   cd tailwind-products-editor
   code .
   ```

1. VS Code will detect a workspace file in this project and ask if you want to open it. Select "Open Workspace".

   ![VS Code notification prompt to open workspace](../media/open-workspace.png)

1. Open the integrated terminal in VS Code by pressing <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>`</kbd>.

1. Select "frontend".

1. Install the project dependencies.

   ```bash
   npm install
   ```

## Add concierge subscription to VS Code

1. Open settings in Visual Studio Code. Windows: <kbd>Ctrl</kbd>/<kbd>Cmd</kbd> + <kbd>,</kbd>.

1. Type "azure tenant".

1. Enter the tenant from your clipboard into the **Azure: Tenant** textbox.

1. Press <kbd>F1</kbd> to open the Command Palette.

1. Type "select subscription".

1. Chose "Azure: Select Subscriptions".

1. Select "Concierge Subscription" by checking the box next to it.

   ![VS Code Command Palette displaying available Azure Subscriptions to connect to.](../media/select-subscription.png)
