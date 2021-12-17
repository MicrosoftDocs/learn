So far, you've been using planets names in a list. You might wonder about working with other data types, like numbers.

Did you know that gravity on other planets is stronger or weaker depending on the planets mass, or size? Gravity is often measured in **G**, where the gravity on earth is 1, and other planets are measured [relative to Earth.](https://nssdc.gsfc.nasa.gov/planetary/factsheet/planet_table_ratio.html) The gravity on the moon is 0.166G, which is why astronauts can jump so high on the moon. The gravity on Neptune is 1.12G, so jumping is harder. Even Olympic athletes would struggle to jump over 2 meters on Neptune.

![Neptune as seen from Voyager 2 from 4.4 million miles, image credit NASA.](../media/neptune-nasa.jpg)

## Storing numbers in lists

To store numbers with decimal places in Python, you use the `float` type. To create a float, you simple write the number with the decimal place and assign it to a variable:

```python
gravity_on_earth = 1.0
gravity_on_the_moon = 0.166
```

Create a list with the gravitational forces of all 8 planets in the solar system, in G:

```python
gravity_on_planets = [0.378, 0.907, 1, 0.377, 2.36, 0.916, 0.889, 1.12]
```

In this list, `gravity_on_planets[0]` is the gravity on Mercury (0.378G), `gravity_on_planets[1]` is the gravity on Venus (0.907G) and so on.

On Earth, a double-decker bus weighs 12,650 KG (12.65 tonnes). On Mercury, where the gravity is 0.378G, it weighs 12.65 tonnes multiplied by 0.378. In Python, to multiply two values, you use the `*` symbol.

In this example, you can work out the weight of a double-decker bus on different planets by getting the value from the list:

```python
bus_weight = 12650 # in KG, on Earth

print("On Earth, a double-decker bus weighs", bus_weight, "KG")
print("On Mercury, a double-decker bus weighs", bus_weight * gravity_on_planets[0], "KG")

# Output
# On Earth, a double-decker bus weighs 12650 KG
# On Mercury, a double-decker bus weighs 4781.7 KG
```

## Using `min()` and `max()` with lists

Python has some builtin functions for calculating the biggest and smallest numbers in a list. The `max()` function returns the largest number and `min()` returns the smallest. So `min(gravity_on_planets)` returns the smallest number in the `gravity_on_planets` list, which is 0.378 (Mercury).

Calculate the minimum and maximum weights in the solar system using these functions:

```python
bus_weight = 12650 # in KG, on Earth

print("On Earth, a double-decker bus weighs", bus_weight, "KG")
print("The lightest a bus would be in the solar system is", bus_weight * min(gravity_on_planets), "KG")
print("The heaviest a bus would be in the solar system is", bus_weight * max(gravity_on_planets), "KG")

# Output
# On Earth, a double-decker bus weighs 12650 KG
# The lightest a bus would be in the solar system is 4781.7 KG
# The heaviest a bus would be in the solar system is 29854 KG
```
