The Django ORM goes beyond allowing you to interact with data. You can also use it to create and update the database itself through a process known as migrations.

## Migrations

A migration is a collection of updates to be performed on a database's schema. A database schema is the definition of the database itself, including all tables and columns, and relationships between those tables. 

When we created our models and defined the fields, we also defined the tables, columns, and relationships between those tables. We created our schema definition by creating our models!

Migrations are used to create and update the database as our models change. As you likely know, software is constantly changing. How we define our models today might be different from how we define them tomorrow. Migrations abstract the process of updating the database away from us. We can then make changes to our models and use Django to perform the necessary changes to the database.

## Make a migration

To create a migration, you use the `makemigrations` command in *manage.py*. The `makemigrations` command uses the current list of migrations to get a starting point, and then uses the current state of your models to determine the delta (the changes that need to be made). It then generates the necessary code to update the database. After `makemigrations` runs, it displays the name of the migration.

```bash
python manage.py makemigrations
```

## Display the SQL for the migration

Any operations that happen inside a relational database require Structured Query Language (SQL). Django's migrations generate the appropriate SQL when they're run. Although you can use the migration tools to update your database directly, some environments might have database administrators who will manage the process for you. 

To build the appropriate SQL statements, you can use `sqlmigrate`.

```bash
python manage.py sqlmigrate <app_label> <migration_name>
```

> [!NOTE]
> The `app_label` part is the name of your app, typically the name of the folder that contains your app. The `migration_name` part is the name of the migration. You can also see the Python code for any app's migrations in its *migrations* folder.

## Display the list of migrations

If you want to see all migrations, you can use `showmigrations`.

```bash
python manage.py showmigrations
```

## Perform a migration

The `migrate` command runs a specific migration or all migrations on the database configured in *settings.py* in the root of your project folder. 

If you open *settings.py*, you'll see a `DATABASES` section at the bottom. This section includes a `default` option, which on a new project is configured to use SQLite. You can configure different database connection strings in this section as needed.

```bash
python manage.py migrate <app_label> <migration_name>
```

> [!NOTE]
> The `app_label` and `migration_name` parts are optional. If you don't provide either, all migrations will run. You'll use this command often during development.
