namespace WeatherClient.Views;

public partial class SimpleEventDriven : ContentPage
{
	public SimpleEventDriven()
	{
		InitializeComponent();
	}

    private void RefreshWeatherButton_Clicked(object sender, EventArgs e)
    {
        WeatherService.Location = PostalCode.Text;
        WeatherService.Refresh();
        Humidity.Text = $"Humidity: {WeatherService.Humidity}";
    }

    static class WeatherService
    {
        public static int Humidity { get; set; } = 22;
        public static string Location { get; set; }
        public static void Refresh() { }

    }
}