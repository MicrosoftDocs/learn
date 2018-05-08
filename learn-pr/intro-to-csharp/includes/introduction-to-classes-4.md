Money flows into and out of your account by  making deposits and withdrawals respectively. As you can see from the code we have so far, we will represent these two *actions* or *behaviors* on an account with the `MakeDeposit` and `MakeWithdrawal` *methods* on our class. In programming terms, we say that we are *encapsulating* the operations necessary to make a deposit on an account with the `MakeDeposit` method. Similarly, the operations needed to make a withdrawal are encapsulated in a method called `MakeWithdrawal`. Before we implement these methods, let's create another class, or type, to represent each transaction on an account. 

 We'll implement deposits and withdrawals by creating a journal of every transaction for the account. That has a few advantages over simply updating the balance on each transaction. The history can be used to audit all transactions and manage daily balances. By computing the balance from the history of all transactions when needed, any errors in a single transaction that are fixed will be correctly reflected in the balance on the next computation.

 Let's start by creating a new type to represent a transaction. This is a simple type that doesn't have any responsibilities. It needs a few properties. In the interactive window, add the following class, just below the `BankAccount` class declaration.

 ```csharp
public class Transaction
{
    public decimal Amount { get; }
    public DateTime Date { get; }
    public string Notes { get; }

    public Transaction(decimal amount, DateTime date, string note)
    {
        this.Amount = amount;
        this.Date = date;
        this.Notes = note;
    }
}
```

We'll create a `Transaction` object every time a deposit or withdrawal is made on the account. To create a journal to hold all this transaction history, we'll need a new class member variable in our `BankAccount` class that can store a collection of objects. 

In the `BankAccount` class, add the following private data member:

 ```csharp
 private List<Transaction> allTransactions = new List<Transaction>();
 ```

Now, let's change how the `Balance` is calculated.  It can now be found by summing the values of all transactions. 

In the interactive window, modify the declaration of the `Balance` property in the `BankAccount` class  to the following:

```csharp
public decimal Balance 
{
    get
    {
        decimal balance = 0;
        foreach (var item in allTransactions)
        {
            balance += item.Amount;
        }

        return balance;
    }
}
```

The `Balance` property now calculates the current balance whenever someone accesses it. The implementation of the `get` accessor calculates the balance by enumerating all transactions in our `allTransactions` list and returns the sum as the current balance. In the next step, we'll implement `MakeDeposit` and 'MakeWithdrawal` to take advantage of this transaction journal. 


At the end of the tutorial, you can check your knowledge with a quiz challenge.
