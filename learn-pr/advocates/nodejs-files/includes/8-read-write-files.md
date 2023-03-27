Reading data from files and writing data to files are core concepts in Node.js.

Tailwind Traders needs to write the total of all the individual store sales files to a new file. This file is then loaded into the company's sales system.

Here, you learn how to use the *fs* module to read and write to files.

## Read data from files

Files are read through the `readFile` method on the *fs* module.

```javascript
await fs.readFile("stores/201/sales.json");
```

The return object from the `readFile` method is a `Buffer` object. It contains the contents of the file that was read, but in binary format. For instance, assume that you have a file called *sales.json* with the following contents.

```
{
  "total": 22385.32
}
```

Logging out the return value of the `readFile` method would give you the `Buffer` value.

```javascript
console.log(await fs.readFile("stores/201/sales.json"));
// <Buffer 7b 0a 20 20 22 74 6f 74 61 6c 22 3a 20 32 32 33 38 35 2e 33 32 0a 7d>
```

That result isn't helpful. You might have read the file, but you certainly can't "read" this data. That's OK, though. JavaScript can convert a `Buffer` value to a string value that you can read. To do that, invoke the `String` object and pass in the buffer.

```javascript
const bufferData = await fs.readFile("stores/201/sales.json");
console.log(String(bufferData));
// {
//   "total": 22385.32
// }
```

## Parse data in files

This data in its string format doesn't do you much good. It's still just characters, but now in a format that you can read. You want the ability to parse this data into a format that you can use programmatically. 

JavaScript includes a built-in parser for JSON files. You don't need to include anything to use it. Just use the `JSON` object. As a bonus, you don't need to convert a `Buffer` value to a string before you parse it. The `JSON.parse` method can do that.

```javascript
const data = JSON.parse(await fs.readFile("stores/201/sales.json"));
console.log(data.total);
// 22385.32
```

> [!TIP]
> Files come in a variety of formats. JSON files are the most desirable to work with because of the built-in support in the language. However, you might encounter files that are .csv, fixed width, or some other format. In that case, it's best to search npmjs.org for a parser for that file type.

## Write data to files

You learned how to write files in the previous exercise. It's just that you wrote an empty one. To write data to a file, use the same `writeFile` method, but pass in the data that you want to write as the third parameter.

```javascript
const data = JSON.parse(await fs.readFile("stores/201/sales.json"));

// write the total to the "totals.json" file
await fs.writeFile("salesTotals/totals.txt"), data.total);

// totals.txt
// 22385.32
```

### Append data to files

In the preceding example, the file is overwritten every time you write to it. Sometimes you don't want that. Sometimes you want to append data to the file not replace it entirely. You can append data by passing a flag to the `writeFile` method. By default, the flag is set to `w`, which means "replace the file." To append to the file instead, pass the `a` flag, which means "append."

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
> In the preceding code example, `\r\n` tells JavaScript to put the value on its own line. If you didn't pass this value (known as a *carriage return line feed*), you would get all the numbers squished together on the same line.

In the next exercise, you'll finish the sales-total project for Tailwind Traders by reading all the sales files and writing the grand total to a .txt file. The company's commerce system can then process the file.
