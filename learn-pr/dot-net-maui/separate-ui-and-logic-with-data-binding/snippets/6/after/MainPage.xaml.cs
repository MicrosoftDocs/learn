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
            object temp = BindingContext;
            BindingContext = null;
            BindingContext = temp;
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
