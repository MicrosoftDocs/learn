TypeScript provides more advanced options for declaring types. Union and Intersection types help you handle situations where a type is composed of two or more possible types, while literal types enable you to constrain the values assigned to a type to a narrow list of options.

## Union types

A **union** type describes a value that can be one of several types. This can be helpful when a value is not under your control (for example, values from a library, an API, or user input.)

The `any` type can also accept different types, so why would you want to use a union type? The union types restrict the assignment of values to the specified types, whereas the any type has no restrictions. Another reason is Intellisense support.

A union type uses the vertical bar or pipe (`|`) to separate each type. In the following example, `multiType` can be a `number` or a `boolean`:

```typescript
let multiType: number | boolean;
multiType = 20;         //* Valid
multiType = true;       //* Valid
multiType = "twenty";   //* Invalid
```

Using type guards, you can easily work with a variable of a union type. In this example, the `add` function accepts two values that can be either a `number` or a `string`. If both values are number types, it adds them. If both are string types, it concatenates them. Otherwise, it raises an error.

```typescript
function add(x: number | string, y: number | string) {
    if (typeof x === 'number' && typeof y === 'number') {
        return x + y;
    }
    if (typeof x === 'string' && typeof y === 'string') {
        return x.concat(y);
    }
    throw new Error('Parameters must be numbers or strings');
}
console.log(add('one', 'two'));  //* Returns "onetwo"
console.log(add(1, 2));          //* Returns 3
console.log(add('one', 2));      //* Returns error
```

## Intersection types

Intersection types are closely related to union types, but they are used very differently. An intersection type combines two or more types to create a new type that has **all properties** of the existing types. This allows you to add together existing types to get a single type that has all the features you need.

An Intersection type uses the ampersand (`&`) to separate each type.

Intersection types are most often used with interfaces. The following example defines two interfaces, `Employee` and `Manager`, and then creates a new intersection type called `ManagementEmployee` that combines the properties in both interfaces.

```typescript
interface Employee {
  employeeID: number;
  age: number;
}
interface Manager {
  stockPlan: boolean;
}
type ManagementEmployee = Employee & Manager;
let newManager: ManagementEmployee = {
    employeeID: 12345,
    age: 34,
    stockPlan: true
};
```

You can learn more about interfaces in the [Implement interfaces in TypeScript](LINK TO MODULE 3 IN THIS LEARNING PATH) module.

## Literal types

A literal is a more concrete subtype of a collective type. What this means is that `"Hello World"` is a `string`, but a `string` is not `"Hello World"` inside the type system.

There are three sets of literal types available in TypeScript: `string`, `number`, and `boolean`. By using literal types, you can specify an exact value that a string, number, or boolean must have (for example, "yes", "no", or "maybe".)

### What is literal narrowing?

When you declare a variable using `var` or `let` in TypeScript, you are telling the compiler that there is the chance that this variable will change its contents. Declaring a variable with let types the variable (for example, as a `string`), allowing for an infinite number of potential values.

In contrast, using `const` to declare a variable will inform TypeScript that this object will never change. Declaring with `const` types it to the value (for example, "Hello World").

The process of going from an infinite number of potential cases to a smaller, finite number of potential cases is called narrowing.

### Defining literal types

Literal types are written as object, array, function, or constructor type literals and are used to compose new types from other types.

The best way to demonstrate the use of literal types is with an example. This type definition creates a literal type called `testResult`, which can contain one of three `string` values:

```typescript
type testResult = "pass" | "fail" | "incomplete";
let myResult: testResult;
myResult = "incomplete";    //* Valid
myResult = "pass";          //* Valid
myResult = "failure";       //* Invalid
```

When setting the value of the variable `myResult`, `"incomplete"` and `"pass"` are valid entries, while `"failure"` is not because it is not one of the items in the `testResult` type definition.

TypeScript also has numeric literal types, which act the same as the string literals above. For example:

```typescript
type dice = 1 | 2 | 3 | 4 | 5 | 6;
let diceRoll: dice;
diceRoll = 1;    //* Valid
diceRoll = 2;    //* Valid
diceRoll = 7;    //* Invalid
```

You can also use `boolean` values when defining literal types, or any combination of types.
