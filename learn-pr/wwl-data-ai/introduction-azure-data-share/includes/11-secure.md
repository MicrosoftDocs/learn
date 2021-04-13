One thing that is a significant concern of many data providers as well as consumers is security. 

Azure Data Share however, leverages the security that Azure offers in relation to the protection of data at rest and in transit. 

The data that is shared or received is encrypted at rest, if it is supported by the underlying datastore. An example could be that if you share a dataset from an Azure Data Lake storage, the dataset that you share will be encrypted at rest and in transit since Azure Data Lake Storage supports data encrypted at rest and in transit.  

When it comes to Access Control, you are able to set it on the Azure Data Share resource level to make sure that only the people who are authorized have access, are able to access it. In addition to that, Azure Data Share uses managed identity to access data stores in which the data resides for the use of data sharing. The reason why it is easy to configure a data share, is because there is no need to exchange credentials between you as data provider, or you as a data consumer. 

For business continuity for Azure Data Share, it might be worth configuring disaster recovery environment for Azure Data Share. Even though Azure Data Center outages are rare, it could cause disruptions in environments where there is dependency for data being shared by provider as well as consumer, therefore it’s been made possible that as a data provider, you can have a data share environment provisioned in a secondary region to make sure that in case such an event does occur, there will be a smooth failover. 

The resources of data share that can be configured are shares and datasets that are existent in the primary Azure Data Share resource. Your data consumers are still able to get access to the data that you shared if you invite them to the secondary shares once you’ve configured the Disaster Recovery environment in which snapshots schedules can still be enabled as part of failover (an active share subscription that is idle for DR). When the data consumer does not want to subscribe to the secondary region, you could invite them to the secondary later as part of a manual failover step.
