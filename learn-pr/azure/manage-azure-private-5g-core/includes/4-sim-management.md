After the deployment a private mobile network, you'll need to manage the SIMs for attached UEs on a routine basis. For example, you may need to provision a SIM for a newly attached UE, or you may need to adjust the SIM groups due to application requirement changes.

This unit introduces you to the SIM management tasks, like SIM provisioning or SIM group management.

## Provision new SIMs

Azure Private 5G Core uses SIM resources to represent the physical SIMs or eSIMs that the UEs in a private mobile network use. For the UEs to communicate with the DNs through the packet core instances, you need to provision their SIMs with the SIM resources.

You can provision SIMs either through the Azure portal or an Azure template.

### Provision new SIMs through the Azure portal

You can use one of the following methods to provision SIMs:

- Manually enter each provisioning value into fields in the Azure portal. Use this method if you're provisioning a few SIMs.
- Use a JSON file containing values for one or more SIM resources. Use this method if you're provisioning a large number of SIMs.

> [!NOTE]
>
> - If you want to assign a SIM policy to a SIM you provision, you must have already created the relevant SIM policy.
> - You can create a new [SIM group](#manage-sims-and-sim-groups) when provisioning the SIMs, or you can choose an existing SIM group.

If you want to use a JSON file to do add SIM details, take the following steps to create the file:

1. Prepare the required field values for each SIM.

   For details about the fields, see [Collect the required information for your SIMs](/azure/private-5g-core/provision-sims-azure-portal).

1. Create the file with appropriate fields and their values.

   For example, the following lines specify the details for a SIM:

   ```json
   {
      "simName": "SIM1",
      "integratedCircuitCardIdentifier": "8912345678901234566",
      "internationalMobileSubscriberIdentity": "001019990010001",
      "authenticationKey": "00112233445566778899AABBCCDDEEFF",
      "operatorKeyCode": "63bfa50ee6523365ff14c1f45f88737d",
      "deviceType": "Cellphone"
   }
   ```

To provision the SIMs, take the following steps:

1. Open the Mobile Network resource representing the private mobile network in which you want to provision the SIMs.
1. Select **Services** from the resource menu and then select the **Create** button.

### Provision new SIMs through an ARM template

## Manage SIMs and SIM groups
