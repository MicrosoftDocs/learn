As highlighted earlier, you can add users with permissions to modify data through the admin site. Let's update the **staffuser** user we created in a prior unit to have permissions to modify dogs.

## Set the user permissions

1. Return to the admin site in your browser.
1. Select **Users**.
1. Select **staffuser** to update our **staffuser**.
1. Ensure **Staff status** is selected.
1. Scroll down to **User permissions**.
1. Select the following permissions:
   - dog_shelters | dog | Can add dog
   - dog_shelters | dog | Can change dog
   - dog_shelters | dog | Can view dog

    > [!NOTE]
    > The page highlights that you can select multiple permissions by using **Control** or **Command** and selecting each item.

1. Select **Choose**.

    :::image type="content" source="../media/set-permissions.png" alt-text="Screenshot showing a dialog box with selected permissions." lightbox="../media/set-permissions.png":::

1. Select **SAVE**.

## Sign in as the staff user

Let's see the difference between a superuser and a staff user by signing in as a staff user.

1. Select **LOG OUT** in the upper-right corner.
1. Select **Login again**.
1. Sign in as **staffuser** by using the password you created earlier.

    > [!NOTE]
    > If you forgot the password, you can sign in as your superuser and reset the password.

   Notice that the admin page only allows access to **Dogs**.

    :::image type="content" source="../media/staff-user-display.png" alt-text="Staff user page showing Dogs as the only administrative option." lightbox="../media/staff-user-display.png":::

1. Select **Dogs**.
1. Select the dog you created earlier.

   Notice that you can modify the dog, but not delete it.

## Summary

We've now configured a staff user with limited permissions in the admin site. You can use this capability to control access to sensitive data in your application.
