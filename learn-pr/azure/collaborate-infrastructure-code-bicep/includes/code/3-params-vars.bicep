param location string = resourceGroup().location

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
param skuName string = 'F1'

@minValue(1)
param skuCapacity int = 1
param sqlAdministratorLogin string

@secure()
param sqlAdministratorLoginPassword string

param managedIdentityName string
param roleDefinitionId string = 'b24988ac-6180-42a0-ab88-20f7382dd24c'

var hostingPlanName = 'hostingplan${uniqueString(resourceGroup().id)}'
var webSiteName = 'webSite${uniqueString(resourceGroup().id)}'
var sqlserverName = 'sqlserver${uniqueString(resourceGroup().id)}'
var databaseName = 'sampledb'
