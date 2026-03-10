Whether you build your ontology manually or generate it from a semantic model, entity types need data bindings before they can be queried. If you followed the manual path, you haven't configured any bindings yet—this unit covers how to create them. If you generated from a semantic model, static bindings were configured automatically, but you still need to add time series bindings for the VitalSignsReadings eventhouse data. Both paths meet here.

## Understand data bindings

Data bindings map each property in your ontology to a specific column in your source tables. You're telling the system: "When someone queries HospitalName, read it from the HospitalName column in the hospitals table." Without these mappings, your ontology has structure but no way to retrieve actual values.

For example, a Hospital entity type with properties like HospitalName, City, and State needs bindings specifying which lakehouse or eventhouse table and columns contain actual hospital information. The binding connects your business vocabulary (the property names in the ontology) to your physical data storage (the columns in OneLake tables).

Two binding types serve different data characteristics:

**Static bindings** connect to data that changes infrequently. Hospital names, department locations, room numbers—these characteristics stay relatively stable. Static data lives in lakehouse tables, structured, and ready for binding. A HospitalName property binds to the HospitalName column in your hospitals table, telling the ontology where to find that information.

**Time series bindings** connect to streaming data arriving continuously. For example, patient vital signs captured every few seconds, equipment temperature readings, sensor data—these observations arrive timestamped. Time series data lives in eventhouse tables designed for high-volume streaming. The binding links timestamped observations to properties that track values changing over time.

Both binding types establish an entity type key—the property or properties uniquely identifying each entity instance. For example, for hospitals, HospitalId serves as the key. For patient vital signs, PatientId contextualizes which patient's readings you're observing.

## Configure static data bindings

Static data bindings connect entity properties to lakehouse tables. Selecting an entity type opens the configuration pane where the Bindings tab manages data connections.

:::image type="content" source="../media/binding-configuration.png" alt-text="Screenshot showing the Entity type configuration pane open on the Bindings tab, showing the Add data to entity type button." lightbox="../media/binding-configuration.png":::

Selecting **Add data to entity type** opens the OneLake catalog, where you choose your data source. For static bindings, select the lakehouse. 

:::image type="content" source="../media/onelake-catalog-picker.png" alt-text="Screenshot showing the OneLake catalog picker showing LamnaHealthcareLH (Lakehouse) and LamnaHealthcareEH (Eventhouse) as available data sources." lightbox="../media/onelake-catalog-picker.png":::

You then choose the specific table to bind to, as shown below.

:::image type="content" source="../media/choose-data-source.png" alt-text="Screenshot showing the Choose data source screen showing LamnaHealthcareLH selected with dbo/hospitals as the chosen table." lightbox="../media/choose-data-source.png":::

After you select the table, the interface maps source columns to entity properties. Once complete, the binding looks like this.

:::image type="content" source="../media/binding-completed.png" alt-text="Screenshot showing the property binding screen showing source columns fully mapped to entity property names with data types displayed." lightbox="../media/binding-completed.png":::

After saving, you configure the entity type key to identify which property uniquely identifies each instance, as shown below.

:::image type="content" source="../media/entity-key-configuration.png" alt-text="Screenshot showing the key configuration screen showing property selection for the entity type key." lightbox="../media/entity-key-configuration.png":::

Each entity type needing static data—hospitals, departments, rooms, patients—follows this binding process to connect structure to lakehouse tables.

## Add time series data bindings

Some entities need both static data (information that rarely changes) and time-series data (measurements arriving continuously). For example, vital sign monitoring equipment has static attributes like which patient it's monitoring and what type of equipment it is, plus streaming measurements like current heart rate and oxygen levels updating every few seconds.

This requires binding the entity to two different tables: static data from a lakehouse table and time-series measurements from an eventhouse table.

### Understand the dual-binding pattern

Consider vital sign monitoring equipment: the equipment itself is defined in one data source, and the readings it generates are stored in another, related to it by EquipmentId.

**VitalSignEquipment.csv** (Lakehouse - Static attributes):
```
EquipmentId | PatientId | EquipmentType      | MonitoringStartDate
M001        | 5         | HeartRateMonitor   | 2024-01-15
M002        | 8         | OxygenMonitor      | 2024-01-16
```
This defines each monitor with contextual information: which patient the device monitors, what type of equipment it is, and when monitoring started. This is the VitalSignEquipment entity's stable identity.

**VitalSignsReadings.csv** (Eventhouse - Streaming measurements):
```
ReadingId | EquipmentId | Timestamp           | HeartRate | OxygenSaturation
1         | M001        | 2024-01-15 08:00:01 | 72        | 98
2         | M001        | 2024-01-15 08:00:06 | 74        | 97
3         | M002        | 2024-01-15 08:00:02 | 68        | 99
```
This contains only measurements with timestamps—no patient information, room number, or equipment type. Just the measurements and an EquipmentId linking back to the equipment entity.

You need both bindings because the time-series data intentionally doesn't duplicate context—it focuses on measurements. The static binding creates the complete equipment entities (M001 is a HeartRateMonitor tracking Patient 5). The time-series binding adds continuously updating measurement properties to those entities.

**Static binding must come first.** Time-series data needs to exist entities to attach to. The system uses EquipmentId from your static binding to match streaming readings to the correct equipment entity. Without the static binding establishing entity M001 first, the system has no entity to attach those readings to.

### Configure a time series binding

To configure a time series data binding, follow the same steps as a static binding—select **Add data to entity type**, choose the *eventhouse* (LamnaHealthcareEH) from the OneLake catalog, then select the VitalSignsReadings table. The difference appears on the **Configure data binding** screen.

Select **Timeseries** as the binding type, then choose the timestamp column—in this case, **Timestamp**. The interface then separates properties into two groups: **Static** (for the linking key, EquipmentId) and **Timeseries** (for the measured values, such as HeartRate and OxygenSaturation), as shown below.

:::image type="content" source="../media/time-series-binding.png" alt-text="Screenshot of Configure data binding with Timeseries type and properties divided into Static and Timeseries sections." lightbox="../media/time-series-binding.png":::

The static property in a time series binding is the linking key—not a new static data binding, but the column that connects each reading back to its equipment entity. The timeseries properties are the measurements that update with each new reading.

With entity types connected to their data sources, the next step is configuring relationship bindings—specifying which table contains the connections between entity types so the ontology knows which specific hospital contains which departments, which rooms hold which patients.
