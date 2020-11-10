# Design Document

## Title

Sustainable Software Engineering Overview

## Role(s)

- Administrator
- Developer
- Solution Architect
- Student
- DevOps Engineer
- Data scientist
- Data Engineer
- Database Administrator
- AI Engineer
- AI Edge Engineer
- Technology Manager

NOTE: See https://docs.microsoft.com/api/learn/catalog/ for more.

## Level

- Beginner

## Product(s)

- TBD

NOTE: See https://docs.microsoft.com/api/learn/catalog/ for list.

## Prerequisites

- TBD

## Summary

Sustainable Software Engineering is an emerging discipline at the intersection of climate science, software, hardware, electricity markets, and data center design. The Principles of Sustainable Software Engineering are a core set of competencies needed to define, build, and run sustainable software applications.

## Learning objectives

1. Identify the eight principles of Sustainable Software Engineering.

## Chunk your content into subtasks

Identify the subtasks of *TBD*

| Which learning objective(s) does this help meet? | How will you assess it: **Exercise or Knowledge check**? | Does the subtask have enough learning content to justify an entire unit?<br>If not, which other subtask will you combine it with? |
| ------------------------------------------------ | -------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |  |
| Identify the eight principles of SSE             | Knowledge check                                          | Yes                                                                                                                               |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Sustainable Software Engineering is an emerging discipline at the intersection of climate science, software, hardware, electricity markets, and data center design.

    The Principles of Sustainable Software Engineering are a core set of competencies needed to define, build, and run sustainable software applications.

1. **Overview**

    This module is an introduction to the eight principles:

      1. Carbon: Build applications that are carbon efficient
      1. Electricity: Build applications that are energy efficient
      1. Carbon Intensity: Consume electricity with the lowest carbon intensity
      1. Embodied Carbon: Build applications that are hardware efficient
      1. Energy Proportionality: Maximize the energy efficiency of hardware
      1. Networking: Reduce the amount of data and distance it must travel across the network.
      1. Demand Shaping: Build carbon-aware applications
      1. Optimization: Focus on step-by-step optimizations that increase the overall carbon efficiency

1. **Carbon: Build applications that are carbon efficient**

    Greenhouse gases (GHG) act as a blanket, increasing the Earth's temperature. This is a natural phenomenon; however, due to human activities, the global climate is changing much faster than animals and plants can adapt. How human society will adapt is still an open question. For more details regarding climate change's causes and impacts, read Take the Green pill and I'll show you how deep the rabbit hole goes.

1. **Electricity: Build applications that are energy efficient**

    Most people think electricity is clean; when we plug something into a wall, our hands don't become dirty, our laptops don't need exhaust pipes. The truth is that most electricity is produced through the burning of fossil fuels, usually coal, and energy supply is the single most significant cause of carbon emission.

    Since we can draw a direct line from electricity to carbon emissions, electricity can be considered one of the proxies for carbon.

    From the applications running on your smartphone to the training of machine learning models running in data centers, all software consumes electricity in its execution. One of the best ways to reduce electricity consumption and the subsequent emissions of carbon pollution made by our software is to make our applications more energy efficient. 

    As sustainable engineers we need to understand electricity, our journey doesn't start from the computer it starts from how the electricity that powers our computers is made. 

1. **Carbon Intensity: Consume electricity with the lowest carbon intensity**

    The carbon intensity of electricity is a measure of how much carbon (CO2eq) emissions produced per kilowatt-hour of electricity consumed.

    The standard unit of carbon intensity is gCO2eq/kWh or grams of carbon per kilowatt-hour.

    Not all electricity is produced in the same way. In different locations and at different times, electricity is made using various sources with varying emissions of carbon. Some sources, such as wind, solar, or hydroelectric, are clean, renewable sources that emit no carbon. Other fossil fuel sources emit varying amounts of carbon to produce electricity. For example, gas-burning power plants emit less carbon than coal-burning power plants.

    If your computer is plugged directly into a hydro plant, then the electricity it consumes would have a carbon intensity of 0 gCO2eq/kWh. A hydro plant emits no carbon to produce that electricity. Most people can't plug directly into hydro plants. Instead, they plug into power grids supplied with electricity from a mix of sources that produce varying amounts of carbon. Therefore, when plugged into a grid, your carbon intensity is usually a number greater than 0.

1. **Embodied Carbon: Build applications that are hardware efficient**

    The device you are reading this document on released some carbon in its creation; once it reaches the end of life, disposing of it may release more. Embodied carbon (otherwise referred to as "Embedded Carbon") is the amount of carbon pollution emitted during the creation and disposal of a device. When calculating the total carbon pollution for the computers running your software, account for both the carbon pollution to run the computer and the computer's embodied carbon.

1. **Energy Proportionality: Maximize the energy efficiency of hardware**

    Utilization is a measure of how much of a computer's resources are being used, usually given as a percent. An idle computer has a low utilization percentage and isn't being utilized, a computer running at its maximum capacity has a high percentage and is being fully utilized.

    Energy proportionality is a measure of the relationship between power consumed in a computer system and the rate at which useful work is done (its utilization). If the overall power consumption is proportional to the computer's utilization, then it is said to be energy proportional. 

    In an energy proportional system, the energy efficiency is a constant, no matter the utilization the energy efficiency remains the same. However, the energy efficiency of hardware is not constant. It varies based on context. Due to the complex interactions of many different components of a hardware device, it can be non-linear.

1. **Networking: Reduce the amount of data and distance it must travel across the network**

    A network is a series of switches, routers, and servers. All the equipment in a network consume electricity and have embedded carbon. The internet is a global network of devices typically run off the standard local grid energy mix or powered by renewables.

    When you send data across the internet, you send that data through many devices in the network, each one of those devices consuming electricity. As a result, any data you send or receive over the internet emits carbon.

1. **Demand Shaping: Build carbon-aware applications**

    Demand shifting is the strategy of moving compute to regions or times when the carbon intensity is less, or to put it another way when the supply of renewable electricity is high.

    Demand shaping is a similar strategy, but instead of moving demand to a different region or time, we shape our demand to match the existing supply.

1. **Optimization: Focus on step-by-step optimizations that increase the overall carbon efficiency**

    Sustainability isn't one optimization, it's thousands. One piece of advice is to look end-to-end and take it step-by-step. Often putting in the effort to understand the full stack, from user experience to data centers and even electricity grids yield simple solutions that significantly improve carbon efficiency.

    Weigh up the effort required to decarbonize vs. the potential rewards. Just like the broader global sustainability movement, some sectors will be harder to decarbonize than others. In computing, some application domains will be harder to decarbonize than others. Some parts of your application architecture will be harder to decarbonize than others.

1. **Knowledge Check**

    1. Question #1:
       a. Answer #1a.
       a. Answer #1b.
       a. Answer #1c.

    1. Question #2:
       a. Answer #2a.
       a. Answer #2b.
       a. Answer #2c.

    1. Question #3:
       a. Answer #3a.
       a. Answer #3b.
       a. Answer #3c.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
## Notes

https://aka.ms/sse/learn/intro
