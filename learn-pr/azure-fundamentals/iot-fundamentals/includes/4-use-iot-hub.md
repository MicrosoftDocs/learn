The Tailwind Traders senior leadership team has decided to partner with a leading appliance manufacture to create an exclusive, high-end brand that promises a preemptive maintenance service agreement. This unique feature would differentiate Tailwind Traders appliances in a crowded, competitive market.  The feature also makes the brand lucrative, because a yearly subscription would be required. To build a strong brand reputation, the appliances will send telemetry information to a centralized location, where it can be analyzed and maintenance can be scheduled.

The devices will not require remote control.  They will merely be sending their telemetry data for analysis and pro-active maintenance.

Because Tailwind Traders already has software in place for managing appliance maintenance requests, the company wants to integrate all functionality into this existing system.

## Which service should you choose?

Let's apply the decision criteria from the previous unit.

First, is it critical to ensure that the device or, in this case, each appliance, isn't compromised?  It's preferable, but not critical, that the devices aren't compromised.  The worst that could happen is that a hacker reads the current temperature of the customer's refrigerator or the number of loads of laundry the washing machine has completed.

Even if the customer calls and reports strange behavior with their appliance, a technician could reset or replace the microcontroller. It might not warrant the extra expense or engineering resources that would be required to employ Azure Sphere.  

Second decision criterion: do I need a dashboard for reporting and management?  In this case, no.  Tailwind Traders wants to integrate the telemetry data and all other functionality into an existing maintenance request system.  In this case, Azure IoT Central is not required.

So, given the responses to the decision criteria, Azure IoT Hub is the best choice in this scenario.

## Why not use Azure IoT Central?

Azure IoT Central provides a dashboard that allows companies to manage IoT devices individually and an aggregate, view reports, and set up error notifications via a GUI. But, in this scenario, Tailwind Traders wants to integrate the telemetry it collects and other analysis functionality into an existing software application. Furthermore, the company's appliances will be collecting data via sensors only and don't need the ability to update settings or software remotely. Therefore, the company doesn't need Azure IoT Central.

## Why not use Azure Sphere?

Azure Sphere provides a complete solution for scenarios where security is critical. In this scenario, security is preferred but not critical. The appliances can't be updated with new software remotely. The sensors merely report usage data.  As a result, Azure Sphere isn't necessary.
