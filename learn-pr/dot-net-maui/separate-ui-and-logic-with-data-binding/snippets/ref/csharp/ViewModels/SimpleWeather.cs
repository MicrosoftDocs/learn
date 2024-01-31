using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace WeatherClient.ViewModels
{
    public class SimpleWeatherServiceObject : CommunityToolkit.Mvvm.ComponentModel.ObservableObject
    {
        public int Humidity { get; set; } = 22;
        public string Location { get; set; }
        public void Refresh() { }

        public ICommand RefreshWeather { get; set; }

        public SimpleWeatherServiceObject()
        {
            RefreshWeather = new RelayCommand(() => {
                Humidity = 44;
                base.OnPropertyChanged(nameof(Humidity));
            });
        }
    }
}
