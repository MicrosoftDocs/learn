The other part of a *search and replace* operation is to find text in a string. You can use the  <xref:System.String.Contains%2A> method for searching. It
tells you if a string contains a substring inside it. Try the following
code to explore <xref:System.String.Contains%2A>:

```csharp
string songLyrics = "You say goodbye, and I say hello";
Console.WriteLine(songLyrics.Contains("goodbye"));
Console.WriteLine(songLyrics.Contains("greetings"));
```

The <xref:System.String.Contains%2A> method returns a **boolean** value which tells you if the
string you were searching for was found. A **boolean** stores either a `true` or a
`false` value. You'll learn more about **boolean** values
in a later lesson.

***Challenge***

There are two similar methods, <xref:System.String.StartsWith%2A> and <xref:System.String.EndsWith%2A> that also search for sub-strings in a string. These find a substring at the beginning or the
end of the string. Try to modify the previous sample to use <xref:System.String.StartsWith%2A> and
<xref:System.String.EndsWith%2A> instead of <xref:System.String.Contains%2A>. Search for "You" or "goodbye" at the beginning of a string. Search for "hello" or "goodbye" at the end of a string.

> [!Note]
> Watch your punctuation when you test for the text at the end of the string. If the string
> ends with a period, you must check for a string that ends with a period.

You should get `true` for starting with "You" and ending with "hello" and false for starting with or ending with "goodbye".

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).