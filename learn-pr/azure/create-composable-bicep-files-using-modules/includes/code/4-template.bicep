@description('TODO')
param location string = resourceGroup().location

@description('TODO')
param appServiceAppName string = 'toy-${uniqueString(resourceGroup().id)}'

@description('TODO')
param appServicePlanSkuName string = 'F1'

module app '4-app.bicep' = {
  name: 'todoapp'
  params: {
    appServiceAppName: appServiceAppName
    appServicePlanSkuName: appServicePlanSkuName
    location: location
  }
}

module cdn '4-cdn.bicep' = {
  name: 'todocdn'
  params: {
    httpsOnly: true
    location: location
    originHostName: app.outputs.appServiceAppHostName
  }
}

// TODO add description
output cdnEndpointHostName string = cdn.outputs.endpointHostName
