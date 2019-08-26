# Title

Get your first Azure IoT Central app working in minutes

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure IoT Central
- Azure Maps

## Prerequisites

- Azure account
- An introductory knowledge of the purpose of Azure IoT.
- A working knowledge of how to navigate a web portal.
- Good working knowledge of Visual Studio Code, or Visual Studio 2017+

## Summary

The tutorial describes step-by-step how to get an Azure IoT Central app up and running. The app simulates a number of refrigerated trucks moving from a base to a number of 
customers, reporting their position and the temperature of the contents. The operator directs the trucks to the customers, watches their progress in the Azure Iot portal, 
and can recall or redirect trucks that are overheating.

## Learning objectives

1. Create an Azure IoT Central app, as the basis for monitoring remote devices.
2. Create and run NodeJS code to simulate remote devices.
3. Add an Azure IoT Central dashboard specifically designed for the task, that easily monitors, and sends commands to, the simulated devices.

## Module subtasks

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create an IoT Central app | Shows the process of creating the IoT Central app, which will handle all aspects of the scenario.  | Exercise | 1 | yes |
| Create a device template | Creates a template for a simulated refrigerated truck. | Exercise | 1 | yes |
| Create simulated devices | Use NodeJS (all code supplied) to build apps for each truck. | Exercise | 2 | yes |
| Create an IoT Central dashboard | This completes the scenario, with all truck movements being visible on a portal map | Exercise | 3 | yes |

## Unit outline


1. **Introduction**

    A popular real-world use of IoT devices is in the monitoring of refrigerated trucks, given the obvious requirement that the contents must remain cold for the 
    entire journey, otherwise an intervening action might be necessary. The simulation in this module shows the movement and temperature of a number of trucks, and
    the cooling system can randomly fail. If the contents are at a too high temperature for too long, then their state is changed to "melting". If the simulated contents 
    are in a melting state,  the operator has the option of redirecting the truck to a nearer customer, recalling the truck and dumping the contents, or doing nothing 
    and delivering the contents in a melting state.

1. **Create an IoT Central app**
    - Creating the app requires that the Azure IoT portal be navigated and used correctly.

1.  **Create a device template**
    - Add telemetry
        - Show how to add telemetry, state, properties and settings that apply to a refrigerated truck.
    - Add commands
        - Shows how to add commands (sent from a human operator to a truck).

1.  **Create simulated devices**
    - Create NodeJS code to simulate each truck
        - Working code is supplied, and described, showing how remote code communicates with IoT Central.
        - Shows how to validate and test the code for one truck.
        - Shows the code that still applies in a real-world scenario. The communication code is very similar moving from a simulated world to the real world.
        - Shows the state changes required for simulation: trucks can be in a loading, ready, en-route, delivering, returning, or dumping state. Contents can be in an
          empty, full, or melting state. The truck cooling system can be in a working or failed state.

1.  **Create an IoT Central dashboard**
    - Construct a dashboard
        - Show how to add components to a dashboard, including a map capable of showing the positions of multiple trucks.
        - Show how to add components to the dashboard to monitor truck temperature
        - Show how to add commands to the dashboard, directing trucks to a specified customer location, or recalling the truck.

1. **Knowledge check**

    1. Questions on setting up IoT Central, such as:
        a.   When adding an IOT Central device, what four Measurements can be defined?
        b.  A typical rule for a device would be "send an alert if the temperature exceeds 90 degrees". If the rule Aggregation value is changed from None to Average, what additional information needs to be provided?
        c.  When a setting is displayed in a tile on the operator's dashboard, a synced message such as "synced since 20 minutes ago" can appear. What does this mean?
        d.  All properties are read/write for simulated devices. When connecting a real device, which two properties become read-only (meaning they are sent from the device)?
    2.  Questions on NodeJS, and its communication with Azure IoT Central.

1. **Summary**

    By completing all steps of the tutorial the user will have an up-and-running IoT Central app that visually demonstrates the power of an IoT Central dashboard in monitoring
    and sending commands to remote devices. The visual interactive nature of the app shows the value of IoT Central in its ability to communicate with remote devices, receive messages and telemetry from these devices, and importantly, to send commands to these devices to change their objectives appropriately.

