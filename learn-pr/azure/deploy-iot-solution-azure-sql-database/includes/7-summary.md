<!--
    - What are some potential other scenarios this could be used for
    - What are the modifications you may need to make depending on the scenarios
    - references
-->

Summary TODO

## References for further learning

### TODO PAIR DOWN AND REVIEW CUSTOMER STORIES DIALOG
### Customers using Azure SQL Database for IoT in production today

[RXR Realty](https://customers.microsoft.com/story/843823-rxr-realty-reopens-for-business-using-azure-iot) is the third-largest real estate owner in New York City, with over 25 million square feet of space across the tri-state area, including some of the most iconic addresses in Manhattan. When the COVID-19 pandemic hit, the company needed a way to integrate new safety measures for tenants after its buildings reopened for business. Working with key partners McKinsey & Co., Infosys, Rigado, and Microsoft, RXR used Microsoft Azure to create and deploy an intelligent, secure, hyperscalable solution—in just a few months.

The solution is named RxWell™—a comprehensive, public-health–based, data-driven program that merges physical and digital assets to help keep employees informed and supported during the “new abnormal” and beyond. Powered by the Internet of Things (IoT) and the intelligent edge, and firmly rooted in responsible artificial intelligence (AI) principles, RxWell combines real-time computer vision, sensors, AI, mobile apps and dashboards, and in-person service offerings. And Azure is making it all possible.

:::image type="content" source="../media/7-rxwell.png" alt-text="RXWells's IoT solution architecture." border="false":::

RXR Realty is using Azure SQL Database as warm storage where events flow through Azure Stream Analytics and Azure Function to power [multiple dashboards and reporting applications](https://www.youtube.com/watch?v=4SWNTqgjjyU) on mobile and embedded devices on-site.

[Schneider Electric](https://customers.microsoft.com/story/778456-schneider-electric-thoughtwire-healthcare-azure-iot), and his partner ThoughtWire, created an end-to-end solution for facilities and clinical operations management in healthcare settings. The solution uses Internet of Things (IoT) technology and Microsoft Azure cloud services to help hospitals and clinics reduce costs, minimize their carbon footprint, promote better patient experiences and outcomes, and increase staff satisfaction. The ThoughtWire application suite uses Azure Virtual Machines infrastructure as a service (IaaS) capabilities to run virtual and containerized workloads that support the ThoughtWire digital twin platform and Smart Hospital Suite in Azure. It also uses Azure SQL Database, which provides the right security controls for solution benefits like encrypting data at rest.

[HB Reavis](https://customers.microsoft.com/story/789851-hb-reavis-smart-spaces-azure-powerbi-slovakia) uses the power of Microsoft Azure IoT Hub, Azure SQL Database, and Stream Analytics. It captures complex IoT metrics essential for monitoring and analyzing diverse aspects of efficient workspace, such as office utilization, environmental insights (CO2, temperature, humidity), and general team dynamics and interactions. Once this data is collected, the platform converts it into actionable insights and visualizes the results on interactive Microsoft Power BI dashboards.

[VERSE Technology](https://customers.microsoft.com/story/823744-verse-technology-manufacturing-azure-iot-en) is building an edge-to-cloud solution based on Microsoft Azure for one of the world’s largest baking companies, Grupo Bimbo. In the past year it has converted 15 factories, with many more scheduled soon. Now, with all this data being processed, analyzed, and visualized in real time, Bimbo can get an unprecedented, accurate picture of the company’s production process and begin transforming its business.

:::image type="content" source="../media/7-verse.png" alt-text="VERSE Technology's edge-to-cloud solution architecture." border="false":::

VERSE has designed a connected cloud solution for Bimbo based on Azure. Azure IoT Hub connects all the data streamed to the platform from different edge devices and sensors. Azure SQL Database is the highly scalable solution for storing RPMs, temperature, gas consumption, and more. This first phase encompasses more than 1,000 devices at the edge, with a range of communication protocols––RF, cellular, and Wi-Fi according to the needs of the location. The company plans to expand to more than 10,000 devices soon.

### Ingest millions of events per second

By adopting the shock absorber design pattern for your IoT solutions, you can leverage a familiar relational engine environment while scaling to billions of events ingested per day and terabytes of compressed historical data stored. As a reference, look at this [packaged sample where we achieved a sustained 4.2 million events per second rate on average on a M-series 128 cores database](https://techcommunity.microsoft.com/t5/azure-sql-database/scaling-up-an-iot-workload-using-an-m-series-azure-sql-database/ba-p/1106271).

### Optimize storage for large volumes of IoT data

In a benchmarking [exercise](https://devblogs.microsoft.com/azure-sql/json-in-your-azure-sql-database-lets-benchmark-some-options/) on real world IoT solution data, the Azure SQL team was able to achieve ~25x reduction in storage usage by storing 3 million, 1.6KB messages (around 5GB total amount) in a ~200MB columnstore-based table.