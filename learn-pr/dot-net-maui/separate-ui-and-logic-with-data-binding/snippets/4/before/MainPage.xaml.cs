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

            Models.WeatherData weatherData = await Services.WeatherServer.GetWeather(txtPostalCode.Text);

            lblWind.Text = weatherData.Wind.ToString();
            lblHumidity.Text = weatherData.Humidity.ToString();
            lblPrecipitation.Text = weatherData.Precipitation.ToString();

            lblTemperature.Text = swiCelsius.IsToggled ?
                                        UnitConverters.FahrenheitToCelsius(weatherData.Temperature).ToString("#") :
                                        weatherData.Temperature.ToString("#");

            imgCondition.Source = weatherData.Condition switch
            {
                Models.WeatherType.Sunny => ImageSource.FromFile("sunny.png"),
                Models.WeatherType.Cloudy => ImageSource.FromFile("cloud.png"),
                _ => ImageSource.FromFile("question.png")
            };

            btnRefresh.IsEnabled = true;
            actIsBusy.IsRunning = false;
        }
    }

}
