extends Node

onready var tileMap:TileMap = $TileMap
onready var widthTilemap:SpinBox = $MainControl/WindowDialog/ScrollContainer/VBoxMain/HBox3/WidthTilemapSize
onready var heightTilemap:SpinBox = $MainControl/WindowDialog/ScrollContainer/VBoxMain/HBox3/HeightTilemapSize
onready var referenceRect:ReferenceRect = $MainControl/ReferenceRect

var noise := OpenSimplexNoise.new()
var	octaves:int = 4
var	period := 20.0
var	persistence := 0.8
var tilemapSize := Vector2(100, 100)

func _ready():
	generateMap()

func generateMap():
	randomize()
	tileMap.clear()
	updateState()

	for x in tilemapSize.x:
		for y in tilemapSize.y:
			if noise.get_noise_2d(x,y) > 0.1: tileMap.set_cell(x, y, 0)
	
	tileMap.update_bitmask_region(Vector2.ZERO, tilemapSize)

func updateState():
	tilemapSize = Vector2(widthTilemap.value, heightTilemap.value)
	noise.seed = randi()
	noise.octaves = octaves
	noise.period = period
	noise.persistence = persistence

func _on_GenerateButton_pressed():
	generateMap()


func _on_SaveScreen_pressed():
	referenceRect.visible = false
	var img:Image = get_viewport().get_texture().get_data()
	img.flip_y()
	img = img.get_rect(Rect2(referenceRect.rect_position, referenceRect.rect_size))
	img.convert(Image.FORMAT_RGBA8)
	#img.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/Muro" + String(OS.get_unix_time()) + ".png")
	img.save_png(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/Muro.png")
	referenceRect.visible = true
