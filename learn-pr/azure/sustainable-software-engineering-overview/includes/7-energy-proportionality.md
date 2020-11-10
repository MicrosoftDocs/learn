Utilization is a measure of how much of a computer's resources are being used, which is usually represented as a percentage. An idle computer has a low utilization percentage and isn't being utilized, a computer running at its maximum capacity has a high percentage and is being fully utilized.

[Energy proportionality](https://en.wikipedia.org/wiki/Energy_proportional_computing) is a measure of the relationship between power consumed in a computer system and the rate at which useful work is done (its utilization). If the overall power consumption is proportional to the computer's utilization, then it is said to be energy proportional.

In an energy proportional system, the energy efficiency is a constant, no matter the utilization the energy efficiency remains the same. However, the energy efficiency of hardware is not constant. It varies based on context. Due to the complex interactions of many different components of a hardware device, it can be non-linear, which means that the relationship between power and utilization is not proportional.

![Power versus utilization.](../media/7-energy-proportionality-1.svg)

At 0% utilization, the computer still draws <nobr>100 W</nobr>; at 50% utilization, it draws <nobr>180 W</nobr>, and at 100% utilization, it draws <nobr>200 W</nobr>. The relationship between power consumption and utilization is not linear, and it doesn't cross the origin.

Because of this relationship, **the more you utilize a computer, the more efficient it becomes at converting electricity to useful computing operations**. Running your work on as few servers as possible with the highest utilization rate maximizes their energy efficiency.

## Static power draw

There are various reasons for this lack of energy proportionality, one of them is static power draw.

An idle computer, even one at zero percent utilization, still draws electricity. This static power draw varies by configuration and hardware components, but all components have some static power draw. This potential power draw is one of the reasons that PCs, laptops, and mobile devices have power-save modes available. If the device is idle, it will eventually trigger a hibernation mode and put the disk and screen to sleep or even change the CPU frequency. These power-save modes save on electricity, but they have other trade-offs, such as a slower restart when the device wakes up.

Servers are usually not configured for aggressive or even minimal power-saving. Many server use-cases demand full capacity as quickly as possible in response to rapidly changing demands. This scenario can leave many servers in idle modes during low demand periods. An idle server has a cost both from embedded carbon and its inefficient utilization.

### Clock speed

Clock speed (frequency) is the operating speed of a computer or its microprocessor, expressed in cycles per second (megahertz). Dynamically adjusting the clock speed of computing devices is often used in consumer devices to achieve more energy proportionality.

Clock speed denotes how fast a computer can execute instructions.

The energy efficiency of microprocessors changes with clock speed, high clock speeds are often **less** energy-efficient than low clock speeds. For example, in the I7-3770K system, you can run at <nobr>3.5 GHz</nobr> for <nobr>50 W</nobr>, or about <nobr>5 GHz</nobr> for <nobr>175 W<nobr>. An approximate 40% increase in clock speed requires <nobr>&gt;3&#10005;</nobr> power increase.

Taking this information into consideration, reducing the clock speed at times of low utilization can increase energy efficiency, thereby maximizing the energy efficiency of hardware.