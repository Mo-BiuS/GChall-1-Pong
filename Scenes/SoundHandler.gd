class_name SoundHandler extends Node

@onready var soundBallBounce:AudioStreamPlayer = $SoundBallBounce
@onready var soundScore     :AudioStreamPlayer = $SoundScore

func playBounce()->void:
	soundBallBounce.play()
func playScore()->void:
	soundScore.play()
