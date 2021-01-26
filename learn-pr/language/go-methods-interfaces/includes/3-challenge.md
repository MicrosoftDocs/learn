To practice what you've learned about methods and interfaces, here's a challenge for a program to practice what you saw in this module, as well as what you've seen in previous modules like creating your own package and using it.

## Create a package to manage an online store

Write a program that uses a custom package that you write to manage an online store.

1. Start by creating a custom type called `Account` with the first and last name of a person and it has to include the functionality to `ChangeName`
2. Once you're done with the `Account` type, you need to create another custom type called `Employee` with a variable to store the number of credits (`float64`) and that also embeds the `Account` object. Additionally, it has to include the functionality to `AddCredits`, `RemoveCredits`, and `CheckCredits`. You need to demonstrate that you can change the account's name via the Employee object.
3. Then, write a Stringer method to your Account object so that the Employee name can be printed out in a format that includes the first and last name.
4. Finally, write a program that consumes the package you created and test all the listed functionality in this challenge. For instance, the main program should change the name, print out the name, add credit, remove credit, and check the balance.
