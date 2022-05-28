extends Control

var itemListControl : PackedScene = preload("res://templates/ItemListControl.tscn")

onready var windowDialog : WindowDialog = $WindowDialog
onready var itemFileDialog : FileDialog = $ItemFileDialog
onready var itemsContainer : VBoxContainer = $WindowDialog/ScrollContainer/VBoxMain/ItemsContainer
onready var referenceRect : ReferenceRect = $ReferenceRect

var dragging := false
var speed := Vector2.ZERO
var relativeMousePosition = Vector2.ZERO

func _ready():
	windowDialog.popup_centered()
	referenceRect.rect_position = Vector2(get_viewport_rect().size * 0.5)

func _on_ConfigureButton_pressed():
	if(!windowDialog.visible): windowDialog.popup_centered()
	else: windowDialog.visible = false

func _on_LoadItemButton_pressed():
	itemFileDialog.popup_centered()
	
func _on_ItemFileDialog_file_selected(path):
	print("Opening item file from path: ", path)
	var newItem := itemListControl.instance()
	var image :ImageTexture = ImageTexture.new()
	var loadingError := image.load(path)
	
	if(loadingError != OK):
		print("Error when loading image: ", loadingError)
		return
	if(image.get_size() > Vector2(512,512)):
		Global.alert_user("Image's size must be smaller than 512 pixels on both coordinates")
		return
	
	itemsContainer.add_child(newItem)
	newItem.set_texture(image)
	newItem.set_path(path)

func _on_TilesetFileDialog_file_selected(path):
	print("Opening tileset file from path: ", path)
	var image :ImageTexture = ImageTexture.new()
	var loadingError := image.load(path)
	
	if(loadingError != OK):
		print("Error when loading image: ", loadingError)
		return
	if(image.get_size() > Vector2(512,512)):
		Global.alert_user("Image's size must be smaller than 512 pixels on both coordinates")
		return


func _on_ReferenceRect_gui_input(event):
	if event is InputEventMouseMotion:
		speed = event.speed
	if event is InputEventMouseButton:
		dragging = event.is_pressed()
		relativeMousePosition = get_global_mouse_position() - referenceRect.rect_position
	if dragging:
		referenceRect.rect_position = get_global_mouse_position() - relativeMousePosition
	speed = Vector2.ZERO


func _on_ImageWidth_value_changed(value):
	referenceRect.rect_size.x = value

func _on_ImageHeight_value_changed(value):
	referenceRect.rect_size.y = value
