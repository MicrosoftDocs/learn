Microsoft Entra access reviews are a feature of Microsoft Entra ID Governance. Access reviews help to ensure that the right identities have the right access to the right resources in the organization. Access reviews can be implemented programmatically using the access reviews API in Microsoft Graph.

## Microsoft Entra access reviews data model

The Microsoft Entra access reviews feature adds the following resource types:

| **Resource type**    | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| accessReview         | The container represents an access review. Can be a one-time review, a recurring review series, or an instance of a recurring review.                                                                                                                                                                                                                                                                                                                               |
| businessFlowTemplate | Template for business flow determines the type resource on which an access review is to be performed. The identifier of a template, such as to review guest members of a group, is supplied by the caller when creating an access review. (The business flow template objects are read only, they're automatically generated when the global administrator onboards the tenant to use the access reviews feature. No other business flow templates can be created.) |
| program              | represents a Microsoft Entra access review program. A program is a container, holding program controls. A tenant can have one or more programs. Each control links an access review to a program, to make it easier to locate related access reviews. Each tenant that has onboarded Microsoft Entra access reviews has one program, `Default program`. A global administrator can create other programs, for example to represent compliance initiatives.          |
| programControl       | represents a control, which links an access review to a particular program                                                                                                                                                                                                                                                                                                                                                                                          |
| programControlType   | the program control type is used when associating a control to a program, to indicate the type of access review the control is for. (The program control type objects are read only, they're automatically generated when the global administrator onboards the tenant to use the access reviews feature. No other program control types can be created.)                                                                                                           |

## Register a Microsoft Entra ID application which has permissions to call the access reviews API in Graph

The Graph authorization model requires that an application must be consented by a user or administrator prior to accessing an organization’s data.

1.  Open the Azure portal as a global administrator.
2.  Navigate to the Microsoft Entra ID extension, and select **App registrations** in the **Manage section**, to land at the page register apps
3.  Select the **New application registration** button at the top of the page.
4.  Provide a name for the application that is different from any other application in your tenant’s directory (example = `graphsample`).
5.  Change the Application type to **Native**, and provide the following as the Redirect URI: `urn:ietf:wg:oauth:2.0:oob`
6.  Select “Create”.
7.  When the application is registered, copy the **Application ID** value, and save the value for later.
8.  Select **Settings**, then select **Required permissions**.
9.  Select **Add**. Choose **Select an API**, select **Microsoft Graph**, and then choose **Select**.
10. Microsoft Entra access-reviews uses the following delegated permissions:
    
    
     -  Read all access reviews that use can access
     -  Manage all access reviews that user can access
     -  Read all programs that user can access
     -  Manage all programs that user can access. This example application requires only the permissions: **Read all access reviews that user can access** and **Read all programs that user can access**
11. Put a check in the box by those two permissions, and choose **Select**.
12. Select “Done”.

## Building blocks of the access review API

The access reviews API is structured logically and is composed of the following building blocks.

1.  Access reviews schedule definition
    
    
     -  This is the logical blueprint that contains the settings of an access review and its instances. These settings include:
        
        
         -  The resources being accessed.
         -  The principals that access the resource.
         -  The reviewers who attest to the need for the principals to maintain access to resources.
         -  The frequency of the access review.
         -  The stages of the access review (for a multi-stage access review).
2.  Access review instance
    
    
     -  Represents a single review activity, or occurrence, against which reviewers make decisions. An access review definition might have multiple instances as is the case in recurring reviews. One-off reviews have exactly one instance. For a multi-stage access review, each instance contains up to three stages.
3.  Decision item recorded for a review
    
    
     -  Represents a decision that a reviewer made on an instance, including the time stamp and justification for the decision. Each review instance has as many decisions as the number of principals under review. If there are no decisions taken, that is, reviewers haven't responded to the review, there will be no decision objects for the instance.
