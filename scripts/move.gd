class_name Move extends Card
	
func init() -> void:
	effected_area = Vector2(1, 1)
	image.frame = 1
	can_rotate = true
	priority = 0
	
func effect() -> void:
	refresh_effected_nodes()
	
	var fighter : Fighter = get_parent().deck_owner
	if effected_nodes:
		fighter.move_to_location(effected_nodes[0])
	
func was_flipped() -> void:
	flipped = not flipped
	image.flip_v = flipped
	effected_area *= -1.0
		
