When you create projects, the admin interface is automatically created, but it doesn't configure any user access. To sign in to the Django admin site, we now need to create our first user, which is a superuser.

## Create a superuser

1. Open a new **terminal** window in Visual Studio Code by selecting **Terminal** > **New terminal**.
1. Ensure the virtual environment is activated by running the following code:

    ```bash
    # Windows
    .\\venv\\Source\\Activate

    # Linux or macOS
    source ./venv/bin/activate
    ```

1. Create a superuser by running the following command:

    ```bash
    python manage.py createsuperuser
    ```

1. Complete the process by answering the questions provided by the wizard. Enter the username you want to use, an email address, and a password.

> [!NOTE]
> The password must be complex according to Django's standards, which means at least eight characters and a combination of upper- and lowercase letters, special characters, and numbers. If you don't meet the complexity rules, Django will ask if you want to override the requirements, which isn't recommended.

## Sign in to the admin site

After the admin user has been created, it's time for our first sign-in to the Django admin interface. During the project setup earlier in this module, we started the server, so our admin site is already active.

1. Go to http://localhost:8000/admin.

    :::image type="content" source="../media/admin-login.png" alt-text="Screenshot showing the Django admin sign-in page.":::

1. Enter the username and password you created earlier.

    After you've successfully signed in to the admin site, you should see a screen that looks like the following one.

    :::image type="content" source="../media/admin.png" alt-text="Screenshot showing the Django admin interface.":::

1. Select **Users**.

    You'll now see the list of users, which includes the user you created.

    :::image type="content" source="../media/user-list.png" alt-text="Screenshot showing the list of Django admin users.":::

## Create a staff user

1. Select **ADD USER** in the upper-right corner.
1. Enter a **Username** for the **staffuser**.
1. Enter a **Password** that meets the complexity requirements, and confirm the password.
1. Select **SAVE**.
1. On the next screen, select **Staff status** to make the new user a staff user.

    :::image type="content" source="../media/staff-user.png" alt-text="Screenshot showing the user options window.":::
1. Select **SAVE**.
