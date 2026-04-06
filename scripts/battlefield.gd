class_name Battlefield extends Node2D

@export var length : int = 7
var distance_between := 40.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_battlefield()
	spawn_nodes()


func get_nodes_at_location(fighter: Fighter, distance: Vector2) -> Array[PositionNode]:
	var result : Array[PositionNode] = []
	var direction := 1
	if fighter.enemy: direction = -1

	for i in range(abs(distance.y)):
		var index : int = fighter.node_index + int(distance.x) + int(i * direction) 
		var pos_node: PositionNode = null
		
		if not out_of_bound(index):
			pos_node = get_child(index)
		
		result.append(pos_node)
	return result
	
func out_of_bound(index: int) -> bool:
	return index < 0 or index > get_child_count() - 1
	
func center_battlefield() -> void:
	global_position.x = get_viewport_rect().position.x
	global_position.x -= float(length - 1) * distance_between / 2
	
func spawn_nodes() -> void:
	for i in range(length):
		var new_position_node = load("res://scenes/position_node.tscn").instantiate()
		new_position_node.scale *= 1.4
		add_child(new_position_node)
		new_position_node.position.x = i * distance_between
	
