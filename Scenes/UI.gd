class_name UI extends CanvasLayer

@onready var scoreLabel0:Label = $ScoreContainer0/ScoreLabel0
@onready var scoreLabel1:Label = $ScoreContainer1/ScoreLabel1
@onready var powerLabel1:Label = $PowerContainer/PowerLabel

func setScore0(s:int)->void:
	scoreLabel0.text = "Player 1 : " + str(s)
func setScore1(s:int)->void:
	scoreLabel1.text = "Player 2 : " + str(s)
func setPower(p:float)->void:
	powerLabel1.text = "Power : " + str(int(p))
