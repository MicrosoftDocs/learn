The following solution provided is one of many possible solutions. The approach taken to solve this challenge was to break down the solution into four steps:

1. Split the `pangram` string on the space character to create the string array `message`.
1. Create a new `newMessage`array that will store a reversed copy of the "word" string from the `message` array.
1. Loop through each element in the `message` array, reverse it and store this element in `newMessage` array.
1. Join "word" strings from the array `newMessage`, using a space again, to create the desired single  string to write to the console.

The final result of this example solution.

```csharp
string pangram = "The quick brown fox jumps over the lazy dog";

// Step 1
string[] message = pangram.Split(' ');

//Step 2
string[] newMessage = new string[message.Length];

// Step 3
for (int i = 0; i < message.Length; i++)
{
    char[] letters = message[i].ToCharArray();
    Array.Reverse(letters);
    newMessage[i] = new string(letters);
}

//Step 4
string result = String.Join(" ", newMessage);
Console.WriteLine(result);

```

This code is merely "*one possible solution*" because you could have taken different approaches to various steps in this process. As long as your output matches the following, you succeeded.

```Output
ehT kciuq nworb xof spmuj revo eht yzal god

```

If you were successful, congratulations!

If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
