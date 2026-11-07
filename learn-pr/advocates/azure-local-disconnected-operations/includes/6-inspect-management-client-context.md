The same Azure CLI command name can target different clouds. A local command line isn't inherently a local-cloud command line. Before automating resource operations, verify the client version, endpoints, authenticated environment, and selected subscription.

## Prepare a controlled client configuration

The reviewed disconnected CLI guidance specifies Azure CLI **2.85.0**. It calls for the 32-bit CLI on Azure Local nodes and the 64-bit CLI on client machines. Its extension table lists maximum supported versions, including `aksarc` **1.5.74** and `stack-hci-vm` **1.15.0**.

A maximum supported extension version isn't an instruction to install any older version. Record the exact supported package set required by the selected deployment, including extension dependencies. Don't allow an automatic upgrade to replace that set with the latest public package.

A CLI extension is a Python package that adds commands to the base CLI. Acquire approved extension wheels and their dependencies outside the isolated environment, verify them, and install them through the documented offline process. An online extension-discovery command is useful on an acquisition station, not evidence that the disconnected client can retrieve packages.

Configure trust for the appliance CA in both the operating system and the CLI's Python environment as required by the documented method. A browser can trust the local portal while CLI requests still fail because the two clients aren't using the same trust configuration.

Register the deployment's custom cloud configuration as `azure.local`. It identifies the local identity and resource-manager endpoints and the appropriate service suffixes. The documented configuration also changes Windows broker and instance-discovery behavior so the client doesn't depend on public-cloud discovery defaults. Apply those settings as part of the approved client build rather than guessing endpoint values during an incident.

Keep commercial-administration and local-operation client contexts separate. Azure Cloud Shell isn't a substitute for a management client that can resolve and reach the isolated network.

## Check the selected local context without changing it

This example assumes that custom-cloud registration, certificate trust, and local sign-in are already complete. The user must have permission to read resource groups in the intended local subscription.

Enter the approved resource-manager hostname without a scheme or path, and the approved local subscription identifier. The example doesn't register a cloud, select a different cloud, sign in, or change resources.

```powershell
$ErrorActionPreference = 'Stop'
$expectedHost = (Read-Host 'Approved local resource-manager hostname').Trim()
$subscriptionId = (Read-Host 'Approved local subscription identifier').Trim()

if ([string]::IsNullOrWhiteSpace($expectedHost) -or
    [string]::IsNullOrWhiteSpace($subscriptionId)) {
    throw 'Both an approved hostname and subscription identifier are required.'
}

$versionText = & az version --output json
if ($LASTEXITCODE -ne 0) { throw 'CLI version inspection failed.' }
if (($versionText | ConvertFrom-Json).'azure-cli' -ne '2.85.0') {
    throw 'This example requires the documented CLI version 2.85.0.'
}

$cloudText = & az cloud show --name azure.local --output json
if ($LASTEXITCODE -ne 0) { throw 'Local cloud configuration is unavailable.' }
$cloud = $cloudText | ConvertFrom-Json
$endpoint = [uri]$cloud.endpoints.resourceManager
if (-not $cloud.isActive -or -not $endpoint.IsAbsoluteUri -or
    $endpoint.Scheme -ne 'https' -or
    $endpoint.DnsSafeHost -ne $expectedHost) {
    throw 'Active cloud or local endpoint does not match the approved design.'
}

$accountText = & az account show --output json
if ($LASTEXITCODE -ne 0) { throw 'No usable local account context.' }
$account = $accountText | ConvertFrom-Json
if ($account.environmentName -ne 'azure.local' -or
    $account.id -ne $subscriptionId) {
    throw 'The authenticated local scope does not match.'
}

$groupsText = & az group list --subscription $subscriptionId `
    --query '[].{name:name,location:location}' --output json
if ($LASTEXITCODE -ne 0) { throw 'Local resource-group query failed.' }
$groupsText | ConvertFrom-Json
```

The code checks native-command exit codes explicitly because `$ErrorActionPreference` alone doesn't consistently turn a nonzero native exit code into a terminating error across PowerShell versions.

Expect the resource groups that the caller can read in the selected subscription. An empty subscription can legitimately return no groups. This result doesn't establish that all fleet resources are present, that group synchronization is fresh, or that the caller has access to other subscriptions.

The example checks the resource-manager destination and account context. It isn't a complete audit of every cloud endpoint or installed extension. Compare the entire client configuration with the approved inventory before allowing write operations.

If the portal works but a CLI query fails, investigate client trust, local DNS, endpoint configuration, authentication, and scope. If group synchronization is stale, hold access-sensitive operations and investigate identity. Switching to public-cloud sign-in doesn't repair either condition.

The following table lists the documented maximum extension versions for the Azure CLI 2.85.0 client configuration. Select the approved versions and dependencies for the services you manage rather than treating these limits as permission to install any older package.

| Extension | Maximum supported version |
| --- | --- |
| `connectedmachine` | 1.1.0 |
| `connectedk8s` | 1.6.2 |
| `k8s-extension` | 1.7.0 |
| `k8s-configuration` | 2.0.0 |
| `customlocation` | 0.1.4 |
| `arcappliance` | 1.7.2 |
| `stack-hci-vm` | 1.15.0 |
| `aksarc` | 1.5.74 |
| `stack-hci` | 1.1.0 |

Azure Container Registry, Azure Policy, and Azure Key Vault commands are built into the CLI. For extensions, transfer approved wheel files and their dependencies from a connected acquisition station, then use `az extension add --source` with the local wheel path. Don't rely on automatic extension installation or an online package index inside the isolated environment.

During client provisioning, configure the Python environment bundled with Azure CLI to trust the appliance CA. On Windows, the recommended approach uses `pip-system-certs` in that bundled Python environment so it can use the operating system's trust store, with the approved root certificate imported into `Cert:\LocalMachine\Root`. Acquire the Python package and its dependencies through the approved offline process. Alternatively, append the root certificate in PEM format to the CLI installation's `Lib\site-packages\certifi\cacert.pem` bundle, preserving the existing certificates. Updating a different Python installation won't establish trust for Azure CLI.

The custom-cloud JSON must identify the local endpoints and service suffixes shown in the following table. Replace `fqdn` with the approved deployment suffix, such as `cloud.contoso.com`, and retain the leading dots in the vault and registry suffixes.

| Cloud configuration field | Value for the local deployment |
| --- | --- |
| `endpoints.activeDirectory` | `https://login.fqdn/adfs` |
| `endpoints.activeDirectoryGraphResourceId` | `https://graph.fqdn` |
| `endpoints.microsoftGraphResourceId` | `https://graph.fqdn` |
| `endpoints.resourceManager` | `https://armmanagement.fqdn` |
| `endpoints.activeDirectoryResourceId` | `https://armmanagement.fqdn` |
| `suffixes.keyvaultDns` | `.vault.fqdn` |
| `suffixes.storageEndpoint` | `fqdn` |
| `suffixes.acrLoginServerEndpoint` | `.edgeacr.fqdn` |

As part of the approved client setup, use `az config set` to set `core.enable_broker_on_windows=false` and `core.instance_discovery=false`. These settings avoid public-cloud broker and discovery assumptions without disabling TLS certificate validation. Save the endpoint and suffix configuration as `cloudconfig.json`, register it with `az cloud register -n azure.local --cloud-config '@cloudconfig.json'`, and select it with `az cloud set -n azure.local` before signing in and selecting the intended local subscription. These are provisioning changes, not actions performed by the read-only inspection example above.
