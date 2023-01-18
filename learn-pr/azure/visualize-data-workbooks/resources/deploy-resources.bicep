@description('Application Name')
@maxLength(30)
param applicationName string = 'to-do-app${uniqueString(resourceGroup().id)}'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('App Service Plan\'s pricing tier. Details at https://azure.microsoft.com/en-us/pricing/details/app-service/')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P4'
])
param appServicePlanTier string = 'F1'

@description('App Service Plan\'s instance count')
@minValue(1)
@maxValue(3)
param appServicePlanInstances int = 1

@description('The URL for the GitHub repository that contains the project to deploy.')
param repositoryUrl string = 'https://github.com/Azure-Samples/cosmos-dotnet-core-todo-app.git'

@description('The branch of the GitHub repository to use.')
param branch string = 'main'

@description('The Cosmos DB database name.')
param databaseName string = 'Tasks'

@description('The Cosmos DB container name.')
param containerName string = 'Items'

@description('Virtual machine admin username')
param adminUserName string 

@description('Virtual machine password')
@secure()
param adminPassword string

@description('The Windows version for the VM. This will pick a fully patched image of this given Windows version.')
//param windowsOSVersion string = '2019-Datacenter'
param ubuntuOsVersion string = '20_04-lts-gen2'



var cosmosAccountName_var = toLower(applicationName)
var websiteName_var = applicationName
var hostingPlanName_var = applicationName
var appInsightsName = '${applicationName}-insights'
var logAnalyticsName = '${applicationName}-la'
//var rg= resourceGroup().name
var cloudInit= '''
#cloud-config
packages:
 - stress

runcmd:
-stress --cpu 8 -v -t 10s
'''

var VMSkus = [
  {
    name:'Standard_D2s_v3'
    location: 'eastus2'
  }
  {
    name:'Standard_DS1_v2'
    location: 'eastus2'
  }
  {
    name:'Standard_B2s'
    location: 'eastus2'
  }
  {
    name:'Standard_B1s'
    location: 'eastus2'
  }
  {
    name:'Standard_B4ms'
    location: 'eastus2'
  }
  {
    name:'Standard_DS3_v2'
    location: 'eastus2'
  }
  {
    name:'Standard_DS3_v2'
    location: 'eastus2'
  }
  {
    name:'Standard_DS2_v2'
    location: 'eastus2'
  }
]

//var nicName = 'myVMNic'
var virtualNetworkLocation = 'eastus2'
var addressPrefix = '10.0.0.0/16'
var subnetName = 'Subnet'
var subnetPrefix = '10.0.0.0/24'
var virtualNetworkName = 'MyVNET'
var subnetRef = '${vn.id}/subnets/${subnetName}'

resource cosmosAccountName 'Microsoft.DocumentDB/databaseAccounts@2021-04-15' = {
  name: cosmosAccountName_var
  kind: 'GlobalDocumentDB'
  location: location
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard'
  }
}

resource hostingPlanName 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: hostingPlanName_var
  location: location
  sku: {
    name: appServicePlanTier
    capacity: appServicePlanInstances
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: { 
    Application_Type: 'web'
    WorkspaceResourceId: la.id
  }
}

resource websiteName 'Microsoft.Web/sites@2020-06-01' = {
  name: websiteName_var
  location: location
  properties: {
    serverFarmId: hostingPlanName.id
    siteConfig: {
      appSettings: [
        {
          name: 'CosmosDb:Account'
          value: cosmosAccountName.properties.documentEndpoint
        }
        {
          name: 'CosmosDb:Key'
          value: listKeys(cosmosAccountName.id, '2021-04-15').primaryMasterKey
        }
        {
          name: 'CosmosDb:DatabaseName'
          value: databaseName
        }
        {
          name: 'CosmosDb:ContainerName'
          value: containerName
        }
        //{
          //name : 'APPINSIGHTS_INSTRUMENTATIONKEY'
         // value : appInsights.properties.InstrumentationKey
        //}
        {
          name : 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value : appInsights.properties.ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~2'
      }
      ]
    }
  }
}

resource websiteName_web 'Microsoft.Web/sites/sourcecontrols@2020-06-01' = {
  parent: websiteName
  name: 'web'
  properties: {
    repoUrl: repositoryUrl
    branch: branch
    isManualIntegration: true
  }
}

resource la 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource diagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: websiteName
  name: 'webappDiagnostics'
  properties: {
    workspaceId: la.id
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    logs: [
      {
        enabled: true
        category: 'AppServiceHTTPLogs'
      }
      {
        enabled: true
        category:'AppServiceAppLogs'
      }
    ]
  }
}



resource vn 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtualNetworkName
  location: virtualNetworkLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
        }
      }
    ]
  }
}

resource nInter 'Microsoft.Network/networkInterfaces@2020-06-01' = [for (sku,i) in VMSkus: {
  name: 'nic-00${i}'
  location: sku.location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties:{
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetRef
          }
        }
      }
    ]
  }
}]


resource vm 'Microsoft.Compute/virtualMachines@2021-04-01' = [for (sku, i) in VMSkus: {
  name: 'vm00-${i}'
  location: sku.location
  properties:{
    hardwareProfile: {
      vmSize: sku.name
    }
    osProfile: {
      computerName: 'vm00-${i}'
      adminPassword: adminPassword
      adminUsername: adminUserName
      customData: base64(cloudInit)
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: ubuntuOsVersion
        version: 'latest'
      }
      osDisk:{
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces:[
        {
          id: nInter[i].id
        }
      ]
    }
  }
}]

/*resource runScript 'Microsoft.Compute/virtualMachines/runCommands@2021-03-01' = {
  name: 'stress-CPU'
  parent: vm[0]
  location: 'eastus2'
  properties: {
    source: {
      commandId: 'RunShellScript'
      script: 'sudo apt-get install stress;sudo stress --cpu 16 -v -t 20s'
    }
  }
}
*/