In this exercise, you'll use enums, structs, and functions to process new car orders.
Your challenge is to correct the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:

- Copy the code and edit it in your local development environment.
- Open the code in a prepared Rust Playground.

> [!NOTE]
> In the sample code, look for the `todo!` macro. This macro indicates code that needs to be completed or updated.

## Define an enum

Your first task is to fix syntax issues in the enum definition, so the code compiles.

1. Open the first block of sample code.

    Copy the following code and edit it in your local development environment, or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    // Declare Car struct to describe vehicle with four named fields
    struct Car {
        color: String,
        transmission: Transmission,
        convertible: bool,
        mileage: u32,
    }
    
    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission {
        // todo!("Fix enum definition so code compiles");
        Manual;
        SemiAuto;
        Automatic;
    }
    ```

1. Correct the syntax error in the `Transmission` enum so the program compiles successfully. 

    Make sure the code compiles before you continue to the next section. The code doesn't display any output yet, but it needs to compile without any errors.

    You can ignore *warning* messages from the compiler. The warnings are because you declared enum and struct definitions, but haven't used them yet.

## Instantiate a struct

Next, add code for the `car_factory` function to create an instance of a `Car` struct. We'll use the values of the input arguments to assign the car characteristics.

1. Add the following code block to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    // Build a "Car" by using values from the input arguments
    // - Color of car (String)
    // - Transmission type (enum value)
    // - Convertible (boolean, true if car is a convertible)
    fn car_factory(color: String, transmission: Transmission, convertible: bool) {

        // Use the values of the input arguments
        // All new cars always have zero mileage
        let car: Car = todo!("Create an instance of a `Car` struct");
    }
    ```

1. Rebuild your code and make sure it compiles. Again, you can ignore any warning messages.

1. Complete the declaration of the `car` variable so it creates an instance of a "Car" struct. The new car should use the values of the input arguments passed in to the function. All new cars have zero mileage.

    > [!Tip]
    > You'll need to change the statement from a type declaration `let car: Car` to an instantiation `let car = Car { ... }`.

1. Rebuild your code and make sure it compiles.

## Return a value from a function

Now, update the `car_factory` function to return the created `Car` struct. To return a value, the function signature needs to declare the value type, and the function body needs to provide the value.

1. Modify the function signature to declare the return value type as a `Car` struct. You'll change the following line of code in your file:

    ```rust
    fn car_factory(color: String, transmission: Transmission, convertible: bool) = todo!("Return a `Car` struct") {
    ```

    > [!Tip]
    > Watch for case sensitivity. Don't try to compile your code yet!

1. To return the newly created car, adjust the statement where you instantiated the `Car` struct.

    ```rust
        let car: Car = todo!("An instance of a `Car` struct", "Set the function return value");
    }
    ```

    > [!Tip]
    > In the previous section, you changed the statement `let car: Car =` to correctly create an instance of the `Car` struct. To complete this step, you can simplify this code. You can create the `Car` struct and return the newly created car in a single statement. You won't need to use the `let` or `return` keywords.

1. Rebuild your code and make sure it compiles without any errors.


## Call a function

Now you're ready to call the function and build some cars!

1. Add the `main` function to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    fn main() {
        // We have orders for three new cars!
        // We'll declare a mutable car variable and reuse it for all the cars
        let mut car = car_factory(String::from("Red"), Transmission::Manual, false);
        println!("Car 1 = {}, {:?} transmission, convertible: {}, mileage: {}", car.color, car.transmission, car.convertible, car.mileage);

        car = car_factory(String::from("Silver"), Transmission::Automatic, true);
        println!("Car 2 = {}, {:?} transmission, convertible: {}, mileage: {}", car.color, car.transmission, car.convertible, car.mileage);

        car = car_factory(String::from("Yellow"), Transmission::SemiAuto, false);
        println!("Car 3 = {}, {:?} transmission, convertible: {}, mileage: {}", car.color, car.transmission, car.convertible, car.mileage);    
    }
    ```

1. Rebuild the code. All the declared items are now used, so the compiler shouldn't issue any errors or warnings. You should see the following output:

    ```output
    Car 1 = Red, Manual transmission, convertible: false, mileage: 0
    Car 2 = Silver, Automatic transmission, convertible: true, mileage: 0
    Car 3 = Yellow, SemiAuto transmission, convertible: false, mileage: 0
    ```

## Solution

You can compare your code with the prepared solution in this [Rust Playground][RustPlay-answer].

<!-- Links -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=559a5739b8980054825099fc1c1c5c84?azure-portal=true
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=74285b6b784df60101a632314f547b18?azure-portal=true
