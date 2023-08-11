In this exercise, you build the front-end app. You start with a scaffold, and then you build out the components you need to add data to the app.

## Scaffold an app

To scaffold an app, you use the `Vite` scaffolder. By using `npx`, you can call the scaffolder and have it create a working React app in a matter of seconds.

1. In a command terminal (with all the prerequisites installed), create the app by using `npx create vite@latest pizza-web --template react`:

    ```bash
    npm create vite@latest PizzaClient --template react
    cd PizzaClient
    ```

    Answer the CLI prompts as follows:

    * **Package name**: `PizzaClient`
    * **Select a framework**: `React`
    * **Select a variant**: `Javascript`

    What you get is a directory, _PizzaClient_, that contains your scaffolded React app. While the code and project are TypeScript, there's little TypeScript used in the project. 

1. Update the `vite.config.js` to provide a consistent front end port. Replace the contents of `./vite.config.js` with the following code:

    :::code language="javascript" source="../code/vite.config.js" highlight="8-11":::

    * **PORT**: The port is set to 3000, a common port number used for front end apps..

1. Start the app by calling `npm run dev`:

   ```bash
   npm run dev
   ```

1. In your browser, go to `http://localhost:3000`.

   You should see the page render like this example:

   :::image type="content" source="../media/vite-orginal.png" alt-text="Screenshot that shows a rendered SPA app.":::

   Press **Ctrl+C** to end execution.

## Build the Pizza component

Build the parent component that manages state for the pizza list.

1. Open the app directory in Visual Studio Code.

   ```bash
   code .
   ```

1. Create a file in the _src_ subdirectory named  _Pizza.jsx_ and give it the following content:

    :::code language="javascript" source="../code/with-components-and-static-data/Pizza.jsx":::

    This component is responsible for managing the data and passing it to the `PizzaList` component. It also handles the `create`, `update`, and `delete` operations. This component has no visible UI. The `PizzaList` component renders the UI.

    The `Pizza` component uses the `useState` and `useEffect` hooks to create data state. The `useState` hook is used to manage the `data` and `maxId`. The `useEffect` hook is used to set the data on the initial page request. The `Pizza` component passes the `data` to the `PizzaList` component.

## Build a Pizza list component

Create a file in the _src_ subdirectory named  _PizzaList.jsx_ and give it the following content:

:::code language="javascript" source="../code/with-components-and-static-data/PizzaList.jsx" :::

This is a React component called `PizzaList` that renders a form to create and edit pizza items. The component receives props and uses the useState and useEffect hooks to manage the form data and the editing state:

* The `handleFormChange` function updates the form data when the user types in the input fields. 
* The `handleSubmit` function creates or updates a pizza item depending on whether the editingId state is null or not. 
* The `handleEdit` function sets the editingId state to the ID of the item being edited. 
* The `handleCancelEdit` function resets the form data and the editingId state. 
* The `handleDelete` function deletes a pizza item by calling the `onDelete` prop with the item ID.

The PizzaList component renders a form with two input fields for the pizza `name` and `description`, and two buttons for creating or updating a pizza item. 

* Edit mode: If the `editingId` state isn't null, the form is in edit mode, and the button label is "Update". 
* Otherwise, the form is in create mode and the button label is "Create". 

## Add Pizza to your app

Open the `main.jsx` and replace the code with the following so the **Pizza** component is included.

:::code language="javascript" source="../code/with-components-and-static-data/main.jsx":::

## Test the app

1. Open a browser and navigate to `http://localhost:3000`.

    :::image type="content" source="../media/form-without-design-system.png" alt-text="Screenshoot of Pizza form without styled components.":::

    The form works to add, update, or delete a pizza but isn't styled. In the next section, learn how to make the form more engaging. 