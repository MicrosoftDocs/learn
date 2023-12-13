.NET runs on many different platforms and architectures. One of the most exciting places to run .NET is on IoT devices like Raspberry Pi. These devices enable new scenarios making use of sensors, analog-to-digital converters, and LCD devices.

With the .NET IoT Libraries, you can build devices for tasks such as:

- Reading environmental conditions.
- Accepting input from physical buttons and dials.
- Controlling electrical activity in other devices with relays.

In this module, you'll learn about the .NET IoT Libraries by implementing a device to monitor environmental conditions and control a relay.

## Learning objectives

In this module, you will:

- Construct circuits to implement:
  - An environmental sensor.
  - A switched circuit to control LEDs or relay modules.
- Write code to read temperature and humidity from a sensor.
- Write code to use GPIO pins to activate an LED or relay module.
- Deploy and test the code.

## Prerequisites

- Intermediate knowledge of .NET
- Basic understanding of Raspberry Pi and Raspberry Pi OS
- .NET SDK 7 or later
- The following hardware components:
  - A Raspberry Pi device (2 or greater) configured as described in the *Important* callout below.
  - BME280 humidity/barometric pressure/temperature sensor breakout ([example](https://learn.adafruit.com/adafruit-bme280-humidity-barometric-pressure-temperature-sensor-breakout))
  - 5 mm LED ([example](https://www.adafruit.com/product/4203))
  - 1.0K ohm resistor ([example](https://www.adafruit.com/product/4294))
  - Jumper wires ([example](https://www.adafruit.com/product/758))
  - Full-sized breadboard ([example](https://www.adafruit.com/product/239))
  - Raspberry Pi GPIO breakout board ([example](https://www.adafruit.com/product/2028))

All of the required hardware components are available from various retailers. You can find most of the components bundled in convenient kits.

> [!IMPORTANT]
> The .NET IoT Libraries support a wide range of hardware platforms. We selected Raspberry Pi for this module due to its wide availability and affordable price point.
>
> Ensure your device has a recent version of [Raspberry Pi OS](https://www.raspberrypi.com/documentation/computers/getting-started.html) installed. Note the following:
>
> - We recommend a 64-bit version of Raspberry Pi OS.
> - A desktop environment isn't required, so you can select the *Lite* variant to conserve space and bandwidth.
> - The 64-bit and Lite variants are located under **Raspberry Pi OS (Other)** in Raspberry Pi Imager's list of available operating systems.
>
> After installing Raspberry Pi OS, use the `raspi-config` command to ensure the following two services are enabled:
>
> - `SSH`
> - `I2C`
>
> For more information, see the [Raspberry Pi documentation](https://www.raspberrypi.com/documentation/computers/configuration.html).

## Learn the scenario

Suppose you manage a gourmet cheese making company in a southern location. The company is proud of its cheese, and is careful to maintain the perfect temperature and humidity as it ages. To maintain the perfect conditions, they age the cheese in a natural cave.

  [![Photograph, close-up, of matured cheese.](../media/cheese-rect.png)](../media/cheese-rect.png#lightbox)

Your company's accepted ideal temperature for aging cheese is 50°F (10°C), with up to ±5°F (2.78°C) acceptable variance. Humidity is also important. A humidity level between 75-95% is acceptable.

You've decided to build a device using a Raspberry Pi to monitor the environmental conditions in the cave. The device will also activate the fan to control humidity as needed. To take advantage of your existing development skills, you decide to use .NET.

  [![Photograph of matured blue cheese.](../media/cheese-circle.png)](../media/cheese-circle.png#lightbox)

## The first step

The first step to building your device is constructing the circuit. In the next unit, you'll use common hardware components to build a prototype device for monitoring and controlling conditions in the cave.
