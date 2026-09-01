In this exercise, you perform actions to troubleshoot.

### Task 1: Use diagnose and solve problem tool

In this task, you use Azure diagnose and solve problems tool to troubleshoot issues of Azure NetApp Files.

1. From the Azure portal, select Diagnose and solve problems from the left navigation pane.
2. From the Diagnose and solve problems page, select the problem type.

    :::image type="content" source="../media/diagnose-problem-types.png" alt-text="Screenshot of Azure portal navigation showing problem type tiles in Diagnose and solve problems for Azure NetApp Files." border="true" lightbox="../media/diagnose-problem-types.png":::

3. After specifying the problem type, select an option (problem subtype) from the pull-down menu to describe the specific problem you're experiencing. Then follow the on-screen directions to troubleshoot the problem.

    :::image type="content" source="../media/exercise-problem-subtype.png" alt-text="Screenshot of Diagnose and solve problems page showing problem subtype selection." border="true" lightbox="../media/exercise-problem-subtype.png":::

4. This page presents general guidelines and relevant resources for the problem subtype you select. In some situations, you might be prompted to fill out a questionnaire to trigger diagnostics. If issues are identified, the tool presents a diagnosis and possible solutions.

    :::image type="content" source="../media/exercise-guidance-page.png" alt-text="Screenshot of troubleshooting guidance page with diagnostic recommendations." border="true" lightbox="../media/exercise-guidance-page.png":::

### Task 2: Troubleshoot user access on LDAP volumes

In this task, you validate user connectivity and access to LDAP-enabled volumes based on group membership

1. In the volume page, select an LDAP-enabled volume, and select **LDAP Group ID List** under **Support & Troubleshooting**.
2. Enter the user ID and select **Get group IDs**.

    :::image type="content" source="../media/exercise-ldap-group-ids.png" alt-text="Screenshot of LDAP Group ID List page showing user ID input and group ID results." border="true" lightbox="../media/exercise-ldap-group-ids.png":::

3. The portal displays up to 256 results even if the user is in more than 256 groups. You can search for a specific group ID in the results.

### Task 3: Troubleshoot file locks on an Azure NetApp Files volume

In this task, you learn to break file locks on NFS, SMB, or dual-protocol volumes that need to be cleared, Azure NetApp Files allows you to break these locks.

You can break file locks for all files in a volume or break all file locks initiated by a specified client. Breaking file locks may be disruptive.

1. Navigate to the volume you want to break file locks on. In the Volume menu under Support & Troubleshooting, navigate to Break File Locks.
2. To break file locks for a specific client connected to a volume, enter an IP address in the **Client IP** field. To break file locks for all clients connected to a volume, leave the **Client IP** field empty.
3. Select **Break File Locks**.

    :::image type="content" source="../media/exercise-break-file-locks.png" alt-text="Screenshot of Break File Locks page with Client IP option and action button." border="true" lightbox="../media/exercise-break-file-locks.png":::

4. Confirm you understand that breaking file locks may be disruptive.
