Azure supports a wide variety of public sector use cases. These use cases include rigorous data protection requirements across many different data classifications, including unclassified and classified data. The following are just a few of the scenarios in which Azure enables public sector customers to use the scale and economic benefits of multi-tenant cloud services.

## Processing highly sensitive or regulated data on Azure Stack Hub

Microsoft provides Azure Stack Hub as an on-premises, cloud-consistent experience for customers who can't directly connect to the internet, or where certain workload types must be hosted in-country/region because of law, compliance, or sentiment. Azure Stack Hub offers IaaS and PaaS services and shares the same APIs as the global Azure cloud. Azure Stack Hub is available in scale units of 4, 8, and 16 servers in a single-server rack. It's also available as four servers in a military-specification, ruggedized set of transit cases, or multiple racks in a modular datacenter configuration.

Azure Stack is a solution for customers who operate in scenarios where:

* Microsoft doesn't have an in-country/region cloud presence and therefore can't meet data sovereignty requirements.
* For compliance reasons, the customer can't connect their network to the public internet.
* For geo-political or security reasons, Microsoft can't offer connectivity to other Microsoft clouds.
* For geo-political or security reasons, the host organization may require cloud management by non-Microsoft entities, or in-country/region by security-cleared personnel.
* Cloud management would pose significant risk to the physical well-being of Microsoft resources operating the environment.

For most of these customers, Microsoft and its partners offer a customer-managed, Azure Stack Hub-based private cloud appliance on field-deployable hardware from [major vendors](https://azure.microsoft.com/products/azure-stack/hub/#partners) such as Avanade, Cisco, Dell EMC, Hewlett Packard Enterprise, and Lenovo. Azure Stack Hub is manufactured, configured, and deployed by the hardware vendor. It can be ruggedized and security-hardened to meet many different environmental and compliance standards. Including, the ability to withstand transport by aircraft, ship, or truck, and deployment into colocation, mobile, or modular datacenters. Azure Stack Hub can be used in exploration, construction, agriculture, oil and gas, manufacturing, disaster response, government efforts, and military efforts in the most extreme conditions and remote locations. Azure Stack Hub allows customers the full autonomy to monitor, manage, and provision their own private cloud resources while meeting their connectivity, compliance, and ruggedization requirements.

## Machine learning model training

[AI](/training/modules/azure-artificial-intelligence/1-introduction-to-azure-artificial-intelligence) holds tremendous potential for governments. [Machine learning](/training/modules/azure-artificial-intelligence/3-machine-learning) is a data science technique that allows computers to learn to use existing data, without being explicitly programmed, to forecast future behaviors, outcomes, and trends. [Machine learning technologies](/azure/architecture/data-guide/technology-choices/data-science-and-machine-learning) can also discover patterns, anomalies, and predictions that can help governments in their missions. As technical barriers continue to fall, decision-makers face the opportunity to develop and explore transformative AI applications. There are five main vectors that can make it easier, faster, and cheaper to adopt machine learning:

* Unsupervised learning.
* Reducing need for training data.
* Accelerated learning.
* Transparency of outcome.
* Deploying closer to where data lives.

In the following sections, we expand on areas that can help government agencies with some of the above vectors.

## IoT analytics

In recent years, we have been witnessing massive proliferation of Internet of Things (IoT) devices and sensors. In almost all cases, these sensors gather signals and data from the environments and conditions they're designed for. The spectrum of capabilities for IoT sensors expands from measuring the level of moisture in soil all the way to gathering intelligence at 5,000-meters altitude. The volume of data collected and the many potential uses for it make data-analysis tools and procedures more important than ever.

Governments are increasingly employing IoT devices for their missions, which could include maintenance predictions, borders monitoring, weather stations, smart meters, and field operations. In many cases, the data is often analyzed and inferred from where it's gathered. The main challenges of IoT analytics are: 

* Large amount of data from independent sources.
* Analytics at the edge and often in disconnected scenarios.
* Data and analysis aggregation.

With innovative solutions such as [Azure IoT Hub](https://azure.microsoft.com/services/iot-hub/) and [Azure Stack Edge](https://azure.microsoft.com/products/azure-stack/edge/), Azure services are well positioned to help governments with these challenges.

## Precision agriculture with Farm Beats

Agriculture plays a vital role in most economies worldwide. In the US, over 70% of rural households depend on agriculture, which contributes about 17% to the total GDP and provides employment to over 60% of the population. In project [Farm Beats](https://www.microsoft.com/research/project/farmbeats-iot-agriculture/), we gather large amounts of data from farms that we couldn't get before, and then by applying AI and machine learning algorithms we can turn this data into actionable insights for farmers. We call this technique data-driven farming.

What we mean by data-driven farming is the ability to map every farm and overlay it with data. For example, what is the soil moisture level 15 cm below soil, what is the soil temperature 15 cm below soil, and so on. These maps can then enable techniques, such as precision agriculture, which has been shown to improve yield, reduce costs, and benefit the environment.

Despite the fact the precision agriculture as a technique was proposed more than 30 years ago, it hasn't taken off. The biggest reason is the inability to capture large amounts of data from farms to accurately represent the conditions in the farm. Our goal as part of the Farm Beats project is to be able to accurately construct these precision maps at a fraction of the cost.

## Unleashing the power of analytics with synthetic data

Synthetic data is data that is artificially created rather than generated by actual events. It's often created with the help of computer algorithms and it's used for a wide range of activities, including usage as test data for new products and tools, as well as for machine learning models validation and improvements. Synthetic data can meet specific needs or conditions that aren't available in existing real data. For governments, the nature of synthetic data removes many barriers and helps data scientists with privacy concerns, accelerated learning, and data volume reduction needed for the same outcome. The main benefits of synthetic data are:

* Overcoming restrictions: Real data may have usage constraints from privacy rules or other regulations. Synthetic data can replicate all important statistical properties of real data without exposing real data.
* Scarcity: Providing data where real data doesn't exist for a given event.
* Precision: Synthetic data is perfectly labeled.
* Quality: The quality of synthetic data can be precisely measured to fit the mission conditions.

Synthetic data can exist in several forms, including text, audio, video, and hybrid.

## Knowledge mining

The exponential growth of unstructured data gathering in recent years has created many analytical problems for government agencies. This problem intensifies when data sets come from diverse sources such as text, audio, video, imaging, and so on. *Knowledge mining* is the process of discovering useful knowledge from a collection of different data sources. This widely used data mining technique is a process that includes data preparation and selection, data cleansing, incorporation of prior knowledge on data sets, and interpretation of accurate solutions from the observed results. This process has proven to be useful for large volumes of data in different government agencies.

For instance, captured data from the field often includes documents, pamphlets, letters, spreadsheets, propaganda, videos, and audio files across many disparate structured and unstructured formats. Buried within the data are [actionable insights](https://www.youtube.com/watch?v=JFdF-Z7ypQo) that can enhance effective and timely response to crisis and drive decisions. The goal of knowledge mining is to enable decisions that are better, faster, and more humane by implementing proven commercial algorithm-based technologies.

## Scenarios for confidential computing

Security is a key driver accelerating the adoption of cloud computing, but it's also a major concern when customers are moving sensitive IP and data to the cloud.

Azure provides broad capabilities to secure data at rest and in transit, but sometimes the requirement is also to protect data from threats as it’s being processed. Microsoft [confidential computing](/azure/confidential-computing/) is designed to address this scenario by performing computations in a hardware-based trusted execution environment (TEE, also known as enclave) based on [Intel Software Guard Extensions](https://software.intel.com/content/www/us/en/develop/topics/software-guard-extensions.html) (SGX) technology. The hardware provides a protected container by securing a portion of the processor and memory. Only authorized code is permitted to run and to access data, so code and data are protected against viewing and modification from outside of TEE.

TEEs can directly address scenarios involving data protection while in use. For example, consider the scenario where data coming from a public or unclassified source needs to be matched with data from a highly sensitive source. Using confidential computing can enable that matching to occur in the public cloud while protecting the highly sensitive data from disclosure. This is a common circumstance in highly sensitive national/regional security and law enforcement scenarios.

A second scenario involves data coming from multiple sources that needs to be analyzed together, even though none of the sources have the authority to see the data. Each individual provider encrypts the data they provide and only within the TEE is that data decrypted. As such, no external party and even none of the providers can see the combined data set. This capability is valuable for secondary use of healthcare data.

Now, let's review what you've learned with a knowledge check.
