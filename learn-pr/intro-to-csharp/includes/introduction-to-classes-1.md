This tutorial introduces the concept of classes. To illustrate the concept, we'll walk through the creation of a class to represent a bank account. 

> [!NOTE]
> This tutorial makes extensive use of the .NET Editor interactive window. We will insert and run code into the window and update the code as we progress through the tutorial. 

Object-oriented programming (OOP) languages, such as C#, organize types of objects into *classes*.  In our example, our fictitious bank account is a type of object - a representation of the funds you have entrusted to your favorite financial institution. 

In this tutorial, our bank account supports the following behaviors:

1. It has a 10-digit number that uniquely identifies the bank account.
2. It has a string that stores the name or names of the owners.
3. The balance can be retrieved.
4. It accepts deposits.
5. It accepts withdrawals.
6. The initial balance must be positive.
7. Withdrawals cannot result in a negative balance.

The bank account *class* we will implement throughout this tutorial will encapsulated all of the behaviors we've listed. 

Type the following code in the interactive window:

```csharp
    public class BankAccount
    {
        public string Number { get; }
        public string Owner { get; set; }
        public decimal Balance { get; }

        public void MakeDeposit(decimal amount, DateTime date, string note)
        {
        }

        public void MakeWithdrawal(decimal amount, DateTime date, string note)
        {
        }
    }
```

This code creates the basic definition of a type, or class, we will call BankAccount. Think of a class declaration as the blueprint for creating objects of this type. Let's examine this code further.

`public class BankAccount` defines the class, or type, you are creating. The name of our class is `BankAccount`. Everything inside the curly brackets `{` and `}` of the class declaration defines the behavior of the class. There are five ***members*** of the `BankAccount` class. The first three are ***properties***. Properties are data elements and can have code that enforces validation or other rules. The last two are ***methods***. Methods are blocks of code that perform a single function. We always try to make the names of all members of our class self-descriptive. Reading the names of each of the members should provide enough information for you or another developer to understand what the class does.

Now that we have a class definition, let's create an object of this type from it. 

At the end of the tutorial, you can check your knowledge with a quiz challenge.