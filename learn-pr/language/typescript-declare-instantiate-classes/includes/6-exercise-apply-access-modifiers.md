In this exercise, you'll apply access modifiers to properties and methods of the `Car` class.

1. Continue defining the `Car` class in the Playground.
1. Test the access of the class members by typing `myCar1.` and notice that all the members appear in the list, including the properties, the `constructor` parameters, the methods, and the `worker` function.

   :::image type="content" source="../media/m05-public-private.png" alt-text="Intellisense showing all of the public members of the Car class: color, doors, make, accelerate, brake, color, doors, make, turn, and worker.":::
   
1. Set the access modifier of the `_color`, `_doors`, and `_make` properties and the `worker` function to `private`.

    ```typescript
    // Properties
    private _make: string;
    private _color: string;
    private _doors: number;
    // ...
    private worker(): string {
        return this._make;
    }
    ```

1. Test the access of the class members again by typing `myCar1.` and notice that the properties and the `worker` function are now unavailable. Any attempt to use these class members will raise an error at compile time.

   :::image type="content" source="../media/m05-public-private-2.png" alt-text="Intellisense showing all of the public members of the Car class with properties and the worker method set to private: accelerate, brake, color, doors, make, and turn.":::
