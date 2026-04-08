class_name StanceChange extends Card

var org_effected_area : Vector2

func init() -> void:
	image.frame = 6
	can_rotate = true
	effected_area = Vector2(2, 1)
	org_effected_area = effected_area
	
func effect() -> void:
	refresh_effected_nodes()
	
	var fighter: Fighter = get_parent().deck_owner
	if not flipped:
		fighter.change_stance()
		
	else:
		if effected_nodes:
			fighter.move_to_location(effected_nodes[0])
			
func was_flipped() -> void:
	flipped = not flipped
	image.flip_v = flipped
	
	if not flipped:
		priority = 1
		effected_area = Vector2.ZERO
	else:
		priority = 0
		effected_area = org_effected_area
