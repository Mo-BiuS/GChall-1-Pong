class_name SoundHandler extends Node

@onready var soundScore     :AudioStreamPlayer = $SoundScore

func playScore()->void:
	soundScore.play()
