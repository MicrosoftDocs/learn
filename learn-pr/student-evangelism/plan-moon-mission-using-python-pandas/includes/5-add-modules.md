As mentioned in an earlier unit, since there isn't a lot of public information about how rockets are made *exaclty*, and because we are not experts, we will be using data that we have available to us to make assumptions. 

This is a *critical* part to data science: ensuring that assumptions you make accurately represent the data and the impact of that data. That means that this particular module is **NOT** something you should use to actually advise astronauts. While that might seem obvious here, it is critical that you understand the importance of that as you take what you learn from this module and apply it to other datasets and problems to solve. 

## Revisiting the Apollo Program

The Apollo program focused on using the Saturn V rocket to send humans into space and onto the Moon. The [Saturn V](https://www.nasa.gov/centers/johnson/rocketpark/saturn_v.html) rocket used in the Apollo program is known as a 3-stage rocket, meaning there are three parts of the rocket that each burn at different times to achieve different goals. The first stage is the main thrust portion that gets the rocket to about 68 kilometers into the sky, and then it falls away back to Earth, making the rocket significantly lighter.  The second stage will start burning its engines until the rocket nearly reaches Earths orbit, and again will fall back down to Earth. The final stage will get the spacecraft into Earths orbit and thrust it towards the Moon.

![Fei Fei's rocket reaching altitude](../media/rocket-flying.png)

As we know from the Over the Moon film, knowing exactly how much weight you can have at each stage significantly effects the outcome of the mission. We also know that astronauts require a lot of materials when flying into space such as food, water, oxygen, tools, and instruments. We got a glimpse of Fei Fei's supplies when she returned to find Gobi at her crash landing site:

![Fei Fei and Gobi in front of her rocket](../media/supplies.png)

The last bit of relevant information about the Apollo program and Saturn V is that for Lunar landings there are two modules that are important:
- Command Module: The module that astronauts live in, when two astronauts are down on the surface of the moon, the third astronaut stays in the command module. This is returned to Earth.
- Lunar Module: the module that detaches from the command module once it has reached orbit around the Moon. This module lands on the surface of the Moon and can carry two astronauts. To return from the surface back to the command module, part of the base (the landing gear) of the lunar module is left on the surface of the Moon. 

These are critical parts of the ship because they are designed so precisely to ensure that astronauts can arrive to the Moons orbit, orbit around the Moon, land on the Moon, launch from the Moon, and return to Earth. The amount of space and weight on each of these modules is precise to ensure the safety and success of the mission. One could conclude that the specifications around these modules could impact that amount of sample that can be collected since the samples have to be carried on each of these modules before returning to Earth. 

## Adding in Command and Lunar Module data

Using the [NASA Space Science Data Coordinated Archive](https://nssdc.gsfc.nasa.gov/nmc/SpacecraftQuery.jsp), we gathered information about each of the specific modules used in each mission. Similar to the samples, create six new columns, three for the lunar modules and three for the command modules:
- Module Name
- Module Mass 
- Module Mass Diff

And fill in any `NaN` values with 0:
```python
missions['Lunar Module (LM)'] = {'Eagle (LM-5)', 'Intrepid (LM-6)', 'Antares (LM-8)', 'Falcon (LM-10)', 'Orion (LM-11)', 'Challenger (LM-12)'}
missions['LM Mass (kg)'] = {15103, 15235, 15264, 16430, 16445, 16456}
missions['LM Mass Diff'] = missions['LM Mass (kg)'].diff()
missions['LM Mass Diff'] = missions['LM Mass Diff'].fillna(value=0)

missions['Command Module (CM)'] = {'Columbia (CSM-107)', 'Yankee Clipper (CM-108)', 'Kitty Hawk (CM-110)', 'Endeavor (CM-112)', 'Casper (CM-113)', 'America (CM-114)'}
missions['CM Mass (kg)'] = {5560, 5609, 5758, 5875, 5840, 5960}
missions['CM Mass Diff'] = missions['CM Mass (kg)'].diff()
missions['CM Mass Diff'] = missions['CM Mass Diff'].fillna(value=0)

missions
```

|   | Mission | Sample Weight(kg) | Weight Diff | Lunar Module (LM) | LM Mass (kg) | LM Mass Diff | Command Module (CM) | CM Mass (kg) | CM Mass Diff |
|---|---|---|---|---|---|---|---|---|---|
| 0 | Apollo11 | 21.55424 | 0.00000 | Challenger (LM-12) | 15264 | 0.0 | Yankee Clipper (CM-108) | 5960 | 0.0 |
| 1 | Apollo12 | 34.34238 | 12.78814 | Orion (LM-11) | 15235 | -29.0 | Kitty Hawk (CM-110) | 5609 | -351.0 |
| 2 | Apollo14 | 41.83363 | 7.49125 | Falcon (LM-10) | 16456 | 1221.0 | Casper (CM-113) | 5840 | 231.0 |
| 3 | Apollo15 | 75.39910 | 33.56547 | Antares (LM-8) | 16430 | -26.0 | America (CM-114) | 5875 | 35.0 |
| 4 | Apollo16 | 92.46262 | 17.06352 | Intrepid (LM-6) | 16445 | 15.0 | Endeavor (CM-112) | 5560 | -315.0 |
| 5 | Apollo17 | 109.44402 | 16.98140 | Antares (LM-8) | 15103 | -1342.0 | Casper (CM-113) | 5758 | 198.0 |

We can add in some totals for each mission across both the lunar and command module:

```python
missions['Total Weight (kg)'] = missions['LM Mass (kg)'] + missions['CM Mass (kg)']
missions['Total Weight Diff'] = missions['LM Mass Diff'] + missions['CM Mass Diff']
missions
```

|   | Mission | Sample Weight(kg) | Weight Diff | Lunar Module (LM) | LM Mass (kg) | LM Mass Diff | Command Module (CM) | CM Mass (kg) | CM Mass Diff | Total Weight (kg) | Total Weight Diff |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | Apollo11 | 21.55424 | 0.00000 | Challenger (LM-12) | 15264 | 0.0 | Yankee Clipper (CM-108) | 5960 | 0.0 | 21224 | 0.0 |
| 1 | Apollo12 | 34.34238 | 12.78814 | Orion (LM-11) | 15235 | -29.0 | Kitty Hawk (CM-110) | 5609 | -351.0 | 20844 | -380.0 |
| 2 | Apollo14 | 41.83363 | 7.49125 | Falcon (LM-10) | 16456 | 1221.0 | Casper (CM-113) | 5840 | 231.0 | 22296 | 1452.0 |
| 3 | Apollo15 | 75.39910 | 33.56547 | Antares (LM-8) | 16430 | -26.0 | America (CM-114) | 5875 | 35.0 | 22305 | 9.0 |
| 4 | Apollo16 | 92.46262 | 17.06352 | Intrepid (LM-6) | 16445 | 15.0 | Endeavor (CM-112) | 5560 | -315.0 | 22005 | -300.0 |
| 5 | Apollo17 | 109.44402 | 16.98140 | Antares (LM-8) | 15103 | -1342.0 | Casper (CM-113) | 5758 | 198.0 | 20861 | -1144.0 |

