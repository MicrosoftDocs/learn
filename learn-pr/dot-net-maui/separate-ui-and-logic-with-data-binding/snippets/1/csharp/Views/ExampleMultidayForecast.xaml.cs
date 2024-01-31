using WeatherClient.Models;

namespace WeatherClient.Views;

public partial class ExampleMultidayForecast : ContentPage
{
	public ExampleMultidayForecast()
	{
		InitializeComponent();
	}

    private void ContentPage_Loaded(object sender, EventArgs e)
    {
		BindingContext = new[] {
			new WeatherDay("Monday", new WeatherData()
										{
											Condition = WeatherType.Cloudy,
											Humidity = 23,
											Precipitation = 2,
											Temperature = 75,
											Wind = 0
										}),
            new WeatherDay("Tuesday", new WeatherData()
                                        {
                                            Condition = WeatherType.Cloudy,
                                            Humidity = 23,
                                            Precipitation = 2,
                                            Temperature = 75,
                                            Wind = 0
                                        }),
            new WeatherDay("Wednesday", new WeatherData()
                                        {
                                            Condition = WeatherType.Cloudy,
                                            Humidity = 23,
                                            Precipitation = 2,
                                            Temperature = 75,
                                            Wind = 0
                                        }),
            new WeatherDay("Thursday", new WeatherData()
                                        {
                                            Condition = WeatherType.Cloudy,
                                            Humidity = 23,
                                            Precipitation = 2,
                                            Temperature = 75,
                                            Wind = 0
                                        }),
            new WeatherDay("Friday", new WeatherData()
                                        {
                                            Condition = WeatherType.Cloudy,
                                            Humidity = 23,
                                            Precipitation = 2,
                                            Temperature = 75,
                                            Wind = 0
                                        }),

        };
    }
}