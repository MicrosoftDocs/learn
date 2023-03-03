The object types are all class, interface, array, and literal types (anything that isn't a primitive type.) For now, let's look at the array and Tuple types.

## Arrays

TypeScript, like JavaScript, allows you to work with arrays. Arrays can be written in one of two ways. In the first, you use the type of the elements followed by square brackets (`[ ]`) to denote an array of that element type:

```typescript
let list: number[] = [1, 2, 3];
```

The second way uses a generic `Array` type, using the syntax `Array<type>`:

```typescript
let list: Array<number> = [1, 2, 3];
```

There's no advantage to using one over the other, so it's up to you to decide which syntax to use.

## Tuples

Having an array of the same value types is useful, but sometimes you have an array that contains values of mixed types. For that purpose, TypeScript provides the Tuple type. To declare a Tuple, use the syntax `variableName: [type, type, ...]`.

### Exercise - Tuples

1. Open the [Playground](https://www.typescriptlang.org/play?azure-portal=true) and remove any existing code.
1. Enter the following code to create a Tuple that contains a `string` and a `number`:

    ```typescript
    let person1: [string, number] = ['Marcia', 35];
    ```

1. Try to add another item to the array. For example:

    ```typescript
    let person1: [string, number] = ['Marcia', 35, true];
    ```

1. You'll note that an error is raised because the elements in the Tuple `array` are fixed. The `person1` Tuple is an array that contains exactly one `string` value and one `numeric` value.
1. Try switching the order of the items in the array. For example:

    ```typescript
    let person1: [string, number] = [35, 'Marcia'];
    ```

1. You'll get an error that indicates that the order of the values must match the order of the types.
