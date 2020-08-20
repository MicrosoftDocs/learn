Tailwind Traders owns a fleet of delivery vehicles that transport products from warehouses to distribution centers, and from distribution centers to stores and homes.  They're looking for a complete logistics solution that takes data sent from an onboard vehicle computer and turns it into actionable information.

Furthermore, shipments can be outfitted with sensors from a third-party vendor to collect and monitor ambient conditions.  These sensors might collect information like the temperature, humidity, tilt, shock, light, and the location of a shipment.  

A few goals of this logistics system include:

- Shipment monitoring with real-time tracing and tracking.
- Shipment integrity with real-time ambient condition monitoring.
- Security from theft, loss, or damage of shipments.
- Geo-fencing, route optimization, fleet management, and vehicle analytics.
- Forecasting for predictable departure and arrival of shipments.

They would prefer a pre-built solution to collect the sensor and vehicle computer data, and provide a graphical user interface where they can view reports about shipments and vehicles.

## Which service should we choose?

Here again, let's apply the decision criteria from a previous unit.

Is it critical to ensure that the device, in this case, each appliance, is not compromised?  Ideally, each sensor and vehical computer would be impervious to interference.  However, security was not mentioned as a critical concern at this point.  The vehical computers and sensors are built by a third-party vendor, and unless Tailwind Traders wants to manufacture their own devices (which they don't), they will be forced to use the hardware already available.

Next, do they need a dashboard for reporting and management?  Yes, a reporting and management dashboard is a requirement from Tailwind Traders.

So, given the responses to the decision criteria, Azure IoT Central is the best choice in this scenario.  The Connected Logistics starter template provides an out-of-the-box dashboard that will accomplish many of these requirements.  This dashboard is pre-configured to showcase the critical logistics device operations activity.  Admittedly, it might need to be reconfigured to remove sea vessel gateways, but the truck gateway functionality would be almost exactly what Tailwind Traders needs.

## Why not use IoT Hub?

Actually, by using IoT Central, Tailwind Traders would be using IoT Hub, preconfigured for their specific needs by the Connected Logistics starter template.

## Why not use Azure Sphere?

Azure Sphere provides a complete solution for scenarios where security is critical.  In this scenario, security is ideal, but not a critical priority.  Azure Sphere provides an end-to-end solution including hardware.  However, Tailwind Traders will use hardware from a third-party vendor.  So, in this scenario, Azure Sphere is not necessary.