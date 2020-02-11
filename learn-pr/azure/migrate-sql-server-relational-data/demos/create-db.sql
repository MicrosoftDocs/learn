CREATE DATABASE Social;
GO

USE Social;
GO

CREATE TABLE dbo.Twitters (
  TwitterKey INT IDENTITY PRIMARY KEY
, Handle     NVARCHAR(256)
, Link       NVARCHAR(256)
)
GO

INSERT dbo.Twitters
  (Handle, Link)
VALUES
  ('Azure Data Factory', 'https://twitter.com/DataAzure')
, ('Azure Data Studio', 'https://twitter.com/AzureDataStudio')
, ('Azure SQL Database', 'https://twitter.com/AzureSQLDB')
, ('Azure Portal', 'https://twitter.com/AzurePortal')
, ('Microsoft Azure', 'https://twitter.com/Azure')
, ('Azure Cosmos DB', 'https://twitter.com/AzureCosmosDB')
, ('SQL Docs', 'https://twitter.com/SQLDocs')
, ('Microsoft SQL Server', 'https://twitter.com/SQLServer')
GO