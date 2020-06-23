To be able to use Azure Machine Learning you will need active Azure subscription and a Machine Learning Resource. These steps will walk you through that.

1. Open [Azure](https://portal.azure.com?azure-portal=true) in a new browser tab and sign in with a Microsoft account. Search for the Machine Learning resource and create a new one. We recommend using Enterprise workspace edition.

1. After the Machine Learning Resource is created, go to the Resource and select **Launch Now** on the Azure Machine Learning Studio.

   :::image type="content" alt-text="Launch Azure Machine Learning Studio" source="../media/launch-azure-ml-studio.png" loc-scope="azure":::

1. From the homepage, navigate to the **Datasets**. Locate the bank-full.csv file on the [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Bank%2BMarketing?azure-portal=true). Select **From local files** and upload the file to Azure Machine Learning Studio.

   :::image type="content" alt-text="Select the CSV file to upload to Azure Machine Learning Studio" source="../media/upload-data-set.png" loc-scope="azure":::

1. Name the dataset **bank-marketing**. Choose **tabular** as the form. Choose the previously created datastore (one was created when you created the Machine Learning Service in Azure). Upload the CSV file. Make sure you use the header from the file.

   :::image type="content" alt-text="Specify the settings for the uploaded CVS file" source="../media/configure-data-store.png" loc-scope="azure":::

## Explore bank-marketing data

Let's take a look at the data we uploaded to Azure Machine Learning. The data is essentially a set of calls made to customers of a particular bank.<sup>[1][^1]</sup> The goal of the calls was to upsell customers on a product or service. This data set contains a row for each call with the demographic infromation of the customer in all columns, except for the final column **y**. The final column indicates whether a customer ended up upgrading to the additional services or products.

***
References

1. _Moro, S., Cortez, P., and Rita, P. (June 2014) [A Data-Driven Approach to Predict the Success of Bank Telemarketing](http://media.salford-systems.com/video/tutorial/2015/targeted_marketing.pdf). Decision Support Systems, Elsevier, 62:22-31_

***

[^1]: <http://media.salford-systems.com/video/tutorial/2015/targeted_marketing.pdf> "Moro, S., Cortez, P., and Rita, P. (June 2014), *A Data-Driven Approach to Predict the Success of Bank Telemarketing*. Decision Support Systems, Elsevier, 62:22-31"
