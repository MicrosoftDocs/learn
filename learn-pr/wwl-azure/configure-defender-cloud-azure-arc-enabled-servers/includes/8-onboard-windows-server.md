The Windows onboarding script includes the Azure cloud, connectivity, resource, and authentication settings you selected in the Azure portal. It doesn't require Log Analytics workspace credentials.

To connect a Windows server:

1. Copy `OnboardingScript.ps1` to the target server.
2. Sign in to the server with an account that's a member of the local Administrators group.
3. Open an elevated 64-bit Windows PowerShell prompt.
4. Change to the folder that contains the script, and then run it:

    ```powershell
    .\OnboardingScript.ps1
    ```

5. Complete the interactive Azure sign-in when the script prompts you.
6. Run the following command and confirm that **Agent Status** is **Connected**:

    ```powershell
    azcmagent show
    ```

Alternatively, verify the connection on the **Machines - Azure Arc** page in the Azure portal. If onboarding fails, review the logs in `%ProgramData%\AzureConnectedMachineAgent\Log`.
