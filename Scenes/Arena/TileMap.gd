extends TileMapLayer

@onready var shaderMaterial = material as ShaderMaterial
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
	shaderMaterial.set_shader_parameter("bitcodeMap", generateBitcodeMap())
	shaderMaterial.set_shader_parameter("scale", scale.x)
	shaderMaterial.set_shader_parameter("tileSize", tile_set.tile_size)

func _process(delta: float) -> void:
	time += delta/2
	shaderMaterial.set_shader_parameter("tcos", sin(time)*.2)
