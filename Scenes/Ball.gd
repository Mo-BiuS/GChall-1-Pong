class_name Ball extends CharacterBody2D

var arenaUp  :int = 32
var arenaDown:int = 480
var speed:float = 200.

signal powerChanged(p:float)

func _process(delta: float) -> void:
	var contact = move_and_collide(velocity*delta)
	if(contact != null):
		if(contact.get_collider() is Paddle):
			speed*=1.1
			velocity = contact.get_collider().position.direction_to(position)*speed
			powerChanged.emit(speed)
		elif(contact.get_collider() is TileMapLayer):
			var angle:float = contact.get_angle()
			if(angle < PI/4):velocity.y*=-1
			elif(angle < 3*PI/4):velocity.x*=-1
			elif(angle < 5*PI/4):velocity.y*=-1
			elif(angle < 7*PI/4):velocity.x*=-1
			else:velocity.y*=-1

#==============================================================================
func action(v:Vector2)->void:
	velocity = v*speed
