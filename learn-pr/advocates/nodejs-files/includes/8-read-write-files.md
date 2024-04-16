The Tailwind Traders application needs to read each store's sales data, then calculate the total, then write the total of all the individual store sales files to a new file. 

## Read data from files with fs.readFile

Files are read through the `readFile` method on the **fs** module.

```javascript
await fs.readFile("stores/201/sales.json");
```

The return object from the `readFile` method is a `Buffer` object. It contains the contents of the file in binary format. For instance, assume that you have a file called *sales.json* with the following contents.

```
{
  "total": 22385.32
}
```

Logging out the return value of the `readFile` method would give you the `Buffer` value.

```console
<Buffer 7b 0a 20 20 22 74 6f 74 61 6c 22 3a 20 32 32 33 38 35 2e 33 32 0a 7d>
```

That result isn't helpful. You might have read the file, but you certainly can't "read" this data. That's OK, though. JavaScript can convert a `Buffer` value to a string value that you can use to calculate the total. To do that, invoke the `String` object and pass in the buffer.

```javascript
const bufferData = await fs.readFile("stores/201/sales.json");
console.log(String(bufferData));
```

The output is: 

```console
{
  "total": 22385.32
}
```

## Parse data with JSON.parse

This data in its string format doesn't do you much good. It's still just characters, but now in a format that you can read. You want the ability to turn this string into programmatically accessible data (known as parsing data). 

JavaScript includes a built-in parser for JSON files. You don't need to include anything to use it. Just use the `JSON` object. As a bonus, you don't need to convert a `Buffer` value to a string before you parse it. The `JSON.parse` method can do that. **JSON.parse** is a common method that you'll use frequently in web development when an API receives data (as strings) over the internet, which then needs to be turned into JSON objects.

```javascript
// read the file as string
const fileContents = await fs.readFile("stores/201/sales.json");

// turn string into JSON
const data = JSON.parse(fileContents);

// access the value by the property key `total`
console.log(data.total);
```

The output is: 

```console
22385.32
```

> [!TIP]
> Files come in a variety of formats. JSON files are the most desirable to work with because of the built-in support in the language. However, you might encounter files that are .csv, fixed width, or some other format. In that case, it's best to search npmjs.org for a parser for that file type.

## Write data to files with fs.writeFile

You learned how to write files in the previous exercise. It's just that you wrote an empty one. To write data to a file, use the same `writeFile` method, but pass in the data that you want to write as the third parameter.

```javascript
// read the file as string
const fileContents = await fs.readFile("stores/201/sales.json");

// turn string into JSON
const data = JSON.parse(fileContents);

// file name is totals.txt
const filePath = path.join("salesTotals","totals.txt");

// write the total to the "totals.json" file
await fs.writeFile(filePath, data.total);
```

The contents of the `totals.txt` file is:

```text
22385.32
```

### Append data to files with fs.writeFile

In the preceding example, the file is overwritten every time you write to it. Sometimes you want to append data to the file instead of replace it entirely. You can append data by passing a flag to the `writeFile` method. By default, the flag is set to `w`, which means _replace the file_. To append to the file instead, pass the `a` flag, which means _append_.

```javascript
// read the file as string
const fileContents = await fs.readFile("stores/201/sales.json");

// turn string into JSON
const data = JSON.parse(fileContents);

// file name is totals.txt
const filePath = path.join("salesTotals","totals.txt");

// write the total to the "totals.json" file
await fs.writeFile(filePath, `${data.total}\r\n`, {flag: "a"});
```

The contents of the `totals.txt` file is:

```text
22385.32
```

> [!TIP]
> In the preceding code example, `\r\n` tells JavaScript to put the value on its own line. If you didn't pass this value (known as a *carriage return line feed*), you would get all the numbers squished together on the same line.

In the next exercise, you'll finish the sales-total project for Tailwind Traders by reading all the sales files and writing the grand total to a .txt file. The company's commerce system can then process the file.
