
namespace WeatherClient
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new AppShell();

            Routing.RegisterRoute(nameof(WeatherClient.MainPage), typeof(WeatherClient.MainPage));
            Routing.RegisterRoute(nameof(Views.MainPageDataBound), typeof(Views.MainPageDataBound));
            Routing.RegisterRoute(nameof(Views.MainPageEventDriven), typeof(Views.MainPageEventDriven));
            Routing.RegisterRoute(nameof(Views.SimpleDataBound), typeof(Views.SimpleDataBound));
            Routing.RegisterRoute(nameof(Views.SimpleEventDriven), typeof(Views.SimpleEventDriven));
            Routing.RegisterRoute(nameof(Views.ExampleBindingResource), typeof(Views.ExampleBindingResource));
            Routing.RegisterRoute(nameof(Views.ExampleBindingControls), typeof(Views.ExampleBindingControls));
            Routing.RegisterRoute(nameof(Views.ExampleMultidayForecast), typeof(Views.ExampleMultidayForecast));
            Routing.RegisterRoute(nameof(Views.ExampleBindingString), typeof(Views.ExampleBindingString));
            Routing.RegisterRoute(nameof(Views.ExampleBindingColor), typeof(Views.ExampleBindingColor));
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            Window window = base.CreateWindow(activationState);
            window.Width = 500;
            window.Height = 450;
            return window;
        }
    }
}
