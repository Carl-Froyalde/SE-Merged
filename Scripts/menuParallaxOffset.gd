extends ParallaxBackground

var scroll_x = 0

func _process(delta):
	scroll_base_offset -= Vector2(100,0) * delta
