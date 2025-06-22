class_name Arena extends Node2D

const STATE_ARENA_PLAYING = 0
const STATE_ARENA_END_GAME = 1
var state

signal toMenu;

const PADDLE_SCENE:PackedScene = preload("res://Scenes/Arena/Paddle.tscn")
const BALL_SCENE:PackedScene   = preload("res://Scenes/Arena/Ball.tscn")

@onready var ui:ArenaUI = $ArenaUI
@onready var soundHandler:SoundHandler = $SoundHander
@onready var mapHandler   :Node2D = $MapHandler
@onready var paddleHandler:Node2D = $PadleList
@onready var ballHandler  :Node2D = $BallList


var mode:int = 0
var mapName:String = "Hourglass"
var map:Map

var player1:Paddle
var player2:Paddle
var ball:Ball

var scorePlayer1 = 0;
var scorePlayer2 = 0;

var scoreGoal:int = 3;

#==============================================================================
func _ready() -> void:
	print(MAP_LIST.ML[mode])
	if(MAP_LIST.ML[mode][mapName] != null):
		map = MAP_LIST.ML[mode].get(mapName).instantiate()
		mapHandler.add_child(map)
		state = STATE_ARENA_PLAYING
		initPaddle()
		initBall(-1)
	else:print("ERROR MAP")

#==============================================================================
func initPaddle() -> void:
	for i in paddleHandler.get_children():i.queue_free()
	
	player1 = PADDLE_SCENE.instantiate()
	player1.player = 0
	player1.position = map.getLeftPlayer1Pos()
	paddleHandler.add_child(player1)
	player2 = PADDLE_SCENE.instantiate()
	player2.player = 1
	player2.position = map.getRightPlayer1Pos()
	paddleHandler.add_child(player2)
func initBall(target:int) -> void:
	for i in ballHandler.get_children():i.queue_free()
	ball = BALL_SCENE.instantiate()
	ball.powerChanged.connect(ui.setPower)
	ui.setPower(ball.speed)
	match target:
		-1:
			match randi()%2:
				0:
					ball.position = player1.position+Vector2( 48,0)
					player1.stickedBall = ball
				1:
					ball.position = player2.position+Vector2(-48,0)
					player2.stickedBall = ball
		0:
			ball.position = player1.position+Vector2( 48,0)
			player1.stickedBall = ball
		1:
			ball.position = player2.position+Vector2(-48,0)
			player2.stickedBall = ball
		_:
			print("Error ball generation invalid target")
	ballHandler.call_deferred("add_child",ball)
func endGame()->void:
	state = STATE_ARENA_END_GAME
	for i in ballHandler.get_children():i.queue_free()
	for i in paddleHandler.get_children():i.isFreezed = true
	if(scorePlayer1 > scorePlayer2): ui.setWinner(0)
	else:ui.setWinner(0)
	ui.gameEndUI.show()
#==============================================================================
func goalLeft(body: Node2D) -> void:
	if(body is Ball):
		soundHandler.playScore()
		scorePlayer2+=1
		ui.setScore1(scorePlayer2)
		if(scorePlayer2 < scoreGoal):initBall(0)
		else:endGame()
func goalRight(body: Node2D) -> void:
	if(body is Ball):
		soundHandler.playScore()
		scorePlayer1+=1
		ui.setScore0(scorePlayer1)
		if(scorePlayer1 < scoreGoal):initBall(1)
		else:endGame()
func replay() -> void:
	ui.gameEndUI.hide()
	var i:int
	if(scorePlayer1>scorePlayer2):i=1
	else:i=0
	scorePlayer1=0
	scorePlayer2=0
	ui.setScore0(scorePlayer1)
	ui.setScore1(scorePlayer2)
	player1.position = map.getLeftPlayer1Pos()
	player2.position = map.getRightPlayer1Pos()
	player1.isFreezed = false
	player2.isFreezed = false
	initBall(i)
	state = STATE_ARENA_PLAYING
func _on_ui_to_menu() -> void:
	toMenu.emit()
