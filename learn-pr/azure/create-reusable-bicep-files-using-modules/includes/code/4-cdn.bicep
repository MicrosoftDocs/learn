@description('TODO')
param location string

@description('TODO')
param originHostName string

@description('TODO')
param profileName string = 'cdn-${uniqueString(resourceGroup().id)}'

@description('TODO')
param endpointName string = 'endpoint-${uniqueString(resourceGroup().id)}'

@description('TODO')
param httpsOnly bool

var originName = 'my-origin'

resource cdnProfile 'Microsoft.Cdn/profiles@2020-09-01' = {
  name: profileName
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2020-09-01' = {
  parent: cdnProfile
  name: endpointName
  location: location
  properties: {
    originHostHeader: originHostName
    isHttpAllowed: ! httpsOnly
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    contentTypesToCompress: [
      'text/plain'
      'text/html'
      'text/css'
      'application/x-javascript'
      'text/javascript'
    ]
    isCompressionEnabled: true
    origins: [
      {
        name: originName
        properties: {
          hostName: originHostName
        }
      }
    ]
  }
}

output endpointHostName string = endpoint.properties.hostName
