The only thing left is to test the app.

## Test the app

Complete the following steps **in the SSH session on the Raspberry Pi**:

1. Launch the app

    ```bash
    ./cheesecave.net    
    ```

    :::image type="content" source="../media/app-running.png" alt-text="A screenshot of a terminal with the cheesecave.net app running." lightbox="../media/app-running.png":::

    The app runs and displays the current status. Notice **Fan** is *OFF*.
    
    > [!NOTE]
    > If you receive either `No such file or directory` or `cannot execute binary file: Exec format error`, the most likely cause is a 32/64-bit mismatch between Raspberry Pi OS and your target runtime.

1. Type `fan` and press <kbd>Enter</kbd>.

    :::image type="content" source="../media/breadboard-illuminated.jpg" alt-text="The breadboard with the LED illuminated." lightbox="../media/breadboard-illuminated.jpg":::

    The LED illuminates, and the console prints a status showing **Fan** is *ON*.

1. Type `fan` and press <kbd>Enter</kbd> again to turn off the LED.
1. Blow some hot or cold air over the BME280 breakout.
1. Type `status` and press <kbd>Enter</kbd>. Notice the effect of the air on the temperature and humidity readings.
1. Type `exit` and press <kbd>Enter</kbd> to end the program.

Congratulations! You've built and coded a working IoT device prototype!

## What to do if something doesn't work

If your app doesn't work right or throws an exception, don't panic. Check the following things:

1. Double-check the connections on your breadboard. Use the tables and diagrams in unit 2 for reference.
1. Did you enable the `I2C` service using `raspi-config`?
1. Did you include the right device address for your BME280? If `Bme280.DefaultI2cAddress` doesn't work, try `Bme280.SecondaryI2cAddress` instead.
1. Debug the code remotely, if needed. See the [.NET IoT Libraries documentation](/dotnet/iot/debugging) for details.
1. Use the `i2cdetect` tool [as described here](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-4-gpio-setup/configuring-i2c) to verify your I<sup>2</sup>C bus and BME280 breakout are functioning.
