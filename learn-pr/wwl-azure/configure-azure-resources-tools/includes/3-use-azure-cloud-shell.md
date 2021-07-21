Azure Cloud Shell is an interactive, browser-accessible shell for managing Azure resources. It provides the flexibility of choosing the shell experience that best suits the way you work. Linux users can opt for a Bash experience, while Windows users can opt for PowerShell.

Cloud Shell enables access to a browser-based command-line experience built with Azure management tasks in mind. You can use Cloud Shell to work untethered from a local machine in a way only the cloud can provide.

:::image type="content" source="../media/cloud-shell-a52770ea.png" alt-text="Screenshot of the Azure portal showing the cloud shell icon.":::


## Azure Cloud Shell features

 -  Is temporary and requires a new or existing Azure Files share to be mounted.
 -  Offers an integrated graphical text editor based on the open-source Monaco Editor.
 -  Authenticates automatically for instant access to your resources.
 -  Runs on a temporary host provided on a per-session, per-user basis.
 -  Times out after 20 minutes without interactive activity.
 -  Requires a resource group, storage account, and Azure File share.
 -  Uses the same Azure file share for both Bash and PowerShell.
 -  Is assigned to one machine per user account.
 -  Persists $HOME using a 5-GB image held in your file share.
 -  Permissions are set as a regular Linux user in Bash.
