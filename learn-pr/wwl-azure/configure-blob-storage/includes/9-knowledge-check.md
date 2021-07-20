Choose the best response for each question. Then select Check your answers.

## Multiple Choice
Which of the following is true about Azure blob storage access tiers? 
( ) The cool access tier is for frequent access of objects in the storage account.  {{That's incorrect. The cool access tier is for infrequently used storage objects.}}
( ) The hot access tier is for storing large amounts of data that is infrequently accessed. {{That's incorrect. The hot access tier is for frequently accessed storage objects.}}
(x) The administrator can switch between hot and cool performance tiers at any time.  {{That's correct.}}

## Multiple Choice
Which of these changes between access tiers will happen immediately?
(x) Hot to Cool  {{That's correct. Changes between hot and cool, and to archive, happen immediately.}}
( ) Archive to Cool {{That's incorrect. Changes from the archive tier do not happen immediately. }}
( ) Archive to Hot {{That's incorrect. Changes from the archive tier do not happen immediately. }}

## Multiple Choice
Which of the following is true about blob object replication?
( ) Object replication doesn't require versioning to be enabled. {{That's incorrect. Object replication requires that blob versioning be enabled on both the source and destination accounts.}}
(x) Object replication doesn't support blob snapshots. {{That's correct. Any snapshots on a blob in the source account are not replicated to the destination account.}}
( ) Object replication is supported in the archive tier. {{That's incorrect. Object replication is supported when the source and the destination accounts are in the hot or cool tier.}}
 
