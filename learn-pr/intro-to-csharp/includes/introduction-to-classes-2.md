The first feature to implement is to open a bank account. When a customer opens an account, they must supply an initial balance, and information about the owner of that account. In code, we do that by instantiating an object of type `BankAccount` and setting those values. In C#, a class ***constructor*** does this heavy lifting. 

 A constructor is a member of a class that has the same name as the class. It is used to initialize objects of that class type. 
 
 Add the following constructor to the `BankAccount` class in the interactive window:

```csharp
public BankAccount(string name, decimal initialBalance)
{
    this.Owner = name;
    this.Balance = initialBalance;
}
```

In this example, the constructor for our BankAccount class creates a new BankAccount object and sets values for `Owner` and `Balance` from the `name` and `initialBalance` input parameters respectively. 

Constructors are called when you create an object using [`new`](../language-reference/keywords/new.md) operator, as you'll see in the following example. Type or paste the following code block into the interactive coding window, replacing `<name>` with, for example, your own name. Place it after the closing curly bracket, `}`, of the class definition.  

```csharp
var account = new BankAccount("AccountName", 1000);
Console.WriteLine($"Account {account.Number} was created for {account.Owner} with {account.Balance} initial balance.");
```

 Now select the ***Run*** button in the interactive windows to run what we have so far. Observe the message in the output pane of the interactive window telling you that the account was created with the name and initial balance you passed into the constructor. 

 Did you notice that the account number in this output message is blank? We'll fix that in the next step. 

At the end of the tutorial, you can check your knowledge with a quiz challenge.
