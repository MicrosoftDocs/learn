In this unit, we'll construct the circuits used to monitor environmental conditions and control the fan in the cheese cave.

## The GPIO header

This array of pins on the Raspberry Pi is called the General Purpose Input/Output (GPIO) header.

:::image type="content" source="../media/gpio-header.png" alt-text="A Raspberry Pi 3 with the GPIO header highlighted." lightbox="../media/gpio-header.png":::

This versatile pin header supports communication using a variety of protocols. You'll learn more about the supported protocols in the next unit.

A GPIO breakout board combined with a breadboard streamlines connecting sensors and other components to the GPIO header.
## Measuring environmental conditions

To measure temperature and humidity, you'll use a commonly available low-cost environmental sensor, the BME280.

:::image type="content" source="../media/bme280-examples.png" alt-text="Two examples of available BME280 breakouts." lightbox="../media/bme280-examples.png":::

Your BME280 is already installed on a breakout board. All we need to do is connect the breakout board to the Inter-Integrated Circuit (I2C) bus on the Raspberry Pi. The I2C bus is accessible on the GPIO header.

> [!NOTE]
> There are many manufacturers of BME280 breakouts. Most designs are similar, and the manufacturer shouldn't make any difference to the functionality. This module was built with the Adafruit example in the prerequisites. Ensure your BME280 breakout includes an Inter-Integrated Circuit (I2C) interface.

> [!TIP]
> Most BME280 breakouts are sold with the pin header unattached. As a consequence, most require soldering to assemble. If you don't know how to solder, don't be discouraged! Soldering isn't as hard as you might think! There are a plethora of tutorials and videos to get you started. [Here's a good example](https://www.youtube.com/watch?v=ZwU9SqO0udU).

## Controlling fans

In a real-world scenario, you would use a relay module like this to control power to the fan.

:::image type="content" source="../media/relay-module.png" alt-text="An example of a generic 5V relay module." lightbox="../media/relay-module.png":::

A relay is an electromagnetic switch that allows you to use small currents to control larger currents. When a small current is passed through the low-voltage input on the relay, it activates the switch. Activating the switch completes a different circuit.

A real-world device might use this relay to control the power to the fan. A fan large enough to maintain humidity in a cave would generally require a large AC current. For safety purposes, and to keep focus on the code, your device is going to use an LED to represent a relay. An illuminated LED will indicate that the relay is "on."

To activate the LED, your code will activate a GPIO pin for output, which will send current to the LED. This is the same process you'd use to activate many relays.

## Exercise: Construct the IoT device

We're going to use a breadboard to build the device. A breadboard is a rapid prototyping tool for circuits. The completed breadboard should look like the following diagram.

:::image type="content" source="../media/breadboard.png" alt-text="A Fritzing diagram illustrating the breadboard solution." lightbox="../media/breadboard.png":::

Refer to the diagram above as you construct your device.

1. Position the GPIO breakout and BME280 breakout on the breadboard as shown.
1. Use jumper wires to connect the BME280 to the GPIO breakout.

    | GPIO pin | BME280 breakout pin         | Diagram color |
    |----------|-----------------------------|---------------|
    | 3.3V     | VIN (sometimes labeled 3V3) | Red           |
    | Ground   | GND                         | Black         |
    | SDA      | SDI (sometimes labeled SDA) | Blue          |
    | SCL      | SCL (sometimes labeled SCL) | Orange        |

1. Use jumper wires to connect the LED to the GPIO breakout.

    | Connect this...                         | ...to this                           | Diagram color |
    |-----------------------------------------|--------------------------------------|---------------|
    | GPIO pin 21                             | LED anode<br>(longer, positive lead) | Green         |
    | LED cathode<br>(shorter, negative lead) | 1.0K Ω resistor<br>(either end)      | N/A           |
    | 1.0K Ω resistor<br>(other end)          | Ground                               | N/A           |

    > [!NOTE]
    > The resistor is required to ensure the LED isn't burnt out due to excessive current. You don't need a resistor in a real-world relay scenario.

:::image type="content" source="../media/breadboard-complete.jpg" alt-text="An image depicting a completed breadboard prototype." lightbox="../media/breadboard-complete.jpg":::

## Connect the Raspberry Pi

While the Raspberry Pi is powered off, use a ribbon cable to connect the GPIO breakout to the Raspberry Pi's GPIO header. Power on the Raspberry Pi.

In the next unit, you'll learn about the .NET IoT Libraries.
