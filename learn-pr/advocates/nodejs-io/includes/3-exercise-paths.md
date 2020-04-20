In this exercise, we will learn how to work with the module `path` to do things such as

- Information - gain information on the path
- Join paths - you'll learn how to concatenate different paths and work with paths in an OS-dependent way
- Absolute path - you'll learn to gain information on the absolute path
- Normalize paths - sometimes your path contains things such as `./` or `../`

Pre-steps

1. Create a directory for your app
2. Navigate to your directory `cd <name of dir>`
3. Now create a JavaScript file that will contain your code and name it `app.js`
4. In the same directory, create a file `info.txt` and give it some sample data 

## Information

Add the following code to your created app file.

```javascript
const path = require("path");

const filePath = '/path/to/file.txt';
console.log(`Base name ${path.basename(filePath)}`);
console.log(`Dir name ${path.dirname(filePath)}`);
console.log(`Extension name ${path.extname(filePath)}`);
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
Base name file.txt
Dir name /path/to
Extension name .txt
```

## Join paths

Here you'll look into different ways of joining paths.
Add the following code to your existing application file:

```javascript
const join = '/path';
const joinArg = '/to/my/file.txt';

console.log(`Joined ${path.join(join, joinArg)}`);

console.log(`Concat ${path.join(join, 'user','files','file.txt')}`)
```

Above you are joining the paths contained in variables `join` and `joinArg` but you're also in our last example testing out concatenating using nothing but directory names and file names:

```javascript
console.log(`Concat ${path.join(join, 'user','files','file.txt')}`)
```

Now run this using

```bash
node <name of your app file>.js
```

This should give the following output:

```bash
Joined /path/to/my/file.txt
Concat /path/user/files/file.txt
```

## Absolute path

Add the following to your application file:

```javascript
console.log(`Abs path ${path.resolve(joinArg)}`);
console.log(`Abs path ${path.resolve("info.txt")}`);
```

Now run this using

```bash
node <name of your app file>.js
```

This should give the following output:

```bash
Abs path /to/my/file.txt
Abs path <this is specific to your system>/info.txt
```

Note how, in the second example, you're using the `resolve()` method on `info.txt` a file that exists in the same directory as you run your code:

```javascript
console.log(`Abs path ${path.resolve("info.txt")}`);
```

The above will attempt to resolve the absolute path for the file.

## Normalize paths

Sometimes you've characters like `./` or `../` in our path. The method `normalize()` help calculate the resulting path. Add the below code to the application file:

```javascript
console.log(`Normalize ${path.normalize('/path/to/file/../')}`)
```

Now run this using

```bash
node <name of your app file>.js
```

This should result in the following output:

```bash
Normalize /path/to/
```
