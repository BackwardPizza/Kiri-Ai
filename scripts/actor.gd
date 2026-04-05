class_name Actor extends Node2D

var context : Node2D = null
var location_node : Node2D = null

func move_to() -> void:
	if not location_node: return
	
	z_index = location_node.z_index
	
	if global_position != location_node.global_position:
		
		var direction = abs(global_position - location_node.global_position).normalized()
		var speed = direction * 10.0
		
		global_position.x = move_toward(global_position.x, location_node.global_position.x, speed.x)
		global_position.y = move_toward(global_position.y, location_node.global_position.y, speed.y)
	
	if scale != location_node.scale:
		scale.x = move_toward(scale.x, location_node.scale.x, 0.05)
		scale.y = move_toward(scale.y, location_node.scale.y, 0.05)


func change_context(input: Node2D) -> void:
	if not input: return
	context = input
	
func set_location_node(node: Node2D) -> void:
	location_node = node
