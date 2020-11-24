Congratulations! You now have a picture of each of the six Apollo missions that landed on the Moon. This picture contains information about the samples that each mission collected and the weights of each lunar and command module. 

| Index | Mission | Sample weight (kg) | Weight diff | Lunar module (LM) | LM mass (kg) | LM mass diff | Command module (CM) | CM mass (kg) | CM mass diff | Total weight (kg) | Total weight diff |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | Apollo11 | 21.55424 | 0.00000 | Challenger (LM-12) | 15264 | 0.0 | Yankee Clipper (CM-108) | 5960 | 0.0 | 21224 | 0.0 |
| 1 | Apollo12 | 34.34238 | 12.78814 | Orion (LM-11) | 15235 | -29.0 | Kitty Hawk (CM-110) | 5609 | -351.0 | 20844 | -380.0 |
| 2 | Apollo14 | 41.83363 | 7.49125 | Falcon (LM-10) | 16456 | 1221.0 | Casper (CM-113) | 5840 | 231.0 | 22296 | 1452.0 |
| 3 | Apollo15 | 75.39910 | 33.56547 | Antares (LM-8) | 16430 | -26.0 | America (CM-114) | 5875 | 35.0 | 22305 | 9.0 |
| 4 | Apollo16 | 92.46262 | 17.06352 | Intrepid (LM-6) | 16445 | 15.0 | Endeavor (CM-112) | 5560 | -315.0 | 22005 | -300.0 |
| 5 | Apollo17 | 109.44402 | 16.98140 | Antares (LM-8) | 15103 | -1342.0 | Casper (CM-113) | 5758 | 198.0 | 20861 | -1144.0 |

But what does it mean?

## Compare the data

The interesting thing about predicting how much sample each Artemis mission can bring back is that we don't yet know the full specs of the spacecraft that the Artemis plans on using. Using some information from the [NASA Factsheet on the Space Launch System (SLS) and Orion Modules](https://www.nasa.gov/sites/default/files/atoms/files/0080_sls_fact_sheet_sept2020_09082020_final_0.pdf?azure-portal=true), we have data on weights and payloads.

A *payload* is basically the total amount of weight that a rocket can get up through our atmosphere and into space. So the likelihood that the payload number is more accurate than the exact weights of each module is high, because deciding the payload will likely affect each of the other design decisions.

We know that the Saturn V payload was 43,500 kg, and the weights of the modules varied from mission to mission. So, to determine the ratios that will allow us to make predictions about the Artemis missions, we can use:
- Saturn V payload
- Mission sample weight
- Mission module weight
 

```python
# Sample-to-weight ratio
saturnVPayload = 43500
missions['Crewed area : Payload'] = missions['Total weight (kg)'] / saturnVPayload
missions['Sample : Crewed area'] = missions['Sample weight (kg)'] / missions['Total weight (kg)']
missions['Sample : Payload'] = missions['Sample weight (kg)'] / saturnVPayload
missions
```

| Index | Mission | Sample weight (kg) | Weight diff | Lunar module (LM) | LM mass (kg) | LM mass diff | Command module (CM) | CM mass (kg) | CM mass diff | Total weight (kg) | Total weight diff | Crewed area : Payload | Sample : Crewed area | Sample : Payload |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | Apollo11 | 21.55424 | 0.00000 | Challenger (LM-12) | 15264 | 0.0 | Yankee Clipper (CM-108) | 5960 | 0.0 | 21224 | 0.0 | 0.487908 | 0.001016 | 0.000495 |
| 1 | Apollo12 | 34.34238 | 12.78814 | Orion (LM-11) | 15235 | -29.0 | Kitty Hawk (CM-110) | 5609 | -351.0 | 20844 | -380.0 | 0.479172 | 0.001648 | 0.000789 |
| 2 | Apollo14 | 41.83363 | 7.49125 | Falcon (LM-10) | 16456 | 1221.0 | Casper (CM-113) | 5840 | 231.0 | 22296 | 1452.0 | 0.512552 | 0.001876 | 0.000962 |
| 3 | Apollo15 | 75.39910 | 33.56547 | Antares (LM-8) | 16430 | -26.0 | America (CM-114) | 5875 | 35.0 | 22305 | 9.0 | 0.512759 | 0.003380 | 0.001733 |
| 4 | Apollo16 | 92.46262 | 17.06352 | Intrepid (LM-6) | 16445 | 15.0 | Endeavor (CM-112) | 5560 | -315.0 | 22005 | -300.0 | 0.505862 | 0.004202 | 0.002126 |
| 5 | Apollo17 | 109.44402 | 16.98140 | Antares (LM-8) | 15103 | -1342.0 | Casper (CM-113) | 5758 | 198.0 | 20861 | -1144.0 | 0.479563 | 0.005246 | 0.002516 |

> [!NOTE]
> We're calling the two modules *crewed area* in the DataFrame because those are the parts of the spacecraft where the crew can be, and likely where the samples would also reside.

## Save the ratios

We can then use the `mean()` function to take the average of all those ratios across all the missions.

```python
crewedArea_payload_ratio = missions['Crewed area : Payload'].mean()
sample_crewedArea_ratio = missions['Sample : Crewed area'].mean()
sample_payload_ratio = missions['Sample : Payload'].mean()
print(crewedArea_payload_ratio)
print(sample_crewedArea_ratio)
print(sample_payload_ratio)
```

```output
0.49630268199233724
0.0028946732226251396
0.0014369195019157093
```

We can then use these ratios to predict the Artemis capacity for samples.
