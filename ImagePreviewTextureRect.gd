extends TextureRect

var offset_coords := Vector2.ZERO

func _draw():
	if(texture != null): draw_cross(texture.get_size() * Vector2(0.5, 1) + offset_coords, 10)

func draw_cross(coords: Vector2, ray: int):
	draw_line(coords + (Vector2.LEFT * ray), coords + (Vector2.RIGHT * ray), Color.red)
	draw_line(coords + (Vector2.UP * ray), coords + (Vector2.DOWN * ray), Color.red)

func _on_XOffset_value_changed(value):
	offset_coords.x = value
	update()

func _on_YOffset_value_changed(value):
	offset_coords.y = value
	update()
