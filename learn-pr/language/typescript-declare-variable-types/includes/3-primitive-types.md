Let's start by reviewing the most basic and common types you might encounter when writing JavaScript or TypeScript code. These basic types will later form the core building blocks of more complex types.

## Boolean type

The most basic datatype is the `true` or `false` value, known as a boolean.

For example:

```typescript
let flag: boolean;
let yes = true;
let no = false;
```

## Number and BigInteger types

As in JavaScript, all numbers in TypeScript are either floating point values or BigIntegers. These floating-point numbers get the type `number`, while BigIntegers get the type `bigint`. In addition to hexadecimal and decimal literals, TypeScript also supports binary and octal literals introduced in ECMAScript 2015.

For example:

```typescript
let x: number;
let y = 0;
let z: number = 123.456;
let big: bigint = 100n;
```

## String type

The `string` keyword represents sequences of characters stored as Unicode UTF-16 code units. Like JavaScript, TypeScript also uses double quotes (`"`) or single quotes (`'`) to surround string data.

Some examples:

```typescript
let s: string;
let empty = "";
let abc = 'abc';
```

In TypeScript, you can also use template strings, which can span multiple lines and have embedded expressions. These strings are surrounded by the backtick/backquote (\`) character, and embedded expressions are of the form `${ expr }`.

For example:

```typescript
let firstName: string = "Mateo";
let sentence: string = `My name is ${firstName}.
    I am new to TypeScript.`;
console.log(sentence);
```

This example produces the output:

```console
My name is Mateo.
    I am new to TypeScript.
```

## The void, null, and undefined types

JavaScript and TypeScript have two primitive values used to signal absent or uninitialized value: `null` and `undefined`. These types are most useful in the context of functions, so we'll discuss them in more detail in a later module.
