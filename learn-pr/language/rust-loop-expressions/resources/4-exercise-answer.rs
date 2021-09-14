#[derive(PartialEq, Debug)]
struct Car { color: String, motor: Transmission, roof: bool, age: (String, u32) }

#[derive(PartialEq, Debug)]
enum Transmission { Manual, SemiAuto, Automatic }

// Get car quality by testing input argument
fn car_quality (miles: u32) -> (String, u32) {
    let mut quality: (String, u32) = (String::from("New"), 0);

    // If car has accumulated miles, car is used
    if miles > 0 {
        quality = (String::from("Used"), miles);
    }

    return quality
}

// Build "Car" using input arguments
fn car_factory(order: i32, miles: u32) -> Car {
    let colors = ["Blue", "Green", "Red", "Silver"];

    // Prevent panic: Check color index, reset as needed
    // Valid colors = 1, 2, 3, or 4
    // Corrected code: Replace if/else with loop to reduce color to lowest divisor of 4
    let mut color = (order) as usize;
    while color > 4 {
        // color = 5 --> index 1, 6 --> 2, 7 --> 3, 8 --> 4
        color = color - 4;
    }

    // Create "Car" instance as requested
    let mut car = Car {
        color: String::from(colors[(color-1) as usize]),
        motor: Transmission::Automatic,
        roof: true,
        age: car_quality(miles)
    };
        
    // Add variety to orders for motor type and roof type
    if order % 3 == 0 {          // 3, 6, 9
        car.motor = Transmission::Automatic;
    } else if order % 2 == 0 {   // 2, 4, 8, 10
        car.motor = Transmission::SemiAuto;
        car.roof = false;
    } else {                     // 1, 5, 7, 11
        car.motor = Transmission::Manual;
    }

    return car
}

fn main() {

    // Initialize a hash map for the car orders
    // - Key: Car order number, i32
    // - Value: Car order details, Car struct
    use std::collections::HashMap;
    let mut orders: HashMap<i32, Car> = HashMap::new();
    
    // Declare a car as mutable "Car" struct
    let mut car: Car;
    
    // Order 11 cars
    // Corrected code: loop to fulfill orders for 11 cars
    // Corrected code: "order" variable created and incremented in "for" loop

    // Start with zero miles
    let mut miles = 0;

    for order in 1..12 {
    
        // Call car_factory to fulfill order
        // Add order <K, V> pair to "orders" hash map
        // Call println! to show order details from the hash map        
        car = car_factory(order, miles);
        orders.insert(order, car);
        println!("Car order {}: {:?}", order, orders.get(&order));
        
        // Reset miles for order variety
        if miles == 2100 {
            miles = 0;
        } else {
            miles = miles + 700;
        }
    }
}
