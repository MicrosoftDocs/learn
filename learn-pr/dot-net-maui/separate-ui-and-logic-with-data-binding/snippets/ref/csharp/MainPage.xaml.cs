namespace WeatherClient
{
    public partial class MainPage : ContentPage
    {
        int count = 0;

        public MainPage()
        {
            InitializeComponent();
        }


        private async void BtnDatabound_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.MainPageDataBound));
        }

        private async void BtnEventDriven_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.MainPageEventDriven));
        }

        private async void BtnSimpleEventDriven_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.SimpleEventDriven));
        }

        private async void BtnSimpleDatabound_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.SimpleDataBound));
        }

        private async void BtnExampleBindRes_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.ExampleBindingResource));
        }

        private async void BtnExampleBindControls_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.ExampleBindingControls));
        }

        private async void BtnExampleFiveDayForecast_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.ExampleMultidayForecast));
        }

        private async void BtnExampleBindingString_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.ExampleBindingString));
        }

        private async void BtnExampleBindingColorConvert_Clicked(object sender, EventArgs e)
        {
            await Shell.Current.GoToAsync(nameof(Views.ExampleBindingColor));

        }
    }

}
