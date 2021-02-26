# Title

Working with users and the Django admin site

## Role(s)

- student
- developer

## Level

- intermediate

## Product(s)

- Django
- Azure App Services
- Visual Studio Code

## Prerequisites

- HTML/CSS
- Git
- npm
- Python

## Summary

Probably the most popular feature of Django is its built-in admin site, which allows internal users to manage data without having to create a special utility. We will explore how to configure users to use this site, and how to setup the site itself.

## Learning objectives

1. Permissions for the admin site
2. Creating users
3. Managing data
4. Managing permissions

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Permissions concepts | Permissions for the admin site | Exercise | Permissions for the admin site | yes |
| User types | Creating users | Exercise | Creating users | Yes |
| Allowing data to be modified in the admin site | Managing data | Exercise | Managing data | yes |
| Granting users permissions | Managing permissions | Exercise | Managing permissions | yes |

## Outline the units

1. **Introduction to the Django admin site**

    The Django admin site is a powerful utility for allowing business users to modify data. Django includes all the necessary tools for creating users and managing permissions.

1. **Exercise - Obtain the starter**

    To streamline this module, we provided a starter project you can use.

    1. Cloning the repository
    2. Installing the necessary libraries
    3. Open Visual Studio Code

1. **Permissions for the admin site**

    Whenever you are talking about data security becomes a key concern. We will explore how Django manages permissions for the admin site.

    - Permissions in Django
    - User types

1. **Exercise - Creating users**

    We will see how to create the superuser to allow administration of the site, and then individual users.

    - Creating superusers
    - Creating users

    1. Creating a superuser
    2. Accessing the admin site
    3. Creating a staff user

1. **Exercise - Managing data**

    Data isn't automatically accessible through the admin site. Fortunately, we can provide through a couple of lines of code. We'll see how to register the models, and modify data.

    - Registering models
    - Using the admin site

    1. Registering models for the admin site
    2. Modifying data in the admin site

1. **Exercise - Managing permissions**

    Let's explore how we can allow staff users to modify data

    - Update permissions
    - Test the user

    1. Update permissions for the staff user
    2. Logout of the admin site
    3. Login as the staff user
    4. Notice the available options

1. **Summary**

    We explored permissions in Django, and how to use the admin site.

1. **Knowledge check**

    What types of questions will test *learning objective*? *[(Knowledge check guidance)](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-knowledge-check)*

    - Multiple choice

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, etc.

- [Django](https://docs.djangoproject.com/)
