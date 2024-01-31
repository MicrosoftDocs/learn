
namespace WeatherClient
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new AppShell();

            Routing.RegisterRoute(nameof(WeatherClient.MainPage), typeof(WeatherClient.MainPage));
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            Window window = base.CreateWindow(activationState);
#if WINDOWS
            window.Width = 500;
            window.Height = 450;
#endif
            return window;
        }
    }
}
