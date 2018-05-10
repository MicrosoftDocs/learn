To finish this tutorial, let's write the `GetAccountHistory` method that creates a `string` for the transaction history. 

Add this method to the `BankAccount` class in the interactive window:

```csharp
public string GetAccountHistory()
{
    var report = new System.Text.StringBuilder();

    report.AppendLine("Date\t\tAmount\tNote");
    foreach (var item in allTransactions)
    {
        report.AppendLine($"{item.Date.ToShortDateString()}\t{item.Amount}\t{item.Notes}");
    }

    return report.ToString();
}
```

`GetAccountHistory` uses the **StringBuilder** class to format a string that contains one line for each transaction. 

To test this method, use the interactive window to add make some deposits and withdrawals and then call `GetAccountHistory`.  For example, copy and paste the following below your class definitions in the interactive window and select ***Run*** to observe the output. 

```csharp
var account = new BankAccount("Foo", 1000);
Console.WriteLine($"Account {account.Number} was created for {account.Owner} with {account.Balance} initial balance.");

account.MakeWithdrawal(500, DateTime.Now, "Rent payment");
Console.WriteLine(account.Balance);
account.MakeDeposit(100, DateTime.Now, "A friend paid me back");
Console.WriteLine(account.Balance);
account.MakeDeposit(1000000, DateTime.Now, "Just won the lottery!");
Console.WriteLine(account.Balance);
Console.WriteLine(account.GetAccountHistory());
```


Congratulations! You've completed this tutorial. As a next step, try the quiz that follows. You can also see the source for this tutorial [classes-quickstart](https://github.com/dotnet/samples/tree/master/csharp/classes-quickstart/) folder of our samples repo in GitHub. 