Here's a challenge to help you practice what you've learned about methods and interfaces. You'll also apply lessons from previous modules, such as creating and using your own package.

## Create a package to manage an online store

Write a program that uses a custom package to manage an online store. Your challenge includes the following four elements:

1. Create a custom type called `Account` that includes the first and last name of the account owner. The type must also include the functionality to `ChangeName`.

2. Create another custom type called `Employee` that includes a variable to store the number of credits (`float64`) and that embeds the `Account` object. The type must also include the functionality to `AddCredits`, `RemoveCredits`, and `CheckCredits`. You need to demonstrate that you can change the account name via the `Employee` object.

3. Write a Stringer method to your `Account` object so that the `Employee` name can be printed out in a format that includes the first and last name.

4. Finally, write a program that consumes the package you created, and test all the functionality listed in this challenge. That is, the main program should change the name, print the name, add credit, remove credit, and check the balance.
