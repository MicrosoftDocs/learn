Now that we know how to create functions, let's create our own module to hold one or more functions.

We learned about Python modules in a previous Microsoft Learn module.  A Python module is just a code file containing files, constants, or services.  We can split up our programs into multiple code files to increase the modularity and reuse of our code across our entire program, or even multiple programs that might need to share the same code.

This exercise utilizes a module to separate the code we might use in multiple applications.  At the very least, it provides separation between the code that implements our card deck from the code that uses the card deck.

### Step 1 - Create a new file in the working folder for this exercise.

Assuming you're continuing from the previous unit, use the techniques you learned in previous modules to add a new code file in the current folder dedicated to this module.  For example, you might create the following file:

```dos
exercise3.py
```

### Step 2 - Create another new file in the working folder for a new module named `deck`.

In the same working folder as the `exercise3.py` file, create another file called `deck.py`.

### Step 3 - Add code to create a deck of cards in the new deck module.

Add the following code to the `deck.py` file.  This is similar code that we created in the module when we learned about lists.  The `create_deck()` function returns a list called `deck` containing 52 string representing each combination of suit and rank in a standard deck of cards.

```python
def create_deck():
  suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
  ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
  deck = []

  for  suit in suits:
    for rank in ranks:
      deck.append(f'{rank} of {suit}')

  return deck
```

### Step 4 - Add code to the exercise3 code file that calls the `create_deck()` method of the `deck` module.

Back in the `exercise3.py` file, add the following code.

```python
import deck

cards = deck.create_deck()

for card in cards:
  print(card)
```

This code consumes the deck module and its functionality.

The first line of code imports the `deck` module.  The second line of code calls the `create_deck()` function of the `deck` module.

When you execute the code, you should see the list of cards printed to the console.

## Recap

In this exercise, we learned how to create our own modules:

- Create a module to separate out reusable code in a modular way.  A Python module is a code file.  By placing functions in a module, you make that code usable from other code files both inside and outside of your program.
- Use the `import` statement to access the module's functions.