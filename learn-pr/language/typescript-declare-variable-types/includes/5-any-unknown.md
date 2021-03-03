There are times when you'll need to work with values that are unknown to you at the time you develop your code, or are of a narrow possible range of value types. In these cases, you can use the `any` and `unknown` types and use type assertion and type guards to maintain control over what your code is allowed to do with the values that are passed.

## Any type

The `any` type is the one type that can represent any JavaScript value with no constraints. This can be useful when you're expecting a value from a third-party library or user inputs where the value is dynamic because the `any` type will allow you to reassign different types of values. And, as mentioned earlier, using the `any` type allows you to gradually migrate your JavaScript code to use static types in TypeScript.

The following example declares a variable of type `any` and assigns values to it:

```typescript
let randomValue: any = 10;
randomValue = true;      // OK
randomValue = 'Mateo';   // OK
```

When this example is compiled, it doesn't throw an error because the `any` type encompasses values of every possible type. The `any` type opts out of type checking and doesn't force you to do any checking before you call, construct, or access properties on these values.

Using the `any` type in this example allows you to call:

- A property that doesn't exist for the type.
- `randomValue` as a function.
- A method that only applies to a `string` type.

The following statements all generate errors or unexpected behavior at runtime.

```typescript
console.log(randomValue.name);  // Logs "undefined" to the console
randomValue();                  // Returns "randomValue is not a function" error
randomValue.toUpperCase();      // Returns "randomValue is not a function" error
```

> [!IMPORTANT]
> Remember that all the convenience of `any` comes at the cost of losing type safety. Type safety is one of the main motivations for using TypeScript. You should avoid using `any` when it's not necessary.

## Unknown type

While flexible, the `any` type can cause unexpected errors. To address this, TypeScript introduced the `unknown` type.

The `unknown` type is similar to the `any` type in that any value is assignable to type `unknown`. However, you can't access any properties of an `unknown` type, nor can you call or construct them.

This example changes the `any` type in the previous example to `unknown`. It will now raise type check errors and prevent you from compiling the code until you take appropriate action to resolve them.

```typescript
let randomValue: unknown = 10;
randomValue = true;
randomValue = 'Mateo';

console.log(randomValue.name);  // Error: Object is of type unknown
randomValue();                  // Error: Object is of type unknown
randomValue.toUpperCase();      // Error: Object is of type unknown
```

> [!NOTE]
> The core difference between `any` and `unknown` is you are unable to interact with a variable of type `unknown`; doing so generates a **compiler** error. `any` bypasses any compile-time checks, and the object is evaluated at runtime; if the method or property exists it will behave as expected.

## Type assertion

If you need to treat a variable as a different data type you can use a **type assertion**. A type assertion tells TypeScript you have performed any special checks that you need before calling the statement. It tells the compiler "trust me, I know what I’m doing." A type assertion is like a type cast in other languages, but it performs no special checking or restructuring of data. It has no runtime impact and is used purely by the compiler.

Type assertions have two forms. One is the `as`-syntax:

`(randomValue as string).toUpperCase();`

The other version is the "angle-bracket" syntax:

`(<string>randomValue).toUpperCase();`

> [!NOTE]
> `as` is the preferred syntax. Some applications of TypeScript, such as JSX, can get confused when using `< >` for type conversions.

The following example performs the necessary check to determine that `randomValue` is a `string` before using type assertion to call the `toUpperCase` method.

```typescript
let randomValue: unknown = 10;

randomValue = true;
randomValue = 'Mateo';

if (typeof randomValue === "string") {
    console.log((randomValue as string).toUpperCase());    //* Returns MATEO to the console.
} else {
    console.log("Error - A string was expected here.");    //* Returns an error message.
}

```

TypeScript now assumes that you have made the necessary check. The type assertion says that `randomValue` should be treated as a `string` and then the `toUpperCase` method can be applied.

## Type guards

The previous example demonstrates the use of `typeof` in the `if` block to examine the type of an expression at runtime. This is called a **type guard**.

You may be familiar with using `typeof` and `instanceof` in JavaScript to test for these conditions. TypeScript understands these conditions and will change type inference accordingly when used in an `if` block.

You can use the following conditions to learn the type of a variable:

| Type| Predicate|
| :--- | :--- |
| `string`| `typeof s === "string"`|
| `number`| `typeof n === "number"`|
| `boolean`| `typeof b === "boolean"`|
| `undefined`| `typeof undefined === "undefined"`|
| `function`| `typeof f === "function"`|
| `array`| `Array.isArray(a)`|
