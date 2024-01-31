using System.Globalization;

namespace WeatherClient.Converters;

internal class FahrenheitToCelsiusConverter : IValueConverter
{
    public bool IsActive { get; set; }

    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        if (IsActive)
        {
            double temperature = System.Convert.ToDouble((int)value!);
            return $"{UnitConverters.FahrenheitToCelsius(temperature):#} C";
        }
        else
            return $"{(int)value!:#} F";
    }

    public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        if (IsActive)
            return UnitConverters.CelsiusToFahrenheit((double)value!);
        else
            return (double)value!;
    }
}
