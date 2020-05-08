In this exercise, we'll add our C# logic to our compound interest razor component. Open the folder for the compound interest project you created in the previous exercise.

## Add code markup to a razor page

1. Open **CompoundInterest.razor**

1. Below the table definition, add an `code` markup with open and closing braces `@code { }`

## Add member variables for compound interest calculation

We'll add several C# variables to store input values from the user. Add the following within the `@code` markup

    ```cshtml
    @code
    {
        private double Principal {get; set; } = 5000;
        private double InterestRate {get; set; } = 5;
        private int Years {get; set; } = 10;
        private double total {get; set; } = 0;
        private string Total {get; set; }
    }
    ```

## Add calculation logic 

Within the `@code` markup, add the following method to calculate compound interest:

    ```cshtml
    private void Calculate()
    {
        var total = Principal * Math.Pow(1 + InterestRate / (1200.0), Years * 12);
        Total = total.ToString("C");
    }
    ```

## Add binding to the input fields

We're now ready to bind the variables we defined in the `@code` markup to our HTML input fields. Use the `@bind` markup on each input field using the appropriate variable.

    ```cshtml
    <tr>
        <th>Initial Principal</th>
        <th><input @bind="Principal" /></th>
    </tr>
    <tr>
        <th>Years</th>
        <th><input @bind="Years" /></th>
    </tr>
    <tr>
        <th>Annual Interest Rate (%)</th>
        <th><input @bind="InterestRate" /></th>
    </tr>
    <tr>
        <th>Total:</th>
        <th>@Total</th>
    </tr>
    ```

Finally, we bind the Calculate button using the `@onclick` event handler.

    ```cshtml
    <button class="btn btn-primary" @onclick="Calculate">Calculate</button>
    ```

## Run the application 

1. In the Visual Studio Code terminal, execute `dotnet run` to launch the app

1. Open a web browser to **http://localhost:5000**  

1. Use the calculator - try changing the input parameters and press the calculate button.

Congratulations, you successfully created a razor component with HTML, C# logic, binding and an event.

    ![Image showing Blazor application running the browser](../media/calculator-app.png)