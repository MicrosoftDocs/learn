using CommunityToolkit.Mvvm.Input;
using System.ComponentModel;
using System.Windows.Input;
using WeatherClient.Models;

namespace WeatherClient.ViewModels;

internal class Weather : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler? PropertyChanged;

    private string _postalCode;
    private int _wind;
    private int _humidity;
    private int _precipitation;
    private int _temperature;
    private bool _isBusy;
    private ImageSource _icon;
    private ICommand _refreshCommand;
    private bool _isCelsius;

    public ImageSource Icon
    {
        get => _icon;
        set
        {
            if (_icon != value)
            {
                _icon = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Icon)));
            }
        }
    }

    public int Wind
    {
        get => _wind;
        set
        {
            if (_wind != value)
            {
                _wind = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Wind)));  
            }
        }
    }

    public int Humidity
    {
        get => _humidity;
        set
        {
            if (_humidity != value)
            {
                _humidity = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Humidity)));
            }
        }
    }

    public int Precipitation
    {
        get => _precipitation;
        set
        {
            if (_precipitation != value)
            {
                _precipitation = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Precipitation)));
            }
        }
    }

    public int Temperature
    {
        get => _temperature;
        set
        {
            if (_temperature != value)
            {
                _temperature = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Temperature)));
            }
        }
    }

    public bool IsBusy
    {
        get => _isBusy;
        set
        {
            if (_isBusy != value)
            {
                _isBusy = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(IsBusy)));
            }
        }
    }

    public string PostalCode
    {
        get => _postalCode;
        set
        {
            if (_postalCode != value)
            {
                _postalCode = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(PostalCode)));
            }
        }
    }

    public bool IsCelsius
    {
        get => _isCelsius;
        set
        {
            if (_isCelsius != value)
            {
                _isCelsius = value;
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(IsCelsius)));

                // Temp is currently Fahrenheit, convert to Celsius
                if (value)
                    Temperature = (int)UnitConverters.FahrenheitToCelsius(Temperature);

                // Temp is currently Celsius, convert to Fahrenheit
                else
                    Temperature = (int)UnitConverters.CelsiusToFahrenheit(Temperature);
            }
        }
    }

    public ICommand RefreshCommand => _refreshCommand;

    public Weather()
    {
        _refreshCommand = new AsyncRelayCommand(RefreshWeather);
        _icon = ImageSource.FromFile("question.png");
    }

    public async Task RefreshWeather()
    {
        IsBusy = true;

        Models.WeatherData weatherData = await Services.WeatherServer.GetWeather(PostalCode);

        Wind = weatherData.Wind;
        Humidity = weatherData.Humidity;
        Precipitation = weatherData.Precipitation;

        Temperature = IsCelsius ? (int)UnitConverters.FahrenheitToCelsius(weatherData.Temperature) : (int)weatherData.Temperature;

        Icon = weatherData.Condition switch
        {
            Models.WeatherType.Sunny => ImageSource.FromFile("sunny.png"),
            Models.WeatherType.Cloudy => ImageSource.FromFile("cloud.png"),
            _ => ImageSource.FromFile("question.png")
        };

        IsBusy = false;
    }
}
