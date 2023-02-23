Code challenges throughout these modules will reinforce what you've learned and help you gain some confidence before continuing on.

## Challenge

In this challenge, you'll work with a string that contains a fragment of HTML. You'll extract data from the HTML fragment, replace some of its content, and remove other parts of its content to achieve the desired output.

### Step 1: Delete all of the code in the .NET Editor from the earlier exercise.

Select all of the code in the .NET Editor, then select the <kbd>Del</kbd> or <kbd>Backspace</kbd> key to delete it.

### Step 2: Write code in the .NET Editor to extract data, replace data, and remove data from an input string.

Given the starting point in the following code listing, you'll add code to extract, replace, and remove portions of the `input`'s value to produce the desired output.

```csharp-interactive
const string input = "<div><h2>Widgets &trade;</h2><span>5000</span></div>";

string quantity = "";
string output = "";

// Your work here

Console.WriteLine(quantity);
Console.WriteLine(output);
```

The following listing is the desired output once you've modified the code in the starting point:

```output
Quantity: 5000
Output: <h2>Widgets &reg;</h2><span>5000</span>
```

You may only add code to the starting point code listing. You must not change the variable declarations. All of your work should go under the comment `// Your work here`.

You'll perform three operations on the input using the tools and techniques you learned in this module:

1. Set the `quantity` variable to the value you extract from between the `<span>` and `</span>` tags.
2. Set the `output` variable to the value of input, then remove the `<div>` and `</div>` tags.
3. Replace the HTML character `&trade;` with `&reg;` in the `output` variable.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.

### Quick HTML primer

In case you're not familiar with HTML, it's the markup language that's used to create all web pages. You can skip this section if you're already well versed in HTML. It's not designed to be a comprehensive tutorial, but provides enough information to complete this challenge.

In HTML, you can define the structure of a document using tags. A tag is composed of:

- an opening angle bracket `<`
- a closing angle bracket `>`
- a word describing the type of tag, so for example: `<div>`, `<span>`, `<h2>`, and so on.

Each tag has a corresponding closing tag that's indicated by a forward slash character `/`. So, if you see `<div>`, there should be a corresponding `</div>` tag.

The data between the opening and closing tag is that tag's content. The content can include text and other tags.

You cam embed a set of tags inside another set of tags. In fact, that's what gives an HTML document its hierarchical structure.
