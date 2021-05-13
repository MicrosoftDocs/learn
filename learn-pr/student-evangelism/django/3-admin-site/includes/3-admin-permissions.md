Django includes a built-in admin site that can be used to manage the data in your application and security. This site is part of the default installation. As we'll see, it requires only a few lines of code to fully activate it. Django also includes a full authentication and authorization implementation, which you can use to control access to the admin site.

## Security and Django

Django is designed to streamline the creation of data-driven web applications by providing the normal functionality that's required by these types of sites. Django provides an authentication and authorization mechanism, and you're free to expand and modify the included system. You can incorporate third-party authenticators, multifactor authentication, or any other requirements your organization might have. We'll explore the default implementation in this module.

## Explore user types

Django has three main types of users by default: users, staff, and superusers. You can create your own types by making groups or setting unique permissions.

### Access levels

Access | User | Staff | Superuser
-------|------|-------|----------
Admin site | No | Yes | Yes
Manage data | No | No | Yes
Manage users | No | No | Yes

By default, staff have access to the admin site but not to modify any data. You can set individual permissions or create groups as needed to provide the appropriate levels of access.

### Create users

To create users in Django, you must first create a superuser. Use the command `createsuperuser` from **manage.py** to create a superuser. After you create a superuser, you can access the admin site to create any other users.

## The admin site

Creating a data-driven application means, by definition, working with data. Allowing internal business users access to modify the data as they see fit often requires quite a bit of code between security and the interface. Django provides an admin site that handles this process for you.

Through the admin site, you can determine which users have access to what data. Users can then use the admin site to add, update, and delete items. They don't need to access the database directly or bypass any of the validation rules you've implemented. The security model and interface are already created for you as part of the framework. All you need to do is activate your models so they appear in the site, which requires only a couple of lines of code.
