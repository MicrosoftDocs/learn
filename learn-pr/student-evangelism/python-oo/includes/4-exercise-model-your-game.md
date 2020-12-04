A game is no different from the _invoice system_ mentioned in a previous unit. It still has the same parts in the world of OOP - objects, data, and behavior. Just like we did with the invoice system you can _model_ a game like rock paper, scissor by first describing its domain and then try listing what's what. Modeling your game is just what you're going to do next and also write some code that you can build on later.

## Analyzing Rock, Paper, Scissor for OOP modeling

This exercise is a modeling exercise. You will be given a problem domain description. You will then be asked to take out the important keywords from the text and arrange it in a table.

> [!TIP]
> Refer to the second unit and the header **Finding objects, data and behavior** if you need to be reminded how to model. Remember, it starts with asking the questions,  _who interacts with whom_ or _who does what to whom_.

### Problem description

Rock paper, scissor is a game played by two participants. The game consists of rounds. In each round, a participant chooses a symbol, rock, paper, or scissor and the other participant does the same. Then a winner of the round is determined by comparing the chosen symbols. The rules of the game states that rock wins over scissor, scissor beats (cuts) paper and paper beats (envelops) rock. Thereafter the winner is awarded a point. The game goes on for as many rounds as the participants agreed on. The winner is the participant with the most number of points.

### Model the game

1. Copy paste the above text into a document and highlight the important keyword, either by making them bold or italic.

   > [!TIP]
   > Spend a few minutes trying to underline what you think are the important keywords. Once you are done, scroll down to a text that highlights the important parts.  

   Here's the problem description text with highlights:

   Rock paper, scissor is a _game_ played by two participants. The game consists of _rounds_. In each round, a _participant_ chooses a _symbol_, _rock_, _paper_, or _scissor_ and the other _participant_ does the same. Then a _winner_ of the round is determined by _comparing_ the chosen symbols. The _rules_ of the game states that rock wins over scissor, scissor beats (cuts) paper and paper beats (covers) rock. Thereafter the winner is awarded a _point_. The game goes on for as many rounds as the participants agreed on. The winner is the participant with the most number of points_.

1. Next, create a table with the columns `Phase`, `Actor`, `Behavior`, and `Data` and arrange the highlighted words where you think they should be placed.

   > [!TIP]
   > Spend a few minutes thinking this through and scroll down once you've given it some thought.

   Here's what a resulting table can look like:

    |Phase     | Actor             |Behavior                                 | Data                                            |
    |----------|-------------------|-----------------------------------------|-------------------------------------------------|
    |Input     | Participant       | chooses symbol                          | Symbol save as _choice_ on Participant(choice)  |
    |Processing| GameRound         | compares choices against game rules     | _Result_ inspected                              |
    |Processing| GameRound         | awards points based on result value     | _Points_ added to winning Participant(point)    |
    |Processing| Game              | check continue answer                   | answer is true, continue, else quit             |
    |Output    | Game              | new game round or game end credit       |                                                 |

## Create classes and state

The table above tells the story of how the game progresses through different phases. By focusing on the two columns `Behavior` and `Data`, you are able to _scaffold_ some initial code that will help support the creation of the game.

1. Create a file `rock-paper-scissor.py` and give it the following content:

   ```python
   class Participant:
   class GameRound:
   class Game:
   ```

   You have the needed classes created for your game. Next you need to think about what data you have and what class to place it on.

1. Keep working with the same file and update the code like so:

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

   The `Participant` class was given the attributes `points` and `choice` as indicated by the first and third line of your table.

   The `Game` has been given the fields `endGame` as a result of the fourth line. Additionally, the `Game` class has two participants, `participant` and `secondParticipant`. Looking back at the conceptual part, there were to roles a variable on an object could have, a state, like the floor of an elevator or a descriptive attribute. The `points` and `choice` attributes are in this context state variables, whereas the participants on the `Game` class are descriptive attributes, a game _has_ participants.
 
   Congrats! You've added classes to your game and created data, attribute,s that you've assigned to the created classes. At this point, you have a good starting code. It doesn't do much yet, it needs behavior. You will add behavior in the next exercise unit.
