Reading data from files and writing data to files is a core concept in Node.js.

Tailwind Traders needs to write the sum total of all their individual store sales files to a new file that contains just that grand total. This file will then be loaded into their sales system.

Here, you'll learn how to use the "fs" module to read and write to files.

## Read data from files

Files are read using the `readFile` method on the "fs" module.

```javascript
await fs.readFile("stores/201/sales.json");
```

The return object from the `readFile` method is a Buffer object. That means that it contains the contents of the file that was read, but in binary format. For instance, if you had the following file called "sales.json" with the following contents...

```
{
  "total": 22385.32
}
```

Logging out the return value of the `readFile` method would give you the Buffer.

```javascript
console.log(await fs.readFile("stores/201/sales.json"));
// <Buffer 7b 0a 20 20 22 74 6f 74 61 6c 22 3a 20 32 32 33 38 35 2e 33 32 0a 7d>
```

That's not super helpful. You may have read the file, but you certainly can't "read" this data. That's OK, though. JavaScript has this unique ability to just convert Buffer's to their string value, which is what you're after here. To do that, just invoke the `String` object and pass in the buffer.

```javascript
const bufferData = await fs.readFile("stores/201/sales.json");
console.log(String(bufferData));
// {
//   "total": 22385.32
// }
```

## Parse data in files

This data in its string format doesn't do you much good. It's still just characters, but now in a format you can read. What you are after is the ability to "parse" this data into a format that you can use programatically. JavaScript includes a built-in parser for JSON files. You don't need to include anything to use it. Just use the `JSON` object. As a bonus, you don't need to convert a Buffer to a string before you parse it. The `JSON.parse` method can do that!

```javascript
const data = JSON.parse(await fs.readFile("stores/201/sales.json"));
console.log(data.total);
// 22385.32
```

> [!TIP]
> Files come a variety of formats. JSON file are the most desireable to work with because of the built-in support in the language. However, you may encouter files that are .csv, Fixed Width, or some other format. In that case, it's best to search npmjs.org for a parser for that file type. As I typed this paragraph, I found parsers for both .cvs and Fixed Width formats with a simple search.

## Write data to files

If you remember from the previous exercise, you've already learned how to write files. It's just that you wrote an empty one. To write data to a file, use the same `writeFile` method, but pass in the data that you want to write as the third parameter.

```javascript
const data = JSON.parse(await fs.readFile("stores/201/sales.json"));

// write the total to the "totals.json" file
await fs.writeFile("salesTotals/totals.txt"), data.total);

// totals.txt
// 22385.32
```

### Append data to files

In the example above, the file is overwritten every time you write to it. Sometimes you don't want that. Sometimes you want to append data to the file; not replace it entirely. You can do this by passing a "flag" to the `writeFile` method. By default, the flag is set to "w", which means, "replace the file". To append to the file instead, pass the "a" flag, which means "append".

```javascript
const data = JSON.parse(await fs.readFile("stores/201/sales.json"));

// write the total to the "totals.json" file
await fs.writeFile(path.join("salesTotals/totals.txt"), `${data.total}\r\n`, {
  flag: "a"
});

// totals.json
// 22385.32
// 22385.32
```

> [!TIP]
> In the above code example, the "\r\n" tells JavaScript to put the value on it's own line. If you didn't pass this value (known as a "carriage return line feed"), you would get all of the numbers on the same line all squished together.

In the next exercise, you'll finish up the sales totals project for Tailwind Traders by reading all the sales files and writing the grand total to a txt file, which can be processed by their commerce system.
