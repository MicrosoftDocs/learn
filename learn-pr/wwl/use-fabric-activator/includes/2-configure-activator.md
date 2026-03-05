Before you can evaluate conditions and trigger actions on real-time data, you need to configure how Activator should interpret your data for rule evaluation. Rules evaluate conditions against specific data points - like "when this package's temperature exceeds 86°F" or "when any delivery takes longer than 48 hours." 

There are several ways to configure Activator for monitoring your data. One approach uses **business objects** - representing of the real-world things you want to monitor, like packages, devices, or customers.

## Understand business objects

Business objects represent the entities you want to monitor. For a package delivery company, each package becomes an **object** in Activator. Each object has **properties** which are the specific data points you want to monitor.

Here's how this organization works:

- **Objects** represent individual instances (Package001, Package002, Package003)
- **Properties** represent the data attributes for each instance (Temperature, City, DeliveryState, HoursInTransit)
- **Events** contain the actual data values that flow in from your data sources

Your data sources send events containing information for multiple packages. Activator uses this incoming data to automatically update the property values for each package object.

## Create objects from eventstreams

When you configure Activator as a destination for an eventstream, you can then create business objects in Activator. During this setup, you tell Activator which data fields represent objects and which fields are properties to evaluate.

Here's how you create objects from an eventstream:

1. **Configure Activator as a destination** - In an eventstream
2. **Open the Activator** - Then select the option to create a new object
3. **Choose your unique identifier** - Select the field that uniquely identifies the object (like PackageId or DeviceID)
4. **Select properties** - Choose which data fields you want to monitor as properties

For example, if your eventstream contains package delivery data with fields like `PackageId`, `Temperature`, `City`, `DeliveryState`, and `HoursInTransit`, you might:
- Use `PackageId` as your unique identifier to create separate package objects
- Select `Temperature` and `HoursInTransit` as properties you want to monitor
- Let Activator automatically create objects for each unique package as data flows in

:::image type="content" source="../media/create-object.png" alt-text="Screenshot showing the Activator interface for creating a new object" lightbox="../media/create-object.png":::

Once configured, your eventstream continuously feeds data to Activator. New events update existing object properties, new unique identifiers automatically create new objects, and property values always reflect the most recent data from your stream.
This configuration means your rules can evaluate conditions as soon as new data arrives.

## Alternative alerting approaches

The Activator engine also supports creating alerts. You can create dashboard alerts directly from Real-Time Dashboard visualizations, set up system event alerts to monitor Fabric workspace activities and OneLake file operations, or create query alerts from KQL Queryset results and visualizations. These approaches use the same Activator engine but interpret data differently than the business objects model.

