class_name Move extends Card

var reach := Vector2(0, 1)
	
func init() -> void:
	image.frame = 1
	can_rotate = true
