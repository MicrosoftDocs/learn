The account number for our new `BankAccount` should be assigned when the object is constructed. But it shouldn't be the responsibility of the caller to create it. In the real world, the bank or financial institution would assign an account number using their own processes. In our example, the `BankAccount` class should have a way to assign new account numbers.  A simple way to do this is to start with a number and increment it when each new account is created. Finally, store the current account number when an object is constructed.

Add the following member declaration to the `BankAccount` class in the interactive window. We chose an arbitrary 10-digit number to act as the seed in this simple example:

```csharp
private static int accountNumberSeed = 1234567890;
```

The keyword `private` defines this variable as a private data member, which means it can only be accessed by code inside the `BankAccount` class. It's a way of separating the public responsibilities (like having an account number) from the private implementation (how account numbers are generated.)

Now add the following two lines to the constructor in the interactive window. This code sets the account number for the newly-created bank account. 

```csharp
this.Number = accountNumberSeed.ToString();
accountNumberSeed++;
```

Finally, select ***Run*** again to see how our output as changed.This time, you see that the account number is displayed in the output message. If you were to create multiple accounts using multiple `new` statements, what do you think happens to the account number?

Now that we can create a **BankAccount** object and initialize it, let's move on to the next step where we will add another class to represent a transaction on our account. 


At the end of the tutorial, you can check your knowledge with a quiz challenge.