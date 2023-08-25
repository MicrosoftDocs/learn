In this exercise, you build the front-end app. You start with a scaffold, and then you build out the components you need to add data to the app.

## Configure dev environment

A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [Develop in browser](#tab/github-codespaces)

GitHub Codespaces runs a development container managed by GitHub with **Visual Studio Code for the Web** as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `main` branch of the `MicrosoftDocs/minimal-api-work-with-databases` GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=422316964)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

1. Validate that .NET 6 and Node.js are installed in your environment:

    ```bash
    dotnet --list-sdks
    node --version
    ```

1. Close the terminal.

1. The remaining exercises in this project take place in the context of this development container.

#### [Develop locally](#tab/visual-studio-code)

The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for [Visual Studio Code](https://code.visualstudio.com/) requires [Docker](https://docs.docker.com/) to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.

1. Open **Visual Studio Code** in the context of an empty directory.

1. Ensure that you have the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in Visual Studio Code.

1. Open a new terminal in the editor.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal.":::

1. Clone the [`MicrosoftDocs/minimal-api-work-with-databases`](https://github.com/MicrosoftDocs/minimal-api-work-with-databases) GitHub repository into the current directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/minimal-api-work-with-databases.git .
    ```

1. Open the folder into which you cloned the GitHub repository.
1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen in Container**.

    :::image type="content" source="../media/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::

    > [!TIP]
    > Visual Studio Code might automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command palette to reopen the current workspace in a container.
    >
    > :::image type="content" source="../media/reopen-container-toast.png" alt-text="Screenshot of a toast notification to reopen the current folder within the context of a development container.":::

1. Validate that .NET 6 and Node.js are installed in your environment:

    ```bash
    dotnet --list-sdks
    node --version
    ```

1. Close the terminal.

1. The remaining exercises in this project take place in the context of this development container.

---

## Scaffold an app

To scaffold an app, you use the `Vite` scaffolder. By using `npx`, you can call the scaffolder and have it create a working React app in a matter of seconds.

1. Open an integrated terminal, <kbd>Ctrl</kbd> + <kbd>\`</kbd> to create the app by using `npx create vite@latest PizzaClient --template react`:

    ```bash
    npm create vite@latest PizzaClient --template react
    cd PizzaClient
    ```

    Answer the CLI prompts as follows:

    * **Package name**: `pizzaclient`
    * **Select a framework**: `React`
    * **Select a variant**: `Javascript`

    What you get is a directory, _PizzaClient_, that contains your scaffolded React app.

1. Install dependencies by calling `npm install`:

   ```bash
   npm install
   ```

1. Update the `vite.config.js` to provide a consistent front-end port. Replace the contents of `./vite.config.js` with the following code:

    :::code language="javascript" source="../code/with-components-and-static-data/vite.config.js" :::

    * **PORT**: The port is set to 3000, a common port number used for front-end apps.


1. Start the app by calling `npm run dev`:

   ```bash
   npm run dev
   ```

1. When you see the notification to **Open in browser**, select that.

   You should see the page render like this example:

   :::image type="content" source="../media/vite-orginal.png" alt-text="Screenshot that shows a rendered SPA app.":::

1. Press **Ctrl+C** to stop the app.

## Build the Pizza component

Build the parent component that manages state for the pizza list. The initial data is hard-coded in the component. Later, you'll move the data to a server.

1. Create a file in the _src_ subdirectory named  _Pizza.jsx_ and give it the following content:

    :::code language="javascript" source="../code/with-components-and-static-data/Pizza.jsx":::

    This component is responsible for managing the data and passing it to the `PizzaList` child component. It also handles the `create`, `update`, and `delete` data operations. This component has no visible UI. That functionality is handled by the `PizzaList` component.

    The `Pizza` component uses the `useState` and `useEffect` hooks to create data state. The `useState` hook is used to manage the `data` and `maxId`. The `useEffect` hook is used to set the data on the initial page request. The `Pizza` component passes the `data` to the `PizzaList` component.

## Build a Pizza list component

Create a file in the _src_ subdirectory named  _PizzaList.jsx_ and give it the following content:

:::code language="javascript" source="../code/with-components-and-static-data/PizzaList.jsx" :::

The `PizzaList` React component renders a form to create and edit pizza items. The component receives props from the parent `Pizza.jsx` and uses the `useState` and `useEffect` hooks to manage the form data and the editing state.

The PizzaList component renders a form with two input fields for the pizza `name` and `description`, and two buttons to create or update a pizza. 

## Add Pizza to your app

Open the `main.jsx` and replace the code with the following so the **Pizza** component is included.

:::code language="javascript" source="../code/with-components-and-static-data/main.jsx":::

## Test the app

1. Start the app by calling `npm run dev`:

   ```bash
   npm run dev
   ```

1. When you see the notification to **Open in browser**, select that.

    :::image type="content" source="../media/form-without-design-system.png" alt-text="Screenshoot of Pizza form without styled components.":::

