This unit provides step-by-step instructions for creating and implementing an application hiding Rule Set, which "hides" the Google Chrome browser for specific users.

1.  Open the **FSlogix Rules Editor**.
    
    :::image type="content" source="../media/introduction-apps-rule-editor-051fc618.png" alt-text="Screenshot displays the Create new Rule Set.":::
    
2.  Select **File -&gt; New** to create a new Rule Set.
3.  Enter the name *Google\_Chrome*`.`
4.  Select **Enter file name to create the Rule Set** and open the rule wizard dialog.
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-555e3e00.png" alt-text="Screenshot displays the New Rule Set.":::
    
5.  Select **Choose from installed** programs.
6.  select **Google Chrome**.
7.  Select **Scan**.
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-wizard-fdd9e241.png" alt-text="Screenshot displays the Rule Set Wizard.":::
    
8.  When complete, the **Scan** button changes. Select **OK** to display the automatic hiding rules.
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-wizard-scan-complete-84912eae.png" alt-text="Screenshot displays the Application scan complete.":::
    
9.  The **Rule Editor** now displays all the items to be hidden that are related to Google Chrome.
    
    :::image type="content" source="../media/apps-one-rule-editor-new-rule-set-rules-aaee51d5.png" alt-text="Screenshot displays the Rule Set rules.":::
    

## Test your hiding rules

Testing your hiding rules on the system where the rules were created is one way to validate the rules work as intended.

To test the hiding rules:

1.  **Be sure the Google\_Chrome** Rule Set is selected in the left pane.
2.  From the action bar, select **Apply Rules to System**.
    
    :::image type="content" source="../media/apps-two-rule-editor-new-rule-set-rules-aa726129.png" alt-text="Screenshot displays for applying rules for the system.":::
    
3.  When complete, select **Apply Rules to System** and the rules no longer apply.

## Create assignments for your Rule Set

Rule Set Assignments specify how and to whom the Rules in the Rule Set apply.

1.  Be sure the **Google\_Chrome** Rule Set is selected in the left pane.
2.  From the action bar, select **Manage Assignments**.
    
    :::image type="content" source="../media/apps-three-rule-editor-new-rule-set-rules-e99f4c56.png" alt-text="Screenshot displays the Manage Assignments.":::
    
3.  Select **Add**.
4.  Select **Group**.
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-manage-assignments-add-095d48aa.png" alt-text="Screenshot displays the Select Assignments.":::
    
5.  The **Select Group** dialog box appears.
6.  Select the '*Person*' icon to the right of the **Group** textbox.
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-manage-assignments-select-5d9c83ea.png" alt-text="Screenshot displays the AD Group.":::
    
7.  Type '*Domain Users*' and select **OK**.
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-ad-group-b3924e44.png" alt-text="Screenshot displays the Domain Users.":::
    
8.  The Assignments window displays:
    
    
     -  '*Everyone*', Applies '*No*'
     -  '*CONTOSO\\Domain Users*', Applies '*Yes*'
    
    :::image type="content" source="../media/apps-rule-editor-new-rule-set-assignments-f5a73a51.png" alt-text="Screenshot displays the Assignments.":::
    
9.  Select **OK** and you've successfully created an assignment for your **Rule Set**.

## Deploy Rule Sets

FSLogix Rule Sets are saved as two (2) separate files:

 -  Assignment file (.fxa)
 -  Rule File (.fxr)

Rule Set files should be copied to the virtual machine. Copy the files to `C:\Program Files\FSLogix\Apps\Rule`s. Once the files are copied to this location, the FSLogix Apps Services uses them immediately.
