In this unit, your challenge is to add missing code and correct mistakes in the exercise so the code compiles.

You can use your local development environment or the Rust Playground to edit the code.


## Exercise - Create an instance of the "Car" struct

Let's build cars!

Edit the `car_factory` function so it can return instances of the `Car` struct as requested by the customers. In the following code, look for the words "TO DO" to locate mistakes to correct or sections where more code is needed.

```rust
// Declare the Car struct to describe the vehicle with four named fields.
struct Car {
    color: String,
    transmission: Transmission,
    convertible: bool,
    mileage: u32,
}

#[derive(PartialEq, Debug)]
// Declare an enum for the Car transmission type
// TO DO: Fix the enum definition so the code compiles
enum Transmission {
    Manual;
    SemiAuto;
    Automatic;
}

// The car_factory function builds a new "Car" using the values of three input arguments:
// - The color of the car (a String)
// - The transmission type (an enum value)
// - The type of car top (a boolean value, true if the car is a convertible)
// TO DO: Fix the function so it returns an instance of a "Car" struct.
fn car_factory(color: String, transmission: Transmission, convertible: bool) {

    // TO DO: Fix the function so it creates a new "Car" instance as requested by the customer
    // The Factory Quality Control Department says new cars must always have zero mileage!
    let car: Car = // Replace this code to create an instance of the "Car" struct

    // Return the new instance of the Car struct
    return car;
}

fn main() {
    // We have orders for three new cars!
    let car_1 = car_factory(String::from("Red"), Transmission::Manual, false);
    let car_2 = car_factory(String::from("Silver"), Transmission::Automatic, true);
    let car_3 = car_factory(String::from("Yellow"), Transmission::SemiAuto, false);

    // Show the car details
    println!("Car 1 = {}, {:?} transmission, convertible: {}", car_1.color, car_1.transmission, car_1.convertible);
    println!("Car 2 = {}, {:?} transmission, convertible: {}", car_2.color, car_2.transmission, car_2.convertible);
    println!("Car 3 = {}, {:?} transmission, convertible: {}", car_3.color, car_3.transmission, car_3.convertible);
}
```

You can run this code in your local computer, or use this [Rust Playground][RustPlay-exercise].

The solution to this exercise is in this [Rust Playground][RustPlay-answer].


<!-- Links -->
[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=68588ed1dd4229a78bc7682f0d64b297?azure-portal=true
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=ff9fe6388606536b0fc1898d82b19fc6?azure-portal=true
