This exercise takes you through the process of creating Azure AD related entities, including an Azure AD tenant as well as user and group objects. You will use them in the subsequent exercises of this module to access Azure AD-integrated instance of Azure Database for PostgreSQL single server instance.

In this exercise, you will:

* Create Azure AD user and group objects in the Azure AD tenant associated with your Azure subscription
* Create an additional Azure AD tenant and a user object
* Create and configure an Azure AD guest user in the Azure AD tenant associated with your Azure subscription

## Prerequisites

* An Azure subscription
* A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription

## Create Azure AD user and group objects in the Azure AD tenant associated with your Azure subscription

You will start by creating Azure AD user and group objects. Once the objects are created, you will configure their respective group membership. To speed up the configuration tasks, you will leverage Azure CLI. You will rely on these Azure AD objects to authenticate to the Azure Database for PostgreSQL single server instance in the next exercise of this module.

1. Start a web browser, navigate to the [Azure portal](https://portal.azure.com/) and sign in to access the Azure subscription you will be using in this module.
1. In the Azure portal, open the **Cloud Shell** by clicking its icon in the toolbar next to the search text box.
1. If prompted to select either **Bash** or **PowerShell**, select **Bash**. 

    > [!NOTE]
    > If this is the first time you are starting Azure Cloud Shell and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and then select **Create storage**. 

1. Within the Bash session in the Azure Cloud Shell pane, run the following command to identify the default DNS domain name of the Azure AD tenant associated with the Azure subscription:

    ```azurecli-interactive
    UPN=$(az ad user list --query "[0].userPrincipalName" -o tsv)
    DOMAIN_NAME=${UPN#*@}
    ```

1. Run the following command to create an Azure AD user in the Azure AD tenant associated with the Azure subscription:

    ```azurecli-interactive
    ADMIN_NAME=adatumadmin1
    ADMIN=$(az ad user create --display-name $ADMIN_NAME \
                      --password Pa55w.rd1234 \
                      --user-principal-name $ADMIN_NAME@$DOMAIN_NAME \
                      --force-change-password-next-login false)
    ```

    > [!NOTE]
    > You will configure this user account as an Azure AD admin of the Azure Database for PostgreSQL single server instance in the next exercise.

1. Run the following command to identify the value of the userPrincipalName attribute of the Azure AD user you created in the previous step:

    ```azurecli-interactive
    echo $ADMIN | jq -r '.userPrincipalName'
    ```

    > [!NOTE]
    > Record this value. You will need it in the next exercise of this module.

1. Run the following command to assign to the newly created user the Contributor role in the Azure subscription you are using for the exercises in this module:

    ```azurecli-interactive
    ADMIN_OBJECT_ID=$(echo $ADMIN | jq -r '.objectId')
    SUBSCRIPTION_ID=$(az account show --query id --output tsv)
    az role assignment create --assignee "$ADMIN_OBJECT_ID" \
                              --role "Contributor" \
                              --scope "/subscriptions/$SUBSCRIPTION_ID"

    ```

1. Run the following command to create an Azure AD user in the Azure AD tenant associated with the Azure subscription:

    ```azurecli-interactive
    USER_NAME=adatumuser1
    USER=$(az ad user create --display-name $USER_NAME \
                      --password Pa55w.rd1234 \
                      --user-principal-name $USER_NAME@$DOMAIN_NAME \
                      --force-change-password-next-login false)
    ```

    > [!NOTE]
    > You will configure this user account as a non-privileged Azure AD user with access to a database on the Azure Database for PostgreSQL single server instance in the next exercise.

1. Run the following command to create an Azure AD group in the Azure AD tenant associated with the Azure subscription:

    ```azurecli-interactive
    GROUP_NAME=adatumgroup1
    GROUP=$(az ad group create --display-name $GROUP_NAME \
                             --mail-nickname $GROUP_NAME \
                             --description $GROUP_NAME)
    ```

    > [!NOTE]
    > You will use this group to assign permissions to the database on the Azure Database for PostgreSQL single server instance in the next exercise.

1. Run the following command to add the user to the group:

    ```azurecli-interactive
    USER_OBJECT_ID=$(echo $USER | jq -r '.objectId')
    az ad group member add --group $GROUP_NAME --member-id $USER_OBJECT_ID
    ```

1. Run the following command to assign to the newly created user the Contributor role in the Azure subscription you are using for the exercises in this module:

    ```azurecli-interactive
    SUBSCRIPTION_ID=$(az account show --query id --output tsv)
    az role assignment create --assignee "$USER_OBJECT_ID" \
                              --role "Contributor" \
                              --scope "/subscriptions/$SUBSCRIPTION_ID"

    ```

    > [!NOTE]
    > You will rely on this role assignment in the next exercise of this module.

1. Close the Cloud Shell pane.
1. To verify the outcome of this exercise, in the Azure portal, use the **Search resources, services, and docs** text box at the top of the Azure portal page to search for **Azure Active Directory** and, in the list of results, select **Azure Active Directory**.
1. On the blade displaying properties of your Azure Active Directory tenant, in the vertical menu, in the **Manage** sections, select **Users**.
1. On the **Users \| All users (Preview)** blade, verify that the list of users contains the user account you created earlier in this task.
1. Navigate back to the blade displaying properties of your Azure Active Directory tenant, in the vertical menu, in the **Manage** sections, select **Groups**.
1. On the **Groups \| All groups** blade, verify that the list of groups contains the group account you created earlier in this task.

## Create an additional Azure AD tenant and a user object

In this task, you will create an Azure AD tenant and a user account in the new tenant by using the Azure portal. In the next task, you will configure this user account as a guest user account in the first tenant.

1. In the web browser, on the Azure portal blade displaying properties of your Azure Active Directory tenant, in the toolbar, select **+ Create a tenant**. 

    | Setting | Value |
    | --- | --- |
    | Organization name | **Contoso** |
    | Initial domain name | any valid DNS name consisting of lower case letters and digits and starting with a letter | 
    | Country/Region | the name of your country or region |

1. On the **Review + create** tab of the **Create a tenant** blade, select **Create**.
1. Wait for the provisioning to complete and then select the **Contoso** link to navigate to the blade displaying properties of the Contoso Azure Active Directory tenant.
1. In the web browser, on the Azure portal blade displaying the **Contoso \| Overview** blade of the **Contoso** Azure Active Directory tenant, in the vertical menu, in the **Manage** sections, select **Users**.
1. On the **Users \| All users (Preview)** blade of the **Contoso - Azure Active Directory** tenant, select **+ New user**.
1. On the **New user** blade, ensure that the **Create user** option is selected and specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | User name | **contosuser1** |
    | Name | **contosouser1** |
    | Let me create the password | enabled |
    | Initial password | **Pa55w.rd1234** |

    > [!NOTE]
    > Use the **Copy to clipboard** icon next to the **User name** drop down list to record the value of the userPrincipalName attribute of **contosouser1**. You will need it later in this and subsequent exercises.

1. On the **New user** blade, select **Create**.
1. On the **Users \| All users (Preview)** blade of the **Contoso - Azure Active Directory** tenant, review the list of user accounts and verify that the new user account was created successfully. 

    > [!NOTE]
    > You will configure this user account as a non-privileged Azure AD user with access to a database on the Azure Database for PostgreSQL single server instance in the next exercise.


## Create and configure an Azure AD guest user in the Azure AD tenant associated with your Azure subscription

To conclude this exercise, you will use the Azure portal to configure the user account in the **Contoso** Azure AD tenant as a guest user in the **Adatum** Azure AD tenant, create a new group in that tenant, and add the guest user to that group.

1. In the web browser, on the Azure portal blade displaying the **Contoso \| Overview** blade of the **Contoso** Azure Active Directory tenant, in the toolbar, select the **Directory + Subscription** icon next to the **Cloud Shell** icon.
1. On the **Directory + subscription** blade, in the **Switch directory** section, select the entry representing the Azure AD tenant associated with the Azure subscription you are using in the exercises of this module.

    > [!NOTE]
    > This will automatically switch your session to the Azure AD tenant associated with the Azure subscription you are using in the exercises of this module.

1. In the Azure portal, use the **Search resources, services, and docs** text box at the top of the Azure portal page to search for **Azure Active Directory** and, in the list of results, select **Azure Active Directory**.
1. On the blade displaying properties of your Azure Active Directory tenant, in the vertical menu, in the **Manage** sections, select **Users**.
1. On the **Users \| All users (Preview)** blade, select **+ New guest user**.
1. On the **New user** blade, ensure that the **Invite user** option is selected and specify the following settings and select **Invite** (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | User name | **contosuser1** |
    | Email address | the value of the userPrincipalName attribute of **contosouser1** you recorded earlier in this task |
    | Personal message | **Welcome to Adatum** |

1. Navigate back to the blade displaying properties of your Azure Active Directory tenant, in the vertical menu, in the **Manage** sections, select **Groups**.
1. On the **Groups \| All groups** blade, select **adatumgroup1**.
1. On the **adatumgroup1** blade, select **Members**. 
1. On the **adatumgroup1 \| Members** blade, select **+ Add members**, on the **Add members** blade, in the **Search** text box, type **contosouser1**, in the list of results, select the **contosouser1** entry, and click **Select**.

Congratulations! You completed the first exercise of this module. In its exercise, you started by creating a user and a group in the Azure AD tenant associated with your Azure subscription, and adding the user to the group. Next, you created another Azure AD tenant and a user in that Azure AD tenant. Finally, you configured that user as a guest user in the Azure AD tenant associated with your Azure subscription, created another group in that tenant, and added the guest user to it.
