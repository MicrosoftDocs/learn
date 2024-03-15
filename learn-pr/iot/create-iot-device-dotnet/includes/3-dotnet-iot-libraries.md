In this unit, you'll learn about the .NET IoT Libraries, which enable interaction with your device.

## Libraries

The .NET IoT Libraries are composed of two open-source NuGet packages:

- [System.Device.Gpio](https://www.nuget.org/packages/System.Device.Gpio/)
- [Iot.Device.Bindings](https://www.nuget.org/packages/Iot.Device.Bindings/)

### System.Device.Gpio

The `System.Device.Gpio` package implements various protocols for interacting with low-level hardware pins to control devices. These protocols include:

- General-purpose I/O (GPIO)
- Inter-Integrated Circuit (I<sup>2</sup>C)
- Serial Peripheral Interface (SPI)
- Pulse Width Modulation (PWM)
- Serial port

`System.Device.Gpio` doesn't provide any device-specific features; it just provides the foundations for communicating using the supported protocols. For example, the BME280 sensor we use in this module uses the I<sup>2</sup>C bus to communicate. `System.Device.Gpio` provides abstractions to interact via I<sup>2</sup>C, but it doesn't provide any functionality specific to the functions of the BME280. If you write code interacting with the BME280 using just `System.Device.Gpio`, your code needs to understand the BME280's functions. That includes how to serialize/deserialize messages to/from the sensor over the I<sup>2</sup>C bus.

### Iot.Device.Bindings

The `Iot.Device.Bindings` package contains device bindings to streamline app development by wrapping `System.Device.Gpio`. It contains classes representing a wide array of common IoT sensors and other devices. It's a community-driven, open-source project, and anybody can add new device support.

Using `Iot.Device.Bindings` allows the developer to work directly with device abstractions without worrying about low-level communication. Consider the example of the BME280 sensor. To communicate with the sensor, your app must send and receive messages in binary on the I<sup>2</sup>C bus. The classes in `Iot.Device.Bindings` provide abstractions using classes in `System.Device.Gpio` to handle the binary communication for you. This library allows you to focus on what you intend to do with the sensor, not on low-level communication.

## Supported operating systems

The .NET IoT Libraries run anywhere .NET is supported, including most versions of Linux that support ARM/ARM64 and Windows 10 IoT Core. Raspberry Pi OS is recommended for most Raspberry Pi projects.

## Supported hardware platforms

The .NET IoT Libraries are compatible with most single-board platforms. Recommended platforms are Raspberry Pi (2 and greater) and Hummingboard. Other platforms known to be compatible are BeagleBoard and ODROID.

PC platforms are supported via the use of a USB to SPI/I<sup>2</sup>C bridge.

> [!NOTE]
> .NET isn't supported on ARMv6 architecture devices, including Raspberry Pi Zero and Raspberry Pi devices prior to Raspberry Pi 2.

In the next unit, you'll use the .NET IoT Libraries to read the BME280 sensor and trigger the LED that represents your fan relay.
