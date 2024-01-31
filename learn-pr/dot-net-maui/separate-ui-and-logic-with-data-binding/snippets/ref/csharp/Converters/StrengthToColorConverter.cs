using System.Globalization;
using WeatherClient.Models;

namespace WeatherClient.Converters;

class StrengthToColorConverter : IValueConverter
{
    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        return (Strength)value! switch
        {
            Strength.Weak => Colors.OrangeRed,
            Strength.Good => Colors.Yellow,
            Strength.Strong => Colors.LightBlue,
            _ => Colors.LightBlue
        };
    }

    public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture) =>
        throw new NotImplementedException();
}
