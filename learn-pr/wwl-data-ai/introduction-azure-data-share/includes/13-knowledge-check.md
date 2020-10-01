##Multiple Choice
What is one of the two technical ways of sharing data within Azure Data Share?
(x)In-place sharing.{{Correct. There are two possible ways of sharing your data within Azure Data Share, one of them is In-Place Sharing the other is Snapshot-based Sharing. With in-place sharing, data providers can share data where it resides without copying the data.}} 
()External sharing.{{Incorrect. You can share data externally, however it is done through In-Place Sharing or Snapshot-based Sharing.}}
()Micro sharing.  {{Incorrect, only In-Place Sharing is correct in this context. The other way of sharing data within Azure Data Share is Snapshot-based Sharing but not External Sharing. Micro sharing is not a valid option.}}

##Multiple Choice
What action prevents access to an Azure Data Share of a recipient that already accepted the invitation and set up the share subscription:
()Delete the invitation. {{Incorrect. After the recipient has accepted the invitation and the share subscription is in place, access is not prevented through deleting the invitation. If the recipient did not accept the invitation yet, this would be possible}}
(x)Revoke access. {Correct. Since the recipient has already accepted the invitation and the share subscription has been created, you would have to revoke access in order to prevent access to the Data share}}
()Perform no action. Accepted invitations time out after 30 days. {{Incorrect. The invitation was already accepted, therefore deleting the invitation won’t prevent access to the Azure Data Share. Only revoking access will prevent access to the Data Share.Performing no action is not an option. Accepted invitations do not time out after 30 days, and you should revoke them.}}
