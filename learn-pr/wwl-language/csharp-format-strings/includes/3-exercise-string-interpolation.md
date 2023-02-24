Suppose we want to print a receipt for the sale of a chemical solvent used in industrial settings. While our scales measure in micrograms, we price each sale in milligrams (a thousandth of a gram). To print the receipt, we'd likely need to combine data of different types, including fractional values, currency, and percentages in precise ways.

### Step 1 - Display the invoice number using string interpolation

Begin by deleting all of the existing code from previous exercises in the .NET Editor. Then, add the following code:

```csharp-interactive
int invoiceNumber = 1201;
decimal productMeasurement = 25.4568m;
decimal subtotal = 2750.00m;
decimal taxPercentage = .15825m;
decimal total = 3185.19m;

Console.WriteLine($"Invoice Number: {invoiceNumber}");
```

When you run the code, you should get the following output:

```output
Invoice Number: 1201
```

### Step 2 - Display the product measurement in milligrams

Because we bill our customers using milligrams even though our measuring instruments measure to the precision of a microgram, we'll only display three digits after the decimal point. Add the following code below the code you typed in step 1:

```csharp-interactive
Console.WriteLine($"   Measurement: {productMeasurement:N3} mg");
```

When you run the code, you should get the following output:

```output
Invoice Number: 1201
   Measurement: 25.457 mg
```

### Step 3 - Display the subtotal that we'll charge the customer formatted as currency

Add the following code below the code you typed in steps 1 and 2:

```csharp-interactive
Console.WriteLine($"     Sub Total: {subtotal:C}");
```

When you run the code, you should get the following output:

```output
Invoice Number: 1201
   Measurement: 25.457 mg
     Sub Total: ¤2,750.00
```

### Step 4 - Display the tax charged on the sale formatted as a percentage

Add the following code below the code you typed in steps 1 through 3:

```csharp-interactive
Console.WriteLine($"           Tax: {taxPercentage:P2}");
```

When you run the code, you should get the following output:

```output
Invoice Number: 1201
   Measurement: 25.457 mg
     Sub Total: ¤2,750.00
           Tax: 15.83 %
```

## Step 5 - Finalize the receipt with the total amount due formatted as currency.

Add the following code below the code you typed in steps 1 through 4:

```csharp-interactive
Console.WriteLine($"     Total Due: {total:C}");
```

The entire code for the exercise should match as follows:

```csharp-interactive
int invoiceNumber = 1201;
decimal productMeasurement = 25.4568m;
decimal subtotal = 2750.00m;
decimal taxPercentage = .15825m;
decimal total = 3185.19m;

Console.WriteLine($"Invoice Number: {invoiceNumber}");
Console.WriteLine($"   Measurement: {productMeasurement:N3} mg");
Console.WriteLine($"     Sub Total: {subtotal:C}");
Console.WriteLine($"           Tax: {taxPercentage:P2}");
Console.WriteLine($"     Total Due: {total:C}");
```

When you run the code, you should get the following output:

```output
Invoice Number: 1201
   Measurement: 25.457 mg
     Sub Total: ¤2,750.00
           Tax: 15.83 %
     Total Due: ¤3,185.19
```
