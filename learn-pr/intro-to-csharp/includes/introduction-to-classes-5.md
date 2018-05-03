 `MakeDeposit` and `MakeWithdrawal`  will enforce the final two rules, or characteristics, of our bank account implementation that we listed at the start of this tutorial: that the initial balance must be positive, and that any withdrawal must not create a negative balance. 

This introduces the concept of ***exceptions***. The standard way of indicating that a method cannot complete its work successfully is to throw an exception. The type of exception and the message associated with it describe the error. Here, the `MakeDeposit` method *throws an exception* if the amount of the deposit is negative. The `MakeWithdrawal` method throws an exception if the withdrawal amount is negative, or if applying the withdrawal results in a negative balance. 

In your interactive window, update the implementation of `MakeDeposit` as follows:

```csharp
public void MakeDeposit(decimal amount, DateTime date, string note)
{
    if (amount <= 0)
    {
        throw new ArgumentOutOfRangeException(nameof(amount), "Amount of deposit must be positive");
    }
    var deposit = new Transaction(amount, date, note);
    allTransactions.Add(deposit);
}
```

As the preceding code illustrates, the method checks the amount being deposited and, if it is a negative amount, throws an exception. 

Ok, now let's update the implementation of `MakeWithdrawal` in the interactive window with the following code:

```csharp
public void MakeWithdrawal(decimal amount, DateTime date, string note)
{
    if (amount <= 0)
    {
        throw new ArgumentOutOfRangeException(nameof(amount), "Amount of withdrawal must be positive");
    }
    if (Balance - amount < 0)
    {
        throw new InvalidOperationException("Not sufficient funds for this withdrawal");
    }
    var withdrawal = new Transaction(-amount, date, note);
    allTransactions.Add(withdrawal);
}
```

Here we see that `MakeWithdrawal` is checking two things. It first makes sure someone doesn't attempt to withdraw a negative amount. It then makes sure that the amount the customer wants to withdraw is not greater than the existing balance on their account. Otherwise, the account would hold a negative balance after the withdrawal. If either check fails, an exception is thrown. 

Finally, let's update the constructor in `BankAccount`one more time. Rather than updating the balance with the `initialBalance` amount passed in as a parameter, it should now add an initial transaction by making the first deposit on this new account with `initialBalance`. 

In the interactive window, replace the `BankAccount` constructor with the following implementation:

```csharp
public BankAccount(string name, decimal initialBalance)
{
    this.Number = accountNumberSeed.ToString();
    accountNumberSeed++;

    this.Owner = name;
    MakeDeposit(initialBalance, DateTime.Now, "Initial balance");
}
```

Test our implementation by pasting the following lines into the interactive window after the class declarations and selecting ***Run*** on the interactive window:

```csharp
account.MakeWithdrawal(500, DateTime.Now, "Rent payment");
Console.WriteLine(account.Balance);
account.MakeDeposit(100, DateTime.Now, "friend paid me back");
Console.WriteLine(account.Balance);
```


Next, test that you are catching error conditions by trying to create an account with a negative balance in the interactive window using the following code:

```csharp
// Test that the initial balances must be positive:
try
{
    var invalidAccount = new BankAccount("invalid", -55);
}
catch (ArgumentOutOfRangeException e)
{
    Console.WriteLine("Exception caught creating account with negative balance");
    Console.WriteLine(e.ToString());
}
```

You use the [`try` and `catch` statements](../language-reference/keywords/try-catch.md) to mark a block of code that may throw exceptions, and to catch those errors that you expect. You can use the same technique to test the code that throws for a negative balance:

```csharp
// Test for a negative balance
try
{
    account.MakeWithdrawal(750, DateTime.Now, "Attempt to overdraw");
}
catch (InvalidOperationException e)
{
    Console.WriteLine("Exception caught trying to overdraw");
    Console.WriteLine(e.ToString());
}
```