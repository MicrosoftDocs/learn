A scenario  where you need to manage existing Azure Data Shares is when you want to send datasets to additional people or organizations, and when you want to add or remove datasets. 

To add recipients to an existing data share navigate to the sent share and select the **Invitations** tab. 

Click **+Add Recipient** and specify the recipient that needs to gain access to that existing share. 

[ ![Add recipient to Azure Data Share](../media/sent-shares-invitation.png) ](../media/sent-shares-invitation.png#lightbox)

To add datasets to an existing share, where recipients might need to gain access to other datasets as well, you can add a dataset to the share so that you don’t have to set up a new data share. 

If you have recipients that no longer work for the company you shared your data with, you will need to revoke their access if they have already accepted the invitation. If the person did not accept the invitation, a simple delete of the invitation to a recipient will prevent them from creating the share subscription and they won’t receive any data that otherwise would have been shared. However, if the consumer already accepted the invitation, you will have to revoke their access to the share subscription. If you revoke the share subscription access from the consumers, you prevent the consumer from triggering snapshots. However, if the consumer previously has performed a snapshot, the latest data that they have will stay in their account. 
