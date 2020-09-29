In this unit, you'll learn about event driven programming and look at several different timers such as Event Timers, Periodic Timers, and One-Shot Timers.

## Event Timers

Event Timers generate events which are bound to handler functions which implement desired actions. 

![The illustration shows event timers concept.](../media/timer-events.png)

For example, blink an LED every second, or read a sensor every 10 seconds. Event-driven programming helps to simplify application design.

The labs use event timers extensively, so there is a generalized model to simplify working with timers.

There are two types of timers:

- periodic timers, and
- one-shot timers.

### Periodic Timers

Periodic Timers produce timed triggers with a fixed period of time between the next occurrence.

The following example is a variable named **measureSensorTimer** of type **LP_TIMER**. This event timer is initialized with a period of 10 seconds **{ 10, 0 }**. When the event timer triggers, the handler function **MeasureSensorHandler** is called to implement the action.

> There are two values used to initialize the **.period** variable. The first is the number of seconds, followed by the number of nanoseconds. If you wanted the timer to trigger events every half a second (500 milliseconds), you would set the .period to be { 0, 500000000 }.

```
static LP_TIMER measureSensorTimer = {
	.period = { 10, 0 },	// Fire the timer event every 10 seconds + zero nanoseconds.
	.name = "measureSensorTimer",	// An arbitrary name for the timer, used for error handling
	.handler = MeasureSensorHandler	// The function handler called when the timer triggers.
};
```

### Reading Telemetry

The following is the implementation of the **MeasureSensorHandler** handler function. This functions reads telemetry, then calls Led2On() to turn on led2.

```
/// <summary>
/// Read sensor and send to Azure IoT
/// </summary>
static void MeasureSensorHandler(EventLoopTimer* eventLoopTimer) {
	if (ConsumeEventLoopTimerEvent(eventLoopTimer) != 0) {
		lp_terminate(ExitCode_ConsumeEventLoopTimeEvent);
		return;
	}
	if (lp_readTelemetry(msgBuffer, JSON_MESSAGE_BYTES) > 0) {
		Log_Debug("%s\n", msgBuffer);
		Led2On();
	}
}
```

### One-Shot Timers

A one-shot timer, as its name suggests fires once only.

The following code uses a one-shot timer to blink an LED once when a button is pressed. The LED turns on, and then a one-shot timer is set. When the one-shot timer triggers, its handler function is called to turn off the LED.

The advantage of this event-driven pattern is that the device can continue to service other events such as checking if a user has pressed a button.

The following is an example of a one-shot timer. The variable named **led2BlinkOffOneShotTimer** is of type **LP_TIMER**. This timer is initialized with a period of { 0, 0 }. Timers initialized with a period of 0 seconds are one-shot timers.

```
static LP_TIMER led2BlinkOffOneShotTimer = {
	.period = { 0, 0 },
	.name = "led2BlinkOffOneShotTimer",
	.handler = Led2OffHandler
};
```

In the **Led2On** function, led2 is turned on, then a one-shot timer is set by calling **SetOneShotTimer**.

> The variable led2BlinkPeriod is set to 300,000,000 nanoseconds (300 milliseconds). This means led2 will be turned off 300 milliseconds after it was turned on.

```
/// <summary>
/// Turn on LED2 and set a one-shot timer to turn LED2 off
/// </summary>
static void Led2On(void) {
	lp_gpioOn(&led2);
	lp_setOneShotTimer(&led2BlinkOffOneShotTimer, &led2BlinkPeriod);
}
```

When the one-shot timer triggers, the handler function **Led2OffHandler** is called to turn off led2.

```
/// <summary>
/// One shot timer to turn LED2 off
/// </summary>
static void Led2OffHandler(EventLoopTimer* eventLoopTimer) {
	if (ConsumeEventLoopTimerEvent(eventLoopTimer) != 0) {
		lp_terminate(ExitCode_ConsumeEventLoopTimeEvent);
		return;
	}
	lp_gpioOff(&led2);
}
```

## Automatic Initialization of Peripherals and Event Timers

Peripherals and timers referenced in a **Set** will be automatically opened and closed.

```
LP_PERIPHERAL_GPIO* peripheralSet[] = { &buttonA, &buttonB, &led1, &led2, &networkConnectedLed };
LP_TIMER* timerSet[] = { &led1BlinkTimer, &led2BlinkOffOneShotTimer, &buttonPressCheckTimer, &networkConnectionStatusTimer, &measureSensorTimer };
```

These sets are referenced when calling **OpenPeripheralSet**, and **StartTimerSet** from the **InitPeripheralsAndHandlers** function. The sets are also referenced when closing the peripheral and timer sets in the **ClosePeripheralsAndHandlers** function.

```
static void InitPeripheralsAndHandlers(void)
{
	lp_initializeDevKit();  // Avnet Starter kit

	lp_openPeripheralSet(peripheralSet, NELEMS(peripheralSet));
	lp_startTimerSet(timerSet, NELEMS(timerSet));
}
```

## Easy to Extend

This model makes it easy to declare another peripheral or timer and add them to the **peripheral** or **timer** sets. The following is an example of adding a GPIO output peripheral.

```
static LP_PERIPHERAL_GPIO fanControl = {
	.pin = FAN1, // The GPIO pin number
	.direction = LP_OUTPUT, // for OUTPUT
	.initialState = GPIO_Value_Low,  // Set the initial state on the pin when opened
	.invertPin = true,  // Should the switching logic be reverse for on/off, high/low
	.initialise = lp_openPeripheral,  // The function to be called to open the GPIO Pin
	.name = "FanControl"  // An arbitrary name for the senor.
};
```

Remember to add this new peripheral to the **peripheral set**. Adding the peripheral to the set ensures automatic opening and closing.

```
Peripheral* peripheralSet[] = { &buttonA, &buttonB, &led1, &led2, &networkConnectedLed, &fanControl };
```
