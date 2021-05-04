Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

## Complicated Permissions Challenge

In this challenge, you'll implement business rules that restrict access to users based on their permissions and their level.  You'll display a different message to the user depending on their permissions and level.

### Step 1 - Delete all of the code in the .NET Editor from the earlier exercise.

Select all of the code in the .NET Editor, and to delete it, select the `del` or backspace key.

### Step 2: Add code as a starting point

To test your Boolean expression logic, use the following code of sample data.

```csharp-interactive
string permission = "Admin|Manager";
int level = 55;
```

To sufficiently test all of the scenarios described in Step 3, you may need to use additional data.

> [!IMPORTANT]
> To determine whether the `permission` variable's value contains one of the permission values you'll be checking for in the "business rules", use the `Contains()` helper method of a string.  Example: `permission.Contains("Admin")` would return `true`.

### Step 3 - Implement business rules

**Business Rules**

1. If the user is an Admin with a level greater than 55, output the message:

   ```output
   Welcome, Super Admin user.
   ```

2. If the user is an Admin with a level less than or equal to 55, output the message:
 
   ```output
   Welcome, Admin user.
   ```

3. If the user is a Manager with a level 20 or greater, output the message:

   ```output
   Contact an Admin for access.
   ```

4. If the user is a Manager with a level less than 20, output the message:

   ```output
   You do not have sufficient privileges.
   ```

5. If the user is not an Admin or a Manager, output the message:

   ```output
   You do not have sufficient privileges.
   ```

### Step 4 - Make sure you get the output given the sample data

When you run the code, including the sample data from Step 2, you should see the following output:

```output
Welcome, Admin user.
```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
