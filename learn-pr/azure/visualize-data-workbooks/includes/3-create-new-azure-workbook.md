 Workbooks provide a canvas for creating interactive visual reports. In this exercise, you will create a new workbook, add some descriptive text and a parameter to query your resources. By the end of this unit, you will have a simple report that shows the distribution of your resources on a map.


## Deploy resources for the exercise using the Azure CLI 

1. The first thing we will do is activate the Azure sandbox and deploy an ARM template containing all the Azure resources we need for this exercise. Activate the Azure sandbox.
1. Create a resource group.
1. If requested, create storage for the resource.
1. Run these commands to deploy the Azure resource group and resources:

    ```azurecli
       git clone https://github.com/MicrosoftDocs/ms-learn-azure-monitor-workbooks.git
       cd ms-learn-azure-monitor-workbooks/Resources/
       resourceGroup=<rgn>[sandbox resource group name]</rgn>
       az deployment group create --resource-group $resourceGroup --template-file deploy-resources.bicep
    ```
1. When you are prompted for an admin user name, enter an admin username. For example, enter `LearnAdmin`.
1. When you are prompted for a password, enter a password that complies with the password requirements. For example, enter `Learn@123456`. Write this password down, you will need it later. 
    The password must:
    - Be at least 12 characters long
    - Contain at least 3 out of the following 4 characteristics:
        - one lower case letter
        - one upper case letter
        - one number
        - one special character, not including `\` or `-`.
1. 

## Create a workbook
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Add some descriptive text
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Add a control to let the user pick a subscription
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

## Add map visualization
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->


## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

