param number int
param name string
param name2 string

var location = 'australiaeast'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: name
  location: location
  properties: {
    addressSpace:{
      addressPrefixes:[
        '10.0.0.0/16'
      ]
    }
    subnets: [for i in range(1, number): {
      name: 'subnet-${i}'
      properties: {
        addressPrefix: '10.0.${i}.0/24'
      }
    }]
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: name2
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
