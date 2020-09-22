When you have set up an Azure Data Share, you need to think of monitoring the shares that you’ve sent out. 
There are different aspects you can monitor in relation to the data sharing relationships. 
Examples include  monitoring the acceptance of the data consumer of the invitation you sent out, as well as checking if the created shared subscription is in place to see if the data consumer used the data that you’ve shared.  In relation to the snapshot sharing you might want to monitor if there were triggers of the snapshots into your Azure Subscription. 

In order to monitor the invitation status that you’ve sent, you can check in the Azure portal in Sent shares -> Invitations 

There are 3 states of the invitation:

1.	*Pending:* this means that the recipient of the shared dataset has not accepted the invitation (yet)
2.	*Accepted:* The Data Share Recipient has indeed accepted your invitation to start sharing data
3.	*Rejected:* The Data share recipient has declined the invitation. 

If by accident, you sent a dataset that needed to be shared with another recipient, then deleting the invitation after is has been accepted, won’t revoke the access. If you need the access to the dataset be revoked, you should do so through revoke access in the share subscription tab. 

In order to monitor the share subscriptions, you can check the status in the Azure portal if you navigate to Sent Shares -> Share subscriptions. In this tab you can find the details about the subscriptions that are active and created by the data consumers once they’ve accepted your invitation. As mentioned, if you want to stop updates to the data consumer, you should revoke the access to the share by selecting the share subscription and revoke. You can also check in the history tab of the share, when data is copied from you as a data provider, to the data consumer’s data store where parameters such as duration, frequency and status of each snapshot can be monitored. 
If you’ve selected a snapshot based share, you’re able to view more details if you check the run start date. You will be able to view the following extra details (for up to 30 days, that is displayed):

1.	The status for every dataset you’ve shared
2.	The amount of data that was transferred
3.	The number of files copied
4.	The duration of the snapshot
5.	The number of vCores used
6.	Possible error messages

In order to see and save more than the 30 days of history that is displayed, you can use the diagnostic setting in which you save log data/events that is of interest. 
