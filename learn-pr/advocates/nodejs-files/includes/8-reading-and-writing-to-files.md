The "fs" module is used to write data to files and read data from files.

## Reading data from files

Files are read using the `readFile` and `readFileSync` methods on the "fs" module.

```javascript
fs.readFileSync("stores/201/sales.json");
```

The return object from the `readFile` and `readFileSync` methods is a Buffer object. That means that it contains the contents of the file that was read, but in binary format. For instance, if you had the following file called "sales.json" with the following contents...

```
{
  "total": 22385.32
}
```

Logging out the return value of the `readFileSync` method would give you the Buffer.

```javascript
console.log(fs.readFileSync("stores/201/sales.json"));
// <Buffer 7b 0a 20 20 22 74 6f 74 61 6c 22 3a 20 32 32 33 38 35 2e 33 32 0a 7d>
```

That's not super helpful. You may have read the file, but you certainly can't "read" this data. That's OK, though. JavaScript has this unique ability to just convert Buffer's to their string value, which is what you're after here. To do that, just invoke the `String` object and pass in the buffer.

```javascript
const bufferData = fs.readFileSync("stores/201/sales.json");
console.log(String(bufferData));
// {
//   "total": 22385.32
// }
```

## Parsing data in files

This data in it's string format doesn't do you much good. It's still just characters, but now in a format you can read. What you are after is the ability to "parse" this data into a format that you can use programatically. JavaScript includes a built-in parser for JSON files. You don't need to include anything to use it. Just use the `JSON` object. As a bonus, you don't need to convert a Buffer to a string before you parse it. The `JSON.parse` method can do that!

```javascript
const data = JSON.parse(fs.readFileSync("stores/201/sales.json"));
console.log(data.total);
// 22385.32
```

> [!TIP]
> Files come a variety of formats. JSON file are the most desireable to work with because of the built-in support in the language. However, you may encouter files that are .csv, Fixed Width, or some other format. In that case, it's best to search npmjs.org for a parser for that file type. As I typed this paragraph, I found parsers for both .cvs and Fixed Width formats with a simple search.

## Writing data to files

If you remember from the previous ecercise, you've already learned how to write files. It's just that you wrote an empty one. To write data to a file, use the same `writeFile` or `writeFileSync` method, but pass in the data that you want to write as the 3rd parameter.

```javascript
const data = JSON.parse(fs.readFileSync("stores/201/sales.json"));

// write the total to the "totals.json" file
fs.writeFileSync(path.join(salesTotalsDir, "stores/totals.txt"), data.total);

// totals.txt
// 22385.32
```

### Appending data to files

In the example above, the file is overwritten everytime you write to it. Sometimes you don't want that. Sometimes you want to append data to the file, not replace it entirely. You can do this by passing a "flag" to the `writeFile` or `writeFileSync` methods. By default, the flag is set to "w", which means, "replace the file". To append to the file instead, pass the "a" flag, which means "append".

```javascript
const data = JSON.parse(fs.readFileSync("stores/201/sales.json"));

// write the total to the "totals.json" file
fs.writeFileSync(
  path.join(salesTotalsDir, "stores/totals.txt"),
  `${data.total}\r\n`,
  {
    flag: "a"
  }
);

// totals.json
// 22385.32
// 22385.32
```

> [!TIP]
> In the above code example, the "\r\n" tells JavaScript to put the value on it's own line. If you didn't pass this value (known as a "carriage return line feed"), you would get all of the numbers on the same line all squished together.

In the next exercise, you'll finish up the sales totals project for Tailwind Traders by reading all the sales files and writing the grand total to a txt file which can be processed by their commerce system.
