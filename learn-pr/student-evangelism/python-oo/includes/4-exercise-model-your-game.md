A game is no different from the _invoice system_ mentioned in a previous unit. It still has the same parts in the world of OOP - objects, data and behavior. Just like we did with the invoice system you can _model_ a game like rock paper, scissor by first describing it's domain and then try listing what's what. Modeling your game is just what you're going to do next and also write some code that you can build on later.

## Analyzing Rock, Paper, Scissor for OOP modeling

This exercise is a modeling exercise. You will be given a problem domain desccription. You will the  be asked to take out the important keywords from the text and arrange it in table. Refer to the second unit and the header **Finding objects, data and behavior** if you need to be reminded how to model. Remember, it starts with asking the questions,  _who interacts with whom_ or _who does what to whom_.

### Problem description

Rock paper, scissor is a game played by two participants. The game consists of rounds. In each round a participant chooses a symbol, rock, paper, or scissor and the other participant does the same. Then a winner of the round is determined by comparing the chosen symbols. The rules of the game states that rock wins over scissor, scissor beats (cuts) paper and paper beats (envelops) rock. Thereafter the winner is awarded a point. The game goes on for as many rounds as the participants agreed on. The winner is the participant with the most amount of points.

### Model the game

1. Copy paste the above text into a document and highlight the important keyword, either by making them bold or italic.

   > [!NOTE]
   > You will be given the answer further down in this exercise but it helps to try doing this yourself first.  

   Here's the problem description text with highlights:

   Rock paper, scissor is a _game_ played by two participants. The game consists of _rounds_. In each round a _participant_ chooses a _symbol_, _rock_, _paper_, or _scissor_ and the other _participant_ does the same. Then a winner of the round is determined by _comparing_ the chosen symbols. The _rules_ of the game states that rock wins over scissor, scissor beats (cuts) paper and paper beats (covers) rock. Thereafter the winner is awarded a _point_. The game goes on for as many rounds as the participants agreed on. The winner is the participant with the most amount of _points_.

1. Next, create a table with the columns `Phase`, `Object`, `Behavior` and `Data` and arrange the highlighted words where you think they should be placed.

   > [!TIP] Spend a few minutes thinking this through and scroll down once you've given it some thought.

   Here's what a resulting table can look like:

    |Phase     | Object            |Behavior          | Data                                        |
    |----------|-------------------|------------------|---------------------------------------------|
    |Input     | Participant       | chooses          | Symbol (rock, paper, scissor)              |
    |Processing| GameRound         | compares         | Symbols checked against Game rules          |
    |Processing| GameRound         | awards           | Points to Participant                       |
    |Processing| Game              | checks           | End condition                               |
    |Output    | Game              | determines       | Winner, select Participant with most points |

## Create classes and state

Now you will create the classes and data needed to support the game. There's two levels to this, understand what classes you need and what classes and data you need to perform a task.

1. Create a file `rock-paper-scissor.py` and give it the following content:

   ```python
   class Participant:
   class GameRound:
   class Game:
   ```

   You have the needed classes created for your game. Next you need to think about what data you have and what class to place it on.

1. Keep working with the same file and update the code to the following:

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

   You've added classes to your game and created data, attributes that you've assigned to the created classes. At this point, you have a good starting code. It doesn't do much yet, it needs behavior. You will add behavior in the next exercise unit.
