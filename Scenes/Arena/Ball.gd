class_name Ball extends CharacterBody2D

@onready var soundBallBounce:AudioStreamPlayer = $SoundBallBounce

var arenaUp  :int  = 32
var arenaDown:int  = 480
var speed:float    = 200.
var isSticked:bool = true

signal powerChanged(p:float)

func _process(delta: float) -> void:
	if(!isSticked):
		var oldSpeed:int = int(speed)
		speed+=delta
		if(oldSpeed < int(speed)):powerChanged.emit(speed)
		var contact = move_and_collide(velocity*delta)
		if(contact != null):
			if(contact.get_collider() is Paddle):
				speed*=1.1
				velocity = contact.get_collider().position.direction_to(position)*speed
				powerChanged.emit(speed)
				soundBallBounce.play()
			elif(contact.get_collider() is TileMapLayer):
				var angle:float = contact.get_angle()
				if(angle < PI/4):velocity.y*=-1
				elif(angle < 3*PI/4):velocity.x*=-1
				elif(angle < 5*PI/4):velocity.y*=-1
				elif(angle < 7*PI/4):velocity.x*=-1
				else:velocity.y*=-1
				soundBallBounce.play()

#==============================================================================
func action(v:Vector2)->void:
	isSticked = false
	velocity = v*speed
	soundBallBounce.play()
