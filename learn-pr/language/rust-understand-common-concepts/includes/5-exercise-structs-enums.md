In this unit, your challenge is to fix the missing parts of each exercise's code to make them compile.

You can use your local development environment or use the Rust Playground to edit the code.

## Exercise - Fix the code with structs and enums

Let's build cars!

Edit only the `car_factory` function so that it can return `Car` objects as requested by the clients.

```rust
struct Car {
    color: String,
    transmission: Transmission,
    convertible: bool,
    mileage: u32,
}

#[derive(PartialEq, Debug)]
enum Transmission {
    Manual,
    SemiAuto,
    Automatic,
}

fn car_factory(color: String, transmission: Transmission, convertible: bool) -> Car {

    // To Do - Fix this part of the function to create a new Car object as requested by the client
    let car: Car = todo!("Replace this with an actual Car instance")

    // Factory's Quality Control Department says that new cars must always have zero mileage!
    assert_eq!(car.mileage, 0);

    // Display the details of the new car order
    if car.convertible {
        println!("New car = {}, {:?}, Convertible", car.color, car.transmission);
    } else {
        println!("New car = {}, {:?}, Hardtop", car.color, car.transmission);
    }

    return car;
}

fn main() {
    let client_request_1 = car_factory(String::from("Red"), Transmission::Manual, false);
    assert_eq!(client_request_1.color, "Red");
    assert_eq!(client_request_1.transmission, Transmission::Manual);
    assert_eq!(client_request_1.convertible, false);

    let client_request_2 = car_factory(String::from("Silver"), Transmission::Automatic, true);
    assert_eq!(client_request_2.color, "Silver");
    assert_eq!(client_request_2.transmission, Transmission::Automatic);
    assert_eq!(client_request_2.convertible, true);

    let client_request_2 = car_factory(String::from("Yellow"), Transmission::SemiAuto, false);
    assert_eq!(client_request_2.color, "Yellow");
    assert_eq!(client_request_2.transmission, Transmission::SemiAuto);
    assert_eq!(client_request_2.convertible, false);
}
```

You can run this code in your local computer, or use this [Rust Playground][RustPlay-exercise].

The solution to this exercise is in this [Rust Playground][RustPlay-answer].


<!-- Links -->
[RustPlay-exercise]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=2cb514cd6d862dc1b3bd3af2cadd1e82?azure-portal=true
[RustPlay-answer]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=cb4224fe1b2acca05237b92e1a4e42f2?azure-portal=true
