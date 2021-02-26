Django includes a built-in admin site which can be used to both manage the data in your application and security. This site is part of the default installation, and as we will see requires only a few lines of code to fully activate it. There is also a full authentication and authorization implementation, allowing you to control access to the admin site out of the box.

## Security and Django

Because Django is designed to streamline the creation of data driven web applications by providing the normal functionality required by these types of sites, an authentication and authorization mechanism is provided out of the box. You are free to expand and modify the included system by incorporating third party authenticators, multi-factor-authentication (MFA), or any other requirements your organization may have. We will explore the default implementation in this module.

## Exploring user types

Django has three main types of users by default - users, staff, and superusers. You have the ability to create your own types as well through groups or setting unique permissions.

### Access levels

Access | user | staff | superuser
-------|------|-------|----------
Admin site | no | yes | yes
Manage data | no | no | yes
Manage users | no | no | yes

You will notice by default staff users have access to the admin site, but do not have access to modify any data. You can set individual permissions or create groups as needed to provide the appropriate levels of access.

### Creating users

In order to create users in Django, you must first create a superuser. This is accomplished through the command `createsuperuser` from **manage.py**. After creating a superuser, you can access the admin site to create any additional users.

## The admin site

Creating a data-driven application means, by definition, working with data. Allowing internal business users access to modify the data as they see fit often requires quite a bit of code between security and the interface. Django provides an admin site which handles all of this for you!

Through the admin site, you can determine which users have access to what data. Users can then use the admin site to add new items, update existing items, and delete them, without needing to access the database directly or bypassing any of the validation rules you have implemented. Both the security model and interface is already created for you as part of the framework. All we need to do is activate our models so they appear in the site, which only requires a couple of lines of code.
