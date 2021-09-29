A _direct method_ is a function on the device that can be invoked by the back-end app.

Calls from the back-end app to invoke direct methods can include multiple parameters as part of the payload. Direct methods are typically used to switch device features off and on or specify settings for the device.

## Handle error conditions

There are several error conditions that need to be checked when a device receives instructions to run a direct method. One of these checks simply responds with an error if the fan is in a failed state. Another error condition to report is when an invalid parameter is received. Well-defined error reporting is important given the potential remoteness of the device.

## Invoke a direct method

Direct methods require that the back-end app prepares the parameters before making a call specifying a single device to invoke the method. The back-end app will then wait for a response. Included in the call from the back-end app is a timeout, specified in seconds. The expectation is the back-end app will have take appropriate action if the device fails to respond satisfactorily.

The device app contains the functional code for the direct method. The function name is registered with the IoT client for the device. This process ensures the client knows what function to run when the call comes from the IoT Hub.

In the following unit, we add code for a direct method to turn on the cheese cave device fan.
