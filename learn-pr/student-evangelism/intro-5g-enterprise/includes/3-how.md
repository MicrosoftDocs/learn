Let us first recap the elements of the scenario we have considered for the 3D warehousing application.

Autonomous robots communicate with each other over the vertical space in the warehouse. When the robots can function correctly, you can reduce costs, strengthen the supply chain, reduce lead times for order fulfillment, increase employee efficiency and improve safety. To achieve these goals, you need to deploy low latency networking technology, integrate it with familiar Azure tools, and provide a standard dashboard for management. 

For the success of this complex and delicate operation, you need resilient wireless connectivity and low latency. Let us now approach this scenario from the perspective of three networking technologies, that is, wi-fi, LTE, and 5G.

- **Wi-fi** connectivity is the default, but it is not practical due to bandwidth and latency limitations.
- **LTE:** The next best option is LTE. LTE is a viable option and will be used even when 5G connectivity is available. Using Azure private MEC for LTE, it is possible to deploy the service. However, connectivity and latency are impacted depending on the density of the robots. 
- **5G:** Azure private MEC with 5G overcomes both the latency and the density issues and is ideal for the 3D warehousing scenario.

In addition, other Azure services can be used to create an end-to-end solution. For example, Azure Stack Edge could provide the local data processing capabilities and implement the analytics required. The Metaswitch Packet Core could be used. You could implement security using Azure Sphere, and you could use IoT Central for the management of the IoT devices. 