This walkthrough connects a standard, single-zone Generation 1 Azure VMware Solution private cloud to an on-premises VMware environment. ExpressRoute Global Reach links the AVS-managed ExpressRoute circuit directly to a functioning customer-provided ExpressRoute circuit.

Global Reach is the preferred direct hybrid connection for this design. Where it isn't available or doesn't meet routing and inspection requirements, supported VPN or network virtual appliance (NVA) transit designs can provide connectivity. Those alternatives require their own configuration. Simply attaching two circuits to one ExpressRoute gateway doesn't make that gateway transit traffic between them.

Generation 2 uses direct VNet attachment and a different on-premises connectivity workflow. Don't apply this AVS circuit-to-circuit procedure to a Generation 2 private cloud.

## Prepare the connection

Before creating the connection, confirm the following prerequisites:

- A separate, provisioned customer ExpressRoute circuit with working Azure private peering is required. Its tier must support Global Reach. ExpressRoute Local doesn't support Global Reach.
- Confirm Global Reach availability for the selected peering locations and topology. Connections across geopolitical regions require Premium circuits at both endpoints. Validate the customer circuit's tier and confirm AVS-side eligibility with Microsoft before proceeding with such a connection. Don't attempt to modify the Microsoft-managed AVS circuit.
- All gateways, including the provider's service, support four-byte autonomous system numbers (ASNs).
- Customer ASN assignments and the provider routing design have been reviewed for conflicts with the AVS-reserved ASNs described in the network-planning unit: `64513`, `64600-64940`, `65000-65412`, `398656-398670`, and `400572-400581`. Coordinate any conflict with the responsible network owner, provider, and Microsoft Support before connecting. Don't change AVS-managed or provider-managed ASNs as part of this walkthrough.
- The administrators have the required permissions on the customer circuit and the AVS private cloud.
- The address ranges don't overlap, and specific return routes exist for on-premises management networks.
- Circuit route-advertisement limits and customer/provider receive-side maximum-prefix settings have been checked for the routes expected after Global Reach is enabled, with capacity for planned growth.

> [!IMPORTANT]
> The following portal and CLI examples create one Global Reach connection for the standard private cloud used in this walkthrough. For a separately planned stretched private cloud, use the stretched-cloud portal workflow to connect each availability zone's AVS circuit to the customer circuit. Create a different customer-circuit authorization for each connection, and confirm that both connections are successfully provisioned and connected. Don't assume that creating a second connection name with the same single-connection CLI inputs selects the other zone's circuit.

Choose either the portal or CLI procedure below. They create the same kind of connection, so don't run both for the same intended connection.

## Use the Azure portal to configure Global Reach

Create the authorization on the customer circuit, then consume it from the AVS private cloud:

1. Open the **customer-provided ExpressRoute circuit** in the Azure portal.
1. Under **Settings > Authorizations**, enter a new authorization name and save it.
1. Record the customer circuit's resource ID and the new authorization key. Use the circuit ID, not the ID of the authorization child resource. Treat the key as a secret.
1. Open the **Generation 1 AVS private cloud**. Select **Manage > Connectivity > ExpressRoute Global Reach > Add**.
1. Select the customer circuit where the portal supports selection, or enter its circuit ID. Supply the authorization created on that customer circuit.
1. Select **Create**, wait for successful provisioning, and confirm that the circuit connection is connected.

> [!NOTE]
> This Global Reach workflow consumes authorization from the customer circuit. Connecting an Azure VNet gateway to the AVS circuit is a different operation and uses an authorization created on the AVS side. Don't exchange these keys or reuse an authorization already consumed by another connection.

When separate administrators own the resources, have the circuit owner securely provide the circuit ID and authorization key to the AVS administrator. Don't include the key in screenshots, shared scripts, or troubleshooting messages.

## Use the Azure CLI to configure Global Reach

As an alternative to the portal, use Azure Cloud Shell Bash with Azure CLI 2.75.0 or later and the `vmware` extension required by the AVS command. The extension supports automatic installation on first use. If your environment disables that behavior, install the supported extension through your approved CLI extension process before starting.

The following script assumes the signed-in identity has the required permissions on both the customer circuit and the private cloud. Replace every `REPLACE_WITH_...` value before running it. Stop and resolve command errors rather than continuing with missing values.

```bash
set -euo pipefail

customerSubscriptionId="REPLACE_WITH_CUSTOMER_CIRCUIT_SUBSCRIPTION_ID"
customerResourceGroup="REPLACE_WITH_CUSTOMER_CIRCUIT_RESOURCE_GROUP"
customerCircuitName="REPLACE_WITH_CUSTOMER_CIRCUIT_NAME"
avsSubscriptionId="REPLACE_WITH_AVS_SUBSCRIPTION_ID"
avsResourceGroup="REPLACE_WITH_AVS_RESOURCE_GROUP"
privateCloudName="REPLACE_WITH_PRIVATE_CLOUD_NAME"
authorizationName="REPLACE_WITH_NEW_AUTHORIZATION_NAME"
connectionName="REPLACE_WITH_NEW_CONNECTION_NAME"

customerCircuitId="/subscriptions/${customerSubscriptionId}/resourceGroups/${customerResourceGroup}/providers/Microsoft.Network/expressRouteCircuits/${customerCircuitName}"

authorizationKey="$(az network express-route auth create \
  --subscription "$customerSubscriptionId" \
  --resource-group "$customerResourceGroup" \
  --circuit-name "$customerCircuitName" \
  --name "$authorizationName" \
  --query authorizationKey \
  --output tsv)"

if [[ -z "$authorizationKey" ]]; then
  printf '%s\n' "No authorization key was returned. Stop and inspect the circuit authorization." >&2
  exit 1
fi

az vmware global-reach-connection create \
  --subscription "$avsSubscriptionId" \
  --resource-group "$avsResourceGroup" \
  --private-cloud "$privateCloudName" \
  --name "$connectionName" \
  --peer-express-route-circuit "$customerCircuitId" \
  --authorization-key "$authorizationKey" \
  --output none

unset authorizationKey
```

If you have access only to AVS, don't run the whole script. Have the circuit owner create the customer-side authorization and securely supply the circuit ID and key. Set the AVS resource details and supplied values, then run only the AVS connection-creation step.

The AVS connection API allocates its Global Reach address prefix from the private-cloud management block. Don't add a manually selected /29 parameter to this command. A generic ExpressRoute peering-connection procedure has a different address-allocation contract.

## Verify the hybrid connection

Open the private cloud's **ExpressRoute Global Reach** connections and confirm successful provisioning and a connected circuit state. Resource creation alone isn't proof of application connectivity.

On the on-premises edge router, confirm the learned AVS management and workload prefixes. Verify that required routes propagate through the on-premises network and that AVS has specific return routes to your private management networks. A customer-advertised default route alone doesn't provide that management return path.

Test permitted management HTTPS access and the required application paths in both directions. Keep firewalls enabled and check their policies if a path fails.

If you're retaining the Bastion management path, start a new Bastion connection to the jumpbox after hybrid routing is configured, then open the private vCenter Server and NSX Manager HTTPS endpoints. If this path no longer works, inspect learned default routes and the Bastion service prerequisites from the deployment unit. Don't treat successful Global Reach provisioning as proof that the Bastion path still works.

The next unit configures NSX workload networking and completes the end-to-end connectivity checks.
