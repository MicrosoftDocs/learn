# Summary

In this module, you built a solution that uploads images from a simulated array of cameras to [Azure Blob Storage](https://azure.microsoft.com/services/storage/blobs/), triggers an [Azure Function](https://azure.microsoft.com/services/functions/) each time an image is uploaded, analyzes the images for polar bears using the [Custom Vision Service](https://azure.microsoft.com/services/cognitive-services/custom-vision-service/), and visualizes the output using [Microsoft Power BI](https://powerbi.microsoft.com/). You also got first-hand experience using [Azure SQL Database](https://azure.microsoft.com/services/sql-database/). It's a sophisticated solution, and one that has applications in the real world.

## Check your knowledge

1. Which of the following Azure Cloud Shell/Azure CLI commands creates an Azure storage account?
	- `az group create`
	- `az account create`
	- `az storage account create`
	- `az storage create`

1. What is the difference between precision and recall when measuring the accuracy of a machine-learning model?
	- Precision measures false positives, while recall measures false negatives
	- Precision measures false negatives, while recall measures false positives
	- Precision is a mean of false-positive rates computed across a range of thresholds
	- Recall is a mean of false-positive rates computed across a range of thresholds

1. When deploying an Azure Function, what is one reason to choose App Service Plan over Consumption Plan?
	- Functions hosted in an App Service Plan support parallel execution, while Functions hosted under the Consumption Plan do not
	- App Service Plans that host Azure Functions hosted do not incur charges
	- Functions hosted in an App Service Plan incur charges only when they execute
	- Functions hosted in an App Service Plan execute immediately when triggered
	
1. When deploying an Azure SQL Database, what is the purpose of adding a client IP address?
	- To allow other Azure services to connect to the database
	- To allow applications running on your computer to connect to the database
	- To make Microsoft aware of your computer's IP address for Windows updates
	- None of the above

1. Power BI Desktop runs on which of the following operating systems?
	- Windows only
	- Windows and macOS
	- Windows, macOS, and Linux
	- macOS and Linux