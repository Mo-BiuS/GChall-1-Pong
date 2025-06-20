class_name Paddle extends Sprite2D

#INPUTS
var inputList:Array = [["up1","down1","action1"],["up2","down2","action2"]]
const UP = 0; const DOWN = 1; const ACTION = 2
@export_range(0, 1, 1) var player:int = 0

#VALUES
var arenaUp  :int = 32
var arenaDown:int = 480
var speed    :float = 200.
var halfSize :float

func _ready() -> void:
	match player:
		0:
			texture = load("res://Ressources/Sprites/Paddle 1.png")
		1:
			texture = load("res://Ressources/Sprites/Paddle 2.png")
		_:
			print("Player Error")
	halfSize = self.texture.get_size().y/2

func _process(delta: float) -> void:
	if(Input.is_action_pressed(inputList[player][UP])):moveUp(delta)
	if(Input.is_action_pressed(inputList[player][DOWN])):moveDown(delta)

func _input(event):
	if(event.is_action_pressed(inputList[player][ACTION])):action()

func moveUp(delta: float)->void:
	if(position.y-speed*delta-halfSize > arenaUp):position.y-=speed*delta
	else:position.y=arenaUp+halfSize
func moveDown(delta: float)->void:
	if(position.y+speed*delta+halfSize < arenaDown):position.y+=speed*delta
	else:position.y=arenaDown-halfSize
func action()->void:
	print("action")
