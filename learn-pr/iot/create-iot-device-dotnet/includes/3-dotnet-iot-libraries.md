In the previous unit, you used common hardware components to construct a prototype device for measuring and maintaining environmental conditions in a cave. In this unit, you'll learn about the .NET IoT Libraries, which enable interaction with your device.

## Libraries

The .NET IoT Libraries are composed of two NuGet packages:

- System.Device.Gpio
- Iot.Device.Bindings

### System.Device.Gpio

`System.Device.Gpio` supports a variety of protocols for interacting with low-level hardware pins to control devices. These include:

- General-purpose I/O (GPIO)
- Inter-Integrated Circuit (I2C)
- Serial Peripheral Interface (SPI)
- Pulse Width Modulation (PWM)
- Serial port

### Iot.Device.Bindings

The `Iot.Device.Bindings` package:

- Contains [device bindings](https://github.com/dotnet/iot/blob/main/src/devices/README.md) to streamline app development by wrapping System.Device.Gpio.
- Is community-supported, and additional bindings are added continually.

Commonly used device bindings include:

- [CharacterLcd - LCD character display](https://github.com/dotnet/iot/tree/main/src/devices/CharacterLcd)
- [SN74HC595 - 8-bit shift register](https://github.com/dotnet/iot/tree/main/src/devices/Sn74hc595)
- [BrickPi3](https://github.com/dotnet/iot/tree/main/src/devices/BrickPi3)
- [Max7219 - LED Matrix driver](https://github.com/dotnet/iot/tree/main/src/devices/Max7219)
- [RGBLedMatrix - RGB LED Matrix](https://github.com/dotnet/iot/tree/main/src/devices/RGBLedMatrix)

## Supported operating systems

`System.Device.Gpio` is supported on most versions of Linux that support ARM/ARM64 and Windows 10 IoT Core.

> [!TIP]
> For Raspberry Pi, [Raspberry Pi OS](https://www.raspberrypi.org/documentation/installation/installing-images/README.md)  (formerly Raspbian) is recommended.

## Supported hardware platforms

`System.Device.Gpio` is compatible with most single-board platforms. Recommended platforms are Raspberry Pi (2 and greater) and Hummingboard. Other platforms known to be compatible are BeagleBoard and ODROID.

PC platforms are supported via the use of a USB to SPI/I2C bridge.

> [!IMPORTANT]
> .NET is not supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi devices prior to Raspberry Pi 2.