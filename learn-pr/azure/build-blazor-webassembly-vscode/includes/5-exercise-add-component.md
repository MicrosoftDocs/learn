In this exercise, we'll add a new Razor page and create the compound interest calculator UI. Open folder for your compound interest project you created in the previous exercise.

## Open the Compound Interest project in VS Code

1. Open VS Code

1. Open the folder containing your compound interest project within VS Code

1. VS Code may prompt you to install required assets, if so, select yes

![Image showing VS Code prompting to install required assets to build and debug](../media/missing-assets-vscode.png)

## Create a new Razor page for your calculator

1. Expand the folders in the VS Code project explorer

1. Click on **> Pages** to view the existing razor pages 

1. Right-click on **Pages** and select **New File**

1. Name the new page **Calc.razor**

## Add the CompoundInterest page to the app navigation

1. Open **calc.razor**

1. Add the @page directive `@page "/compoundinterest"`

1. Add a simple H1 header `<h1>Compound Interest</h1>`

1. Open the **Shared** folder in the project explorer

1. Open **NavMenu.razor**

1. Add a forth list item with the href set to **calc** and a title off **Compound Interest**

    ```cshtml
    <li class="nav-item px-3">
        <NavLink class="nav-link" href="calc">
            <span class="oi oi-plus" aria-hidden="true"></span> Compound Interest
        </NavLink>
    </li>
    ```

### Optional - run the application 

1. In the VS Code terminal `dotnet run`

1. Open a web browser to http://localhost:5000  

![Image showing Blazor application running the browser](../media/create-new-component.png)

## Add Hmtl UI 
We'll add html UI for our calculator, specifically a table.  

1. Add a 2x4 html table. 

1. Add text in the left column for: **Initial Principal**, **Years**, **Annual Interest Rate** and **Total:**. We'll populate the right column later.

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
1. Below the table, add a button which we'll use to trigger the calculation.

    ```cshtml
    <button class="btn btn-primary">Calculate</button>
    ```

### Optional - run the application 

1. In the VS Code terminal `dotnet run`

1. Open a web browser to http://localhost:5000  
