The Linux onboarding script includes the Azure cloud, connectivity, resource, and authentication settings you selected in the Azure portal. It doesn't require Log Analytics workspace credentials.

To connect a Linux server:

1. Copy `OnboardingScript.sh` to the target server.
2. Sign in to the server with an account that has root access.
3. Change to the folder that contains the script, and then run it:

    ```bash
    chmod +x ./OnboardingScript.sh
    ./OnboardingScript.sh
    ```

4. Complete the interactive Azure sign-in when the script prompts you.
5. Run the following command and confirm that **Agent Status** is **Connected**:

    ```bash
    azcmagent show
    ```

Alternatively, verify the connection on the **Machines - Azure Arc** page in the Azure portal. If onboarding fails, review the logs in `/var/opt/azcmagent/log`.
