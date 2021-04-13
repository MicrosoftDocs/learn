Over the past few decades, datacenters have grown both in size (in terms of the number of racks and cabinets) and in density.

The following figure shows a view of a datacenter owned by Google.

![Google datacenter](../media/google-data-center.png)

_Figure 17: Google datacenter_ ([Source](http://www.google.com/about/datacenters/))

## Datacenter growth

Greater density has become possible because of advances in CPUs, integrated circuits (ICs), and printed circuit board (PCB) design. This leads to faster and more powerful computers within the same area. 

The minimum size of an element on an integrated circuit (called the feature size) has become smaller by orders of magnitude over the last four decades. Individual transistors decreased in size from about 10 microns in 1971 to about 0.022 microns in 2014. As individual transistors get smaller, more can fit on the same silicon, so each transistor consumes less power.

Within the same thermal constraints, CPUs have gone from single core to 16 cores, with transistor counts going from millions to billions. Additionally, accelerators/coprocessors have emerged that provide hundreds of additional floating point units (FPUs) each, with increasing floating point operations per second (FLOPs), per watt. Also, recent storage arrays have gone from supporting three or four mechanical hard drives per rack unit to 15 to 21 drives per rack unit.

Hence, although the power efficiency of individual components has improved over the years, computers themselves have become more dense, packing in more processing cores, memory, and storage per square foot. This density caused the overall power consumption per rack and per square foot to rise dramatically over the last few years. This trend means that both power and cooling requirements also increase per datacenter.

A large datacenter now consumes several megawatts of power, which is roughly the same power requirements of a small town.

![Trends in power density](../media/trends-power-density.png)

_Figure 18: Trends in power density_

## Datacenter efficiency

Information and communications technology (ICT) now accounts for approximately 2% of the global carbon footprint.<sup>[1][^1]</sup> Within that amount, datacenters currently account for approximately 15% (or 0.3% of total global emissions). With the proliferation of ICT worldwide, as more people gain access, the energy footprint of ICT is set to grow considerably for the foreseeable future.

Over the past decade or so, there has been an increased focus on "green" IT, or power-efficient computing. Later in this module, we discuss various methods available in the industry to reduce power consumption and carbon footprint.

Efforts in improving power efficiency in IT exist across many parts of the datacenter.

### Servers

Entire servers attempt to reduce power consumption by going into idle states, in which they temporarily power down or reduce the power consumption of components when the system is underutilized. For example, a server that typically consumes 650 W when busy can scale down to about 200 W when idle. In addition, virtualization enables better management of IT resources and allows organizations to consolidate individual servers onto fewer physical servers.

### Server components

Within individual servers, CPUs and other integrated circuits have gained in performance while maintaining or reducing power consumption. Efforts have also been made to reduce idle power consumption (time periods of low CPU utilization). In addition, dynamic clocking techniques for multicore CPUs enable these CPUs to lower the clock rate of individual cores based on usage and can significantly reduce idle power consumption.

### Power

Systems that distribute and manage electrical power, as well as those providing backup supplies, have recently become targets in the drive for efficiency. Where individual datacenter racks were previously fed from 110 to 220 volts alternating current (VAC), high voltage (277 to 480 VAC) is now becoming more popular because that configuration requires fewer step-down transformers.

The efficiency of a power supply is the ratio of its output power divided by its input power. For instance, a fully loaded, 800-W power supply at 80% efficiency would consume 1000 W of power, with the remaining 200 W lost as heat. These power supplies have gained efficiency recently, with some of them reaching 95%. An alternate design feeds DC to servers directly, instead of converting AC to DC on each rack. Delivering high-voltage, direct current (HVDC) to each server allows using more efficient, DC/DC supplies within the rack.

Large, centralized, uninterruptible power supply (UPS) systems also incur AC/DC conversion losses. To minimize these losses, many public cloud providers have adopted a decentralized UPS plan, including dedicated battery backup for each server. Some manufacturers now offer this server-based UPS configuration for datacenters.

### Cooling

Significant advances have also been made in the area of cooling. Eventually, all of the electricity used to power the IT equipment turns into heat (and some noise). This heat has to be dissipated away from the equipment. Traditional server room cooling uses the raised floor plenum with computer room air conditioners (CRACs), but this has limited cooling density. Newer approaches that improve efficiency and capacity include hot-aisle containment, in-row cooling, liquid cooling to the rack, and even completely submerging the equipment in mineral oil. Evaporative cooling techniques, as part of the facility, are more energy efficient than chillers and compressors. In colder climates, many server rooms are designed to mix colder outside air as well as reclaim the heat generated by servers for use elsewhere in the building.

The leading driver of increasing power efficiency in the datacenter is to decrease operating cost. Any power that is drawn from the electric company is billed, but only what is getting to the IT equipment is considered useful. The rest of the losses eventually become heat. Similarly, the more efficient your cooling system is, the lower your monthly costs.

> [!div class="alert is-tip"]
> ### Did you know?
>
> Each time you convert from AC to DC, or vice versa, energy is lost. Similarly, conversions between voltage levels are never 100% efficient.

Techniques to calculate and improve power efficiency in datacenters are covered in a later module.
<br>
***
### References

1. _GeSI (2008). [SMART 2020: Enabling the low-carbon economy in the information age Global e-Sustainability Initiative Report](https://ecocloud360.com/wp-content/uploads/2015/02/02_Smart2020Report.pdf)_

***

[^1]: <https://ecocloud360.com/wp-content/uploads/2015/02/02_Smart2020Report.pdf> "GeSI (2008). *SMART 2020: Enabling the low-carbon economy in the information age Global e-Sustainability Initiative Report*"
