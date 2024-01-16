Once you have keys and secrets stored in the key vault it's important to think about a rotation strategy. There are several ways to rotate the values:

 -  As part of a manual process
 -  Programmatically by using API calls
 -  Through an Azure Automation script

This diagram shows how Event Grid and Function Apps can be used to automate the process.

:::image type="content" source="../media/az500-key-vault-rotation-0d01efe7.png" alt-text="Screenshot showing how an Event Grid and Function Apps can be used to automate the process.":::


1.  Thirty days before the expiration date of a secret, Key Vault publishes the "near expiry" event to Event Grid.
2.  Event Grid checks the event subscriptions and uses HTTP POST to call the function app endpoint subscribed to the event.
3.  The function app receives the secret information, generates a new random password, and creates a new version for the secret with the new password in Key Vault.
4.  The function app updates SQL Server with the new password.
