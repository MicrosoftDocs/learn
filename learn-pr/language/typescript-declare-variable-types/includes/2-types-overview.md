The main benefit of Typescript is that it enables you to add static types to your JavaScript code. Types place static constraints on program entities, such as functions, variables, and properties, so that compilers and development tools can offer better verification and assistance during development.

The TypeScript static compile-time type system closely models the dynamic run-time type system of JavaScript, enabling you  to accurately express the type relationships that are expected to exist when your programs run and have those assumptions pre-validated by the TypeScript compiler. The TypeScript type analysis occurs entirely at compile-time and adds no run-time overhead to program execution.

Static types also provide a way to better document the intention of your code, which helps you and other developers understand it.

## Declaring let and const variables

[ECMAScript 2015](https://www.ecma-international.org/ecma-262/6.0/?azure-portal=true) added the `let` and `const` keywords for variable declaration in JavaScript, which eliminated some of the problems associated with the `var` keyword in previous versions. This change makes it possible to declare variables with block level scope and prevents you from declaring the same variable multiple times.

TypeScript encourages the use of the `let` and `const` keywords for variable declarations.

> [!NOTE]
> As a reminder, the difference between them is that `let` declarations can be done without initialization, whereas `const` declarations are always initialized with a value. And `const` declarations, once assigned, can never be reassigned.

## Exercise - Type inference in TypeScript

You can associate types with variables through explicit type annotations or through implicit type inference.

While recommended, explicit type annotations are optional in TypeScript. To do this, use the syntax `variableName: type`. This statement `let myVariable: number` declares the variable as a number type without initializing it. Alternatively, you can also initialize the variable by using  `let myVariable: number = 10`.

To imply the variable type through type inference, simply use the same format you use in JavaScript. For example, `let myVariable = 10`  infers that the variable is of type `number` because it is initialized with the value `10`.

Let's open the [Playground](https://www.typescriptlang.org/play?azure-portal=true) and see how this works.

1. Enter the following variable declarations:

    ```typescript
    let x: number;   //* Explicitly declares x as a number type
    let y = 1;       //* Implicitly declares y as a number type
    let z;           //* Declares z without initializing it
    ```

1. TypeScript now treats `x` as a `number` type. TypeScript also infers the type of `y` to be a number type because that is the type of the value used to initialize it. But what happens if you try to assign a different value type to it? And what happens to the variable z?
1. Open the **Errors** tab in the Playground so you can monitor for any errors.
1. Enter `x = 1`. This should work as expected with no errors.
1. Enter `x = "one"`. As expected, this raises the error **Type 'string' is not assignable to type 'number'** because static type checking does not allow a `string` to be assigned to the variable.
1. Enter `y = "one"`. You'll see that the same error is raised. This is because TypeScript has inferred that y is of type `number`.
1. Enter the variable name `y` followed by a period and you'll notice one more thing. Even though you didn't explicitly specify a type for the variable `y`, Intellisense is providing methods that only apply to a `number` type.
1. Enter `z = 1` and `z = "one"`. TypeScript accepted both but why? This works in the same way that it works in JavaScript because variable `z` can now accept any value assigned to it. (TypeScript has inferred the `z` is of type `any` because you did not assign a type or initialize it when it was declared. You'll learn more about the `any` type later.)

While you can implicitly infer types through type inference in TypeScript, should you? Through type inference, you do get some of the benefit of static type checking and Intellisense and it enables you to gradually migrate to explicit type declarations in your projects. But explicit type declarations also provide a way to better document the intention of your code and provide a more deliberate path going forward.

## Types and subtypes in TypeScript

Before diving into using types for variable declaration, let's look at the types and subtypes in TypeScript.

### Any type

All types in TypeScript are subtypes of a single top type called the `any` type. The `any` type is the one type that can represent any JavaScript value with no constraints. All other types are categorized as primitive types, object types, or type parameters. These types introduce various static constraints on their values.

:::image type="content" source="../media/m02-types.png" alt-text="Type hierarchy with any as the top type, and primitive types, object types, and type parameters as subtypes. Primitive types null and undefined are subtypes of all other types." border="false":::

### Primitive types

The primitive types are the `boolean`, `number`, `string`, `void`, `null`, and `undefined` types along with user-defined enumeration or `enum` types. The `void` type exists purely to indicate the absence of a value, such as in a function with no return value. The `null` and `undefined` types are subtypes of all other types. It is not possible to explicitly reference the null and undefined types. Only the values of those types can be referenced, using the `null` and `undefined` literals.

### Object types and type parameters

The object types are all class, interface, array, and literal types (anything that is not a primitive type.)

Class and interface types are introduced through class and interface declarations and are referenced by the name given to them in their declarations. Class and interface types may be generic types that have one or more type parameters. You'll learn more about these object types in later modules.
