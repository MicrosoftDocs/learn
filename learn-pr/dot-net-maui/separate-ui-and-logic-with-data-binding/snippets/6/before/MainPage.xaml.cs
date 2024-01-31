namespace WeatherClient
{
    public partial class MainPage : ContentPage
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private void swiCelsius_Toggled(object sender, ToggledEventArgs e)
        {
            if (double.TryParse(lblTemperature.Text, out double temperature))
            {
                lblTemperature.Text = e.Value ?
                                        UnitConverters.FahrenheitToCelsius(temperature).ToString("#") :
                                        UnitConverters.CelsiusToFahrenheit(temperature).ToString("#");
            }
        }

        private async void btnRefresh_Clicked(object sender, EventArgs e)
        {
            btnRefresh.IsEnabled = false;
            actIsBusy.IsRunning = true;

            BindingContext = await Services.WeatherServer.GetWeather(txtPostalCode.Text);

            btnRefresh.IsEnabled = true;
            actIsBusy.IsRunning = false;
        }
    }
}
