**Estimated Time**: 60 minutes

## Scenario

In this lab, you learn about Microsoft Dev Box, a self-service developer environment provisioning service that enables developers to create and manage their development environments. You implement a Microsoft Dev Box environment and customize it to meet the needs of your development team.

## Objectives

After completing this lab, you can:

- Implement a Microsoft Dev Box environment
- Customize a Microsoft Dev Box environment

## Requirements

- A Microsoft Entra tenant with three precreated user accounts (and, optionally three precreated Microsoft Entra groups) representing three different roles involved in Microsoft Dev Box deployments. For the sake of clarity, the user and group names in the lab instructions are matching the information in the following table:

  | User              | Group                        | Role                  |
  | ----------------- | ---------------------------- | --------------------- |
  | platformegineer01 | DevCenter_Platform_Engineers | Platform engineer     |
  | devlead01         | DevCenter_Dev_Leads          | Development team lead |
  | devuser01         | DevCenter_Dev_Users          | Developer             |

- An Azure subscription to host Microsoft Dev Box resources associated with the Microsoft Entra tenant hosting the user and group accounts
- A Microsoft Intune subscription associated with the same Microsoft Entra tenant as the Azure subscription
- A Microsoft Intune license assigned to the three precreated Microsoft Entra user accounts
- A GitHub repo created as a fork of https://github.com/microsoft/devcenter-catalog
- A GitHub repo created as a fork of https://github.com/dhruvchand/contoso-co-eShop

## Exercises

During this lab, you complete the following exercises:

- Exercise 1: Implement a Microsoft Dev Box environment.
- Exercise 2: Customize a Microsoft Dev Box environment

[:::image type="content" source="../media/launch-exercise-25d42425-89186225-a01e310c.png" alt-text="Screenshot of a launch button that will take you to the lab.":::
](https://go.microsoft.com/fwlink/?linkid=2300792)
