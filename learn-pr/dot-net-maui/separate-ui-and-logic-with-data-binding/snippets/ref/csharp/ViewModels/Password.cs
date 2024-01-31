using CommunityToolkit.Mvvm.ComponentModel;
using WeatherClient.Models;

namespace WeatherClient.ViewModels;

public class PasswordObject : ObservableObject
{
    private Strength _strength;
    private string _password = "";
    public string Password
    {
        get => _password;
        set
        {
            _password = value;
            SetStrength();
        }
    }
    public Strength PasswordStrength => _strength;

    public void SetStrength()
    {
        if (_password == null)
        {
            SetProperty(ref _strength, Strength.Weak, nameof(PasswordStrength));
            return;
        }

        Strength newStrength = Password.Length switch
        {
            < 5 => Strength.Weak,
            < 10 => Strength.Good,
            _ => Strength.Strong
        };

        SetProperty(ref _strength, newStrength, nameof(PasswordStrength));
    }
}
