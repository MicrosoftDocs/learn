Now that you have added classes and data to your rock paper scissors game, it's time to add the last part, behavior. Behavior in the form of methods. You will add methods to your classes and the end result is working game of rock, paper, scissors. 

## Implement behavior

You've been taught that to build a program in OOP style you model first and then you code. The modeling produced an output, a table that represented what objects, data and behavior your program seems to consist of. Here's that same table again:

|Phase     | Object            |Behavior          | Data                                        |
|----------|-------------------|------------------|---------------------------------------------|
|Input     | Participant       | chooses          | Symbol (rock, paper, scissor)               |
|Processing| GameRound         | compares         | Symbols checked against Game rules          |
|Processing| GameRound         | awards           | Points to Participant                       |
|Processing| Game              | checks           | End condition                               |
|Output    | Game              | determines       | Winner, select Participant with most points |

This time you will focus on the column `Behavior` and add those in the form of methods to your classes. Additionally you will add code to those methods so they work the way they should.

Here's your code so far, let's extend it, in steps:

```python
class Participant:
  def __init__(self):
    self.points = 0
    self.choice = ""

class GameRound:

class Game:
  def __init__(self):
    self.endGame = False
    self.participant = Participant()
    self.secondParticipant = Participant()
   ```

### Start a game

The first part of the game involves setting it up which means to instantiate the game itself and take the game to a point where it's waiting for the participants to act.

1. Replace the content of `rock-paper-scissors.py` with this code:

```python
class Participant:
  def __init__(self, name):
    self.name = name
    self.points = 0
    self.choice = ""
  def choose(self):
    self.choice = input("{name}, select rock, paper or scissor: ".format(name= self.name))
    print("{name} selects {choice}".format(name=self.name, choice = self.choice))

class GameRound:
  def __init__(self, p1, p2):
    p1.choose()
    p2.choose()
  def compareChoices(self):
    print("implement")
  def awardPoints(self):
    print("implement")

class Game:
  def __init__(self):
    self.endGame = False
    self.participant = Participant("Spock")
    self.secondParticipant = Participant("Kirk")
  def start(self):
    game_round = GameRound(self.participant, self.secondParticipant)

  def checkEndCondition(self):
    print("implement")
  def determineWinner(self):
    print("implement")

game = Game()
game.start()
```

You've added the methods from your table to each object. Additionally you've implemented the `choose()` method on the `Participant` class.

1. Run the code by invoking `python3`:

   ```bash
   python3 rock-paper-scissors.py
   ```

   The program produces an output like so:

   ```output
   Spock, select rock, paper or scissor:
   ```

   That output means the program is waiting for you to act.

1. Ensure the program works by selecting `rock` and then press `enter` and then select `paper` and press enter again:

   Your output resembles this text:

   ```output
   Spock, select rock, paper or scissor: rock
   Spock selects rock
   Kirk, select rock, paper or scissor: paper
   Kirk selects paper
   ```

### Implement rules

matrix?

|Choice   |Rock     |Paper    |Scissor  |
|---------|---------|---------|---------|
|Rock     | 0       | -1      |  1      |
|Paper    | 1       |  0      | -1      |
|Scissor  | -1      |  1      |  0      |

### Score game

### Add continuation query

Continue?

### BONUS: Add spock
