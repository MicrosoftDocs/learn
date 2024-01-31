using System.Globalization;
using WeatherClient.Models;

namespace WeatherClient.Converters;

internal class WeatherConditionToImageConverter : IValueConverter
{
    public bool IsActive { get; set; }

    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        WeatherType weatherCondition = (WeatherType)value!;

        return weatherCondition switch
        {
            Models.WeatherType.Sunny => ImageSource.FromFile("sunny.png"),
            Models.WeatherType.Cloudy => ImageSource.FromFile("cloud.png"),
            _ => ImageSource.FromFile("question.png")
        };
    }

    public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture) =>
        throw new NotImplementedException();
}
