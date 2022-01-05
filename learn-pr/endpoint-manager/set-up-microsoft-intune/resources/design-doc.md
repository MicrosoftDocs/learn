# Title

Set up Microsoft Intune

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Microsoft Endpoint Manager
- Microsoft 365
- Microsoft Intune

## Prerequisites

- Basic knowledge of endpoint management
- Basic knowledge of Microsoft Endpoint Manager, Microsoft Intune

## Summary

Microsoft Intune, which is a part of Microsoft Endpoint Manager, provides the cloud infrastructure, the cloud-based mobile device management (MDM), the cloud-based mobile application management (MAM), and the cloud-based PC management for your organization. It lets you protect your organization by controlling features and settings on Android, Android Enterprise, iOS/iPadOS, macOS, and Windows 10/11 devices. It integrates closely with Azure Active Directory (Azure AD) for identity and access control and also Azure Information Protection to help protect your organization's data. If you have on-premises infrastructure, such as Exchange or an Active Directory, you can use Intune connectors to help you connect to external services. Intune is included in Microsoft's [Enterprise Mobility + Security (EMS) suite](https://www.microsoft.com/microsoft-365/enterprise-mobility-security?azure-portal=true).

In this module, you'll step through the process of setting up Microsoft Intune. Also, this module will provide the choices and considerations you need to make when setting up an endpoint management solution such as Intune. When you're complete, you'll have a better understanding of Intune's supported configurations. You'll have signed up for the Microsoft Intune's free trial. You'll add end users, define user groups, assign licenses to users, and configure the other needed settings to begin using Microsoft Intune. All of these steps will prepare you to add and manage devices and apps using Intune.

## Learning objectives

In this module, you will:

- Review the supported configurations
- Sign up for the Microsoft Intune trial
- Configure the Intune tenant domain name
- Add users to Intune
- Create groups in Intune
- Assign licenses to users
- Grant admin permissions for Intune
- Understand the MDM authority
- 
## Chunk your content into subtasks

Identify the subtasks of *Learn about paths to modern endpoint management*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Review the supported configurations, which include the supported operating systems and browsers | Understand the primary end user needs that should be addressed. | Knowledge check | 1 | Yes |
| Sign up for the Microsoft Intune trial | Step through the process of signing up for Microsoft Intune. | Knowledge check | 2 | Yes |
| Configure the Intune tenant domain name | Configure the Intune tenant domain name | Knowledge check | 3 | Yes |
| Add end users and define the groups that will be managed by Intune | Step through the process of adding users and groups to Intune | Knowledge check | 4,5 | Yes |
| Assign licenses to users so they can enroll devices in Intune | Step through the process of assigning licenses to end users. | Knowledge check | 6 | Yes |
| Grant admin permissions for Intune | Step through the process of assigning an MDM authority | Knowledge check | 7 | Yes |
| Confirm the Mobile Device Management (MDM) authority setting | Confirm the MDM authority | Knowledge check | 8 | Yes |

## Outline the units

1. **Introduction**

    Suppose that you're the administrator or business decision maker of a company with several thousand employees. You need to keep your corporate data safe by protecting data, apps, and devices that your employees use, as well as keep your employees productive and maximize the return on your investment. You and your company have determined that Microsoft Intune is the endpoint management solution that they want to use to manage end users devices, apps, and data. You currently have a limited Mobile Device Management solution. Learn how you can set up Microsoft Intune and [benefit from modern endpoint management](/learn/modules/benefits-microsoft-endpoint-manager?azure-portal=true).


2. **Review the supported configurations, which include the supported operating systems and browsers**

    List the content that will enable the learner to understand this module:
    - Enabling objective
        - Your objectives for the end users at your organization will likely focus on one or more of the following items:
            - Intune supported operating systems
            - Intune supported web browsers
            - Intune network configuration requirements
            - Intune bandwidth considerations

3. **Sign up for the Intune free trial**
   List the content that will enable the learner to understand this module:
    - Enabling objective
        - Your organization's endpoints will likely be focused to one or more of the following categories:
            - Sign up for the Intune free trial
            - Sign in to Microsoft Intune
            - View Microsoft Intune free trial details

4. **Configure Intune tenant domain name**
   List the content that will enable the learner to understand this module:
    - Enabling objective
        - To determine endpoint licensing for your organization, you must consider the following:
            - Add and verify your custom domain (OPTIONAL)
  
5. **Add users to Intune**
   List the content that will enable the learner to understand this module:
   - Enabling objective
       - Add individual Intune users one at a time
       - Add multiple Intune users at the same time
 
6. **Create groups in Intune**
   List the content that will enable the learner to understand this module:
   - Enabling objective
       - Add a new group
       - Groups and policies

7. **Assign licenses to users**
   List the content that will enable the learner to understand this module:
   - Enabling objective
       - Assign an Intune license to an individual user
       - Assign Intune licenses to multiple users

8. **Grant admin permissions for Intune**
   List the content that will enable the learner to understand this module:
   - Enabling objective
       - Give permissions in Microsoft Endpoint Manager admin center
       - Give permissions in Microsoft 365 admin center
       - Common types of administrators

9. **Understand the MDM authority**
   List the content that will enable the learner to understand this module:
    - Enabling objective
       - Learn how to create a rollout plan:
           - Confirm your tenant's MDM authority

7. **Knowledge check**

    What types of questions will test *Understand why you should migrate to a modern endpoint management solution.*? 

    - Question #1: Before you create users in Intune, you must first create an Intune license for each user.
        - Answer: False 
    - Question #2: When you sign up for a Microsoft service, you commonly create a tenant. Which statement best describes a tenant?
        - Answer: A tenant is a dedicated instance of Azure Active Directory (Azure AD) where your subscription to Intune is hosted. Your organization receives this tenant at the beginning of a relationship with Microsoft. It's in this Azure AD tenant that you register and manage your end user's devices and apps.
    - Question #3: Before you assign a role to a user in Intune, you must first assign the user an Intune license.
        - Answer: True

8. **Summary**

    This module provided the choices and considerations that are needed to set up the Microsoft Intune endpoint management solution. 
    
    In this module, you accomplished the following:
    
    - Reviewed the supported configurations, which include the supported operating systems, browsers, and network
    - Signed up for the Microsoft Intune trial
    - Configured the Intune tenant domain name
    - Added users to Intune
    - Created groups in Intune
    - Assigned licenses to users
    - Granted admin permissions for Intune
    - Learned about the Mobile Device Management (MDM) authority
    
    ## Next steps
    
    To determine your mobile device management and mobile application management next steps, see the following resources:
    
    - To become more familiar with Intune, walk through the [Microsoft Endpoint Manager tutorial](/mem/intune/fundamentals/tutorial-walkthrough-endpoint-manager?azure-portal=true).
    - [Plan your deployment with FastTrack experts included in EMS subscription](https://go.microsoft.com/fwlink/?linkid=2143850&azure-portal=true)
    
    ## Resources
    
    For more information about Microsoft Endpoint Manager, see the following resources:
    
    - [Microsoft Endpoint Manager documentation](/mem/?azure-portal=true)