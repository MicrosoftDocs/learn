Use the Fluent UI design system to improve the appearance of your app.

## Install Material UI

To install Material UI, run the following command:

```bash
npm install @mui/material @emotion/react @emotion/styled @mui/icons-material
```

## Import Material UI

To import Material UI to your React app, replace `main.tsx` with the following code:

:::code language="javascript" source="../code/with-components-with-style/main.jsx":::

The code imports the ThemeProvider and createTheme components from Material UI and creates a default theme using the createTheme function. The ThemeProvider component is then used to wrap the Pizza component and apply the default theme to the app. Additionally, the CssBaseline component is imported and used to apply a baseline CSS to the app.

## Pizza component

Because the `pizza.tsx` file controls state but doesn't control rendering the pizza list, you don't need to add styles to this page.

## PizzaList component

Material UI provides a lot of functionality. For this unit, change the Pizza List to be more engaging with styles and icons. Open `PizzaList.jsx` and replace the code with the following code. Notice that only the `return ()` section is changed.

:::code language="javascript" source="../code/with-components-with-style/PizzaList.jsx" highlight="61-88":::

In the `PizzaList` component, the Material UI components TextField, Button, Box, List, ListItem, ListItemText, ListItemSecondaryAction, and IconButton are imported and used to create a list of pizza items. 

* The **Box** component is used to wrap the form elements and add spacing between them. 
* The **List** component is used to display the list of pizza items. 
* The **ListItem** component is used to display each pizza item in the list. 
* The **ListItemText** component is used to display the name and description of each pizza item. 
* The **ListItemSecondaryAction** component is used to display the edit and delete buttons for each pizza item. 
* The **IconButton** component is used to create the edit and delete buttons. 
* The **TextField** component is used to create the input fields for the name and description of each pizza item. 
* The **Button** component is used to create the create, update, and cancel buttons.

## Run the app

1. If you stopped your app in the previous unit, run the following command to start the app:

    ```bash
    npm run dev
    ```

1. Open a browser and navigate to `http://localhost:3000`.

    :::image type="content" source="./media/design-system-form.png" alt-text="Screenshoot of Pizza form with styled components.":::
    