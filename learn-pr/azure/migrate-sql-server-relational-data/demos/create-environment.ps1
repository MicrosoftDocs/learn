$rgName = 'admsdemo2'

$saName = 'admsdemosa'
$locName = 'centralus'

$netName = 'admsdemovnet'
$netAddress = '10.0.0.0/16'
$subnetName = 'admsdemosubnet'
$subnetAddress = '10.0.1.0/24'

$nsgName = 'admsdemonsg'

Install-Module Az -Force
Install-Module SqlServer -Force

Connect-AzAccount

Set-AzContext -SubscriptionName 'Pay-As-You-Go'

$rgExists = Get-AzResourceGroup -Name $rgName `
                                -ErrorAction SilentlyContinue
if ( $rgExists -eq $null )
{
  New-AzResourceGroup -Name $rgName `
                      -Location $locName
}

$resourceGroup = Get-AzResourceGroup $rgName


$storageAccount = New-AzStorageAccount `
  -ResourceGroupName $rgName `
  -Name $saName `
  -Location $locName `
  -Type Standard_LRS

# Allow RDP
$rdpRule = New-AzNetworkSecurityRuleConfig `
  -Name 'rdp-rule' `
  -Description 'Allow RDP' `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix Internet `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 3389  

# Allow Internet (Http) Access on Port 80
$httpRule = New-AzNetworkSecurityRuleConfig `
  -Name web-rule `
  -Description 'Allow HTTP' `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 101 `
  -SourceAddressPrefix Internet `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 80

# Allow SQL Server
$sqlRule = New-AzNetworkSecurityRuleConfig `
  -Name 'sql-rule' `
  -Description 'Allow SqlServer' `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 102 `
  -SourceAddressPrefix Internet `
  -SourcePortRange * `
  -DestinationAddressPrefix * `
  -DestinationPortRange 1433  

# Now that the rules have been created, let's create the NSG
$nsg = New-AzNetworkSecurityGroup `
  -ResourceGroupName $rgName `
  -Location $locName `
  -Name $nsgName `
  -SecurityRules $rdpRule, $httpRule, $sqlRule

#  $subnetConfig = New-AzVirtualNetworkSubnetConfig `
#  -Name $subnetName -AddressPrefix $subnetAddress
#
#New-AzVirtualNetworkSubnetConfig `
#  -Name $netName `
#  -AddressPrefix $netAddress `
#  -Subnet $subnetConfig `
#  -Location $locName

$frontendSubnet = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet `
    -AddressPrefix "10.0.1.0/24" -NetworkSecurityGroup $nsg

$backendSubnet = New-AzVirtualNetworkSubnetConfig -Name backendSubnet `
    -AddressPrefix "10.0.2.0/24" -NetworkSecurityGroup $nsg

$pip = New-AzPublicIpAddress -Name "pip" -ResourceGroupName $rgName `
   -Location $locName -Sku "Standard" -IdleTimeoutInMinutes 4 -AllocationMethod "static"

#$natgateway = New-AzNatGateway -ResourceGroupName $rgName -Name "nat_gateway" `
#   -IdleTimeoutInMinutes 4 -Sku "Standard" -Location $locName -PublicIpAddress $pip
#
#$natGatewaySubnet = New-AzVirtualNetworkSubnetConfig -Name natGatewaySubnet `
#   -AddressPrefix "10.0.3.0/24" -InputObject $natGateway

New-AzVirtualNetwork `
  -Name $netName `
  -ResourceGroupName $rgName `
  -Location $locName `
  -AddressPrefix '10.0.0.0/16' `
  -Subnet $frontendSubnet, $backendSubnet #, $natGatewaySubnet

# Create a NIC
# Get a reference to our existing virtual network
$vNet = Get-AzVirtualNetwork `
  -ResourceGroupName $rgName `
  -Name $netName

$nicName = 'admsdemonic'
$nic = New-AzNetworkInterface `
  -Name $nicName `
  -ResourceGroupName $rgName `
  -Location $locName `
  -SubnetId $vNet.Subnets[0].Id `
  -PublicIpAddressId $pip.Id `
  -NetworkSecurityGroupId $nsg.Id

$publisher = 'MicrosoftSQLServer'
$offer = 'SQL2017-WS2016'
$sku = 'SQLDEV'
$vmSize = 'Basic_A3'

# Give our VM a name
$vmName = 'admsdemosqlvm'

# Create a PSCredential object
$userName = 'learner'
$password = 'SecureP@ssW0rd' |
  ConvertTo-SecureString -AsPlainText -Force

$cred = New-Object PSCredential ($username, $password)

# Now create a new VM Configuration, the first step toward our VM
$vm = New-AzVMConfig -VMName $vmName -VMSize $vmSize

$vm = Set-AzVMOperatingSystem `
  -VM $vm `
  -Windows `
  -ComputerName $vmName `
  -Credential $cred `
  -ProvisionVMAgent `
  -EnableAutoUpdate

$vm = Set-AzVMSourceImage `
  -VM $vm `
  -PublisherName $publisher `
  -Offer $offer `
  -Skus $sku `
  -Version 'latest'

$vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id

$diskName = 'admsdemoos'
$diskURI = $storageAccount.PrimaryEndpoints.Blob.ToString() `
             + 'vhds/' + $diskName + '.vhd'

$vm = Set-AzVMOSDisk `
  -VM $vm `
  -Name $diskName `
  -VhdUri $diskURI `
  -CreateOption FromImage

# Create the new VM
New-AzVm -ResourceGroupName $rgName `
  -Location $locName `
  -VM $vm


