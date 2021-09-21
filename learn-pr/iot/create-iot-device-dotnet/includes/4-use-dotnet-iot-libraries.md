We have the codez!!!111!!!!!

## CODEZ!!!1111!!!11!

```csharp
using System;
using System.Device.Gpio;
using System.Device.Gpio.Drivers;
using System.Device.I2c;
using Iot.Device.Bmxx80;

bool _fanOn = false;
bool _exit = false;
int _pin = 21;

// Initialize the GPIO controller
using GpioController gpio = new GpioController(PinNumberingScheme.Logical, new RaspberryPi3Driver());

// Open the GPIO pin for output
gpio.OpenPin(_pin, PinMode.Output);
gpio.Write(_pin, PinValue.Low);

// Get a reference to the I2C bus
var i2cSettings = new I2cConnectionSettings(1, Bme280.DefaultI2cAddress);
using I2cDevice i2cDevice = I2cDevice.Create(i2cSettings);

// Get a reference to the BME280 on the I2C bus
using var bme280 = new Bme280(i2cDevice);

// Write the fan, temperature, and humidity statuses to the console
WriteStatus();

// Main control loop
while (!_exit)
{
    string commandText = Console.ReadLine();
    DoCommand(commandText);
}

// Close the pin before exit
gpio.ClosePin(_pin);

// Exit
return;

void DoCommand(string commandText)
{
    switch (commandText)
    {
        case "exit":
            Console.WriteLine("Exiting!");
            _exit = true;
            break;
        
        case "fan":
            if (!_fanOn)
            {
                // Turn on the fan
                gpio.Write(_pin, PinValue.High);
                Console.WriteLine("Turned fan on!");
            }
            else 
            {
                // Turn off the fan
                gpio.Write(_pin, PinValue.Low);
                Console.WriteLine("Turned fan off!");
            }
            _fanOn = !_fanOn;
            WriteStatus();
            break;

        case "status":
            WriteStatus();
            break;

        default:
            Console.WriteLine("Command not recognized! Try again.");
            return;
    }
}

void WriteStatus()
{
    // Get temperature
    bme280.TryReadTemperature(out var tempValue);

    // Get humidity
    bme280.TryReadHumidity(out var humValue);

    Console.WriteLine();
    Console.WriteLine("DEVICE STATUS");
    Console.WriteLine("-------------");
    Console.WriteLine($"Fan: {(_fanOn ? "ON" : "OFF")}");
    Console.WriteLine($"Temperature: {tempValue.DegreesFahrenheit:0.#}\u00B0F");
    Console.WriteLine($"Relative humidity: {humValue.Percent:#.##}%");
    Console.WriteLine();
    Console.WriteLine("Enter command (status/fan/exit):");
}
```
