In this unit, you'll use the .NET IoT Libraries to write code that interacts with your cave-monitor device. Although the .NET SDK is supported on Raspberry Pi and other IoT boards, we recommend using a computer. Using a computer lets you use fully featured IDEs and editors like Visual Studio and Visual Studio Code.

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
    dotnet add package System.Device.Gpio --version 2.1.0
    dotnet add package IoT.Device.Bindings --version 2.1.0
    ```

    The preceding commands:

    - Add the `System.Device.Gpio` and `Iot.Device.Bindings` packages to the project.
    - Specifies version `2.1.0` is added for both packages.

## Add code

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
    using GpioController gpio = new GpioController();

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
        string commandText = Console.ReadLine() ?? string.Empty;
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
        double temperatureF = output.Temperature?.DegreesFahrenheit ?? double.NaN;
        double humidityPercent = output.Humidity?.Percent ?? double.NaN;

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

1. Examine the code to understand how it interacts with the GPIO pin. In the preceding code:

    - An instance of `GpioController` is created for use in GPIO operations.
    - Pin 21 is opened with `gpio.OpenPin()`. The pin is opened for output with `PinMode.Output`.
    - The value of Pin 21 is set to `PinValue.Low`. This value represents the lowest amount of voltage the pin can emit. For purposes of illuminating the LED, `PinValue.Low` represents *off*, and `PinValue.High` represents *on*. As a result, the LED representing the fan is turned off.
    - The code toggles the fan/LED on and off by writing `PinValue.Low` and `PinValue.High`.
        > [!TIP]
        > Many real-world relays use `PinValue.High` for *off* and `PinValue.Low` for *on*. That's the opposite of what you're implementing for the LED that's representing the fan relay in this exercise.

    - Before the code exits, Pin 21 is closed with `gpio.ClosePin()`.

1. Examine the code to understand how it interacts with the BME280. In the preceding code:

    - An instance of `I2cConnectionSettings` is created. The first constructor parameter, `busId`, is set to `1`, the I2C bus ID on the Raspberry Pi. The second constructor parameter, `deviceAddress`, is set to `Bme280.DefaultI2cAddress`.
        > [!WARNING]
        > Some BME280 breakouts use `Bme280.SecondaryI2cAddress` for the device address. If your app throws `System.IO.IOException: Error 121 performing I2C data transfer.`, try this value instead.

    - An instance of `I2cDevice` is created using the `I2cConnectionSettings` object.
    - An instance of `Bme280` is created using the `I2cDevice` object. This object represents the physical BME280.
    - In the `WriteStatus()` method, a `Bme280ReadResult` object is created by calling `Bme280.Read()`.
    - The `Bme280ReadResult` object contains `Temperature` and `Humidity` properties.
        - The `Temperature` and `Humidity` properties are both nullable, which means they might contain `null`. Accordingly, the null-conditional operator `?.` is used to access their members.
        - The properties themselves expose properties that do automatic unit conversions, such as `DegreesFahrenheit` and `Percent`.
        - In both cases, the null-coalescing operator `??` checks the return value, and if it's `null`, replaces it with `double.NaN`.

    > [!TIP]
    > If you need help understanding null safety, see [Null safety in C#](/training/modules/csharp-null-safety/).

## Build the app

Run the following command to build the app.

```dotnetcli
dotnet build
```

The build completes with no errors or warnings.

In the next unit, you'll deploy your app to the Raspberry Pi and test it.
