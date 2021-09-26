@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('Indicates whether the web application firewall policy should be enabled.')
var enableWafPolicy = (environmentType == 'prod')

@description('The default host name of the App Service app.')
output hostName string = app.properties.defaultHostName
