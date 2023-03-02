As we mentioned in an earlier unit, there isn't a lot of public information about *exactly* how rockets are made. Because we are not experts, we will be using data that is available to us to make assumptions. 

This is a *critical* part of data science: ensuring that the assumptions you make accurately represent the data and the impact of that data. That means that this particular training module is **not** something you should use to actually advise astronauts. While that might seem obvious here, it is critical to understand the importance of that as you take what you learn from this module and apply it to other datasets and problems to solve. 

## Revisiting the Apollo program

The Apollo program focused on using the Saturn V rocket to send humans into space and onto the Moon. The [Saturn V](https://www.nasa.gov/centers/johnson/rocketpark/saturn_v.html?azure-portal=true) rocket that was used in the Apollo program is known as a three-stage rocket. This means that the rocket has three parts, each of which burns at a different times to achieve a different goal.

The first stage is the main thrust portion that gets the rocket to about 68 kilometers into the sky, and then it falls away back to Earth, making the rocket significantly lighter.  The second stage starts burning its engines until the rocket nearly reaches Earth's orbit and likewise falls back down to Earth. The final stage gets the spacecraft into Earth's orbit and thrusts it toward the Moon.

:::image type="content" source="../media/rocket-flying.png" alt-text="Image that shows Fei Fei's rocket reaching altitude." border="false":::

As we know from the *Over the Moon* film, knowing exactly how much weight you can have at each stage significantly affects the outcome of the mission. We also know that astronauts in space require a lot of materials, such as food, water, oxygen, tools, and instruments. We got a glimpse of Fei Fei's supplies when she returned to find Gobi at her crash landing site:

:::image type="content" source="../media/supplies.png" alt-text="Image that shows Fei Fei and Gobi in front of her rocket." border="false":::

The last bit of relevant information about the Apollo program and Saturn V is that for lunar landings there are two important spacecraft modules:
- Command module: The module that astronauts live in. When two astronauts are down on the surface of the Moon, the third astronaut stays in the command module. This module is returned to Earth.
- Lunar module: The module that detaches from the command module after it has reached orbit around the Moon. This module lands on the surface of the Moon and can carry two astronauts. When the lunar module returns from the surface to the command module, it leaves part of the base (the landing gear) on the surface of the Moon. 

The modules are critical parts of the ship because they are designed precisely to ensure that the astronauts can enter the Moon's orbit, orbit the Moon, land on the Moon, launch from the Moon, and return safely to Earth. The amount of space and weight on each of these modules is precise to ensure the safety and success of the mission. It is fair to conclude that the specifications around these modules affect the amount of mineral samples that can be collected, because the samples have to be carried on each of these modules before returning to Earth. 

## Add in command and lunar module data

By using the [NASA Space Science Data Coordinated Archive](https://nssdc.gsfc.nasa.gov/nmc/SpacecraftQuery.jsp?azure-portal=true), we gathered information about each module used in each mission. As you did when you created the samples tables, create six new columns, three for the lunar modules and three for the command modules:
- Module name
- Module mass 
- Module mass diff

Fill in any `NaN` values with 0:

```python
missions['Lunar module (LM)'] = ['Eagle (LM-5)', 'Intrepid (LM-6)', 'Antares (LM-8)', 'Falcon (LM-10)', 'Orion (LM-11)', 'Challenger (LM-12)']
missions['LM mass (kg)'] = [15103, 15235, 15264, 16430, 16445, 16456]
missions['LM mass diff'] = missions['LM mass (kg)'].diff()
missions['LM mass diff'] = missions['LM mass diff'].fillna(value=0)

missions['Command module (CM)'] = ['Columbia (CSM-107)', 'Yankee Clipper (CM-108)', 'Kitty Hawk (CM-110)', 'Endeavor (CM-112)', 'Casper (CM-113)', 'America (CM-114)']
missions['CM mass (kg)'] = [5560, 5609, 5758, 5875, 5840, 5960]
missions['CM mass diff'] = missions['CM mass (kg)'].diff()
missions['CM mass diff'] = missions['CM mass diff'].fillna(value=0)

missions
```

| Index | Mission | Sample weight (kg) | Weight diff | Lunar module (LM) | LM mass (kg) | LM mass diff | Command module (CM) | CM mass (kg) | CM mass diff |
|---|---|---|---|---|---|---|---|---|---|
| 0 | Apollo11 | 21.55424 | 0.00000 | Challenger (LM-12) | 15264 | 0.0 | Yankee Clipper (CM-108) | 5960 | 0.0 |
| 1 | Apollo12 | 34.34238 | 12.78814 | Orion (LM-11) | 15235 | -29.0 | Kitty Hawk (CM-110) | 5609 | -351.0 |
| 2 | Apollo14 | 41.83363 | 7.49125 | Falcon (LM-10) | 16456 | 1221.0 | Casper (CM-113) | 5840 | 231.0 |
| 3 | Apollo15 | 75.39910 | 33.56547 | Antares (LM-8) | 16430 | -26.0 | America (CM-114) | 5875 | 35.0 |
| 4 | Apollo16 | 92.46262 | 17.06352 | Intrepid (LM-6) | 16445 | 15.0 | Endeavor (CM-112) | 5560 | -315.0 |
| 5 | Apollo17 | 109.44402 | 16.98140 | Antares (LM-8) | 15103 | -1342.0 | Casper (CM-113) | 5758 | 198.0 |

We can add some totals for each mission across both the lunar and command modules:

```python
missions['Total weight (kg)'] = missions['LM mass (kg)'] + missions['CM mass (kg)']
missions['Total weight diff'] = missions['LM mass diff'] + missions['CM mass diff']
missions
```

| Index | Mission | Sample weight (kg) | Weight diff | Lunar module (LM) | LM mass (kg) | LM mass diff | Command module (CM) | CM mass (kg) | CM mass diff | Total weight (kg) | Total weight diff |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | Apollo11 | 21.55424 | 0.00000 | Challenger (LM-12) | 15264 | 0.0 | Yankee Clipper (CM-108) | 5960 | 0.0 | 21224 | 0.0 |
| 1 | Apollo12 | 34.34238 | 12.78814 | Orion (LM-11) | 15235 | -29.0 | Kitty Hawk (CM-110) | 5609 | -351.0 | 20844 | -380.0 |
| 2 | Apollo14 | 41.83363 | 7.49125 | Falcon (LM-10) | 16456 | 1221.0 | Casper (CM-113) | 5840 | 231.0 | 22296 | 1452.0 |
| 3 | Apollo15 | 75.39910 | 33.56547 | Antares (LM-8) | 16430 | -26.0 | America (CM-114) | 5875 | 35.0 | 22305 | 9.0 |
| 4 | Apollo16 | 92.46262 | 17.06352 | Intrepid (LM-6) | 16445 | 15.0 | Endeavor (CM-112) | 5560 | -315.0 | 22005 | -300.0 |
| 5 | Apollo17 | 109.44402 | 16.98140 | Antares (LM-8) | 15103 | -1342.0 | Casper (CM-113) | 5758 | 198.0 | 20861 | -1144.0 |
