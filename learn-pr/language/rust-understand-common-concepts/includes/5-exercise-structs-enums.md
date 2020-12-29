In this unit, your challenge is to fix the missing parts of each exercise's code to make them compile.

You can use your local development environment or use the Rust Playground to edit the code.

## Exercise - Fix the code with structs and enums

Let's build cars!

Edit only the `car_factory` function so that it can return `Car` objects as requested by the clients.

```rust
struct Car {
    color: String,
    transmission: Transmission,
    conversible: bool,
    mileage: u32,
}

#[derive(PartialEq, Debug)]
enum Transmission {
    Manual,
    SemiAuto,
    Automatic,
}

fn car_factory(color: String, transmission: Transmission, conversible: bool) -> Car {
    // TODO: Replace the ??? for an actual Car instance
    let car: Car = ???;

    // Factory's Quality Control Department says that new cars must always have zero mileage!
    assert_eq!(car.mileage, 0);
    return car;
}

fn main() {
    let client_request_1 = car_factory(String::from("Red"), Transmission::Manual, false);
    assert_eq!(client_request_1.color, "Red");
    assert_eq!(client_request_1.transmission, Transmission::Manual);
    assert_eq!(client_request_1.conversible, false);

    let client_request_2 = car_factory(String::from("Silver"), Transmission::Automatic, true);
    assert_eq!(client_request_2.color, "Silver");
    assert_eq!(client_request_2.transmission, Transmission::Automatic);
    assert_eq!(client_request_2.conversible, true);

    let client_request_2 = car_factory(String::from("Yellow"), Transmission::SemiAuto, false);
    assert_eq!(client_request_2.color, "Yellow");
    assert_eq!(client_request_2.transmission, Transmission::SemiAuto);
    assert_eq!(client_request_2.conversible, false);
}
```

You can run this code in your local computer, or use this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=a6392731e066f804d30c3c56bc8bd7ae?azure-portal=true).

The solution to this exercise is in this [Rust Playground link](https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=2d69c0f7c5c2e478650ec43f5ee5e427?azure-portal=true).
