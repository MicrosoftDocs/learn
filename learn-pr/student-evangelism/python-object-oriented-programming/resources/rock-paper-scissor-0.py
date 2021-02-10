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