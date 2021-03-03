When creating projects, the admin interface is automatically created, but it does not configure any user access. In order to login the Django admin site we now need to create our first user - a superuser.

## Creating a superuser

1. Open a new **terminal** window in Visual Studio Code by selecting **Terminal** > **New terminal**.
1. Ensure the virtual environment is activated by executing the following code:

    ```bash
    # Windows
    .\\venv\\Source\\Activate

    # Linux or macOS
    source ./venv/bin/activate
    ```

1. Create a superuser by executing the following command

    ```bash
    python manage.py createsuperuser
    ```

1. Complete the process by answering the questions provided by the wizard, including the username you wish to use, an email address, and a password

> [!NOTE]
> The password must be complex according to Django's standards, which means at least 8 characters, and a combination of upper/lowercase letters, special characters and numbers. If you don't meet the complexity rules Django will ask if you want to override the requirements, which is typically not recommended.

## Logging into the admin site

With the admin user has been created it is time for our first login to the Django admin interface. During the project setup earlier in this module we started the server, so our admin site is already active.

1. Navigate to http://localhost:8000/admin 

    ![Django Admin Login] <Missing media: ../media/Module3_DjangoAdminLogin.PNG>

1. Enter the username and password you created earlier

    Once you have successfully logged into the admin site you should see a screen that looks like below.

    ![Django Admin Interface] <Missing media: Module3_DjangoAdmin.PNG>

1. Click **users**

    You will now see the list of users, which will include the one you created.

    ![Django Admin Users] <Missing media: Module3_DjangoAdminSeeUsers.PNG>

## Create a staff user

1. Click **ADD USER** in the upper right corner
1. Provide a **Username** of **staffuser**
1. Provide a **Password** and **Password confirmation** which meets the complexity requirements
1. Click **SAVE**
1. On the next screen, select **Staff status** to make the new user a staff user

    :::image type="content" source="../media/staff-user.png" alt-text="Screenshot showing the User options window.":::
1. Click **SAVE**
