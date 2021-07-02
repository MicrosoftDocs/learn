resource firewallRule 'Microsoft.Sql/servers/firewallRules@2014-04-01' = {
  parent: sqlServer
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0' // This combination represents 'all Azure IP addresses'.
    endIpAddress: '0.0.0.0'
  }
}

/*
  This Bicep file was developed by the web team.
  It deploys the resources we need for our toy company's website.
*/
