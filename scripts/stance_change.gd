class_name StanceChange extends Card

func init() -> void:
	image.frame = 6
	can_rotate = true
	effected_area = Vector2.ZERO
	
func effect() -> void:
	refresh_effected_nodes()
	if not flipped:
		var fighter: Fighter = get_parent().deck_owner
		fighter.change_stance()
		
	else:
		var fighter : Fighter = get_parent().deck_owner
	
		if effected_nodes[0]:
			fighter.node_index = effected_nodes[0].get_index()
			fighter.location_node = effected_nodes[0]
			

func refresh_effected_area() -> void:
	if not flipped:
		effected_area = Vector2.ZERO
	else:
		effected_area = Vector2(2, 1)
