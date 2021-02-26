Interfaces can extend each other. This enables you to copy the members of one interface into another, giving you more flexibility in how you separate your interfaces into reusable components.

When extending an interface with one or more interfaces, these rules apply:

- You must implement all the required properties from all interfaces.
- Two interfaces can have the same property if the property has the exact same name and type.
- If two interfaces have a property with the same name but different types, you must declare a new property such that the resulting property is a subtype of both interfaces.

## Extend an interface

There are several types of desserts you can create from the `IceCream` interface (sundaes, milkshakes, and so on), but they all have different properties in addition to those declared in `IceCream`. Let's extend the interface with a new one called `Sundae` and declare its properties.

1. Continue your project in the [Playground](https://www.typescriptlang.org/play?azure-portal=true).
1. Under the `IceCream` interface declaration, declare a new interface called `Sundae` that `extends` the `IceCream` interface. The `Sundae` interface includes four new properties:
    - `sauce` of literal type `'chocolate' | 'caramel' | 'strawberry'`
    - `nuts` of type `boolean` (optional)
    - `whippedCream` of type `boolean` (optional)
    - `instructions` of type `boolean` (optional)

    ```typescript
    interface Sundae extends IceCream {
        sauce: 'chocolate' | 'caramel' | 'strawberry';
        nuts?: boolean;
        whippedCream?: boolean;
        instructions?: boolean;
    }
    ```

1. You should notice an error in the new interface. TypeScript has found that both the `IceCream` and `Sundae` interfaces have a property called `instructions`, but they are of different types. To resolve this error, let's make both `instructions` properties of the same type, `string`.
1. Let's try out the new interface by changing the `myIceCream` variable to type ``Sundae``. This generates an error stating that **Property 'sauce' is missing in type '{ flavor: string; scoops: number; }' but required in type 'Sundae'**. You added four new properties to the Sundae interface but only the sauce property was required.

    ```typescript
    let myIceCream: Sundae = {
        flavor: 'vanilla',
        scoops: 2
    }
    ```

1. Correct the error by adding the required property, plus any of the optional properties that you want to use.

    ```typescript
    let myIceCream: Sundae = {
        flavor: 'vanilla',
        scoops: 2,
        sauce: 'caramel',
        nuts: true
    }
    ```

1. Now, try implementing the `Sundae` interface in the `tooManyScoops` function. You should not see any errors in the function itself, but the call to the function in the next line generates an error. This is because it is expecting three required parameters. Fix the error by adding the `sauce` property to the function call.

    ```typescript
    function tooManyScoops(dessert: Sundae) {
        if (dessert.scoops >= 4) {
            return dessert.scoops + ' is too many scoops!';
        } else {
            return 'Your order will be ready soon!';
        }
    }
    console.log(tooManyScoops({flavor: 'vanilla', scoops: 5, sauce: 'caramel'}));
    ```
