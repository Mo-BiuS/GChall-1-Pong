class_name Arena extends Node2D

const PADDLE_SCENE:PackedScene = preload("res://Scenes/Paddle.tscn")
const BALL_SCENE:PackedScene   = preload("res://Scenes/Ball.tscn")

@onready var ui:UI = $UI
@onready var soundHandler:SoundHandler = $SoundHander

@onready var paddleHandler:Node2D = $PadleList
@onready var ballHandler  :Node2D = $BallList
@onready var tileMap      :TileMapLayer = $Decorations/TileMap

@onready var startPos1:Marker2D = $StartingPos/Player1
@onready var startPos2:Marker2D = $StartingPos/Player2

var player1:Paddle
var player2:Paddle
var ball:Ball

var scorePlayer1 = 0;
var scorePlayer2 = 0;

#==============================================================================
func _ready() -> void:
	initPaddle()
	initBall(-1)

#==============================================================================
func initPaddle() -> void:
	for i in paddleHandler.get_children():i.queue_free()
	
	player1 = PADDLE_SCENE.instantiate()
	player1.player = 0
	player1.position = startPos1.position
	paddleHandler.add_child(player1)
	player2 = PADDLE_SCENE.instantiate()
	player2.player = 1
	player2.position = startPos2.position
	paddleHandler.add_child(player2)
func initBall(target:int) -> void:
	for i in ballHandler.get_children():i.queue_free()
	ball = BALL_SCENE.instantiate()
	ball.powerChanged.connect(ui.setPower)
	ball.hasBounced.connect(soundHandler.playBounce)
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

#==============================================================================
func goalLeft(body: Node2D) -> void:
	if(body is Ball):
		soundHandler.playScore()
		scorePlayer2+=1
		ui.setScore1(scorePlayer2)
		initBall(0)
func goalRight(body: Node2D) -> void:
	if(body is Ball):
		soundHandler.playScore()
		scorePlayer1+=1
		ui.setScore0(scorePlayer1)
		initBall(1)
