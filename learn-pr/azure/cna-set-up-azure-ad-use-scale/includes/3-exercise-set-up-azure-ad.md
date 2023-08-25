This exercise takes you through the process of creating and managing Azure AD-related entities, including Azure AD tenants, users and groups. You will start by creating a user account and two groups in the Azure AD tenant associated with your subscription, and adding the user to the first group. Then you will create another Azure AD tenant and a user account in that tenant. To conclude this exercise, you will add the user account from the second tenant as a guest account in the first tenant. In the subsequent exercises of this module, you will implement integration between an Azure Database for PostgreSQL single server instance and the first Azure AD tenant, and grant access to its content to the two previously created groups.

In this exercise, you'll:

* Create Azure AD user and group objects in the Azure AD tenant associated with your Azure subscription.
* Create an additional Azure AD tenant and a user object.
* Create and configure an Azure AD guest user in the Azure AD tenant associated with your Azure subscription.

## Prerequisites

To perform this exercise, you need:

* An Azure subscription.
* A Microsoft account or an Azure AD account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription.

    > [!NOTE]
    > The exercises in this module perform sensitive operations and require very high privileges so, as such, should be performed within an isolated lab environment. If you don't have access to such an environment, consider using for this purpose an Azure Trial subscription.

## Create Azure AD user and group objects in the Azure AD tenant associated with your Azure subscription

You'll start by creating Azure AD user and group objects. After the objects are created, you'll configure their respective group memberships. To speed up the configuration tasks, you'll use Azure CLI. You'll rely on the Azure AD objects to authenticate to the Azure Database for PostgreSQL single server instance in the next exercise of this module.

1. Start a web browser, navigate to the [Azure portal](https://portal.azure.com/?azure-portal=true) and sign in to access the Azure subscription you'll be using in this module.
1. In the Azure portal, open the **Cloud Shell** by selecting its icon in the toolbar next to the search text box.
1. If needed, select **Bash**.

    > [!NOTE]
    > If this is the first time you're starting Azure Cloud Shell and you're presented with the **You have no storage mounted** message, select the subscription you're using in this exercise, and then select **Create storage**.

1. Within the Bash session on the **Azure Cloud Shell** pane, run the following command to identify the default DNS domain name of the Azure AD tenant associated with the Azure subscription:

    ```azurecli
    DOMAIN_NAME=$(az rest --method GET --url 'https://management.azure.com/tenants?api-version=2020-01-01' --query "value[0].defaultDomain" -o tsv)
    ```

1. Run the following command to create an Azure AD user in the Azure AD tenant associated with the Azure subscription:

    ```azurecli
    ADMIN_NAME=adatumadmin1
    ADMIN=$(az ad user create --display-name $ADMIN_NAME \
                      --password Pa55w.rd1234 \
                      --user-principal-name $ADMIN_NAME@$DOMAIN_NAME \
                      --force-change-password-next-sign-in false)
    ```

    > [!NOTE]
    > You'll configure this user account as an Azure AD admin of the Azure Database for PostgreSQL single server instance in the next exercise.

1. Run the following command to identify the value of the **userPrincipalName** attribute of the Azure AD user you created in the previous step:

    ```azurecli
    echo $ADMIN | jq -r '.userPrincipalName'
    ```

    > [!NOTE]
    > Record this value. You'll need it in the next exercise of this module.

1. Run the following commands to assign to the newly created user the Contributor role in the Azure subscription you're using for the exercises in this module:

    ```azurecli
    ADMIN_OBJECT_ID=$(echo $ADMIN | jq -r '.id')
    SUBSCRIPTION_ID=$(az account show --query id --output tsv)
    az role assignment create --assignee "$ADMIN_OBJECT_ID" \
                              --role "Contributor" \
                              --scope "/subscriptions/$SUBSCRIPTION_ID"

    ```

    > [!NOTE]
    > The second command will return the ID of your default subscription. If you intend to use a different subscription, you need to set the value of the $SUBSCRIPTION_ID variable accordingly.

1. Run the following command to create an Azure AD user in the Azure AD tenant associated with the Azure subscription:

    ```azurecli
    USER_NAME=adatumuser1
    USER=$(az ad user create --display-name $USER_NAME \
                      --password Pa55w.rd1234 \
                      --user-principal-name $USER_NAME@$DOMAIN_NAME \
                      --force-change-password-next-sign-in false)
    ```

    > [!NOTE]
    > You'll configure this user account as a non-privileged Azure AD user with access to a database on the Azure Database for PostgreSQL single server instance in the next exercise.

1. Run the following command to create an Azure AD group in the Azure AD tenant associated with the Azure subscription:

    ```azurecli
    GROUP_NAME=adatumgroup1
    GROUP=$(az ad group create --display-name $GROUP_NAME \
                             --mail-nickname $GROUP_NAME \
                             --description $GROUP_NAME)
    ```

    > [!NOTE]
    > You'll use this group to assign permissions to the database on the Azure Database for PostgreSQL single server instance in the next exercise.

1. Run the following command to add the user to the group:

    ```azurecli
    USER_OBJECT_ID=$(echo $USER | jq -r '.id')
    az ad group member add --group $GROUP_NAME --member-id $USER_OBJECT_ID
    ```

1. Run the following command to assign to the newly created user the Contributor role in the Azure subscription you're using for the exercises in this module:

    ```azurecli
    SUBSCRIPTION_ID=$(az account show --query id --output tsv)
    az role assignment create --assignee "$USER_OBJECT_ID" \
                              --role "Contributor" \
                              --scope "/subscriptions/$SUBSCRIPTION_ID"

    ```

    > [!NOTE]
    > You'll rely on this role assignment in the next exercise of this module.

1. Close the **Cloud Shell** pane.
1. To verify the outcome of this exercise, in the Azure portal, use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **Azure Active Directory**.
1. In the list of results, select **Azure Active Directory**.
1. On the blade displaying properties of your Azure AD tenant, in the vertical menu, in the **Manage** sections, select **Users**.
1. On the **Users \| All users** blade, verify that the list of users contains the user account you created previously in this task.
1. Navigate back to the blade displaying properties of your Azure AD tenant, and in the vertical menu, in the **Manage** sections, select **Groups**.
1. On the **Groups \| All groups** blade, verify that the list of groups contains the group account you created previously in this task.

## Create an additional Azure AD tenant and a user object

In this task, you'll create an Azure AD tenant and a user account in the new tenant by using the Azure portal. In the next task, you'll configure this user account as a guest user account in the first tenant.

1. In the web browser, on the Azure portal blade displaying properties of your Azure AD tenant, select **Manage tenants** and then select **+ Create**.
1. On the **Basics** tab of the **Create a tenant** blade, ensure that the **Azure Active Directory** option is selected and select **Next: Configuration >**.
1. On the **Configuration** tab of the **Create a tenant** blade, specify the following settings:

    | Setting | Value |
    | --- | --- |
    | Organization name | **Contoso** |
    | Initial domain name | Any valid DNS name consisting of lowercase letters and digits and starting with a letter |
    | Country/Region | The name of your country or region |

1. Select **Review + create** and, on the **Review + create** tab of the **Create a tenant** blade, select **Create**.
1. If prompted, on the **Help us prove you're not a robot**, enter the provided code, and then select **Submit**.
1. Wait for the provisioning to complete and then select the **Contoso** link to navigate to the blade displaying properties of the Contoso Azure AD tenant.
1. In the web browser, on the Azure portal blade displaying the **Contoso \| Overview** blade of the **Contoso** Azure AD tenant, in the vertical menu, in the **Manage** sections, select **Users**.
1. On the **Users \| All users** blade of the **Contoso - Azure Active Directory** tenant, select **+ New user**, then select **Create new user**.
1. On the **Create new user** blade, specify the following settings, while leaving the other settings with their default values:

    | Setting | Value |
    | --- | --- |
    | User name | **contosouser1** |
    | Name | **contosouser1** |
    | Let me create the password | Enabled |
    | Initial password | **Pa55w.rd1234** |

1. Use the **Copy to clipboard** icon next to the **User name** drop-down list to record the value of the **User principal name** attribute of **contosouser1**. You'll need it later in this and subsequent exercises.

1. On the **New user** blade, select **Create**.
1. On the **Users \| All users** blade of the **Contoso - Azure Active Directory** tenant, review the list of user accounts and verify that the new user account was created successfully.

    > [!NOTE]
    > You'll configure this user account as a non-privileged Azure AD user with access to a database on the Azure Database for PostgreSQL single server instance in the next exercise.

## Create and configure an Azure AD guest user in the Azure AD tenant associated with your Azure subscription

To conclude this exercise, you'll use the Azure portal to configure the user account in the **Contoso** Azure AD tenant as a guest user in the **Adatum** Azure AD tenant, create a new group in that tenant, and add the guest user to that group.

1. In the web browser, on the Azure portal blade displaying the **Contoso \| Overview** blade of the **Contoso** Azure AD tenant, in the toolbar, in the upper right corner, select the **Subscriptions** icon next to the **Cloud Shell** icon, and then select the **Switch directory** link. 
1. On the **Directories + subscriptions** blade, select the entry representing the Azure AD tenant associated with the Azure subscription you're using in the exercises of this module, and then select **Switch**.

    > [!NOTE]
    > This will automatically switch your session to the Azure AD tenant associated with the Azure subscription you're using in the exercises of this module.

1. In the Azure portal, use the **Search resources, services, and docs** text box at the beginning of the Azure portal page to search for **Azure Active Directory** and, in the list of results, select **Azure Active Directory**.
1. On the blade displaying properties of your Azure Active Directory tenant, in the vertical menu, in the **Manage** sections, select **Users**.
1. On the **Users \| All users** blade, select **+ New user**, then select **Invite external user**.
1. On the **Invite external user** blade, ensure that the **Invite user** option is selected, specify the following settings while leaving the other settings with their default values, select **Review + invite**, and then select **Invite**:

    | Setting | Value |
    | --- | --- |
    | Email address | The value of the User principal name attribute of **contosouser1** you recorded earlier in this task |
    | Display name | **contosouser1** |
    | Invitation message | **Welcome to Adatum** |

1. Navigate back to the blade displaying the properties of your Azure Active Directory tenant, and then, in the vertical menu, in the **Manage** sections, select **Groups**.
1. On the **Groups \| All groups** blade, select **adatumgroup1**.
1. On the **adatumgroup1** blade, select **Members**.
1. On the **adatumgroup1 \| Members** blade, select **+ Add members**.
1. On the **Add members** blade, in the **Search** text box, enter **contosouser1**.
1. In the list of results, select the **contosouser1** entry, and then select **Select**.

## Results

Congratulations! You've completed the first exercise of this module. You started this exercise by creating a user and a group in the Azure AD tenant associated with your Azure subscription, and then adding the user to the group. Next, you created another Azure AD tenant and a user in that Azure AD tenant. Finally, you configured that user as a guest user in the Azure AD tenant associated with your Azure subscription, created another group in that tenant, and added the guest user to it.
