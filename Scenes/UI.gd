class_name UI extends CanvasLayer

@onready var scoreLabel0:Label = $ScoreContainer0/VBoxContainer/ScoreLabel
@onready var scoreLabel1:Label = $ScoreContainer1/VBoxContainer/ScoreLabel
@onready var powerLabel1:Label = $PowerContainer/PowerLabel

func setScore0(s:int)->void:
	scoreLabel0.text = "Score : " + str(s)
func setScore1(s:int)->void:
	scoreLabel1.text = "Score : " + str(s)
func setPower(p:float)->void:
	powerLabel1.text = "Power : " + str(int(p))
