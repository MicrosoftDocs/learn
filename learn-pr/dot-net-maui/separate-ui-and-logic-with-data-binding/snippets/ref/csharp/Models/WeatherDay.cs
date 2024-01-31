using System;
namespace WeatherClient.Models;

public readonly record struct WeatherDay(string DayName, WeatherData Forecast)
{
    public override string ToString() =>
        DayName;
}
