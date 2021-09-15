In this exercise, you'll use compound data types to expand on a car factory program.

We'll use a tuple to track car quality with two values that are related, but have different data types. We'll create a function named `car_quality` that returns this tuple to the calling this function. Our `main` function will call the `car_factory` function to create each car order.

Your challenge is to finish the sample code so it compiles and runs.

To work on the sample code for this exercise, you have two options:
- Copy the code and edit it in your local development environment. 
- Open the code in a prepared Rust Playground.

In the sample code, look for the words `TO DO` to locate the sections to update.


## Update the Car struct to have a tuple field

Your first task is to change the `Car` struct definition. We're going to move the `mileage` field into a tuple field named `age`. Along with the mileage value, the `age` tuple needs another field to identify if the car is new or used.

1. Open the first block of sample code.

    Copy the following code and edit it in your local development environment,<br>
    or open the code in this prepared [Rust Playground][RustPlay-exercise].

    ```rust
    #[derive(PartialEq, Debug)]
    // Declare Car struct to describe vehicle with four named fields
    // TO DO: Replace the "mileage" field from the previous exercise with an "age" field
    // TO DO: The "age" field should hold tuple value of two fields: String, u32
    struct Car {
        color: String,
        motor: Transmission,
        roof: bool,
        mileage: u32,
    }

    #[derive(PartialEq, Debug)]
    // Declare enum for Car transmission type
    enum Transmission { Manual, SemiAuto, Automatic }
    ```

1. Correct the declaration of the `Car` struct.

    1. Remove the `mileage` field.
    1. Add a tuple field named `age` to hold the car mileage and the text "New" or "Used" to describe the car quality.
    
    > [!Tip]
    > The `String` data type can be used for the "New" and "Used" values.
 
1. Build the program. Make sure the code compiles before you continue to the next section.

    The code doesn't display any output yet, but it needs to compile without any errors. You can ignore *warning* messages from the compiler. The warnings are because you declared enum and struct definitions, but haven't used them yet.


## Create the car_quality function

Next, we'll add code for a new function named `car_quality`. This function will take the car mileage as an input argument. We'll create a tuple to hold the mileage and car quality. The function will return the tuple to the caller.

1. Add the following code block to your existing code. You can add the new code at the top of the file or at the bottom.

    ```rust
    // Get the car quality by testing the value of the input argument
    // - miles (u32)
    // Create a tuple for the car quality with the age ("New" or "Used") and miles
    // Return a tuple with the arrow `->` syntax
    fn car_quality (miles: u32) -> (String, u32) {

        // Declare and initialize the return tuple value
        // For a new car, set the miles to 0
        // TO DO: Define "quality"
        // - Set the value to a "New" car
        // - Set the mileage using the "miles" input argument
        let quality: (String, u32);

        // TO DO: Return the completed tuple
        return 
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
        // TO DO: Replace the "mileage" field from the previous exercise with an "age" field
        // TO DO: The "age" field calls the "car_quality" function with the "miles" input argument 
        let car = Car {
            color: color,
            motor: motor,
            roof: roof,
            mileage: miles
        };
    
        // Return new instance of "Car" struct
        return car
    }
    ```

1. Correct the initialization of the `car` variable.

    1. Remove the `mileage` field.
    1. Add a field named `age`. This field should call the `car_quality` function with the `miles` input argument.

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
        // TO DO: Set the values: 0 = Blue, 1 = Green, 2 = Red, 3 = Silver
        let colors;
        
        // Declare the car type and initial values
        // TO DO: Create "car" as a "Car" struct
        // TO DO: Create "engine" as a "Transmission" enum
        let mut car: Car;        
        let mut engine: Transmission;
    }
    ```

1. Complete the definition for the `colors` array variable. A car can be one of four colors: Blue, Green, Red, or Silver.

1. Fix the declaration syntax for the `car` struct and `engine` enum variables. At this point in the program, we need to define the data type structure, but not add any specific values.

    > [!Tip]
    > Don't forget to create both variables as changeable.

1. Build your program. Make sure the code compiles without any errors before you continue to the next section.


## Call a function to fulfill the car orders

In our `main` function, we'll call the `car_factory` function to fulfill the car orders. The function call expects a color for the car. We need to correct how we're indexing into the `colors` array, so we actually pass a color as expected.

1. Add the following code block to your `main` function. Place this code after the definitions you added in the last step, and before the closing curly brace `}` for the function.

    ```rust
        // Order 3 cars, one car for each type of transmission
        // TO DO: Fix indexing into `colors` array to vary the color for each order
    
        // Car order #1: New, Manual, Hard top
        engine = Transmission::Manual;
        car = car_factory(String::from(colors<index>), engine, true, 0);
        println!("Car order 1: {}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);
        
        // Car order #2: New, Semi-automatic, Convertible
        // TO DO: Adjust the Transmission value syntax
        engine = Transmission.SemiAuto;
        car = car_factory(String::from(colors<index>), engine, false, 100);
        println!("Car order 2: {}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);

        // Car order #3: New, Automatic, Hard top
        engine = Transmission::Automatic;
        car = car_factory(String::from(colors<index>), engine, true, 200);
        println!("Car order 3: {}, Hard top = {}, {:?}, {}, {} miles", car.age.0, car.roof, car.motor, car.color, car.age.1);
    ```

1. Fix the indexing into the `colors` array by correcting the `colors()` syntax. The array has four elements, so we'll try to use different colors as we fulfill the orders.

    > [!Tip]
    > Elements in an array start from index location 0. The value for the first element is at index location 0.

1. Build your program. Make sure the code compiles without any errors. Be sure to fix the syntax issue in car order \#2. You can ignore any warning messages.


## Run the program

When the program is complete, you should see output similar to this example:
    
```output
Car order 1: New, Hard top = true, Manual, Blue, 0 miles
Car order 2: New, Hard top = false, SemiAuto, Green, 100 miles
Car order 3: New, Hard top = true, Automatic, Red, 200 miles
```


## Solution

You can compare your program output to the solution for this exercise in this [Rust Playground][RustPlay-answer].


<!-- Links -->
<!-- [Rust-loops]: /learn/modules/rust-loop-expressions/index?azure-portal=true -->

[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=a765aeb7a68eff0508698398ec127c32?azure-portal=true

[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=d348ed467e20aa2a39e5f04da0e58c3d?azure-portal=true
