namespace WeatherClient.Views;

public partial class ExampleBindingString : ContentPage
{
    public ExampleBindingString()
    {
        InitializeComponent();

        BindingContext = new Bills { BillAmount = 22.0304M };
    }


    private class Bills
    {
        public decimal BillAmount { get; set; }

    }
}