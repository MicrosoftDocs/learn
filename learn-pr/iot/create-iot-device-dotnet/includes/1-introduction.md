.NET runs on a variety of platforms and architectures. Common Internet of things (IoT) boards, such as Raspberry Pi and Hummingboard, are supported. These small, low-power platforms enable interaction with specialized hardware, such as sensors, analog-to-digital converters, and LCD devices.

With the .NET IoT Libraries, you can build devices that perform tasks such as:

- Reading environmental conditions.
- Accepting input from physical buttons and dials.
- Controlling electrical activity in other devices with relays.

In this module, you'll learn about the .NET IoT Libraries by implementing a device to monitor environmental conditions and control a relay.

## Learning objectives

In this module you will:

- Construct circuits to implement:
  - An environmental sensor.
  - A switched circuit to control LEDs or relay modules.
- Write code to read temperature and humidity from a sensor.
- Write code to use GPIO pins to activate an LED or relay module.
- Deploy and test the code.

## Prerequisites

- Basic understanding of ASP.NET Core Web API.
- Basic understanding of Raspberry Pi.
- .NET SDK 5 or greater.
- The following hardware components:
  - A Raspberry Pi device (2 or greater) configured as described in the *Important* callout below.
  - BME280 humidity/barometric pressure/temperature sensor breakout ([example](https://learn.adafruit.com/adafruit-bme280-humidity-barometric-pressure-temperature-sensor-breakout))
  - 5 mm LED ([example](https://www.adafruit.com/product/4203))
  - 1.0K Ω resistor ([example](https://www.adafruit.com/product/4294))
  - Jumper wires ([example](https://www.adafruit.com/product/758))
  - Full-sized breadboard ([example](https://www.adafruit.com/product/239))
  - Raspberry Pi GPIO breakout board ([example](https://www.adafruit.com/product/2028))

All of the required hardware components are available from a variety of retailers. Most of the components can be found bundled in convenient kits.

> [!IMPORTANT]
> The .NET IoT Libraries support a wide range of hardware platforms. Raspberry Pi was selected for this module due to its wide availability and affordable price point.
>
> Ensure your device has the latest version of [Raspberry Pi OS](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) installed. Since we won't be using the Raspberry Pi desktop, it isn't necessary to do the full install. If you prefer the "Lite" image, it's found under **Raspberry Pi OS (Other*)* in the Raspberry Pi OS Installer.
>
> After installing Raspberry Pi OS, use the `raspi-config` command to ensure the following two services are enabled:
>
> - SSH
> - I2C
>
> For more information on `raspi-config`, refer to the [Raspberry Pi documentation](https://www.raspberrypi.org/documentation/configuration/raspi-config.md).

## Learn the scenario

Suppose you manage a gourmet cheese making company in a southern location. The company is proud of its cheese, and is careful to maintain the perfect temperature and humidity of a natural cave that is used to age the cheese.

  [![Close up photograph of matured cheese.](../media/cheese-rect8.png)](../media/cheese-rect8.png#lightbox)

Your company's accepted ideal temperature for aging cheese is 50°F (10°C), with up to ±5°F (2.78°C) acceptable variance. Humidity is also important. A humidity level between 75-95% is acceptable.

You've decided to build the device using a Raspberry Pi to monitor the environmental conditions in the cave. The device will also activate the fan to control humidity as needed. To leverage your existing development skills, you decide to use .NET.

  [![Photograph of matured blue cheese.](../media/cheese-circle1.png)](../media/cheese-circle1.png#lightbox)

## The first step

The first step to building your device is constructing the circuit.
