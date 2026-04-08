class_name Attack extends Card

func will_hit() -> bool:
	for node in effected_nodes:
		for fighter in node.occupied:
			if fighter != get_parent().deck_owner:
				return true
				
	return false
