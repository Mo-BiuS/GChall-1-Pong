class_name Odhal extends Node

const MAIN_MENU_PACKED:PackedScene = preload("res://Scenes/UI/MainMenuUI.tscn")
const LOCAL_LOBBY:PackedScene = preload("res://Scenes/UI/LocalLobbyUI.tscn")
const ARENA_PACKED:PackedScene = preload("res://Scenes/Arena/Arena.tscn")

const STATE_MAIN_MENU = 0
const STATE_LOCAL_LOBBY = 1
const STATE_MULTIPLAYER_LOBBY = 2
const STATE_CAMPAIGN = 3
const STATE_GAME = 10
var state:int = -1

#==============================================================================
func _ready() -> void:
	toMainMenu()

func toMainMenu() -> void:
	state = STATE_MAIN_MENU
	for i in get_children():i.queue_free()
	var scene:MainMenuUI = MAIN_MENU_PACKED.instantiate()
	scene.campagn
	scene.local.connect(toLocalLobby)
	scene.onlineClient
	scene.onlineServer
	add_child(scene)

func toLocalLobby() -> void:
	state = STATE_LOCAL_LOBBY
	for i in get_children():i.queue_free()
	var scene:LocalLobbyUI = LOCAL_LOBBY.instantiate()
	add_child(scene)
