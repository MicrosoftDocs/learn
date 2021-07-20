Choose the best response for each question. Then select Check your answers.

## Multiple Choice
A company uses an Azure storage account for storing large numbers of video and audio files. Containers store each type of file and access should be limited to those files. Additionally, the files can only be accessed through shared access signatures. The company wants to be able to revoke access to the files and to change the period for which users can access the files. Which of the following is the easiest way to meet the requirement?
( ) Create an SAS for each user and delete the SAS to prevent access. {{That's incorrect. Creating a SAS for each user would involve a great amount of administrative overhead. Is there another alternative?}}
(x) Implement stored access policies for each container to enable revocation of access or change of duration. {{That's correct. SAS will  change access based on permissions or duration by replacing the policy with a new one or deleting it altogether to revoke access.}}
( ) Periodically regenerate the account key to control access to the files. {{That's incorrect. Regenerating keys would prevent all users from accessing all files at the same time.}}

## Multiple Choice
When configuring network access to your Azure Storage Account, what is the default network rule?
(x) To allow all connections from all networks. {{That's correct. The default network rule is to allow all connections from all networks. }}
( ) To allow all connection from a private IP address range. {{That's incorrect. By default the IP address is not considered.}}
( ) To deny all connections from all networks. {{That's incorrect. All connections are not, by default, denied. }}

## Multiple Choice
The company is planning a delegation model for the Azure storage. Apps in the production environment must have unrestricted access to storage resources. Which of the following is the best course of action?
( ) Use shared access signatures for the production apps. {{That's incorrect. Shared access signatures is not the best solution for the production app.}}
(x) Use access keys for the production apps.  {{That's correct. Access keys provide unrestricted access to the storage resources, which is the requirement for production apps in this scenario.}}
( ) Use Stored Access Policies for the production apps. {{That's incorrect. Stored Access Policies are not the best solution for the production app. }}
 
