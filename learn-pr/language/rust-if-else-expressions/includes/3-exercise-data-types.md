In this exercise, you'll use compound data types to expand on a car factory program.

We'll use a tuple to track car quality with two values that are related, but have different data types. We'll create a function named `car_quality` that returns this tuple to the calling function. Our `main` function will call the `car_factory` function to create each car order.

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:

- Copy the code and edit it in your local development environment.
- Open the code in a prepared Rust Playground.

> [!Note]
> In the sample code, look for the `todo!` macro. This macro indicates code that needs to be completed or updated.

## Update the Car struct to have a tuple field

Your first task is to change the `Car` struct definition. We're going to move the `mileage` field into a tuple field named `age`. Along with the mileage value, the `age` tuple needs another field to identify if the car is "New" or "Used."

1. Open the first block of sample code.

    Copy the following code and edit it in your local development environment, or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    #[derive(PartialEq, Debug)]
    // Declare Car struct to describe vehicle with four named fields
    struct Car {
        color: String,
        motor: Transmission,
        roof: bool,
        mileage: u32, // todo!("Move `mileage: u32` field into `age` field - a tuple with two fields: an `Age` enum, u32");
    }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission { Manual, SemiAuto, Automatic }
    ```

1. Add an enum named `Age` with the values "New" and "Used" to describe the car quality.

1. Correct the declaration of the `Car` struct.

    1. Replace the `mileage: u32` field with a tuple field named `age`.
    1. Define the `age` tuple to have two fields: an `Age` enum value and the car mileage.

1. Build the program. Make sure the code compiles before you continue to the next section.

    The code doesn't display any output yet, but it needs to compile without any errors. You can ignore *warning* messages from the compiler. The warnings are because you declared enum and struct definitions, but haven't used them yet.


## Create the car_quality function

Next, we'll add code for a new function named `car_quality`. This function will take the car miles as an input argument. We'll create a tuple to hold the mileage and car age. The function will return the tuple to the caller.

1. Add the following code block to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    // Get the car quality by testing the value of the input argument
    // - miles (u32)
    // Create a tuple for the car quality with the Age ("New" or "Used") and mileage
    // Return a tuple with the arrow `->` syntax
    fn car_quality (miles: u32) -> (Age, u32) {

        // Declare and initialize the return tuple value
        // For a new car, set the miles to 0
        let quality: (Age, u32) = todo!("Set the `Age` value to \"New\", set the mileage using the `miles` input argument");

        // Return the completed tuple to the caller
        todo!("Return the tuple");
    }
    ```

1. Complete the code to set the `quality` tuple values for a "New" car.

1. Update the `return` statement at the end of the function, so it sends the completed tuple back to the caller.

1. Build your program. Make sure the code compiles before you continue to the next section. The code doesn't display any output yet, but it needs to compile without any errors.

## Update the car_factory function

The next step is to update the `car_factory` function. We need to support the tuple returned from the `car_quality` function. We updated the definition of the `Car` struct, so we need to adjust the function body to correctly process the data.

1. Add the following code block to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    // Build a new "Car" using the values of four input arguments
    // - color (String)
    // - motor (Transmission enum)
    // - roof (boolean, true if the car has a hard top roof)
    // - miles (u32)
    // Call the car_quality(miles) function to get the car age
    // Return an instance of a "Car" struct with the arrow `->` syntax
    fn car_factory(color: String, motor: Transmission, roof: bool, miles: u32) -> Car {
        // Create a new "Car" instance as requested
        // - Bind first three fields to values of input arguments
        // - "age" field calls "car_quality" function with "miles" input argument 
        Car {
            color: color,
            motor: motor,
            roof: roof,
            mileage: miles, // todo!("Replace `mileage: miles` with `age` tuple field, call `car_quality()` with `miles` as input argument");
        }
    }
    ```

1. Correct the initialization of the `car` variable.

    1. Replace the `mileage: miles` field with a tuple field named `age`. 
    1. The `age` field should call the `car_quality` function with the `miles` input argument.

1. Build the program. Make sure the code compiles before you continue to the next section.

## Set main function variables

Now we're ready to start working on our `main` function. The first step is to define variables we'll use in the program:

- An array for car colors
- A struct for each car order
- An enum to describe the Transmission type

1. Add the following code block for the `main` function to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    fn main() {
        // Create car color array
        let colors = todo!("Set the enum values: 0 = Blue, 1 = Green, 2 = Red, 3 = Silver");
        
        // Declare the car type and initial values
        let mut car: Car = todo!("Create `car` as a `Car` struct");     
        let mut engine: Transmission = todo!("Declare `engine` as a `Transmission` enum, initialize to `Manual`");
    }
    ```

1. Complete the definition for the `colors` array variable. A car can be one of four colors: Blue, Green, Red, or Silver.

1. Fix the declaration syntax for the `car` struct and `engine` enum variables. Initialize the `engine` enum to "Manual."

    > [!Tip]
    > Don't forget to create both variables as changeable.

1. Build your program. Make sure the code compiles without any errors before you continue to the next section.

## Call a function to fulfill the car orders

In our `main` function, we'll call the `car_factory` function to fulfill the car orders. The function call expects a color for the car. We need to correct how we're indexing into the `colors` array, so we actually pass a color as expected.

1. Add the following code block to your `main` function. Place this code after the definitions you added in the last step, and before the closing curly brace `}` for the function.

    ```rust
        // Order 3 cars, one car for each type of transmission
    
        // Car order #1: New, Manual, Hard top
        car = car_factory(String::from(todo!("Index into the `colors()` array")), engine, true, 0);
        println!("Car order 1: {:?}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);
        
        // Car order #2: Used, Semi-automatic, Convertible
        engine = Transmission::SemiAuto;
        car = car_factory(String::from(todo!("Index into the `colors()` array")), engine, false, 100);
        println!("Car order 2: {:?}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);

        // Car order #3: Used, Automatic, Hard top
        engine = Transmission::Automatic;
        car = car_factory(String::from(todo!("Index into the `colors()` array")), engine, true, 200);
        println!("Car order 3: {:?}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);
    ```

1. Fix the indexing into the `colors` array in the calls to `String::from`. The `colors` array has four elements, so try to use a different color for each order.

    > [!Tip]
    > Elements in an array start from index location 0. The value for the first element is at index location 0.

1. Build your program. Make sure the code compiles without any errors. You can ignore any warning messages.

## Run the program

When the program is complete, you should see output similar to this example:

```output
Car order 1: New, Hard top = true, Manual, Blue, 0 miles
Car order 2: New, Hard top = false, SemiAuto, Green, 100 miles
Car order 3: New, Hard top = true, Automatic, Red, 200 miles
```

Even though orders 2 and 3 are for Used cars, our `car_quality` function only returns New for now. In a later exercise, we'll see how we can use conditional expressions to correct that, and to vary the orders.

## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].

<!-- Links -->
<!-- [Rust-loops]: /learn/modules/rust-loop-expressions/index?azure-portal=true -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=713ad42aab739f31e3a5dec8eacc56db?azure-portal=true

[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=eab57e76d363a904005f96c501148f22?azure-portal=true
