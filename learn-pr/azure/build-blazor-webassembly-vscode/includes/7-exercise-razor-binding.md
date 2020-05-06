In this exercise, we'll add our C# logic to the razor page. Open folder for your compound interest project you created in the previous exercise.

## Add code markup to a razor page

1. Open **CompoundInterest.razor**

1. Below the table add a **@code** markup with open and closing braces

    ```csharp
    @code 
    {

    }
    ```

## Add member variables for compound interest calculation

We'll add several variables which will be used to gather input from the user. Add the following within the @code markup
    ```csharp
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

Within the @code markup, add the following method to calculate compound interest:

    ```csharp
    private void Calculate()
    {
        var total = Principal * Math.Pow(1 + InterestRate / (1200.0), Years * 12);
        Total = total.ToString("C");
    }```

##

    ```csharp
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

    <button class="btn btn-primary" @onclick="Calculate">Calculate</button>
    ```
