Your company is pleased with your object-oriented programming (OOP) implementation of rock, paper, scissors. So much so, they want you to change the game to rock, paper, scissors, lizard, Spock because that's what all the cool kids are playing these days.

## Add the choices lizard and Spock

Adding two more choices like lizard and Spock might sound like there's a lot to change. Thanks to the way you implemented the rules, the changes needed are minor.

What are the rules for lizard and Spock though?

_Scissors decapitate lizard, scissors cut paper, paper covers rock, rock crushes lizard, lizard poisons Spock, Spock smashes scissors, scissors decapitate lizard, lizard eats paper, paper disproves Spock, Spock vaporizes rock, and as it always has, rock crushes scissors._

The preceding description can be translated into this updated rules table:

|Choice   |Rock     |Paper    |Scissors |Lizard |Spock |
|---------|---------|---------|---------|-------|------|
|Rock     |  0      | -1      |  1      |  1    | -1   |
|Paper    |  1      |  0      | -1      | -1    |  1   |
|Scissors | -1      |  1      |  0      |  1    | -1   |
|Lizard   | -1      |  1      | -1      |  0    |  1   |  
|Spock    |  1      | -1      |  1      | -1    |  0   |

1. Locate the `Participant` class, and update the method `toNumericalChoice()` to look like so:

   ```python
   def toNumericalChoice(self):
     switcher = {
       "rock": 0,
       "paper": 1,
       "scissor": 2,
       "lizard": 3,
       "spock": 4
     }
     return switcher[self.choice]
   ```

1. Locate the `GameRound` class. In the `__init__()` method, change the `self.rules` variable to this code:

   ```python
   self.rules = [
      [0, -1, 1, 1, -1],
      [1, 0, -1, -1, 1],
      [-1, 1, 0, 1, -1],
      [-1, 1, -1, 0, 1],
      [1, -1, 1, -1, 0]
   ]
   ```

1. Run `python3 rock-paper-scissor.py` to try out your changes:

   ```bash
   python3 rock-paper-scissor.py
   ```

   Select `spock` and `paper` to see that the rules work properly. Your output should look similar to the following example:

   ```output
   Spock, select rock, paper, scissor, lizard or spock: spock
   Spock selects spock
   Kirk, select rock, paper, scissor, lizard or spock: paper
   Kirk selects paper
   Round resulted in a loss
   Continue game y/n: n
   Game ended, Spock has 0, and Kirk has 1
   Winner is Kirk
   ```

Congratulations! You've added two choices, _lizard_ and _Spock_, to the game with minimal effort to your code.
