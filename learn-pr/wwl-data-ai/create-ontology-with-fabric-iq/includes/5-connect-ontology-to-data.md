::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=b53e641a-5353-42ba-ac4b-d3a655bce475]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Whether you build your ontology manually or generate it from a semantic model, data bindings connect its definitions to source records. This unit explains how bindings connect hospital information and equipment readings to the same business vocabulary.

## Understand data bindings

Data bindings map each property in your ontology to a column in a source table. For example, a HospitalName property binds to the HospitalName column in the hospitals table. The binding connects your business vocabulary to physical data so a consuming experience can retrieve the appropriate values.

Bindings support sources such as lakehouses, eventhouses, and semantic models. In Lamna Healthcare, a lakehouse supplies hospital and equipment records, while an eventhouse supplies timestamped equipment readings.

These sources supply two kinds of information:

**Descriptive attributes** provide context, such as a hospital name, department location, or equipment type. These attributes can change, but they describe an entity rather than a sequence of observations.

**Time-series observations** describe values at particular times. A heart-rate reading needs an equipment identifier and timestamp as well as a measured value. Timestamped observations don't have to arrive continuously: a fixed sample file can contain historical time-series data.

## Bind properties to a primary source

The **Property binding** page connects an entity to a source table selected through the OneLake catalog. Source columns appear as proposed properties on **Entity type properties**. They can supply new properties or map to existing ones, keeping business names independent of technical column names.

For Hospital, the hospitals table supplies HospitalId, HospitalName, City, and State. Department, Room, Patient, and VitalSignEquipment follow the same pattern. The entity's **Configure** page shows each property's source and column, including bindings supplied by semantic-model generation.

## Add a related observation source

An entity can use more than one source. VitalSignEquipment combines descriptive attributes from the lakehouse with readings from the eventhouse. A common column, EquipmentId, links the primary equipment source to the secondary readings source. This adds context without copying every descriptive field into each measurement.

**Illustrative equipment records** (lakehouse):
```text
EquipmentId | PatientId | EquipmentType      | MonitoringStartDate
M001        | 5         | HeartRateMonitor   | 2024-01-15
M002        | 8         | OxygenMonitor      | 2024-01-16
```
These records identify each monitor, its assigned patient, equipment type, and monitoring start date.

**Illustrative readings** (eventhouse):
```text
ReadingId | EquipmentId | Timestamp           | HeartRate | OxygenSaturation
1         | M001        | 2024-01-15 08:00:01 | 72        | 98
2         | M001        | 2024-01-15 08:00:06 | 74        | 97
3         | M002        | 2024-01-15 08:00:02 | 68        | 99
```
Both readings with EquipmentId M001 belong to the same monitor. ReadingId identifies an observation, while EquipmentId links it to equipment and PatientId supplies the patient context through the equipment record. Timestamp distinguishes successive readings: 72 and 74 are heart-rate values at different times, not conflicting values for one attribute.

The combined properties retain their source mappings: EquipmentType comes from the equipment table and HeartRate comes from the readings table. Supported property types include string, integer, boolean, datetime, and double. Timestamp uses datetime so consumers can distinguish observations over time.

Property bindings now describe where the facts come from. You still need relationship configuration to connect separate business entities, such as Hospital to Department or equipment to Patient.

::: zone-end
