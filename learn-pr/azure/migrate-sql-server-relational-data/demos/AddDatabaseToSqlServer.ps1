param(
    [string]
    $userName,
	
  	[string]
	  $password
)

if ((Get-Command Install-PackageProvider -ErrorAction Ignore) -eq $null)
{
	# Load the latest SQL PowerShell Provider
	(Get-Module -ListAvailable SQLPS `
		| Sort-Object -Descending -Property Version)[0] `
		| Import-Module;
}
else
{
	# Conflicts with SqlServer module
	Remove-Module -Name SQLPS -ErrorAction Ignore;

	if ((Get-Module -ListAvailable SqlServer) -eq $null)
	{
		Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null;
		Install-Module -Name SqlServer -Force -AllowClobber | Out-Null;
	}

	# Load the latest SQL PowerShell Provider
	Import-Module -Name SqlServer;
}

$query = @'
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
'@


Invoke-Sqlcmd `
  -QueryTimeout 0 `
  -ServerInstance . `
  -UserName $username `
  -Password $password `
	-Query $query
	