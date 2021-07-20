Choose the best response for each question. Then select Check your answers.

## Multiple Choice
What is cloud tiering in Azure File Sync?
(x) It's a feature that archives infrequently accessed files to free up space on the local file share. {{That's correct. Cloud tiering allows frequently accessed files to be cached on the local server. Infrequently accessed files are tiered, or archived, to the Azure file share according to the policy created.}}
( ) It's a policy that prioritizes the sync order of file shares. {{That's incorrect. Cloud tiering does not prioritize the sync order of file shares. }}
( ) It's a policy that sets the frequency at which the sync job runs. {{That's incorrect. Cloud tiering does not set the job frequency.}}

## Multiple Choice
A local manufacturing company runs dedicated software in their warehouse to keep track of stock. The software needs to run on machines in the warehouse, but the management team wants to access the output from the main office. The limited bandwidth available in the warehouse has caused problems in the past when they tried to use cloud-based solutions. What is the best way to sync these files with the cloud?
( ) Create an Azure Files share and directly mount shares on the machines in the warehouse. {{That's incorrect. Is there a more efficient answer?}}
(x) Use a machine in the warehouse to host a file share, install Azure File Sync, and share a drive with the rest of the warehouse. {{That's correct. This answer is best because the low bandwidth means Azure File Sync will handle the updating and syncing of files efficiently over the low-bandwidth network.}}
( ) Install Azure File Sync on every machine in the warehouse and head office. {{That's incorrect. Is there a more efficient answer?}}

## Multiple Choice
Which of the following best describes the Azure File Sync agent?
(x) It's installed on a server to enable Azure File Sync replication between the local file share and an Azure file share. {{That's correct. The Azure File Sync agent is a downloadable package that enables a Windows Server file share to be synced with an Azure file share.}}
( ) It's installed on a server to set NTFS permissions on files and folders.  {{That's incorrect. Azure File Sync does not configure file permissions.}}
( ) It's installed on an Azure file share to control on-premises file and folder replication traffic. {{That's incorrect. Azure File Sync is not just an on-premises agent.}}
