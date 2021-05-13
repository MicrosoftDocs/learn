A game is no different from the _invoice system_ mentioned in a previous unit. It still has the same parts in the world of object-oriented programming (OOP). These parts are objects, data, and behavior. Just like we did with the invoice system, you can _model_ a game like rock, paper, scissors by first describing its domain, and then try listing what's what. Modeling your game is what you're going to do next. You'll also write some code that you can build on later.

## Analyze rock, paper, scissors for OOP modeling

This exercise is a modeling exercise. You'll be given a problem domain description. You'll then be asked to take out the important keywords from the text and arrange them in a table.

> [!TIP]
> If you need to be reminded how to model, see the section "Find objects, data, and behavior" in the second unit. Remember, modeling starts with asking the questions _who interacts with whom_ or _who does what to whom_.

### Problem description

Rock, paper, scissors is a game played by two participants. The game consists of rounds. In each round, a participant chooses a symbol from rock, paper, or scissors, and the other participant does the same. Then a winner of the round is determined by comparing the chosen symbols. The rules of the game state that rock wins over scissors, scissors beats (cuts) paper, and paper beats (covers) rock. The winner of the round is awarded a point. The game goes on for as many rounds as the participants agreed on. The winner is the participant with the most points.

### Model the game

1. Copy and paste the preceding text into a document. Highlight the important keywords by making them bold or italic.

   > [!TIP]
   > Spend a few minutes trying to underline what you think are the important keywords. After you're finished, scroll down to text that highlights the important parts.

   Here's the problem description text with highlights:

   Rock, paper, scissors is a _game_ played by two participants. The game consists of _rounds_. In each round, a _participant_ chooses a _symbol_ from _rock_, _paper_, or _scissors_, and the other _participant_ does the same. Then a _winner_ of the round is determined by _comparing_ the chosen symbols. The _rules_ of the game state that rock wins over scissors, scissors beats (cuts) paper, and paper beats (covers) rock. The winner of the round is awarded a _point_. The game goes on for as many rounds as the participants agreed on. The winner is the participant with the most points.

1. Next, create a table with the columns `Phase`, `Actor`, `Behavior`, and `Data`. Arrange the highlighted words where you think they should be placed.

   > [!TIP]
   > Spend a few minutes thinking this through, and scroll down after you've given it some thought.

   Here's what a resulting table can look like:

    |Phase     | Actor             |Behavior                                 | Data                                            |
    |----------|-------------------|-----------------------------------------|-------------------------------------------------|
    |Input     | Participant       | Chooses symbol                          | Symbol saved as _choice_ on Participant(choice)  |
    |Processing| GameRound         | Compares choices against game rules     | _Result_ inspected                              |
    |Processing| GameRound         | Awards points based on result value     | _Points_ added to winning Participant(point)    |
    |Processing| Game              | Check continue answer                   | Answer is true, continue, else quit             |
    |Output    | Game              | New game round or game end credit       |                                                 |

## Create classes and state

The preceding table tells the story of how the game progresses through different phases. By focusing on the two columns `Behavior` and `Data`, you can _scaffold_ some initial code that will help support the creation of the game.

1. Create a file `rock-paper-scissor.py`, and give it the following content:

   ```python
   class Participant:
   class GameRound:
   class Game:
   ```

   You have the needed classes created for your game. Next, you need to think about what data you have and what class to place it on.

1. Keep working with the same file, and update the code like so:

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

   The `Game` has been given the fields `endGame` because of the fourth line. Additionally, the `Game` class has two participants, `participant` and `secondParticipant`. There were two roles a variable on an object could have. The roles could be a state, like the floor of an elevator, or a descriptive attribute. The `points` and `choice` attributes are state variables in this context. The participants on the `Game` class are descriptive attributes because a game _has_ participants.

   Congratulations! You've added classes to your game and created data--attributes that you've assigned to the created classes. At this point, you have a good starting code. It doesn't do much yet because it needs behavior. You'll add behavior in the next exercise unit.
