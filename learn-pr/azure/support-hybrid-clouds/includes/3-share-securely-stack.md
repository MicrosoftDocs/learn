Azure Stack Edge supports the storage and processing of highest classification data but also allows customers to upload resulting information or models directly to Azure. This approach creates a path for information sharing between domains that makes it easier and more secure.

## Azure Stack Edge

Azure Stack Edge is an AI-enabled edge computing device with network data transfer capabilities. It allows customers to pre-process data at the edge and move data to Azure efficiently. Azure Stack Edge uses advanced Field-Programmable Gate Array (FPGA) hardware natively integrated into the appliance to run machine learning algorithms at the edge efficiently. The size and portability allow customers to run Azure Stack Edge as close to users, apps, and data as needed. Figure 3 shows Azure Stack Edge capabilities and key use cases.

The ability to gather, discern, and distribute mission data is key to making critical decisions. Tools that help process and transfer data directly at the edge make this possible. For example, Azure Stack Edge, with its light footprint and built-in hardware acceleration for machine learning inferencing, is useful to further the intelligence of forward-operating units or similar mission needs with AI solutions designed for the tactical edge. Data transfer from the field, which is traditionally complex and slow, is made seamless with the [Azure Data Box](https://azure.microsoft.com/services/databox/) family of products.

## Key use cases

Together with Azure Stack Hub, Azure Stack Edge unites the best of edge and cloud computing to unlock never-before-possible capabilities such as synthetic mapping and machine learning model inferencing. From submarines to aircraft to remote bases, Azure Stack Hub and Azure Stack Edge allow customers to harness the power of cloud at the edge.

Key [uses cases](https://docs.microsoft.com/azure/databox-online/azure-stack-edge-overview#use-cases) for Azure Stack Edge include:

* **Preprocess data:** Analyze data from on-premises or IoT devices to quickly obtain results while staying close to where data is generated. Azure Stack Edge transfers the full data set (or just the necessary subset of data when bandwidth is an issue) to the cloud to perform more advanced processing or deeper analytics. Preprocessing can be used to aggregate data, modify data (for example, remove Personally Identifiable Information or other sensitive data), transfer data needed for deeper analytics in the cloud, and analyze and react to IoT events.
* **Inference Azure Machine Learning:** Inference is a part of deep learning that takes place after model training, such as the prediction stage resulting from applying learned capability to new data. For example, it's the part that recognizes a vehicle in a target image after the model has been trained by processing many tagged vehicle images, often augmented by computer synthesized images (synthetics). With Azure Stack Edge, customers can run machine learning models to get results quickly and act on them before the data is sent to the cloud. The necessary subset of data (in case of bandwidth constraints) or the full data set is transferred to the cloud to continue to retrain and improve customer's machine learning models.
* **Transfer data over network to Azure:** Use Azure Stack Edge to transfer data to Azure to enable further compute and analytics or for archival purposes.

Next, let's explore a conceptual architecture for classified workloads.
