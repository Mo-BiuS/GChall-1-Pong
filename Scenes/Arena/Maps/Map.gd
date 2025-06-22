class_name Map extends TileMapLayer

@onready var shaderMaterial = material as ShaderMaterial
@onready var leftPlayer1Pos:Marker2D = $StartingPos/LeftPlayer1Pos
@onready var leftPlayer2Pos:Marker2D = $StartingPos/LeftPlayer2Pos
@onready var RightPlayer1Pos:Marker2D = $StartingPos/RightPlayer1Pos
@onready var RightPlayer2Pos:Marker2D = $StartingPos/RightPlayer2Pos

func getLeftPlayer1Pos()->Vector2: return leftPlayer1Pos.position
func getLeftPlayer2Pos()->Vector2: return leftPlayer2Pos.position
func getRightPlayer1Pos()->Vector2: return RightPlayer1Pos.position
func getRightPlayer2Pos()->Vector2: return RightPlayer2Pos.position

var time:float

func generateBitcodeMap() -> Array[int]:
	var size:Vector2i = get_used_rect().size
	var rep:Array[int]
	
	for x in range(32):
		for y in range(32):
			var bit:int = 0;
			if get_cell_source_id(Vector2i(x,y)) != -1 :
				if get_cell_source_id(Vector2i(x,y) + Vector2i.UP   + Vector2i.LEFT ) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.UP  ) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.LEFT ) == -1 : bit+=1
				if get_cell_source_id(Vector2i(x,y) + Vector2i.UP   + Vector2i.RIGHT) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.UP  ) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.RIGHT) == -1 : bit+=2
				if get_cell_source_id(Vector2i(x,y) + Vector2i.DOWN + Vector2i.RIGHT) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.DOWN) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.RIGHT) == -1 : bit+=4
				if get_cell_source_id(Vector2i(x,y) + Vector2i.DOWN + Vector2i.LEFT ) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.DOWN) == -1 || get_cell_source_id(Vector2i(x,y) + Vector2i.LEFT ) == -1  : bit+=8
			rep.append(bit)
	
	return rep

func _ready() -> void:
	if(material != null):
		shaderMaterial.set_shader_parameter("bitcodeMap", generateBitcodeMap())
		shaderMaterial.set_shader_parameter("scale", scale.x)
		shaderMaterial.set_shader_parameter("tileSize", tile_set.tile_size)

func _process(delta: float) -> void:
	if(material != null):
		time += delta/2
		shaderMaterial.set_shader_parameter("tcos", sin(time)*.2)
