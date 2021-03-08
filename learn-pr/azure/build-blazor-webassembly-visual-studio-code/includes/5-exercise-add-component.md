In this exercise, you'll add a new Razor page and create the UI for the compound interest calculator.

## Open the compound interest project in Visual Studio Code

1. Open Visual Studio Code.

1. Within Visual Studio Code, open the folder that contains your compound interest project.

1. If Visual Studio Code prompts you to install required assets, select **Yes**.

    ![Screenshot showing Visual Studio Code prompting to install assets required to build and debug](../media/missing-assets-visual-studio-code.png)

## Create a new Razor page for your calculator

1. Expand the folders in the Visual Studio Code project explorer.

1. Select **Pages** to view the existing Razor pages.

1. Select and hold (or right-click) **Pages**, and select **New File**.

1. Name the new page CompoundInterest.razor.

## Add the CompoundInterest page to the app navigation

Here, you'll set up the route for your new page and add a link to your side menu.

1. Open CompoundInterest.razor.

1. Add the **\@page** directive **\@page "/compoundinterest"**.

1. Add the H1 header **\<h1\>Compound Interest\</h1\>**.

1. Open the Shared folder in the project explorer.

1. Open NavMenu.razor.

1. Add a fourth list item with the `href` attribute set to `compoundinterest` and the title set to `Compound Interest`.

    ```cshtml
    <li class="nav-item px-3">
        <NavLink class="nav-link" href="compoundinterest">
            <span class="oi oi-plus" aria-hidden="true"></span> Compound Interest
        </NavLink>
    </li>
    ```

### Run the app (optional)

1. In the Visual Studio Code terminal, enter **dotnet run** to run the app.

1. In a web browser, go to https://localhost:5000.

    ![Screenshot showing the Blazor app running in a browser](../media/create-new-component.png)

## Add HTML UI

Add an HTML table to your calculator UI.

1. Add a 2 &times; 4 HTML table.

1. Add text in the leftmost column for `Initial Principal`, `Years`, `Annual Interest Rate`, and `Total`.

    ```cshtml
    <table class="table">
        <tr>
            <th>Initial Principal</th>
            <th></th>
        </tr>
        <tr>
            <th>Years</th>
            <th></th>
        </tr>
        <tr>
            <th>Annual Interest Rate (%)</th>
            <th></th>
        </tr>
        <tr>
            <th>Total:</th>
            <th></th>
        </tr>
    </table>
    ```

1. Below the table, add a button, which you'll use to trigger the calculation.

    ```cshtml
    <button class="btn btn-primary">Calculate</button>
    ```

### Run the app (optional)

1. In the Visual Studio Code terminal, enter **dotnet run** to run the app.

1. In a web browser, go to **https://localhost:5000**.
