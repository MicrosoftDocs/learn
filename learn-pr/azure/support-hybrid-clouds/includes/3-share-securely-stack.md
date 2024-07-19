Azure Stack Edge supports the storage and processing of highest classification data but also allows customers to upload the resulting information or models directly to Azure. This approach creates a path for information sharing between domains that makes it easier and more secure.

## Azure Stack Edge

:::row:::
:::column span="2":::
Azure Stack Edge is an AI-enabled edge computing device with network data transfer capabilities. It allows customers to preprocess data at the edge and move data to Azure efficiently. The size and portability allows customers to run Azure Stack Edge as close to users, apps, and data as needed.

The ability to gather, discern, and distribute mission data is key to making critical decisions. Tools that help process and transfer data directly at the edge make these capabilities possible. For example, Azure Stack Edge, with its light footprint and built-in hardware acceleration for machine learning inferencing, is useful to further the intelligence of forward-operating units with AI solutions designed for the tactical edge. Data transfer from the field, which is traditionally complex and slow, is made seamless with the [Azure Data Box](https://azure.microsoft.com/services/databox/) family of products.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/azure-stack-edge-capabilities.png" alt-text="Azure Stack Edge capabilities.":::
Infographic shows an illustration of an AI-enabled edge computing appliance with Network data transfer capabilities on the left side. On the right, are three icons representing the Azure Stack Edge capabilities. The first icon is labeled "Data preprocessing at the edge." The second icon is labeled "Machine learning at the edge." The third icon is labeled "Network data transfer from edge to cloud."
:::image-end:::
:::column-end:::
:::row-end:::

## Key use cases

Together with Azure Stack Hub, Azure Stack Edge unites the best of edge and cloud computing to unlock never-before-possible capabilities such as synthetic mapping and machine learning model inferencing. From submarines to aircraft to remote bases, Azure Stack Hub and Azure Stack Edge allow customers to harness the power of cloud at the edge.

Key [use cases](/azure/databox-online/azure-stack-edge-gpu-overview#use-cases) for Azure Stack Edge include:

* **Preprocess data:** Analyze data from on-premises or IoT devices to quickly obtain results while staying close to where data is generated. Azure Stack Edge transfers the full data set (or just the necessary subset of data when bandwidth is an issue) to the cloud to perform more advanced processing or deeper analytics. Preprocessing can be used to aggregate data, modify data (for example, removing personal or sensitive information), and transfer data needed for deeper analytics in the cloud. It can also be used to analyze and react to IoT events.
* **Inference Azure Machine Learning:** Inference is a part of deep learning that takes place after model training, such as the prediction stage resulting from applying learned capability to new data. For example, it's the part that recognizes a vehicle in a target image after the model is trained by processing many tagged vehicle images, often augmented by computer synthesized images (synthetics). With Azure Stack Edge, customers can run machine learning models to get results quickly and act on them before the data is sent to the cloud. The necessary subset of data (if there are bandwidth constraints) or the full data set, is transferred to the cloud to continue to retrain and improve the customer's machine learning models.
* **Transfer data over network to Azure:** Use Azure Stack Edge to transfer data to Azure to enable further compute and analytics or for archival purposes.

Next, let's explore a conceptual architecture for classified workloads.