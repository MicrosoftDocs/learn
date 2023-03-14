Tailwind Traders owns a fleet of delivery vehicles that transport products from warehouses to distribution centers, and from distribution centers to stores and homes. The company is looking for a complete logistics solution that takes data sent from an onboard vehicle computer and turns it into actionable information.

Furthermore, shipments can be outfitted with sensors from a third-party vendor to collect and monitor ambient conditions. These sensors can collect information such as the temperature, humidity, tilt, shock, light, and the location of a shipment.

A few goals of this logistics system include:

- Shipment monitoring with real-time tracing and tracking.
- Shipment integrity with real-time ambient condition monitoring.
- Security from theft, loss, or damage of shipments.
- Geo-fencing, route optimization, fleet management, and vehicle analytics.
- Forecasting for predictable departure and arrival of shipments.

The company would prefer a prebuilt solution to collect the sensor and vehicle computer data, and provide a graphical user interface that displays reports about shipments and vehicles.

## Which service should you choose?

Here again, apply the decision criteria that you learned about earlier.

First, is it critical to ensure that the device isn't compromised? Ideally, each sensor and vehicle computer would be impervious to interference. However, security wasn't mentioned as a critical concern at this point. The vehicle computers and sensors are built by a third-party vendor. So, Tailwind Traders is forced to use hardware that's already available, unless it wants to manufacture its own devices.

Second, does Tailwind Traders need a dashboard for reporting and management? Yes, a reporting and management dashboard is a requirement.

Based on these responses to the decision criteria, Azure IoT Central is the best choice in this scenario. The Connected Logistics starter template provides an out-of-box dashboard that satisfies many of these requirements. This dashboard is preconfigured to showcase the critical logistics device operations activity. Admittedly, the dashboard might need to be modified to remove sea vessel gateways, but the truck gateway functionality would be almost exactly what Tailwind Traders needs.

## Why not use IoT Hub?

If Tailwind Traders uses IoT Central, the company would actually be using an IoT hub that's preconfigured for its specific needs. By using the Connected Logistics starter template. Otherwise, the company would require custom development to build its own cloud-based dashboards and management systems on top of Azure IoT Hub.

## Why not use Azure Sphere?

Azure Sphere provides a complete solution for scenarios where security is critical. In this scenario, security is ideal, but not a critical priority for Tailwind Traders. Although Azure Sphere provides an end-to-end solution that includes hardware, the company uses hardware from a third-party vendor. So, in this scenario, Azure Sphere isn't necessary.
