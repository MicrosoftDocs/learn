Methods can provide return values after performing their tasks. By using parameters and return types together, you can create streamlined methods that receive input, perform a task, and provide output. This format allows you to efficiently build functionality into your programs while maintaining clean, readable code.

Suppose you need to create an application that uses many methods to perform calculations on input values. You need a way to retrieve the results of the calculations, and use those results throughout your program. You can do this by creating methods with return values. 

Consider a game where the player must fight enemies. The game contains some code that determines if a character was hit whenever an `Update()` method is called. The code might contain the following methods:

```c#
void Update();

int[] GetEnemyCoordinates(string enemyId);
int[] GetDistanceFromHero(string enemyId);
int[] GetHeroCoordinates();

bool EnemyCanHitHero(string enemyId);
int GetEnemyDamageOutput(string enemyId);
void UpdateHeroHP(int damage);
```

Looking at the method signatures, you can imagine how the input and output of each method can be used across the program. The methods also allow make the game code more robust since each one has return values that can be used for different types of scenarios.

Capturing return values from methods is incredibly useful for all sorts of applications. In this module, you'll learn more about method execution and working with method return types.

## Learning Objectives

In this module, you will:

- Understand return types
- Learn more about the `return` keyword
- Learn more about capturing method return values

## Prerequisites

- Experience using C# data types including `int`, `string`, arrays, and 2D arrays
- Experience using `switch` statements, if-else statements, and for-loops
- Experience using the `Random` class to generate a random number.
- Basic understanding of C# methods