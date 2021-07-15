@description('The type of the environment to deploy. This will determine the SKUs and cost of the resources.')
@allowed([
  'Production'
  'NonProduction'
])
param environmentType string

@secure()
@description('The secret key to use.')
param key string

@description('The Azure region into which the resources should be deployed.')
param location string

@description('The number of Azure SQL logical servers to create.')
@maxValue(5)
param sqlServerCount int
