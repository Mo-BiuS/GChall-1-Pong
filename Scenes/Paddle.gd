class_name Paddle extends CharacterBody2D

@onready var sprite:Sprite2D = $Sprite
@onready var collisionShape:CollisionShape2D = $CollisionShape2D

#INPUTS
var inputList:Array = [["up1","down1","action1"],["up2","down2","action2"]]
const UP = 0; const DOWN = 1; const ACTION = 2
var player:int = -1

#VALUES
var acceleration:float = 500.0
var deceleration:float = 300.0
var maxSpeed :float = 200.
var halfSize :float

#ENTITIES
var stickedBall:Ball = null

#==============================================================================
func _ready() -> void:
	match player:
		0:
			sprite.texture = load("res://Ressources/Sprites/Trains/Train1.png")
		1:
			sprite.texture = load("res://Ressources/Sprites/Trains/Train1.png")
			sprite.flip_h = true
		_:
			print("Player Error")
	halfSize = sprite.texture.get_size().y
	collisionShape.shape.size = sprite.texture.get_size()*2-Vector2(2,2)

func _process(delta: float) -> void:
	var direction:int = 0;
	if(Input.is_action_pressed(inputList[player][UP  ])):direction-=1
	if(Input.is_action_pressed(inputList[player][DOWN])):direction+=1
	
	if(direction != 0):
		velocity.y += direction * acceleration * delta
	else:
		if abs(velocity.y) > 1:velocity.y -= sign(velocity.y) * deceleration * delta
		else:velocity.y = 0
	
	velocity.y = clamp(velocity.y, -maxSpeed, maxSpeed)
	
	if(move_and_collide(velocity*delta) != null):velocity=Vector2(0,0)
	
	if(stickedBall != null):
		if(stickedBall.position.y > position.y+halfSize):stickedBall.position.y = position.y+halfSize
		if(stickedBall.position.y < position.y-halfSize):stickedBall.position.y = position.y-halfSize

func _input(event):
	if(event.is_action_pressed(inputList[player][ACTION])):action()

#==============================================================================
func action()->void:
	if(stickedBall != null):
		stickedBall.action(position.direction_to(stickedBall.position))
		stickedBall = null
