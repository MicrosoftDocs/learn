Your company is pleased with your OOP implementation of Rock, Paper, Scissors. So much so, they want you to change it into Rock, Paper, Scissor, Lizard, Spock, cause that's what all the cool kids are playing these days.  

## Add choices Spock and lizard

Adding two more choices like lizard and Spock might sound like there's a lot to change. However, thanks to the way you've implemented the rules, the changes needed are minor.

What's the rules for lizard and Spock though?

_Scissors decapitate Lizard, Scissors cuts paper, paper covers rock, rock crushes lizard, lizard poisons Spock, Spock smashes scissors, scissors decapitates lizard, lizard eats paper, paper disproves Spock, Spock vaporizes rock, and as it always has, rock crushes scissors._

The above description can be translated into this updated rules table:

|Choice   |Rock     |Paper    |Scissor  |Lizard| Spock |
|---------|---------|---------|---------|------|-------|
|Rock     | 0       | -1      |  1      |  1   |  -1   |
|Paper    | 1       |  0      | -1      | -1   |   1   |
|Scissor  | -1      |  1      |  0      |  1   |  -1   |
|Lizard   | -1      |  1      | -1      |  0   |   1   |  
|Spock    | 1       | -1      |  1      |  -1  |   0   |

1. Locate the `Participant` class and update the method `toNumericalChoice()` to look like so:

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

1. Locate the `GameRound` class and in the `__init__()` method change the `self.rules` variable to this code:

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

   Select `spock` and `paper` to see that the rules work properly. Your output should look similar to the below:

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

Congrats, you've added two choices, _Lizard_ and _Spock_ to the game with minimal effort to your code.
