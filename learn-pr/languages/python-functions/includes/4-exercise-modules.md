Now that you now know how to create functions, create your own module to hold one or more functions.

You learned about Python modules in a previous Microsoft Learn module. A Python module is just a code file containing files, constants, or services. You can split up a program into multiple code files to increase the modularity and code reuse across the entire program. Modules even let multiple programs share the same code.

This exercise uses a module to separate code you might use in multiple apps. The module separates code that implements your card deck from code that uses the card deck.

### Step 1 - Create a new file in the working folder for this exercise

This unit assumes you're continuing from the previous unit. Use the techniques you learned in previous modules to add a new code file in the folder dedicated to this module. Name the new file exercise3.py.

### Step 2 - Create another new file in the working folder for a new module named `deck`

In the same working folder as the exercise3.py file, create another file called deck.py.

### Step 3 - Add code to create a deck of cards in the new deck module

Add the following code to the deck.py file. This code is similar to what you created in the module when you learned about lists. The `create_deck()` function returns a list called `deck`. The list contains 52 strings that represent every combination of suits and ranks in a standard deck of cards.

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

### Step 4 - Add code to the exercise3 code file that calls the `create_deck()` method of the `deck` module

In the exercise3.py file, add the following code.

```python
import deck

cards = deck.create_deck()

for card in cards:
  print(card)
```

This code consumes the deck module and its functionality.

The first line of code imports the `deck` module. The second line of code calls the `create_deck()` function of the `deck` module.

When you run the code, it should print the list of cards.

## Recap

In this exercise, you learned how to create your own modules.

- Create a module to separate out reusable code in a modular way. A Python module is a code file. By placing functions in a module, you make that code usable from other code files both inside and outside of your program.
- Use the **import** statement to access a module's functions.
