@description('The location into which your Azure resources should be deployed.')
param location string = resourceGroup().location

@description('Select the type of environment you want to provision. Allowed values are Production and Test.')
@allowed([
  'Production'
  'Test'
])
param environmentType string

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorLoginPassword string

@description('The tags to apply to each resource.')
param tags object = {
  CostCenter: 'Marketing'
  DataClassification: 'Public'
  Owner: 'WebsiteTeam'
  Environment: 'Production'
}

// Define the SKUs for each component based on the environment type.
var environmentConfigurationMap = {
  Production: {
    appServicePlan: {
      sku: {
        name: 'S1'
        capacity: 2
      }
    }
    sqlDatabase: {
      sku: {
        name: 'S1'
        tier: 'Standard'
      }
    }
  }
  Test: {
    appServicePlan: {
      sku: {
        name: 'F1'
        capacity: 1
      }
    }
    sqlDatabase: {
      sku: {
        name: 'Basic'
      }
    }
  }
}

// Compose the connection string using the secure password parameter and the outputs from the SQL module deployment.
var sqlDatabaseConnectionString = 'Data Source=tcp:${sql.outputs.sqlServerFullyQualifiedDomainName},1433;Initial Catalog=${sql.outputs.sqlDatabaseName};User Id=${sqlServerAdministratorLogin}@${sql.outputs.sqlServerFullyQualifiedDomainName};Password=${sqlServerAdministratorLoginPassword};'

module sql '8-module-sql.bicep' = { // TODO rename
  name: 'sql'
  params: {
    location: location
    resourceNameSuffix: resourceNameSuffix
    sqlDatabaseSku: environmentConfigurationMap[environmentType].sqlDatabase.sku
    sqlServerAdministratorLogin: sqlServerAdministratorLogin
    sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
    tags: tags
  }  
}

module appService '8-module-app-service.bicep' = { // TODO rename
  name: 'app-service'
  params: {
    appServicePlanSku: environmentConfigurationMap[environmentType].appServicePlan.sku
    location: location
    resourceNameSuffix: resourceNameSuffix
    sqlDatabaseConnectionString: sqlDatabaseConnectionString
    tags: tags
  } 
}
