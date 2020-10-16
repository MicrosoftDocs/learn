Now that you have finished joining and transforming the dataset, it is imperative to write the newly created dataset into a destination store. 

The way to do so is using the sink transformation option in Azure Data Factory. 

Each time you’re using dataflow, it requires at least one sink transformation, however if you want to write multiple sinks to complete the transformation flow, that is also possible. 

The way to do so is to write additional sinks and creating new streams through new branches and conditional splits. 

When looking at sink transformations, every sink is associated to one Azure Data Factory dataset or linked service. 
So each sink transformation determines the location as well as the shape of the data that you are going or want to write to. 
Therefore, if you’re writing to Azure Synapse Analytics, the datasets need to be compatible with that location. 

Mapping Data flow, that follows an ELT approach and works on staging dataset that is in Azure, currently the datasets that can be used in a source transformation for Synapse Analytics is the dataset option. 
Other sources might allow you to choose inline, or a common data model approach. 
