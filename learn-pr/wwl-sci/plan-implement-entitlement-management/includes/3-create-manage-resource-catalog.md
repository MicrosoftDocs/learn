## Create an Azure account and add Azure Active Directory Premium P2 trial licenses

The tasks in this exercise require and Azure subscription. You'll also find the exercises in this learning path need an Azure subscription. You can use or to sign up for an Azure trial account. If you already have your own Azure subscription, you may skip this task.

1. In a web browser, go to [Azure portal](https://azure.microsoft.com/free/).
1. Scroll down through the page to learn more about the benefits and free services available.
1. Select **Start free**.
1. Use the wizard to sign up for your Azure trial subscription.
1. You'll need to an Azure AD P2 license to complete some of the exercises. In the organization you created, search for and then select **Azure Active Directory**.
1. In the left navigation menu, select **Getting started**.
1. Under Getting started with Azure AD, select **Get a free trial for Azure AD Premium**.
1. In the Activate pane, under **AZURE AD PREMIUM P2**, select **Free trial** and then select **Activate**.
1. In the navigation menu on the left, select **Overview**.
1. Refresh the browser until you see Azure AD Premium P2 under the organization name. It may take a couple of minutes.
1. The license may take a few minutes to activate. You may need to sign out and sign back into Microsoft Azure. Try restarting if you encounter problems with expected features not being available.

## Create a catalog

A catalog is a container of resources and access packages. You create a catalog when you want to group related resources and access packages. Whoever creates the catalog becomes the first catalog owner. A catalog owner can add other catalog owners.

1. Sign in to the [Azure portal](https://portal.azure.com/) as a Global administrator.
    
    
     -  Azure AD Premium P1, P2, EMS E3, or EMS E5 subscription.
     -  If you don't have one of these subscriptions, you can get Azure AD Premium or enable Azure AD Premium trial.
     -  One of the following administrator accounts for the directory you want to configure:
        
        
         -  Global Administrator
         -  Security Administrator
         -  Conditional Access Administrator
1. Open **Azure Active Directory** and the select **Identity Governance**.
1. In the left menu, under **Entitlement management**, select **Catalogs**.
1. On the top menu, select **+New Catalog**.
    
    :::image type="content" source="../media/identity-governance-catalog-16d8e5a1.png" alt-text="Screenshot of the Identity governance catalog page with the New catalog menu highlighted.":::
    
1. In the New catalog pane, in the **Name** box, enter **Marketing**.
1. In the **Description** box, enter **For marketing department users**. Users will see this information in an access package's details.
1. **Enabled for external users** allows users in selected external directories to be able to request access packages in this catalog. No changes will be made to this setting.
1. Under **Enabled, select No**. You may choose to enable the catalog for immediate use. You can disable if you intend to stage it or keep it unavailable. For this exercise, the catalog doesn't need to be enabled.
    
    :::image type="content" source="../media/new-catalog-marketing-0db0c001.png" alt-text="Screenshot of the New catalog pan with the Name, Description, Enabled, and Create options highlighted.":::
    
1. Select Create.

## Add resources to a catalog

To include resources in an access package, the resources must exist in a catalog. The types of resources you can add are groups, applications, and SharePoint Online sites. The groups can be cloud-created Microsoft 365 Groups or cloud-created Azure AD security groups. The applications can be Azure AD enterprise applications, including both SaaS applications and your own applications federated to Azure AD. The sites can be SharePoint Online sites or SharePoint Online site collections.

1. On the Identity Governance screen, if necessary, select **Catalogs**.
1. In the **Catalogs** list, select **Marketing**.
1. In the left navigation, under **Manage**, select **Resources**.
1. On the menu, select + **Add resources**.
1. In the Add resources to catalog screen, review the available options.
1. You might not have selected any resources in Groups and Teams, Applications, or SharePoint sites. To add a resource to the catalog, select a resource category, then select a resource from that category. For this exercise, it's okay to choose any resource you may have available.
    
    :::image type="content" source="../media/catalog-add-resources-ec6424b8.png" alt-text="Screenshot of the Add resources to a catalog screen within the creation of a new entitlement package.":::
    
1. When finished, select **Add**. These resources can now be included in access packages within the catalog.

## Add more catalog owners

The user that created a catalog becomes the first catalog owner. To delegate management of a catalog, you add users to the catalog owner role. This helps share the catalog management responsibilities.

1. In the Marketing catalog, in the left navigation menu, select Roles and administrators. If necessary, in the Azure portal, browse to **Azure Active Directory**, then **Identity Governance**, then **Catalogs** and then select **Marketing**.
    
    :::image type="content" source="../media/catalog-roles-admins-281217c1.png" alt-text="Screenshot of the Roles and administrators page for the Marketing catalog. Pick your catalog owner.":::
    
1. On the top menu, review the available roles and then select **+ Add owner**.
1. In the Select members pane, select your administrator account and then select **Select**.
1. Review the newly added role in the Roles and administrators list.

## Edit a catalog

You can edit the name and description for a catalog. Users see this information in an access package's details.

1. In the Marketing screen, in the left navigation, select **Overview**.
1. On the top menu, select **Edit**.
1. Review the setting and, under **Properties** in the **Enabled** field, select **Yes**.
    
    :::image type="content" source="../media/edit-marketing-catalog-20e3bd57.png" alt-text="Screenshot of the properties being enabled. Update the name of the package or its description.":::
    
1. Select **Save**.

## Delete a catalog

You can delete a catalog, but only if it doesn't have any access packages.

1. In the Marketing catalog’s Overview page, on the top menu, select Delete.
1. In the Delete dialog box, review the information and then select **Yes**.
