The Django ORM goes beyond only allowing you to interact with data. The Django ORM also allows you to create and update the database itself through a process known as migrations.

## Migrations

A migration is a collection of updates to be performed on a database's schema. A database schema is the definition of the database itself, including all tables and columns, and relationships between those tables. When we created our models, and defined the fields, we also defined the tables, columns, and relationships between those tables. We created our schema definition by creating our models!

Migrations are used to create and update the database as our models change. As you likely know, software is constantly changing, and how we define our models today may be different from how we define it tomorrow. Migrations abstract the process of updating the database away from us, allowing us to make changes to our models, and then use Django to perform the necessary changes to the database.

## Make a migration

To create a migration, you use the **makemigrations** command in **manage.py**. **makemigrations** will look at the current list of migrations to get a starting point, and then at the current state of your models to determine the delta (the changes that need to be made). It will then generate the necessary code to update the database. After executing, **makemigrations** will display the name of the migration.

```bash
python manage.py makemigrations
```

## Display the SQL for the migration

Any operations that take place inside a relational database require SQL (Structured Query Language). Django's migrations will generate the appropriate SQL when executed. While you can use the migration tools to update your database directly, in some environments there may be database administrators who will manage the process for you. To build the appropriate SQL statements, you can use **sqlmigrate**

```bash
python manage.py sqlmigrate <app_label> <migration_name>
```

> [!NOTE]
> **app_label** is the name of your app, typically the name of the folder which contains your app. **migration_name** is the name of the migration. You can also see the Python code for any app's migrations in its **migrations** folder.

## Display the list of migrations

If you want to see all migrations, you can use **showmigrations**

```bash
python manage.py showmigrations
```

## Perform a migration

The **migrate** command will execute a specific or all migrations on the database configured in **settings.py** in the root of your project folder. If you open **settings.py**, you will see a `DATABASES` section at the bottom. You will see a `default` option, which on a new project will be configured to use SQLite. You can configure different database connection strings in this section as needed.

```bash
python manage.py migrate <app_label> <migration_name>
```

> [!NOTE]
> **app_label** and **migration_name** are optional. If you do not provide either, all migrations will run. You will find yourself using this command quite frequently during development.
