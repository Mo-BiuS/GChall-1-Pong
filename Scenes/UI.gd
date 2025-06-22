class_name UI extends CanvasLayer

@onready var battleUI:Control  = $BattleUI
@onready var scoreLabel0:Label = $BattleUI/ScoreContainer0/VBoxContainer/ScoreLabel
@onready var scoreLabel1:Label = $BattleUI/ScoreContainer1/VBoxContainer/ScoreLabel
@onready var powerLabel1:Label = $BattleUI/PowerContainer/PowerLabel

@onready var gameEndUI:Control = $GameEndUI
@onready var whoWonLabel:Label = $GameEndUI/PanelContainer/PanelContainer/MarginContainer/VBoxContainer/WhoWonLabel
signal replay;
signal toMenu;

func setScore0(s:int)->void:
	scoreLabel0.text = "Score : " + str(s)
func setScore1(s:int)->void:
	scoreLabel1.text = "Score : " + str(s)
func setPower(p:float)->void:
	powerLabel1.text = "Power : " + str(int(p))

func setWinner(w:int)->void:
	match(w):
		0:whoWonLabel.text = "Team 1 won"
		1:whoWonLabel.text = "Team A won"
		_:whoWonLabel.text = "Team @ won"
func _on_replay_button_pressed() -> void:
	replay.emit();
func _on_menu_button_pressed() -> void:
	toMenu.emit();
