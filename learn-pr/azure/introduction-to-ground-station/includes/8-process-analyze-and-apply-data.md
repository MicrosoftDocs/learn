Once data has been downlinked, you need to process it before you can analyze it.

## Process data

In this unit, we’ll return to the hypothetical satellite operator company, Contoso. Contoso has completed all the preceding actions using Azure Orbital Ground Station from their own mission-planning application.

To use the data downlinked from their satellites, Contoso must first process it. Processing data transforms it from unusable, demodulated data into an analysis-ready dataset. Every satellite constellation has its own set of tools to process data coming from its satellites, so Contoso will use their unique tools and algorithms on Azure. With Azure’s vast storage and powerful compute, Contoso can process their data quickly and access all the compute and storage they could possibly need.

### Data levels

There are four standard data levels, from 0-4. For data to be considered analysis ready, it needs to be at a level 2.

**Level 0**: Data directly from the spacecraft. At this stage, it's reconstructed, unprocessed instrument and payload data at full resolution. All communication artifacts, such as duplicate data or synchronization frames, are removed.

**Level 1 (A-C)**: Instrument data that's reconstructed, unprocessed, and at full resolution. It includes time references and annotations with ancillary information and new variables to describe the spectra.

**Level 2 (A-B)**: Data that contains information from the geolocated sensor data, such as ground elevation, energy quantile heights, and other waveform-derived metrics that describe the intercepted surface. You can open level 2 data as an image in a GIS or any number of tools.

**Level 3**: Data with space-time grid scales; typically in weekly, 10-day, or monthly scales so that the data can be analyzed based on changes over time.

**Level 4**: Model or output results from analyses of lower-level data.

## Analyze data

Contoso has a diverse range of customers across industries who want to use earth-observation data for data-driven decision making. To provide the unique analysis needed for each end customer, Contoso can use solutions from members of the Azure Space partner community. The Azure Space partner community offers industry-leading AI and ML data analysis tools to support data-driven decision making. Contoso can bundle these offerings into a larger managed service offering to provide increased value to Contoso’s end user.  

## Possible data applications

Let’s look at some possible use cases for how Contoso’s customers could use earth-observation data that's collected on Contoso’s satellites, downlinked via Azure Orbital Ground Station, and further analyzed using Azure Space Partner community offerings:

- **Risk intelligence for insurance**: AI analysis of satellite imagery can identify property risks like weather to inform more tailored premiums.

- **Scientific discovery**: Researchers can gain insights into patterns of vegetation, bodies of water, bird migration, and geological landforms.

- **Battlefield awareness**: AI can help mission planners more effectively identify terrain features, troop movements, enemy assets, and fortifications.

- **Geospatial Intelligence**: Earth-observation data can provide the intelligence community with insights into objects and activities in hostile territory. For instance, given criteria that describes the typical characteristics of a nuclear power plant, object-based classification and multi-spectral imagery can be used to help identify undeclared nuclear powerplants.

- **Agriculture**: Digital terrain models can inform planning decisions for an irrigation system, and remote sensing can provide insight into crop health, soil type, erosion, and moisture content. Based on this data, farmers could predict which crops would grow best based on anticipated weather conditions and soil type.

- **Measuring gravity**: Satellites can measure gravity more accurately than ever before. This has implications for oceanography, because the pull of gravity can be analyzed to reveal underwater mountains and seafloor topography.

- **Disaster prevention and relief**: The combination of AI and satellite imagery can provide early warnings of disaster, such as monitoring active volcanoes using thermal remote sensing or inventorying potential landslides with interferometry. In the wake of a crisis, relief efforts can gain a deeper appraisal of the situation, with closer to real-time updates.

- **Optimized logistics**: High-resolution, up-to-date maps can improve pre-trip planning for transit fleets, helping anticipate last-mile obstacles and delays. Transit fleets can be tracked with greater accuracy, and the resulting data ingested and analyzed by AI in real time to optimize routes. Finally, post trip-analysis of journeys can help managers keep track of routes and problem areas to better plan future trips.

- **Weather Assessment**: Remote sensing provides accurate and continuous information about the earth’s atmosphere. You could use this data to understand weather patterns and to predict phenomena like storms, cyclones, and droughts.

- **Urban planning/management**: Satellite imagery can help urban planners understand population growth and land use changes, or monitor the state of infrastructure and traffic patterns.

By providing Azure Orbital Ground Station as a fully managed, end-to-end service, Microsoft and our partners seek to broaden the many important applications for earth observation data across industries. As seen through the preceding examples, this creates important new opportunities across a vast array of space and non-space industries.
