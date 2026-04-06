class_name Move extends Card
	
func init() -> void:
	effected_area = Vector2(1, 1)
	image.frame = 1
	can_rotate = true
	
func effect() -> void:
	refresh_effected_nodes()
	var fighter : Fighter = get_parent().deck_owner
	
	if effected_nodes.size() > 0:
		if not effected_nodes[0].occupied:
			fighter.set_location_node(effected_nodes[0]) 
		
func refresh_effected_area() -> void:
	var fighter : Fighter = get_parent().deck_owner
	var direction := 1.0
	if fighter.enemy:
		direction = -1.0
	
	if not flipped:
		effected_area = Vector2(1, 1) * direction
	else:
		effected_area = Vector2(-1, -1) * direction
