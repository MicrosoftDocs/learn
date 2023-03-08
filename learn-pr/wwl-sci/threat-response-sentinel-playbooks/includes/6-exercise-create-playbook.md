
As a security engineer working for Contoso, you recently notice that a significant number of alerts are generated when someone deletes a virtual machine. You want to analyze such occurrences in the future and reduce the alerts generated for false positive occurrences.



## Exercise: Threat response using Microsoft Sentinel playbooks



You decide to implement a Microsoft Sentinel playbook to automate responses to an incident.



In this exercise, you'll explore the Microsoft Sentinel playbooks by performing the following tasks:



- Create a playbook to automate an action to respond to incidents.

- Create a playbook from the Microsoft Sentinel repository on GitHub.



> [!NOTE]

> You need to complete the Exercise Setup unit, in order to be able to complete this exercise. If you have not done so, complete it now, and then continue with the exercise steps.



### Task 1: Work with Microsoft Sentinel playbooks



1. In the Azure portal, search for and select Microsoft Sentinel, and select the previously created Microsoft Sentinel workspace.

2. In the **Microsoft Sentinel** panel, on the menu bar, in the **Configuration** section, select **Automation**.

3. On the top menu, select **Create** and **Add new playbook**.

4. In the  **Logic App** panel, on the **Basics** tab, specify the following settings:



    | **Settings** | **Value** |

    | --- | --- |

    | Subscription | Select your Azure subscription. |

    | Resource group | Select the resource group of your Microsoft Sentinel service. |

    | Logic App name | **ClosingIncident** *(you can choose any name)* |

    | Select the location | **Region** |

    | Location | Select the same location as the location of Microsoft Sentinel. |

    | Log Analytics | **Off** |



5. Select  **Review + Create**, and then select  **Create**.



    > [!NOTE]

    > Wait for the deployment to complete. The deployment should take less than 1 minute.



6. After the deployment is complete, select **Go to resource**.

7. In the **Logic Apps Designer** pane, scroll down and select **Blank Logic App.**

8. In the search field, enter and select **Microsoft Sentinel**.

9. On the **Triggers** tab, select **When a response to a Microsoft Sentinel alert is triggered (preview)**.



    :::image type="content" source="../media/06-azure-sentinel-trigger.png" alt-text="Screenshot of the Microsoft Sentinel trigger." border="true":::



10. On the **Microsoft Sentinel** page, set the drop-down menu to **Default Directory**, and then select **Sign in**.



    :::image type="content" source="../media/06-sign-in-aad-tenant.png" alt-text="Screenshot of the authorizing API connection." border="true":::



11. Provide the credentials for your Azure subscription, and then select **+ New step**.

12. In the **Choose an operation** window, in the search field,  select **Microsoft Sentinel**.

13. On the **Actions** tab, locate and select **Alert-Get incident (Preview)**.

14. In the **Alert-Get Incident (Preview)** window, provide the following inputs, and then select **+ New step**.



    > [!TIP]

    > When you select a field, a new window opens to help you fill these fields with dynamic content. On the **Dynamic content** tab, in the search box, you can start entering **Resource group** for example, and then you can select the entry from the list, as the following screenshot displays.



    :::image type="content" source="../media/06-get-incident.png" alt-text="Screenshot of Get Incident." border="true":::



    | Settings | Values |

    | --- | --- |

    | Specify subscription ID | **Subscription ID** |

    | Specify resource group | **Resource group** |

    | Specify workspace ID | **Workspace ID** |

    | Specify alert ID | **System Alert ID** |



15. In the **Choose an operation** window, in the search field,  select **Microsoft Sentinel**.

16. From the **Actions** tab, locate and select **Change incident status (Preview)**.

17. In the **Change incident status (Preview)** window, provide the following inputs:



    | Settings | Values |

    | --- | --- |

    | Specify subscription ID | **Subscription ID** |

    | Specify resource group | **Resource group** |

    | Specify workspace ID | **Workspace ID** |

    | Identifier | From the drop-down menu, select **Alert**. |

    | Specify alert / incident | **System Alert ID** |

    | Specify status | From the drop-down menu, select **Closed**. |

    | Close reason | From the drop-down menu select **Enter custom value**, and then enter **Incident Resolved**. |

    | Close reason text | Write descriptive text. |



    :::image type="content" source="../media/06-change-incident-status.png" alt-text="Screenshot of the Get Incident status." border="true":::



18. Choose **Save**, and then close the Logic Apps Designer.



### Task 2: Invoke an incident and review the associated actions



1. In the Azure portal, in the **Search resources, services, and docs** text box, enter **virtual machines**, and then select **Enter**.

2. On the **Virtual machines** page, locate and select the **simple-vm** virtual machine, and then on the header bar, select **Delete**.

3. In the **Delete virtual machine** prompt, select **Yes** to delete the virtual machine.



> [!NOTE]

> This task creates an incident based on the analytics rule that you created earlier in the exercise setup unit. Incident creation can take up to 15 minutes. Wait for it to complete before proceeding to the next step.



### Task 3: Assign the playbook to an existing incident



1. In the Azure portal, search for and select Microsoft Sentinel, and then select the previously created Microsoft Sentinel workspace.

2. On the **Microsoft Sentinel | Overview** page, on the menu bar, in the **Threat management** section, select **Incidents**.



    > [!NOTE]

    > Incident creation can take up to 15 minutes. Refresh the page until incident appears in the **Incidents** page.



3. On the **Microsoft Sentinel | Incidents** page, select the incident that has been created based on the deletion of the virtual machine.

4. In the details pane, select **View full details**.

5. On the **Incident** page, in the details pane, in the **Alerts** list, select the **View playbooks** link.

6. On the **Alert playbooks** page, select the **ClosingIncident** playbook, and then select **Run**.

7. Verify that you receive the message **Playbook was triggered successfully**.

8. Close the **Alert** page, and then close the **Incident** page to return to the **Microsoft Sentinel | Incidents** page.

9. In the **Microsoft Sentinel | Incidents** page, on the header bar, select **Refresh**. You'll notice that the incident disappears from the pane. On the **Status** menu, select **Closed**, and then select **OK**.



    > [!NOTE]

    > It could take up to 5 minute for Alerts to be shown as **Closed**



    :::image type="content" source="../media/06-header-refresh.png" alt-text="Screenshot of the header bar." border="true":::



10. Verify that the incident displays again and notice the **Status** column to check that it's **Closed**.



### Clean up the resources



1. In the Azure portal, search for **Resource groups**.

2. Select **azure-sentinel-rg**.

3. On the header bar, select **Delete resource group**.

4. In the **TYPE THE RESOURCE GROUP NAME:** field, enter the name of the resource group **azure-sentinel-rg** and select **Delete**.


