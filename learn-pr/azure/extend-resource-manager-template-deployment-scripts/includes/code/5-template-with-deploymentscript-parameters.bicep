@description('List of files to copy to application storage account.')
param filesToCopy array = [
  'appsettings.json'
]

var storageAccountName = 'storage${uniqueString(resourceGroup().id)}'
var storageBlobContainerName = 'config'
var userAssignedIdentityName = 'configDeployer'
var roleAssignmentName = guid(resourceGroup().id, 'contributor')
var contributorRoleDefinitionId = resourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
var deploymentScriptName = 'CopyConfigScript'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  tags: {
    displayName: storageAccountName
  }
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    allowBlobPublicAccess: true
    encryption: {
      services: {
        blob: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    supportsHttpsTrafficOnly: true
  }

  resource blobService 'blobServices' existing = {
    name: 'default'
  }
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-04-01' = {
  parent: storageAccount::blobService
  name: storageBlobContainerName
  properties: {
    publicAccess: 'Blob'
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: userAssignedIdentityName
  location: resourceGroup().location
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: roleAssignmentName
  properties: {
    roleDefinitionId: contributorRoleDefinitionId
    principalId: userAssignedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: deploymentScriptName
  location: resourceGroup().location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity.id}': {}
    }
  }
  properties: {
    arguments: '-File \'${string(filesToCopy)}\''
    environmentVariables: [
      {
        name: 'ResourceGroupName'
        value: resourceGroup().name
      }
      {
        name: 'StorageAccountName'
        value: storageAccountName
      }
      {
        name: 'StorageContainerName'
        value: storageBlobContainerName
      }
    ]
    azPowerShellVersion: '3.0'
    scriptContent: '''
      param([string]$File)
      $fileList = $File -replace '(\[|\])' -split ',' | ForEach-Object { $_.trim() }
      $storageAccount = Get-AzStorageAccount -ResourceGroupName $env:ResourceGroupName -Name $env:StorageAccountName -Verbose
      $count = 0
      $DeploymentScriptOutputs = @{}
      foreach ($fileName in $fileList) {
          Write-Host "Copying $fileName to $env:StorageContainerName in $env:StorageAccountName."
          Invoke-RestMethod -Uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/mslearn-arm-deploymentscripts-sample/$fileName" -OutFile $fileName
          $blob = Set-AzStorageBlobContent -File $fileName -Container $env:StorageContainerName -Blob $fileName -Context $storageAccount.Context
          $DeploymentScriptOutputs[$fileName] = @{}
          $DeploymentScriptOutputs[$fileName]['Uri'] = $blob.ICloudBlob.Uri
          $DeploymentScriptOutputs[$fileName]['StorageUri'] = $blob.ICloudBlob.StorageUri
          $count++
      }
      Write-Host "Finished copying $count files."
    '''
    retentionInterval: 'P1D'
  }
  dependsOn: [
    roleAssignment
    blobContainer
  ]
}

output fileUri object = deploymentScript.properties.outputs
output storageAccountName string = storageAccountName
