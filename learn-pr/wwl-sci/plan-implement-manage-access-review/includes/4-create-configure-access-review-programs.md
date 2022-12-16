Azure Active Directory (Azure AD) access reviews is a feature of Azure AD Identity Governance. Access reviews help to ensure that the right identities have the right access to the right resources in the organization. Access reviews can be implemented programmatically using the access reviews API in Microsoft Graph.

## Azure AD access reviews data model

The Azure AD access reviews feature adds the following resource types:

| **Resource type**    | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| accessReview         | The container represents an access review. Can be a one-time review, a recurring review series, or an instance of a recurring review.                                                                                                                                                                                                                                                                                                                               |
| businessFlowTemplate | Template for business flow determines the type resource on which an access review is to be performed. The identifier of a template, such as to review guest members of a group, is supplied by the caller when creating an access review. (The business flow template objects are read only, they're automatically generated when the global administrator onboards the tenant to use the access reviews feature. No other business flow templates can be created.) |
| program              | represents an Azure AD access review program. A program is a container, holding program controls. A tenant can have one or more programs. Each control links an access review to a program, to make it easier to locate related access reviews. Each tenant that has onboarded Azure AD access reviews has one program, `Default program`. A global administrator can create other programs, for example to represent compliance initiatives.                       |
| programControl       | represents a control, which links an access review to a particular program                                                                                                                                                                                                                                                                                                                                                                                          |
| programControlType   | the program control type is used when associating a control to a program, to indicate the type of access review the control is for. (The program control type objects are read only, they're automatically generated when the global administrator onboards the tenant to use the access reviews feature. No other program control types can be created.)                                                                                                           |

## Register an Azure AD application which has permissions to call the access reviews API in Graph

The Graph authorization model requires that an application must be consented by a user or administrator prior to accessing an organization’s data.

1. Open the Azure portal as a global administrator.
1. Navigate to the Azure AD extension, and select **App registrations** in the **Manage section**, to land at the page register apps
1. Select the **New application registration** button at the top of the page.
1. Provide a name for the application that is different from any other application in your tenant’s directory (example = `graphsample`).
1. Change the Application type to **Native**, and provide the following as the Redirect URI: `urn:ietf:wg:oauth:2.0:oob`
1. Select “Create”.
1. When the application is registered, copy the **Application ID** value, and save the value for later.
1. Select **Settings**, then select **Required permissions**.
1. Select **Add**. Choose **Select an API**, select **Microsoft Graph**, and then choose **Select**.
1. Azure AD access-reviews uses the following delegated permissions:
    
    
     -  Read all access reviews that use can access
     -  Manage all access reviews that user can access
     -  Read all programs that user can access
     -  Manage all programs that user can access. This example application requires only the permissions: **Read all access reviews that user can access** and **Read all programs that user can access**
1. Put a check in the box by those two permissions, and choose **Select**.
1. Select “Done”.

## Building blocks of the access review API

The access reviews API is structured logically and is composed of the following building blocks.

1. Access reviews schedule definition
    
    
     -  This is the logical blueprint that contains the settings of an access review and its instances. These settings include:
        
        
         -  The resources being accessed.
         -  The principals that access the resource.
         -  The reviewers who attest to the need for the principals to maintain access to resources.
         -  The frequency of the access review.
         -  The stages of the access review (for a multi-stage access review).
1. Access review instance
    
    
     -  Represents a single review activity, or occurrence, against which reviewers make decisions. An access review definition may have multiple instances as is the case in recurring reviews. One-off reviews have exactly one instance. For a multi-stage access review, each instance contains up to three stages.
1. Decision item recorded for a review
    
    
     -  Represents a decision that a reviewer made on an instance, including the time stamp and justification for the decision. Each review instance has as many decisions as the number of principals under review. If there are no decisions taken, that is, reviewers haven't responded to the review, there will be no decision objects for the instance.
