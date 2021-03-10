As highlighted earlier, you can add users with permissions to modify data through the admin site. Let's update the **staffuser** user we created in a prior exercise to have permissions to modify dogs.

## Set the user permissions

1. Return to the admin site in your browser
1. Click **Users**
1. Click **staffuser** to update our **staffuser**
1. Ensure **Staff status** is selected
1. Scroll down to **User permissions**
1. Select the following permissions
   - dog_shelters | dog | Can add dog
   - dog_shelters | dog | Can change dog
   - dog_shelters | dog | Can view dog

    > [!NOTE]
    > The page highlights you can select multiple permissions by using **Control** or **Command** and clicking on each item

1. Click the **Choose** button

    :::image type="content" source="../media/set-permissions.png" alt-text="Dialog box showing selected permissions." lightbox="../media/set-permissions.png":::

1. Click **SAVE**

## Login as the staff user

Let's see the difference between a superuser and staff user by logging in as a staff user.

1. Click **LOG OUT** in the upper right corner
1. Click **Login again**
1. Login as **staffuser** using the password you created earlier

    > [!NOTE]
    > If you forgot the password, you can login as your superuser and reset the password

1. Notice the admin page only allows access to **Dogs**

    :::image type="content" source="../media/staff-user-display.png" alt-text="Staff user page showing dogs as only administrative option." lightbox="../media/staff-user-display.png":::

1. Click **Dogs**
1. Click the dog you created earlier
1. Notice you have the ability to modify the dog, but not delete it

## Summary

We have now configured a staff user with limited permissions in the admin site. You can use this capability to control access to sensitive data in your application.
