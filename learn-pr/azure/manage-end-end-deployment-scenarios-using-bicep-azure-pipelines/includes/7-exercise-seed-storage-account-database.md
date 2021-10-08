1. Review the website and notice there are no products listed.
1. Update the pipeline's build stage to copy the JSON documents and product images to artifacts.
1. Update the pipeline's deployment stage to add a new script that uploads blobs from the product images artifact to the storage account name specified in the Bicep deployment outputs.
1. Update the pipeline's deployment stage to add a new script that creates Cosmos DB documents from the JSON documents artifact to the Cosmos DB container specified in the Bicep deployment outputs.
1. Run the pipeline. Notice that the test case you previously added now passes.