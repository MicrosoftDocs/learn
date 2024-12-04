As mentioned in the preceding unit, we can use the [NASA Factsheet on the Space Launch System (SLS) and Orion Modules](https://www.nasa.gov/sites/default/files/atoms/files/0080_sls_fact_sheet_sept2020_09082020_final_0.pdf) to gather estimated data on the rockets and modules that will be used in the Artemis program.

As a reminder, the [Artemis program](https://www.nasa.gov/specials/artemis/) is NASA's second set of missions to land humans on the surface of the Moon. The program will launch in 2025 and will send not only the next pair of humans, but also the first woman to set foot on the Moon. The preparation for this mission is even bigger than focusing on a Moon landing. It will also provide space for a commercial payload on the ship and is the first step along the [Moon to Mars program](https://www.nasa.gov/topics/moon-to-mars). So, while the Artemis missions will likely bring home additional samples, there are other goals that might affect the amount of capacity that's required to do so. 

## Create an Artemis mission DataFrame

We don't have all the details about the Artemis mission, but we do know currently that three iterations of the rocket will be cycled through for each mission. Each rocket will have one version meant to sustain a crew and one meant only for cargo. For the purposes of this module, we will focus only on the three rockets meant to house crew, to be more aligned with the Apollo missions. We also know that the expected payload of the Space Launch System (SLS) is expected to grow with each iteration, but that the current weight of Orion (the command and lunar modules combined) has one estimated weight today. 

Again, we will call the command and lunar modules the *crewed area*, and we can create a DataFrame with the information we have about the three crewed missions:

```python
artemis_crewedArea = 26520
artemis_mission = pd.DataFrame({'Mission':['artemis1','artemis1b','artemis2'],
                                 'Total weight (kg)':[artemis_crewedArea,artemis_crewedArea,artemis_crewedArea],
                                 'Payload (kg)':[26988, 37965, 42955]})
artemis_mission
```

| Index | Mission | Total weight (kg) | Payload (kg) |
|---|---|---|---|
| 0 | artemis1 | 26520 | 26988 |
| 1 | artemis1b | 26520 | 37965 |
| 2 | artemis2 | 26520 | 42955 |

And we can estimate the weight of samples based on the ratios we determined from the Apollo missions:

```python
artemis_mission['Sample weight from total (kg)'] = artemis_mission['Total weight (kg)'] * sample_crewedArea_ratio
artemis_mission['Sample weight from payload (kg)'] = artemis_mission['Payload (kg)'] * sample_payload_ratio
artemis_mission
```

| Index | Mission | Total weight (kg) | Payload (kg) | Sample weight from total (kg) | Sample weight from payload (kg) |
|---|---|---|---|---|---|
|0|artemis1|26520|26988|75.549232|38.779584|
|1|artemis1b|26520|37965|75.549232|54.552649|
|2|artemis2|26520|42955|75.549232|61.722877|

Finally, we can get the average of the two predictions:

```python
artemis_mission['Estimated sample weight (kg)'] = (artemis_mission['Sample weight from payload (kg)'] + artemis_mission['Sample weight from total (kg)'])/2
artemis_mission
```

| Index | Mission | Total weight (kg) | Payload (kg) | Sample weight from total (kg) | Sample weight from payload (kg) | Estimated sample weight (kg) |
|---|---|---|---|---|---|---|
|0|artemis1|26520|26988|75.549232|38.779584|57.164408|
|1|artemis1b|26520|37965|75.549232|54.552649|65.050940|
|2|artemis2|26520|42955|75.549232|61.722877|68.636054|

We can see now that the three Artemis missions can likely return 57.16 kg, 65.05 kg, and 68.64 kg, respectively.

Now the question is, what kinds of rocks should they prioritize?
