class_name MainMenuUI extends CanvasLayer

@onready var startMenu:Control = $StartMenu

signal campagn()
signal local()
signal onlineClient()
signal onlineServer()


func _on_campagn_pressed() -> void:
	campagn.emit()
func _on_local_pressed() -> void:
	local.emit()
func _on_online_pressed() -> void:
	#TODO client server data
	pass
