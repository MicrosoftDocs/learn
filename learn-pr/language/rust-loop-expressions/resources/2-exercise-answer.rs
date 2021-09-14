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

    // Prevent panic: Check color value, reset as needed
    let mut color = (order) as usize;
    if color > 4 {
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
    // Corrected code: To create a hash map, use HashMap::new()
    use std::collections::HashMap;
    let mut orders: HashMap<i32, Car> = HashMap::new();
    
    // Initialize counter variable
    let mut order = 1;
    // Declare a car as mutable "Car" struct
    let mut car: Car;
        
    // Order 6 cars
    // - Increment "order" after each request
    // - Add each order <K, V> pair to "orders" hash map
    // - Corrected code: Use ".insert()" method to add each order
    // - Adjust println call to show order details from the hash map
    
    // Car order #1: Used, Hard top
    car = car_factory(order, 1000);
    orders.insert(order, car);
    println!("Car order {}: {:?}", order, orders.get(&order));
    
    // Car order #2: Used, Convertible
    order = order + 1;
    car = car_factory(order, 2000);
    orders.insert(order, car);
    println!("Car order {}: {:?}", order, orders.get(&order));

    // Car order #3: New, Hard top
    order = order + 1;
    car = car_factory(order, 0);
    orders.insert(order, car);
    println!("Car order {}: {:?}", order, orders.get(&order));

    // Car order #4: New, Convertible
    order = order + 1;
    car = car_factory(order, 0);
    orders.insert(order, car);
    println!("Car order {}: {:?}", order, orders.get(&order));

    // Car order #5: Used, Hard top
    order = order + 1;
    car = car_factory(order, 3000);
    orders.insert(order, car);
    println!("Car order {}: {:?}", order, orders.get(&order));

    // Car order #6: Used, Hard top
    order = order + 1;
    car = car_factory(order, 4000);
    orders.insert(order, car);
    println!("Car order {}: {:?}", order, orders.get(&order));
}