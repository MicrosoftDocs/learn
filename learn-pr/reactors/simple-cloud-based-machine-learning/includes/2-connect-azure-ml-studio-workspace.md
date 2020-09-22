To use Azure Machine Learning, you need an active Azure subscription and a Machine Learning resource. These steps walk you through the process.

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) in a new browser tab, and sign in with a Microsoft account. Search for the Machine Learning resource, and create a new one. Use the Enterprise workspace edition.

1. After the Machine Learning resource is created, go to the resource and select **Launch Now** in Azure Machine Learning Studio.

   :::image type="content" alt-text="Open Azure Machine Learning Studio" source="../media/launch-azure-ml-studio.png" loc-scope="azure":::

1. From the home page, go to **Datasets**. Locate the bank-full.csv file in the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Bank%2BMarketing?azure-portal=true). Select **From local files**, and upload the file to Azure Machine Learning Studio.

   :::image type="content" alt-text="Select the .csv file to upload to Azure Machine Learning Studio" source="../media/upload-data-set.png" loc-scope="azure":::

1. Name the dataset **bank-marketing**. Select **tabular** as the form. Choose the datastore that was created when you created the Machine Learning service in Azure. Upload the .csv file. Make sure you use the header from the file.

   :::image type="content" alt-text="Specify the settings for the uploaded .csv file" source="../media/configure-data-store.png" loc-scope="azure":::

## Explore bank-marketing data

Let's take a look at the data we uploaded to Azure Machine Learning. The data is essentially a set of calls made to customers of a particular bank.<sup>[1][^1]</sup> The goal of the calls was to upsell customers on a product or service. This dataset contains a row for each call with the demographic information of the customer in all columns, except for the final column **y**. The final column indicates whether a customer upgraded to the additional services or products.

<br>

***
References

1. _Moro, S., Cortez, P., and Rita, P. (June 2014) [A Data-Driven Approach to Predict the Success of Bank Telemarketing](http://repositorium.sdum.uminho.pt/bitstream/1822/30994/1/dss-v3.pdf). Decision Support Systems, Elsevier, 62:22-31_.


[^1]: <http://repositorium.sdum.uminho.pt/bitstream/1822/30994/1/dss-v3.pdf> "Moro, S., Cortez, P., and Rita, P. (June 2014), *A Data-Driven Approach to Predict the Success of Bank Telemarketing*. Decision Support Systems, Elsevier, 62:22-31"
