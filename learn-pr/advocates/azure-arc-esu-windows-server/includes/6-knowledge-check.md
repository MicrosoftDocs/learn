Question 1). You want to delegate the task of creating and assigning ESUs to Azure Arc endabled Windows Server 2012 computers to your subordinate. You want to follow the principle of least privilege. Which Azure RBAC role should you assign to the subordinate so the are able to create and assign ESUs to these Arc enabled servers? 

A)  Contributor role. To create and assign ESUs to Arc-enabled servers you'll need the Contributor Azure RBAC role.

B)  Reader role. To create and assign ESUs to Arc-enabled servers you'll need the Contributor Azure RBAC role. The Reader role does not have the required permissions. 

C)  Owner role. Whilst you could use the Owner role to create and assign ESUs to Arc-enabled servers, this role includes more permissions than is necessary. The most appropriate role to use is the Contributor Azure RBAC role.

Question 2). You have 20 Windows Server 2012 R2 servers that are hosted on an isolated subnet that has no connectivity to the internet. You want to activate these servers for extended security updates and then deploy the updates manually. Which of the following tools could you use to accomplish this goal?

A)  Windows Deployment Services. Incorrect. You cannot use Windows Deployment Services to deploy software updates.

B)  Windows Server Update Services. Incorrect. Whilst Windows Server Update Services can be used to deploy software updates, you cannot use Windows Server Update Services to activate ESUs.

C)  Volume Activation Management Tool. Correct. For computers that are unable to directly communicate with the Internet, you can activate ESUs using the Volume Activation Management Tool (VAMT) in conjunction with the VAMT ESU configuration file.

D)  Azure Arc. Incorrect. Azure Arc requires that the servers be connected to the internet.

Question 3). What is the minimum number of physical cores that you can license when obtaining an ESU license?

A)  4 cores. Incorrect. If you choose to license based on physical cores, the licensing requires a minimum of 16 physical cores per license. If you choose to license based on virtual cores, the licensing requires a minimum of eight virtual cores per Virtual Machine.

B)  8 cores. Incorrect. If you choose to license based on physical cores, the licensing requires a minimum of 16 physical cores per license. If you choose to license based on virtual cores, the licensing requires a minimum of eight virtual cores per Virtual Machine.

C)  16 cores. Correct. If you choose to license based on physical cores, the licensing requires a minimum of 16 physical cores per license. If you choose to license based on virtual cores, the licensing requires a minimum of eight virtual cores per Virtual Machine.

D)  2 cores. Incorrect. If you choose to license based on physical cores, the licensing requires a minimum of 16 physical cores per license. If you choose to license based on virtual cores, the licensing requires a minimum of eight virtual cores per Virtual Machine.