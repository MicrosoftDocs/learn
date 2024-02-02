In this module, you've learned how you can use self-service password reset (SSPR) in Microsoft Entra ID to allow users to reset their forgotten or expired passwords. An administrator doesn't have to do the password reset. SSPR is secured by authentication methods of your choice. These methods can include a mobile authentication app, a code sent to you by an SMS text message, or security questions. 

SSPR helps reduce the amount of work required from administrators. It also minimizes the productivity impact for users when they forget their password.

## Clean up

Remember to clean up after you've finished.

- **Delete the user you created in Microsoft Entra ID**: Go to **Microsoft Entra ID** > **Manage** > **Users**. Check the box next to the user and select **Delete**. Select **OK**.
- Delete the group you created in Microsoft Entra ID. Go to **Microsoft Entra ID** > **Manage** > **Groups**. Check the box next to the group and select **Delete**. Select **OK**.
- Turn off self-service password reset. Go to **Microsoft Entra ID** > **Manage** > **Password reset**. Under **Self service password reset enabled**, select **None**. Select **Save**.

If you created a Premium trial Microsoft Entra tenant for this module, you can delete the tenant 30 days after the trial has expired.

## Learn more

- [Tutorial: Enable users to unlock their account or reset passwords using Microsoft Entra self-service password reset](/azure/active-directory/authentication/tutorial-enable-sspr)
- [How it works: Microsoft Entra self-service password reset](/azure/active-directory/authentication/concept-sspr-howitworks)
- [Deploy Microsoft Entra self-service password reset](/azure/active-directory/authentication/howto-sspr-deployment)
