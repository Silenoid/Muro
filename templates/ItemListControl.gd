extends VBoxContainer

onready var texture_rect: TextureRect = $HBox/ImagePreviewTextureRect
onready var pathSlider: Label = $HBox1/FilePathLabel

func set_texture(texture: ImageTexture):
	texture_rect.texture = texture
	
func set_path(path: String):
	pathSlider.text = path

func _on_DeleteButton_pressed():
	queue_free()
