You've built a prototype device to monitor and control environmental conditions in the cave. In this unit, you'll use the .NET IoT Libraries to write code that interacts with the hardware.

Even though the .NET SDK is supported on Raspberry Pi and other ARM-based boards, the best experience for developing .NET apps for IoT devices is found on a development workstation or laptop. Using a computer for development enables you to use full-featured IDEs like Visual Studio and Visual Studio Code.

## Create the app

Complete the following steps from a command shell on your development machine.

1. Create a new console app named *cheesecave.net*.

    ```dotnetcli
    dotnet new console -o cheesecave.net
    cd ./cheesecave.net
    ```

    The preceding commands:
    - Create a new .NET console app in a folder named *cheesecave.net*.
    - Set the current location to the *cheesecave.net* folder.

1. Add the .NET IoT Libraries to the project.

    ```dotnetcli
    dotnet add package System.Device.Gpio --version 1.5.0
    dotnet add package IoT.Device.Bindings --version 1.5.0
    ```

    The preceding commands:
    - Add the `System.Device.Gpio` and `Iot.Device.Bindings` packages to the project.
    - Specifies version `1.5.0` is added for both packages.

1. Using your preferred IDE or editor, replace the contents of *Program.cs* with the following code:

    ```csharp
    using System;
    using System.Device.Gpio;
    using System.Device.Gpio.Drivers;
    using System.Device.I2c;
    using Iot.Device.Bmxx80;
    using Iot.Device.Bmxx80.ReadResult;
    
    bool _fanOn = false;
    bool _exit = false;
    int _pin = 21;
    
    // Initialize the GPIO controller
    using GpioController gpio = new GpioController(PinNumberingScheme.Logical, new RaspberryPi3Driver());
    
    // Open the GPIO pin for output
    gpio.OpenPin(_pin, PinMode.Output);
    gpio.Write(_pin, PinValue.Low);
    
    // Get a reference to a device on the I2C bus
    var i2cSettings = new I2cConnectionSettings(1, Bme280.DefaultI2cAddress);
    using I2cDevice i2cDevice = I2cDevice.Create(i2cSettings);
    
    // Create a reference to the BME280
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
        // Read the BME280
        Bme280ReadResult output = bme280.Read();
        double temperatureF = output.Temperature.Value.DegreesFahrenheit;
        double humidityPercent = output.Humidity.Value.Percent;
    
        // Print statuses
        Console.WriteLine();
        Console.WriteLine("DEVICE STATUS");
        Console.WriteLine("-------------");
        Console.WriteLine($"Fan: {(_fanOn ? "ON" : "OFF")}");
        Console.WriteLine($"Temperature: {temperatureF:0.#}°F");
        Console.WriteLine($"Relative humidity: {humidityPercent:#.##}%");
        Console.WriteLine();
        Console.WriteLine("Enter command (status/fan/exit):");
    }
    ```

    In the preceding code:
    - **TODO** EXPLAIN THE CODE

1. Build the app.

    ```dotnetcli
    dotnet build
    ```

    The build completes with no issues.
