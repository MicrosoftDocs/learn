Use this Try-this exercises to get some hands-on experience with Azure.

In this demonstration, we'll explore the Azure Key Vault.

## Task 1: Create a virtual network

1. In the portal, search for and select Virtual networks.

2. On the Virtual networks page, select Create.<br>

3. On the Basics tab of Create virtual network, enter or select the following information:

| **Setting**      | **Value**                                                          |
| ---------------- | ------------------------------------------------------------------ |
| Project details  |                                                                    |
| Subscription     | Select your subscription.                                          |
| Resource group   | Select **Create new.**<br>Enter **test-rg** in Name.<br>Select OK. |
| Instance details |                                                                    |
| Name             | Enter **vnet-1.**                                                  |
| Region           | Select **(US) East US**                                            |

4. Select **Next: IP Addresses** at the bottom of the page.

5. In the **IP Addresses** tab, under **IPv4 address space,** select the garbage deletion icon to remove any address space that already appears, and then enter **10.0.0.0/16.**<br>

6. Select **+ Add subnet.**<br>

7. Enter or select the following information in **Add subnet:**<br>

| **Setting**          | **Value**              |
| -------------------- | ---------------------- |
| Subnet name          | Enter **subnet-1.**    |
| Subnet address range | Enter **10.0.0.0/24.** |

8. Select **Add.**

## Task 2: Create a key vault<br>

In this task, we'll create a key vault.

1. From the Azure portal menu, or from the **Home** page, select **Create a resource**.

2. In the Search box, enter **Key Vault.**

3. From the results list, choose **Key Vault.**

4. On the Key Vault section, choose **Create.**

5. On the Create key vault section provide the following information:

 -  **Name:** A unique name is required. For this example, we use **Contoso-vault2.**
 -  **Subscription:** Choose a subscription.
 -  Under **Resource Group,** choose **Create new** and enter a resource group name.
 -  In the **Location** pull-down menu, choose a location.
 -  Leave the other options to their defaults.

6. Select **Create**.

Take note of these two **example** properties:

 -  Vault Name: In the **example,** this is **Contoso-Vault2.** You'll use this name for other steps.<br>
 -  Vault URI: In the **example,** the Vault Uniform Resource Identifiers (URI) is **https://contoso-vault2.vault.azure.net/**. Applications that use your vault through its Representations State Transfer API must use this Uniform Resource Identifiers (URI).

> [!NOTE]
> At this point, your Azure account is the only one authorized to perform operations on this new vault.

## Task 3: Configure Azure Key Vault networking settings

1. Browse to the **previously created key vault** you want to secure.

2. Select **Networking,** and then select the **Firewalls and virtual networks** tab.

3. Under **Allow access from,** select **Allow public access from specific virtual networks and IP addresses**

4. To add existing virtual networks to firewalls and virtual network rules, select + **Add a virtual networks,**  \+ **Add existing virtual networks.**

5. In the new blade that opens, select the subscription, virtual networks, and subnets that you want to allow access to this key vault. If the virtual networks and subnets you select don't have service endpoints enabled, confirm that you want to enable service endpoints, and select **Enable.** It might take up to 15 minutes to take effect.

6. Under **IP Networks,** add IPv4 address ranges by typing IPv4 address ranges in CIDR (Classless Inter-domain Routing) notation or individual IP addresses.

7. If you want to allow Microsoft Trusted Services to bypass the Key Vault Firewall, select 'Yes'.

8. Select **Save.**

> [!NOTE]
> You can also add new virtual networks and subnets, and then enable service endpoints for the newly created virtual networks and subnets, by selecting + **Add new virtual network.** Then follow the prompts.

## Task 4: Verify if soft delete is enabled on a key vault and enable soft delete<br>

1. Log in to the Azure portal.

2. Select your key vault.

3. Click on the "Properties" blade.

4. Verify if the radio button next to soft-delete is set to "Enable Recovery".

5. If soft-delete isn't enabled on the key vault, click the radio button to enable soft delete and click "Save".

## Task 5: Grant access to a service principal to purge and recover deleted secrets

1. Log in to the Azure portal.

2. Select your key vault.

3. Click on the "Access Policy" blade.

4. In the table, find the row of the security principal you wish to grant access to (or add a new security principal).

5. Click the drop-down for keys, certificates, and secrets.

6. Scroll to the bottom of the drop-down and click "Recover" and "Purge"

7. Security principals will also need get and list functionality to perform most operations.

## Task 6: List, recover, or purge a soft-deleted key vault

1. Log in to the Azure portal.

2. Click on the search bar at the top of the page.

3. Search for the "Key Vault" service. Don't click an individual key vault.

4. At the top of the screen, click the option to "Manage deleted vaults"

5. A context pane will open on the right side of your screen.

6. Select your subscription.

7. If your key vault has been soft deleted it will appear in the context pane on the right.

8. If there are too many vaults, you can either click "Load More" at the bottom of the context pane or use CLI or PowerShell to get the results.

9. Once you find the vault you wish to recover or purge, select the checkbox next to it.

10. Select the recover option at the bottom of the context pane if you would like to recover the key vault.

11. Select the purge option if you would like to permanently delete the key vault.

## Task 7: List, recover or purge soft deleted secrets, keys, and certificates

1. Log in to the Azure portal.

2. Select your key vault.

3. Select the blade corresponding to the secret type you want to manage (keys, secrets, or certificates).

4. At the top of the screen, click on "Manage deleted (keys, secrets, or certificates)

5. A context pane will appear on the right side of your screen.

6. If your secret, key, or certificate doesn't appear in the list, it isn't in the soft-deleted state.

7. Select the secret, key, or certificate you would like to manage.

8. Select the option to recover **or** purge at the bottom of the context pane.
