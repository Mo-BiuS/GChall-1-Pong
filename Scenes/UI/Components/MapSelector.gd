extends PanelContainer

@export var mapPort:SubViewport
@export var nMapLabel:Label
@export var mapNameLabel:Label

var mapName:String
var mapid:int = 0
var mode:int = -1

func _ready() -> void:
	setMode(0)

func setMode(m:int)->void:
	if(m != mode && (m==0||m==1)):
		mode = m
		mapName = MAP_LIST.ML[mode].keys()[mapid]
		loadMap()
		refreshLabel()

func loadMap()->void:
	for i in mapPort.get_children():i.queue_free()
	var map:Map = MAP_LIST.ML[mode][mapName].instantiate()
	map.scale/=4
	map.material = null
	mapPort.add_child(map)

func refreshLabel()->void:
	mapNameLabel.text = mapName
	nMapLabel.text = str(mapid+1) + " / " + str(MAP_LIST.ML[mode].size())

func getMapName()->String:
	return mapName

func _on_prev_pressed() -> void:
	mapid-=1
	if(mapid < 0): mapid = MAP_LIST.ML[mode].size()-1
	mapName = MAP_LIST.ML[mode].keys()[mapid]
	loadMap()
	refreshLabel()

func _on_next_pressed() -> void:
	mapid+=1
	if(mapid >= MAP_LIST.ML[mode].size()): mapid = 0
	mapName = MAP_LIST.ML[mode].keys()[mapid]
	loadMap()
	refreshLabel()
