Exercise - Simulating a Production Environment

The world doesn't stand still with data. Now that we essentially have a flowing pipeline of data in place, we will simulate some new data as well as delta files coming through to the ADLSv2 from our scheduled Azure Data Factory pipelines. 

Run the following Powershell command to upload new files to Purview. 

You can either wait until the next Purview Scan occurs and picks up these files, or you can run a manual scan and not wait. 

Once the new assets have been picked up in Purview, in approximately 30 seconds, you should also see that new file in CluedIn, ready to ingest. If you head to the settings section of CluedIn you can enable auto-integration and mapping or like you did in the exercise before, you can create the ingestion endpoint and use the automapping feature in CluedIn to onboard the new data. 

For the first new file called Companies.csv, it should have automatically mapped to an Organization, chosen the Entity Codes, Edges and Properties and been ingested. If this is the case, you should be able to simply look in your ADLSv2 that your Organization.parquet now has 1045 records instead of the 1000. You should also see that the cleaning that we did on the 1000 records have automatically been applied to the 45 records and they do not have those problems anymore. We should also see that our enrichment services have auto-completed the values that we did not have. 

As for the Vendors.xslx, we shoudl see that Purview has automatically detected a new file in the Mastered folder called Vendors.parquet with full visibilty over lineage, data quality, ownership and more. 

Further your learning with other references

 - CluedIn Master Data Management Reference Architecture
 - Migrate Master Data Services to CluedIn with Azure Purview